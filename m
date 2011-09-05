From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "Your local changes ... would be overwritten" bug
Date: Mon, 05 Sep 2011 18:52:31 +0200
Message-ID: <vpqty8rx774.fsf@bauges.imag.fr>
References: <8362l73qi6.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Mon Sep 05 18:52:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0cPj-0007fS-JF
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 18:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab1IEQwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 12:52:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54626 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308Ab1IEQwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 12:52:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p85GpYWY031007
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2011 18:51:34 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R0cPQ-0005kn-5Z; Mon, 05 Sep 2011 18:52:32 +0200
In-Reply-To: <8362l73qi6.fsf@kalahari.s2.org> (Hannu Koivisto's message of
	"Mon, 05 Sep 2011 19:25:53 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 Sep 2011 18:51:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p85GpYWY031007
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315846298.35445@PlDFTfOskP6MRM5bKq1X1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180749>

Hannu Koivisto <azure@iki.fi> writes:

> The following script can be used to reproduce the problem:

[...]

I cannot reproduce on Linux.

> I'm running Cygwin git 1.7.5.1 in Windows XP.

Probably a dumb question (from a non-windows-user), but why not use the
native Git for windows?

What happens if you run "git status" before running the problematic "git
checkout"? (I'm asking because "git status" refreshes the stat-cache, so
it may change the result)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
