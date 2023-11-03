Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB356FDA
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF+6UQa0"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2666DD4D
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 04:41:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc2575dfc7so16223655ad.1
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699011688; x=1699616488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o70dtQiTCDZTbCs2NKQImDOyNGIYzWne3Wp067Na6j0=;
        b=IF+6UQa0GfzJvcYm4SJjd2wPTc1Dmd5SWr4IZ684NrMUUhCHmcmNUBSzyKmp0TYUE3
         YmjU3r42swZGjNmVZ9V1OR4f7F35hm1sYmK7ZLNw8fvoSWdE/TRm2PkG/br/vK9plMDh
         7iBzt5zN7mNov1JyX0HQNv0b4PpKbOXF413oxlNi0DgPrhCzV3BD10iL1AuqOv6JD5ZI
         Bj1y2EJYoCdkYr9F0Hgbj4PfA+F/BwCqmsqsye/ZpdUsV5xmRKwHIR88WpbbiTn18DH/
         22V1Tx7PGBJkGjLweQ6T6IndtpIi5w6sQZkC5LO+dBwm3pP2SjL2A8pdL326DS/uitAU
         qaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699011688; x=1699616488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o70dtQiTCDZTbCs2NKQImDOyNGIYzWne3Wp067Na6j0=;
        b=sHqPoZtCPkOvBGKQCl37K2FUPovPdzqpsL0+wxHy90YM8etNCQd4sZNx/OivRldTtL
         /d0vjqQ+EhlkEB5Qb2JX1RuIvn2bk8AtkHPV2kcKSGyEtNDTNSGvev4ToAtpf9J2fnej
         2LW3C1v2wwqVBRkbliPLP8ggnjUhTCig6r/p4yRk4dDl9Gbjb5ymu8iXicUnldGKfmYz
         N/hnh3lEFUStuhvmoz7noA0mR46Ub5rhZmXUgALLremEUKXFrtMBmo167g8PSSYX8EGj
         4Q9O+XVJPwoyewR3VL63zpvGx8clN43OkXAQIrnrbCyEmV/k0H2HqGav7pAh9XOF+q2e
         LHew==
X-Gm-Message-State: AOJu0Yz+z3w2zjQA536dATjmfG2P2FbwdLyPUfN6yaVsSEmGVKynOfYe
	lArpa0UyiTkgazxO4gv2ZmFPOGbC2QKz5g==
X-Google-Smtp-Source: AGHT+IFw8m7Em7lii91A57r+UH+hxy+JLFrKkKedVE86trUFxobA314uKhvk5DCcGbroK+bKbmSisA==
X-Received: by 2002:a17:90a:8:b0:280:c576:31bb with SMTP id 8-20020a17090a000800b00280c57631bbmr5736075pja.35.1699011688306;
        Fri, 03 Nov 2023 04:41:28 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090ad50600b0027d219d3ac6sm1295320pju.47.2023.11.03.04.41.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Nov 2023 04:41:27 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Jordi Mas <jmas@softcatala.org>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Jimmy Angelakos <vyruss@hellug.gr>,
	=?UTF-8?q?Christopher=20D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alessandro Menti <alessandro.menti@alessandromenti.it>,
	Gwan-gyeong Mun <elongbug@gmail.com>,
	Arusekk <arek_koz@o2.pl>,
	Daniel Santos <dacs.git@brilhante.top>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= <vnwildman@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.43.0 round #1
Date: Fri,  3 Nov 2023 19:41:24 +0800
Message-Id: <20231103114124.21811-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.43.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 84 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Sun, 19 Nov 2023. 

    https://github.com/git-l10n/git-po/

As of git 2.37, we (git l10n contributors) have a new l10n workflow. The
following description of the new l10n workflow is from the "po/README.md"
file.


## The "po/git.pot" file is a generated file, no longer in the repository

The l10n coordinator does not need to generate the "po/git.pot" file every
time to start a new l10n workflow, and there is no "po/git.pot" file at all.

Everyone can generate the "po/git.pot" file with the command below:

    make po/git.pot

But we can also forget about it. By updating our corresponding "po/XX.po"
file, the "po/git.pot" file is automatically generated.


## Update the "po/XX.po" file, and start to translate

Before updating the "po/XX.po" file, l10n contributors should pull the latest
commits from the master branch of "git.git". E.g.:

    git pull --rebase git@github.com:git/git.git master

Then update the cooresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodate "po/XX.po" file, and create a new commit.


## Refine your commits, send pull requests

In the "po/XX.po" file, there are location lines in comments like below:

    #: add-interactive.c:535 add-interactive.c:836 reset.c:136 sequencer.c:3505
    #: sequencer.c:3970 sequencer.c:4127 builtin/rebase.c:1261
    #: builtin/rebase.c:1671

These comments with file locations are useful for l10n contributors to locate
the context easily during translation. But these file locations introduce a
lot of noise and will consume a lot of repository storage. Therefore, we
should remove these file locations from the "po/XX.po" file.

To remove file locations in the "po/XX.po" file, you can use one of the
following two ways, but don't switch back and forth.

 * Keep the filenames, only remove locations (need gettext 0.19 and above):

        msgcat --add-location=file po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

 * Remove both filenames and locations:

        msgcat --no-location po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

After squashing trivial commits and removing file locations in the "po/XX.po"
file, send pull request to the l10n coordinator's repository below:

    https://github.com/git-l10n/git-po/


## Resolve errors found by the l10n CI pipeline for the pull request

A helper program hosted on "https://github.com/git-l10n/git-po-helper" can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions as l10n CI
pipeline to validate each pull request in the "git-l10n/git-po" repository.
Please fix the issues found by the helper program.


** Please note: The update window will close on Sun, 19 Nov 2023. **


--
Jiang Xin
