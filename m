From: DimanNe <dimanne@ya.ru>
Subject: =?utf-8?B?Z2l0IHN2biBhbHJlYWR5IHNldCDigKYgd2FudGVkIHRvIHNldCB0bzo=?=
Date: Tue, 29 Oct 2013 10:57:55 +0400
Message-ID: <1771383029875@web26g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:04:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3Ls-0000Ue-Jz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab3J2HE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:04:29 -0400
Received: from forward17.mail.yandex.net ([95.108.253.142]:34246 "EHLO
	forward17.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab3J2HEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:04:24 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2013 03:04:23 EDT
Received: from web26g.yandex.ru (web26g.yandex.ru [95.108.253.235])
	by forward17.mail.yandex.net (Yandex) with ESMTP id 2AAB910613B3
	for <git@vger.kernel.org>; Tue, 29 Oct 2013 10:57:56 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web26g.yandex.ru (Yandex) with ESMTP id B925DD817A1;
	Tue, 29 Oct 2013 10:57:55 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1383029875; bh=RgqsqRWl7df4NnbYx+tlxr08oMi2CNenTNKU4151bl8=;
	h=From:To:Subject:Date;
	b=u32lS3rfdS9Fxol/MbRvxz8g/NeoBrXSqBu1vyWEoIF6ULr3YGJhMhhMsvn0PX1SH
	 Tm9jKDwgNHWirSgSGwEklUIvMowCDs8tcJJDxel/4ieHPm/Q2lovA2Fp2Ni8cPG/Vg
	 907LXHdKWQw2Y78xR8v61bQNFqp7gnwOjdI+u1eY=
Received: from dhcp172-103-red.yandex.net (dhcp172-103-red.yandex.net [95.108.172.103]) by web26g.yandex.ru with HTTP;
	Tue, 29 Oct 2013 10:57:55 +0400
Envelope-From: Dimanne@yandex.ru
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236896>

I am trying to clone/fetch svn branch with git-svn:

git config --add svn-remote.stable-2012-03-29.url https://some_host/branch
git config --add svn-remote.stable-2012-03-29.fetch :refs/remotes/stable-2012-03-29
git svn fetch stable-2012-03-29

which gives me this error message:

svn-remote.stable-2012-03-29.url already set: https://some_host/branch/ wanted to set to: https://some_host/

I know that I probably can fix this by re-fetching all svn-repo from scratch, but it will take months or even years (due to size of repo).

So, is there any solutions?
