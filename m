Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2nfaV/B"
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B89E
	for <git@vger.kernel.org>; Sun, 19 Nov 2023 16:13:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-280165bba25so2530132a91.2
        for <git@vger.kernel.org>; Sun, 19 Nov 2023 16:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700439194; x=1701043994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkG2DhVWTydx8NZ/IAvx2M03duwDS3mZP938sCRmFpE=;
        b=Q2nfaV/B08yn3wo+J6wkq+/Vlerr/dBKKTr56xxcolW548ZwcUy5ewmLiUCvXpmE5k
         mnTnaiRbkDteLyHU3VS/y6fLZXW9BIWRSVsZOYKPVER2LS+DqX+zn+FAGRb1GgxBvNnk
         qloQ9hCCyQyZfy9S47xUolGFIBqkv1gXvFpAJ+1GrD3B5mJZ4JgkTXaPDYyWW1h+2Hqi
         duBRWm6K6jy8v+NUykVyPTZL4da3KU2VBoumaoAEUjGE4ss/nD9jQElK7aFGhsHhcmWm
         wJrNN056IWoyCp/tQZtMzIwKl12nbkhyvhyPKaGau/fUG3N9Xz///zCvmtZs0AZxCW8F
         ETAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700439194; x=1701043994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkG2DhVWTydx8NZ/IAvx2M03duwDS3mZP938sCRmFpE=;
        b=lkocdGcOuu6sbZwWIwIqw5Mp2kBldf1Q2KW4eISgABW30EvAoaV7JuLaUTvK3zYU9J
         ejx01yLO5ZoYAMx9HNhp4SsDYpKwir9pivt0A+YyWIiLv4eKY1WRBlc7yOERtS6ZwYEe
         TB35axRYp/SL1oGWEocYwm3y5vCV9ThUrZJhzWyUEJ1dMyoasMu2yEnSMAgo6O74Y1GB
         rZHYbSGw5MKQOc99OVH8O5gXGXZfAf9rmy+ZkIcUCiLXSO+cZirRp9qMt4jb3i3BrXFr
         i+J4L68jqi37ffiMM86om50Aevdi6zP74RHfRLDSY3pGFTFE5XKX0nKtDd1zbrRcWsaj
         082Q==
X-Gm-Message-State: AOJu0Yy5WXwIIgJC435KIt5xMdWrLVcWCX5AzVVB/0koq9TDeQBNoynw
	9UzN1nUsEPid8l9vu8o7WLmQHKFvsVA=
X-Google-Smtp-Source: AGHT+IHwzbMkBQwZEL6lc1RTCJIE/cPPid60Pwbb0ggDenrQ/gQCLoYlFnXoWDpcs/gLfX5o5LdNOQ==
X-Received: by 2002:a17:90b:1e03:b0:280:ca21:e50c with SMTP id pg3-20020a17090b1e0300b00280ca21e50cmr3717256pjb.35.1700439193926;
        Sun, 19 Nov 2023 16:13:13 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090ad91000b0028514bf911asm2109597pjv.43.2023.11.19.16.13.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2023 16:13:13 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Arkadii Yakovets <ark@cho.red>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Emir SARI <emir_sari@icloud.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jordi Mas <jmas@softcatala.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: [GIT PULL] l10n updates for 2.43.0 round 2
Date: Mon, 20 Nov 2023 08:13:09 +0800
Message-Id: <20231120001309.24434-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Please pull the following l10n updates for Git 2.43.0.

The following changes since commit cfb8a6e9a93adbe81efca66e6110c9b4d2e57169:

  Git 2.43-rc2 (2023-11-14 15:14:45 +0900)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.43.0-rnd2

for you to fetch changes up to d30343266793525abd82c15fcb246d892f474d92:

  Merge branch 'l10n/zh-TW/2023-11-19' of github.com:l10n-tw/git-po (2023-11-20 07:57:09 +0800)

----------------------------------------------------------------
l10n-2.43.0-rnd2
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAmVaodkACgkQk24VDd1F
MtUXAxAAqkzi6QOAXCdCFylSP/zSHGoOdY1zpOZxKcQbfmfY6FBUVAW31c3nCg6h
7OIXmreS2sMY+nIhvowSQO/Azn7Ka/kglB3MaOu5EcfO9SEbAGmT4JtvDOSLdUZS
kZytWwvFY83l3aJGCPmz5FDc6upo3v9b2aSrbiYv3o7A+r3YSwTtLqKeoXZnRyg9
ACh2fq2PVJV/LkPXbbg6xcwsiKSOL71hUBH/OfZrPuEIXQUJZXgUQySopu2R4HX2
UPyP2uhg5XncoN4oCgkFTX/tO+lIzdnREzCVQGlmHI4v0WFOIPKP9bgMQHi4qRi7
SMwCW+su8vFPCucNgeM8xh6NYg7UBCR3RXq8tRw7WCct3Hz3FHVS5HI/zCg/lCD8
4YS3CcCokGggif4ONV0qrQQih3QXv4mwmtzGy7y6t+4Qi0XKV17yJb5d6Es+/7YT
/CTM3JQNguiejNzNjrvMg6LOBBYr32dULnH8+E8ZYaG8wZY4ZI8gwR4p0BUNvE6K
Sxa+/2sdskaNL+h4vhT+dq3skDqxfy2gLc6UavTLkxwEzRLMlqD9h4SbXyJKl2ur
VH7A/KoypdrMoRcYeDtM00kMONxQmVXhLWE0PHdUIHnj3Bt4skMWEJCI5Xc5oQIE
uoNUYDhs9mDbQybJU/1Sak7f5C0qwqMjp5QczyTWgEGrUdqnPLs=
=XEYO
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (5579t)

Arkadii Yakovets (1):
      l10n: update uk localization for v2.43

Bagas Sanjaya (1):
      l10n: po-id for 2.43 (round 1)

Emir SARI (1):
      l10n: tr: v2.43.0

Jean-Noël Avila (1):
      l10n: fr: v2.43.0 rnd 2

Jiang Xin (8):
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'fr_v2.43.0' of github.com:jnavila/git
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'catalan' of github.com:Softcatala/git-po
      Merge branch '2.43-uk-update' of github.com:arkid15r
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'l10n/zh-TW/2023-11-19' of github.com:l10n-tw/git-po

Jordi Mas (1):
      l10n: Update Catalan translation

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (5579t)

Ralf Thielow (1):
      l10n: Update German translation

Teng Long (1):
      l10n: zh_CN: for git 2.43.0-rc1

Yi-Jyun Pan (1):
      l10n: zh-TW: Git 2.43.0-rc1

 po/bg.po    | 1448 ++++++++++++++----------
 po/ca.po    |  691 +++++++-----
 po/de.po    |  571 ++++++----
 po/fr.po    |  640 +++++++----
 po/id.po    |  674 ++++++-----
 po/sv.po    | 3569 ++++++++++++++++++++++++++++++-----------------------------
 po/tr.po    |  529 +++++----
 po/uk.po    |  625 ++++++-----
 po/zh_CN.po |  602 ++++++----
 po/zh_TW.po | 1116 +++++++------------
 10 files changed, 5712 insertions(+), 4753 deletions(-)

--
Jiang Xin
