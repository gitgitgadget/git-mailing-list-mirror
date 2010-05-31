From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Commit to other branch
Date: Mon, 31 May 2010 18:28:48 +0200
Message-ID: <vpq8w70m3wf.fsf@bauges.imag.fr>
References: <4C03D9C1.1060404@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Mon May 31 18:29:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ7rY-0007Yj-Se
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 18:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab0EaQ3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 12:29:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32877 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab0EaQ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 12:29:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o4VGLUjG030248
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 31 May 2010 18:21:30 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OJ7r6-0002O1-HU; Mon, 31 May 2010 18:28:48 +0200
In-Reply-To: <4C03D9C1.1060404@cedarsoft.com> (Johannes Schneider's message of "Mon\, 31 May 2010 17\:46\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 May 2010 18:21:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o4VGLUjG030248
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1275927693.77506@PTsn6+mxHXCJgtuwJy1PwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148050>

Johannes Schneider <mailings@cedarsoft.com> writes:

> I tried to "git stash "
> But then *all* changes are stashed (including my changes)...

Not completely answering the question, but "git stash -k"
(--keep-index) allows you to do a selective stash. If you have
relevant changes staged, and want to commit the unstaged ones
elsewhere, you can do something like

git stash -k
git checkout elsewhere
git commit
git checkout back-to-your-branch
git stash pop

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
