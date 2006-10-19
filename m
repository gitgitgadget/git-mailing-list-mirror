From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 14:04:14 +0200
Message-ID: <vpqirigqzpd.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
	<45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org>
	<20061019091045.GV75501@over-yonder.net> <45375E56.4090106@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 14:05:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaWeN-0004n8-Rd
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 14:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWJSMFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 08:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWJSMFY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 08:05:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:23802 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1751517AbWJSMFW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 08:05:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9JC4F57007442
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Oct 2006 14:04:15 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GaWdC-0003Ij-IS; Thu, 19 Oct 2006 14:04:14 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GaWdC-0000I6-F1; Thu, 19 Oct 2006 14:04:14 +0200
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <45375E56.4090106@op5.se> (Andreas Ericsson's message of "Thu\, 19 Oct 2006 13\:15\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 19 Oct 2006 14:04:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29345>

Andreas Ericsson <ae@op5.se> writes:

> You, and others, keep saying "leftmost". What on earth does left or
> right have to do with anything? Or rather, how do you determine which
> side anything at all is on?

Not sure it's the same in git, but in bzr, a new revision is always
created by a commit (it can be "fetched" by other commands though). If
you "merge", then you have to commit after.

What people call "leftmost ancestor" is the revision which used to be
the tip at the time you commited. For example, if you do "bzr diff;
bzr commit" the diff shown before is the same as the one got with
"bzr diff -r last:1" right after the commit.

I believe this doesn't make a difference for merge algorithms, but in
the UI, it's here when you say, e.g.:

bzr diff -r last:12..before:revid:foo@bar-auents987aue

(once in "last:", and once in "before:")

-- 
Matthieu
