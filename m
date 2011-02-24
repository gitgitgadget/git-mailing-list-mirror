From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 17:04:12 +0100
Message-ID: <vpqk4gp4dxf.fsf@bauges.imag.fr>
References: <20110224112246.3f811ac2@glyph>
	<4D6672F7.4020101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:05:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psdgd-0000Xq-Va
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab1BXQE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:04:59 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59209 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306Ab1BXQE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 11:04:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p1OG4Bsd031859
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Feb 2011 17:04:11 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Psdfo-0003bw-Ro; Thu, 24 Feb 2011 17:04:12 +0100
In-Reply-To: <4D6672F7.4020101@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 24 Feb 2011 16:02:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Feb 2011 17:04:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1OG4Bsd031859
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1299168254.00809@EYaGluAl7nmLPATENcw9bQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167828>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Why does it not exist? Because you should at least
> "git add -A && git status && behappy && git commit".

There are alternatives like

git status && behappy && git commit -A

or

git commit -A && look at status $EDITOR && behapy && save

> Also, "-A" supports a very "un-gitty" way of using git. This makes it
> unlikely that someone cares to implement it...

I guess that's it. It's not usefull to most Git developers, hence nobody
cared to implement it. But IIRC the switch "add -A" was chosen partly
because -A didn't exist for commit, hence this leaves room for commit
-A.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
