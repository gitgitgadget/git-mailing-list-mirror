From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 11:37:55 +0100
Message-ID: <vpq8wdsqmm4.fsf@bauges.imag.fr>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
	<20091125203922.GA18487@coredump.intra.peff.net>
	<7viqcytjic.fsf@alter.siamese.dyndns.org>
	<20091125210034.GC18487@coredump.intra.peff.net>
	<7vmy2as319.fsf@alter.siamese.dyndns.org>
	<20091125214949.GA31473@coredump.intra.peff.net>
	<885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com>
	<20091125222037.GA2861@coredump.intra.peff.net>
	<885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com>
	<20091127062013.GA20844@coredump.intra.peff.net>
	<alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 27 11:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDyGy-0005Pr-41
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 11:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbZK0Klm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 05:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbZK0Kll
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 05:41:41 -0500
Received: from imag.imag.fr ([129.88.30.1]:40352 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbZK0Kll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 05:41:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nARAbujq020247
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 27 Nov 2009 11:37:56 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NDyD6-0007XT-9R; Fri, 27 Nov 2009 11:37:56 +0100
In-Reply-To: <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302> (Johannes Schindelin's message of "Fri\, 27 Nov 2009 10\:31\:30 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 27 Nov 2009 11:37:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133889>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Guess what.  I have a similar problem, only it is that my "git status" 
> output is _always_ too long, so I always have to page it.
>
> Once upon a time, Junio applied a patch that implied -p with status.  I 
> was overjoyed.  He reverted that patch later.  Yes, exactly.

In this particular example, a config variable was added (pager.status
= true). But one big difference is that while pager.status = true can
be /annoying/ for some users, it can never really harm (since the
pager will automatically disable itself in the cases where you'd
really don't want it).

OTOH, a config variable that actually changes the beahvior of the
command can indeed harm. Those who ever tried doing portable
programming in PHP, where the apache config can actually change the
semantics of the language probably understand what I mean ;-).

> So I end up doing "git config --global ps '-p status'" on every new 
> account (I usually even forget to curse!), and I really cannot see why you 
> do not do the equivalent "git config fullgrep grep --full-tree" in your 
> repositories (or even the global thing).

(I guess you meant alias.fullgrep)

Maybe "mygrep" or "dwimgrep" would be a better name, except for the
difficulty to type it: the same alias can be defined to different
things on different machines.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
