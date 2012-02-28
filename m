From: Jiang Xin <worldhello.net@gmail.com>
Subject: l10n: the maintaince of git-po repo
Date: Wed, 29 Feb 2012 01:40:09 +0800
Message-ID: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 18:40:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2R29-0002MO-Th
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052Ab2B1RkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 12:40:11 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44637 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2B1RkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 12:40:10 -0500
Received: by ggnh1 with SMTP id h1so2699798ggn.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 09:40:09 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.180.193 as permitted sender) client-ip=10.236.180.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.180.193 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.180.193])
        by 10.236.180.193 with SMTP id j41mr6003452yhm.55.1330450809955 (num_hops = 1);
        Tue, 28 Feb 2012 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=jVZ9yqEqUDU/uObh09jeYQOseezlPktFtVyoei4JaHs=;
        b=Iy2147UD030J0mGAY/ClSeWj26UySrNk8XXP4oM88Ab0Wp25ub0lthnyI8jkFpw3OG
         10HMvfXhA0HgGwZziM4mYtNgU0RGHvzuLGwA5xrdAPxnVJYeo/Rvn7n3Cgkj6ecBPnfj
         zo0bjNjlqyQKr5uXg5DbzQyhlA22aDjvilP5I=
Received: by 10.236.180.193 with SMTP id j41mr4676031yhm.55.1330450809906;
 Tue, 28 Feb 2012 09:40:09 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Tue, 28 Feb 2012 09:40:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191751>

I'm looking forward to the next git release with Chinese l10n, so that
I can start to rewrite my book on Git. ;-)

The maintaince of the git-po and git-po-zh_CN repositories so far:

git-po repository
-----------------
Location   : https://github.com/gotgit/git-po
Fork from  : https://github.com/git/git
Description: This is the Git l10n master repo, and is used to coordinate
             works of l10n teams. L10n team leaders send pull requests
             to this repo, while other l10n contributors should wok on
             the language specified repository created by the l10n team
             leader.
Typical commits:

- commit https://github.com/gotgit/git-po/commit/71eb878

      merge the pull request sent from the Chinese l10n team leader.

- commit https://github.com/gotgit/git-po/commit/1d4ac88

      l10n: Update git.pot (12 new messages)

- commit https://github.com/gotgit/git-po/commit/508d124

      Merge branch 'master' of 'git.git' into git-po,
      and will generate new po/git.pot in next commit.

- commit https://github.com/gotgit/git-po/commit/dce37b6

      l10n: initial git.pot for 1.7.10 upcoming release


git-po-zh_CN repository
-----------------------
Location   : https://github.com/jiangxin/git-po-zh_CN
Fork from  : https://github.com/gotgit/git-po
Description: Git l10n for Simplified Chinese.
Typical commits:

- commit https://github.com/jiangxin/git-po-zh_CN/commit/7ac1c0a

      l10n: update Chinese translation to the new git.po

- commit https://github.com/jiangxin/git-po-zh_CN/commit/0ad9e96

      fix of Chinese translation

- commit https://github.com/jiangxin/git-po-zh_CN/commit/d4a8e00

      fix of Chinese translation

- commit https://github.com/jiangxin/git-po-zh_CN/commit/c04f5ac

      l10n: initial of zh_CN l10n


-- 
Jiang Xin
