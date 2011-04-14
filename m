From: Chris Patti <cpatti@gmail.com>
Subject: Symbolic 'references' in Git?
Date: Thu, 14 Apr 2011 16:30:59 -0400
Message-ID: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 22:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATC0-0002lO-L2
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab1DNUbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:31:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51542 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1DNUbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:31:00 -0400
Received: by fxm17 with SMTP id 17so1428628fxm.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=8FlZSaG13LErVLAacyS5qdP12Bzefk2ZYNUS+CNibNA=;
        b=Rxgg3OEJQOsHcSJ/2bFaXLedYUuS3QTO04Mq4yoJHEgeSzo+seDbqHO5efsxHGPcfO
         77dgda3iqNvP6ZTzTnpTYa9uf0OY4BTTQ902ndvjQnqWY/yWtvrZ1u8iZp1BGqCUNwkm
         Z5Xu4E0H1YuY3QXFI823wAV2hJSE7853vrJco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UdZL8w8fj4rNosVAED3iwgWb1DR44b5Lws+i9GQ2UrxpSTUqkP/xthreH53qUDad6C
         Yx8Qe4S0DVkMgWEFZQRlpyMuJnkVwz05geMgHJlQtDlU/0XBDdfB/UC4B5as6jMpQED1
         DL76ddHOHuh/XVsJ+aRJLvK4xYDY/jzFD8jYY=
Received: by 10.223.14.22 with SMTP id e22mr1322291faa.64.1302813059325; Thu,
 14 Apr 2011 13:30:59 -0700 (PDT)
Received: by 10.223.119.3 with HTTP; Thu, 14 Apr 2011 13:30:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171547>

Folks;

We want a way to have our Bamboo configuration utilize a symbol to
refer to 'latest release' 'latest patch' etc. in Git, rather than
having to go in and change the actual branch name every time we ship a
release and create a new one.

We thought about using something like:

git symbolic-ref -m'new next-release branch build for Bamboo'
next-release release-3.15

However, this symbolic ref is only local to one repository, and we
want it to be global across all of Bamboo.

Rather than resorting to manually copying the symbolic ref file
around, from repo to repo, is there any way to make such a symbolic
'variable' global?

Thanks!
-Chris


-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
