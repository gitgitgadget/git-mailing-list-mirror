From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-browse-help?
Date: Sat, 15 Dec 2007 11:25:59 -0800
Message-ID: <7vhcijn4jc.fsf@gitster.siamese.dyndns.org>
References: <20071214092829.GA22725@coredump.intra.peff.net>
	<7vtzmlrxc2.fsf@gitster.siamese.dyndns.org>
	<20071215100811.GA1692@coredump.intra.peff.net>
	<20071215110153.GA3447@coredump.intra.peff.net>
	<20071215111154.GB3447@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3cen-0006HT-Km
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 20:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754AbXLOT0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 14:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbXLOT0R
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 14:26:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705AbXLOT0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 14:26:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B5D4C3C13;
	Sat, 15 Dec 2007 14:26:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 06C933C12;
	Sat, 15 Dec 2007 14:26:05 -0500 (EST)
In-Reply-To: <20071215111154.GB3447@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 15 Dec 2007 06:11:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68407>

Jeff King <peff@peff.net> writes:

> BTW, Junio, I remember discussion a long time ago about doing:
>
>   cover letter
>   -- >8 --
>   commit
>   ---
>   diff
>
> versus
>
>   commit
>   ---
>   cover letter
>   diff
>
> and I recall that you did not have a strong preference. I have started
> using the former, as I find it a bit more convenient to write (and I
> think it is more readable when you are following up a discussion rather
> than writing a real cover letter or commenting on the patch).

Yeah, and it is not too inconvenient to trim it off if you use "am -i"
or "commit --amend".  An added bonus is unlike the "top-post" style, the
cover material is available when editing the final log message, so I
actually slightly prefer "cover -- >8 -- log --- patch" myself.
