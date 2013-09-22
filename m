From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Proposed updates of po/git.pot in pu branch
Date: Mon, 23 Sep 2013 01:00:14 +0800
Message-ID: <CANYiYbHDKVxtSpVnQq8nGMgnJVYPZcs1-tdgi+kku0upCgSguA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?Jean=2DNo=EBl_Avila?= <jn.avila@free.fr>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Harring Figueiredo <harringf@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>
X-From: git-owner@vger.kernel.org Sun Sep 22 19:00:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNn1I-00043z-Df
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 19:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab3IVRAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 13:00:17 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:64131 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab3IVRAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 13:00:15 -0400
Received: by mail-wi0-f170.google.com with SMTP id cb5so1403317wib.3
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=RxnOtgyp2+rGahVWsaaNTal6ugYIBnM4ZIJc3u06Pek=;
        b=ps1cRpluaM5c3FRtqJz4tzLRS51e/2W+mu40l9Byg/LpGCm9dgAM+vPUbYQsmIjJE2
         MF+uiIAanN8GpNWfqUtU8kliTLw+QcM0/JNedEF8srlVu6YsaUIY++PzayZbZpLr4I06
         Opi0cylPfd8VlrnKat77RpVvtHx4hwYU8I1h6iuBJ7DLjPnkuvUhxYUxZfIaTlAN9Wgg
         LjEMuZ+ZBTUgj5fvjcj82UWrk5drQExnBU9MYcHd2ZduXt+3FTa0Ka6/2cRM02MZ+KG1
         pMnTimuBzn0tQJfZha27JHsEIhGsNI/0sGkrT6DQtKTnYxD2rFUre86ZLeLHJ/uISDgy
         FtjQ==
X-Received: by 10.180.81.71 with SMTP id y7mr10195054wix.63.1379869214165;
 Sun, 22 Sep 2013 10:00:14 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Sun, 22 Sep 2013 10:00:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235166>

Hi, Git l10n teams

I created a new branch "pu" in the l10 coordinator repository to
hold proposed updates of "po/git.pot" for translations. See commit
log for hints:

commit e9d227174abf2b7f66a7027a509886f9cba1adea

    l10n: git.pot: proposed updates since v1.8.4 (48+)

    The 1st round of Git l10n often starts very late duing the release
    cycle of Git, usually after the release of rc1. This leads to a
    gaint update of "po/git.pot" and lots of works for translators with
    a tight deadline (about one week).

    This "pu" branch holds proposed updates of the file "po/git.pot" for
    Git next release (1.8.5), and will be updated and rewound without
    notification when there are remarkable updates for it.

    Translators could work on this "pu" branch before the l10n coordinator
    starts the 1st round of l10n for this release cycle of Git, and
    rebase their works onto the master branch (with the commit for the
    1st round of l10n), then send pull request to the l10n coordinator.

    Please note:

     1. Because this branch will be rewound occasionally, translators
        SHOULD NOT merge, but SHOULD rebase to this rewound branch
        instead.

            $ git fetch git://github.com/git-l10n/git-po.git pu
            $ git rebase --onto FETCH_HEAD HEAD~1

     2. Update your translated message file "po/XX.po".

            $ msgmerge --add-location --backup=off -U "po/XX.po" \
              po/git.pot

     3. Then start to translate "po/XX.po" and commit.

     4. DO NOT send pull request to the l10n coordinator for
        translations on this "pu" branch.

     5. When the l10n coordinator starts the 1st round l10n for the
        current Git release cycle, translators should rebase and squash
        their works onto the master branch, and then send pull request.

            $ git fetch git://github.com/git-l10n/git-po.git master
            $ git rebase --onto FETCH_HEAD HEAD~1

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

Hope this may help, and not bring troubles.

-- 
Jiang Xin
