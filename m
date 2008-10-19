From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Detached checkout will clobber branch head when using symlink
 HEAD
Date: Sun, 19 Oct 2008 12:36:08 -0700
Message-ID: <7vskqs74yf.fsf@gitster.siamese.dyndns.org>
References: <1224095087.5366.19.camel@localhost>
 <20081016191751.GB14707@coredump.intra.peff.net>
 <1224187863.2796.15.camel@localhost>
 <20081016203916.GB9487@coredump.intra.peff.net>
 <7vfxmuhlad.fsf@gitster.siamese.dyndns.org>
 <20081019130050.GA1822@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Draisey <matt@draisey.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:35:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kre5l-0007VC-9u
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 21:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYJSTgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYJSTgR
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 15:36:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYJSTgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 15:36:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5538B8D0A7;
	Sun, 19 Oct 2008 15:36:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5F6BD8D0A6; Sun, 19 Oct 2008 15:36:09 -0400 (EDT)
In-Reply-To: <20081019130050.GA1822@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 19 Oct 2008 09:00:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31867478-9E15-11DD-9C8B-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98645>

Jeff King <peff@peff.net> writes:

> But if I am reading your patch right, you are actually enabling detached
> HEAD in this instance, which is much better. Unfortunately, I had quite
> a few conflicts in applying your patches on top of master (with or
> without the patch from "checkout --track -b broken"), and when I thought
> I had fixed up the result, the test actually still failed.
>
> So I will take your word that it actually works, and that I screwed up
> resolving the conflicts.

It's the three-patch series that leads to 684968c (Fix checkout not to
clobber the branch when using symlinked HEAD upon detaching, 2008-10-17).

> PS If you are rebasing or resolving anyway, as I suspect you will have
> to, there is a typo in the test: s/detch/detach/

Thanks; the series was only in 'pu', so I will.
