From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 21:56:15 -0800
Message-ID: <7vhchjy4cg.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
	<7v3at42avd.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111609t3103af1frc23519cab43ae8be@mail.gmail.com>
	<7vbq7r28qo.fsf@gitster.siamese.dyndns.org>
	<9b3e2dc20801111733o477b3aadv6ee76d3aafade54a@mail.gmail.com>
	<7vejcnzu5z.fsf@gitster.siamese.dyndns.org>
	<20080112045231.GB5211@coredump.intra.peff.net>
	<7vprw7y6mz.fsf@gitster.siamese.dyndns.org>
	<7vlk6vy5jj.fsf@gitster.siamese.dyndns.org>
	<20080112053225.GA6059@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Sinclair <radarsat1@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDZN0-0003cy-3M
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 06:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762606AbYALF4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 00:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762588AbYALF4f
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 00:56:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762581AbYALF4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 00:56:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 715BA4B5A;
	Sat, 12 Jan 2008 00:56:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D0D344B59;
	Sat, 12 Jan 2008 00:56:27 -0500 (EST)
In-Reply-To: <20080112053225.GA6059@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 12 Jan 2008 00:32:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70273>

Jeff King <peff@peff.net> writes:

> On Fri, Jan 11, 2008 at 09:30:24PM -0800, Junio C Hamano wrote:
>
>> I think what we could do if we wanted to protect people from
>> unconfigured identity is to stop pulling names from gecos and
>> hostname, and respect _only_ environment and config.
>
> I am fine with that, as I have always set up the configuration manually
> anyway. But I think it would need a significant comment period from the
> list (ISTR that Linus _likes_ pulling the hostname from gecos).

You do not pull hostname from gecos, but I agree with your main
point.
