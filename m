From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] No color diff when redirecting to file
Date: Mon, 24 Jan 2011 10:38:05 +0100
Message-ID: <vpqtygyhcaq.fsf@bauges.imag.fr>
References: <201101231410.48528.saschpe@gmx.de>
	<201101231547.18529.j6t@kdbg.org> <vpq39oj4jfz.fsf@bauges.imag.fr>
	<201101240959.02852.saschpe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sascha Peilicke <saschpe@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 24 10:38:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhIsd-0005N4-1n
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 10:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab1AXJiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 04:38:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:38857 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389Ab1AXJiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 04:38:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p0O9c5lp028862
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jan 2011 10:38:05 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PhIs9-0006wG-Qu; Mon, 24 Jan 2011 10:38:05 +0100
In-Reply-To: <201101240959.02852.saschpe@gmx.de> (Sascha Peilicke's message of "Mon\, 24 Jan 2011 09\:59\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Jan 2011 10:38:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0O9c5lp028862
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1296466686.63291@3iObvNwim3QFl83hE1UZnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165442>

Sascha Peilicke <saschpe@gmx.de> writes:

> try the same with
>
> git diff > foo

git diff > foo && cat foo
=> no color.

git diff --no-color > foo && cat foo
=> no color either

git diff --color=always > foo && cat foo
=> colors.

Again, just the expected behavior.

If it helps:

$ uname -a
Linux bauges 2.6.36-686 #1 SMP PREEMPT Fri Nov 5 10:35:38 CET 2010 i686 GNU/Linux
$ git --version
git version 1.7.4.rc1.17.ge7ece

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
