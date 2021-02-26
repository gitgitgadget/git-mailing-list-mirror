Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EF0C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898EF64E38
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 12:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZMKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 07:10:36 -0500
Received: from mout.gmx.net ([212.227.15.18]:56115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhBZMKe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 07:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614341342;
        bh=fK8Zi2tvSUwWNBjpbjKDpA1dusT5bepigl19VK5d0+c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kJ5x9o/wjVqUKjAu7uI2HmY72v0cq8ixuatadryVARir5uEM2LRfSgWdhi2fVaQ6h
         aYU7ouCY/CsLzJeEx75KlhlSBpk1xqyZZUwa24fUtDiRe5+vY3eagoJg1cecE/JoKz
         czN1YioxOEPy7K4mRDn0EO3yR/L6XqxitGXm1yX4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az132-388.arhwbrt4m44e5iaw53mmhiu5qf.xx.internal.cloudapp.net
 ([52.191.174.81]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1Mqb1W-1lbSDl2lX6-00mfau; Fri, 26 Feb 2021 13:09:02 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.31.0-rc0
Date:   Fri, 26 Feb 2021 12:08:58 +0000
Message-Id: <20210226120858.6103-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.30.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:jnkLYjZoGMBg+HCvPxBYcHl3hL5d5rf1gTbE5QpgIhu9KGdkJ1n
 sYbeO5F9tGN1nTEQJcf6Fo7Nwz+FGHOUVywqvm/hGPMpt4n5l+ORq25+JgxsXSQfABkgOf/
 Jaw2BWNooKVrbhlbA9fvegeINyDMus7/D6Y/LDpF6EsqhdpYemRytMnG5GmWidHNsuOjn//
 TfTHf9bS8lrmK5ovS4oXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FdQmWzlg8nU=:28HWZx+cXqpOCJx9rwTcBW
 hOQlu+UEXSZFgGfBhGeJG4r4+MMwZ6Dviymgio9Ifhpis6ISe8QbuhMD7x7X83GqTJh2XGdEV
 eYyxeT8m+ueCzD5cnpjdKex/1oJsjExzBDmzyh29CZZU+NtUJIHYfEInmy1IBBKULLWy4f3rN
 YI0CkXaFn7kEDQZfwAXeC6wbv8OdB/2ImaXRglu00sPihqhh+YVcqpuLjGS2JAk/KuLh0TzuJ
 CLK3LCRfSL33n8b9gSA/UGeKI41PFDKkhI2x1vks6ekrHenbrXq7nPHTSvd82aNRfLkpPlkIZ
 HHP1fstsiN5TH4Pvj07ha7YhBr9/6HDdUZ9oVaF3LSEH0pe/8tfHgCx5HVEcjSfgyIaSFodc9
 CgbtZgXWOdOP1VtTytu+fmOQL+gjtqnhYuViP/z7ZokAeF6OUMuDHpGpz7saJuW46627Cq9cJ
 C+4FXaIEHvACmTBkVLKP2MA0WFSzCtuik76WqwyV+bjkcrGgOw5h/Fy88o40HkyJ/fKKXpE+r
 1sThTpP8nlPSt+2Ax3G+hIt5jYRI057S2NGO0VtYf5CgCtR8uWq7OCZI/blGMFL5ebeQ0clA6
 DGUfMsRjJiPvHLTkj9BW480vu9Blp740eYI7FL05J2I/YQn6qoTAl/NcAhTJhv/CSa6wWoUdB
 7MiUm+6WzHDNneW/krVK1lw3ysI1CXpZlc3wwVrc+N1Aq6rw40DG2Y5fSJO/Z9UwxSYFjiM2m
 z4YvSYUZqD35uZj3KRHaYiAVwWpZxCMghptqIbXrHxHJ7i6Gd25V0yA2r79naq4QT10klfJR6
 wixneSeLGTptyHK7IVjW+5wtw73YxmVVHSEQ1fFyLnT9iHq1FWK+v0inVVle5cME9VgyJprox
 hT3TQV7MOJUSIOe90d3AOsEHhEdtyw45xJ+wLasjY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.31.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.31.0-rc0.windows.1

Changes since Git for Windows v2.30.1 (February 9th 2021)

New Features

  * Comes with Git v2.31.0-rc0.
  * Comes with PCRE2 v10.36.
  * Comes with tig v2.5.2.
  * Comes with OpenSSL v1.1.1j.

Git-2.31.0-rc0-64-bit.exe | b2a70c18924822efff3352e3e064206bd91ab7b21805367bfc90f1ad7f5432c9
Git-2.31.0-rc0-32-bit.exe | 3797f2d9319dd16064e12d8c12f5a81cabc87000aa3b7a34a2a0da735f75dde6
PortableGit-2.31.0-rc0-64-bit.7z.exe | ef5ac1b399a6877f22ae0d8e2b54b22cd2bfb967a52026fa22b098a8c5b805fc
PortableGit-2.31.0-rc0-32-bit.7z.exe | a8234607a5d984aca228ad9e7ebd6ba9467dc15d70271017c3a198d560ce0dc6
MinGit-2.31.0-rc0-64-bit.zip | 25780258faae9f4a6237e68d7af64dd3cfd7c6f68f45cb07e9f530744caade07
MinGit-2.31.0-rc0-32-bit.zip | c1aebd29ba088df66e27c777ca602c5666a52db95f9ff52085f0de34e3074697
MinGit-2.31.0-rc0-busybox-64-bit.zip | 68eeeeaf717c846eb25ae518e24e14d05d7eb328f6e830f1a02bba92decc6551
MinGit-2.31.0-rc0-busybox-32-bit.zip | 9d23c0cc5ff3a30b3e5514e442bbacef73ba0bec63f6dc848e9aa35a9aedfcc6
Git-2.31.0-rc0-64-bit.tar.bz2 | 7eeae96ff1189ae741ab83f2aa70e72c01865cf758705f6ed177cd8c25f6aa3d
Git-2.31.0-rc0-32-bit.tar.bz2 | 678456c8db8536b1ebd0f80a0c889d88861a1f1d2c8d9b13b1bae5022a53fe1d

Ciao,
Johannes
