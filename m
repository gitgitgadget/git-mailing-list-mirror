From: Olivier de Broqueville <olivier.debroqueville@gmail.com>
Subject: How to update git on Mac OS X Mountain Lion 10.8.4
Date: Fri, 28 Jun 2013 21:31:38 +0200
Message-ID: <CAN_-5Z94-OV7rHYf+mUuf_xanxu0+odwovv0mpB4GRHVsjccDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 28 21:31:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UseOW-0002m3-NU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 21:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab3F1Tbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 15:31:41 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:61292 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab3F1Tbj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 15:31:39 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so1236855lbc.3
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Tga90eXsBIb5AjBaOEHPB789fWd39AABD0BSO9jMoNQ=;
        b=WKmHWJxlh1hcUw/2MlocWMlkyv6my3+GLv8lJPeh5l00pbJfA9F3Iprr21KDMSoxQz
         VCmodyoB4KXky75L4t9r3da+x3sjNlzqxqX7QP7vm/OZbF4hHRtpGFs+HDHa4sTfGSKj
         QzIuJu75cKb/Hxhn8oYV5Uqkq+eaO0jMsAIWMJquz74uvSCywv1c7iI0kCxzvHY3X1r1
         YF72j7b1wl4y/ZpB8MfWMfMx9bUia5aaVZNLVm51n6FTz3qPUrb/6MnYY4HYiEz75a22
         nTSsLaaPgb0cwciLjhYlggTRUwYObiKdIqn13eQzzoATSRTdCaBNOUIuDKgf01k3Q1He
         gdkA==
X-Received: by 10.112.13.199 with SMTP id j7mr7267312lbc.25.1372447898286;
 Fri, 28 Jun 2013 12:31:38 -0700 (PDT)
Received: by 10.112.158.163 with HTTP; Fri, 28 Jun 2013 12:31:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229227>

Hello,

I've learnt that Xcode installs git by default on the Mac. My current
version of git is 1.7.12.4 and it's located in /usr/bin/git.

I wanted to update git to the latest stable version available:
1.8.3.1. I proceeded with the instructions on:
http://git-scm.com/downloads and typed:

git clone https://github.com/git/git.git

(rather than using the .dmg file because I don't want to install a new
version of git in addition to the existing one used by Xcode.
Furthermore, I have no idea where the new version would end up being
installed and I've read that users have had trouble doing this!)

This rendered the following results:
Oliviers-iMac:~ odebroqueville$ git clone https://github.com/git/git.git
Cloning into 'git'...
remote: Counting objects: 157697, done.
remote: Compressing objects: 100% (53116/53116), done.
remote: Total 157697 (delta 114700), reused 143715 (delta 102625)
Receiving objects: 100% (157697/157697), 39.56 MiB | 2.01 MiB/s, done.
Resolving deltas: 100% (114700/114700), done.
Oliviers-iMac:~ odebroqueville$ which git
/usr/bin/git
Oliviers-iMac:~ odebroqueville$ git --version
git version 1.7.12.4 (Apple Git-37)

As you can see, nothing seems to have changed!

Would you have any explanations?

Thank you in advance for your help.
Best regards,
Olivier de Broqueville.
