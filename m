From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] commit: suggest --amend --reset-author to fix commiter identity
Date: Fri, 07 Jan 2011 18:16:49 +0100
Message-ID: <vpq7hegmy66.fsf@bauges.imag.fr>
References: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
	<20110107171329.GA16571@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 18:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbFwg-0004Vw-2k
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 18:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab1AGRRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 12:17:22 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59662 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754859Ab1AGRRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 12:17:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p07HGNRM004713
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Jan 2011 18:16:24 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PbFvl-00087n-Em; Fri, 07 Jan 2011 18:16:49 +0100
In-Reply-To: <20110107171329.GA16571@burratino> (Jonathan Nieder's message of "Fri\, 7 Jan 2011 11\:13\:29 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jan 2011 18:16:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p07HGNRM004713
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1295025384.2457@7hUXGQokWaC9gpH7PwoAiA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164722>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This message gets used when the author was set from gecos because
> not available in the configuration.

The complete message says:

"Your name and email address were configured automatically based\n"
"on your username and hostname. Please check that they are accurate.\n"
"You can suppress this message by setting them explicitly:\n"
"\n"
"    git config --global user.name \"Your Name\"\n"
"    git config --global user.email you@example.com\n"
"\n"
"If the identity used for this commit is wrong, you can fix it with:\n"
"\n"
"    git commit --amend --author='Your Name <you@example.com>'\n"
"\n"
"or\n"
"\n"
"    git commit --amend --reset-author\n";

So, the natural thing to do is

git config --global user.name "me"
git config --global user.email "my.email@bla.com"
git commit --amend --reset-author

and it's not necessary to use the longer

git config --global user.name "me"
git config --global user.email "my.email@bla.com"
git commit --amend --author='me <my.email@bla.com>'

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
