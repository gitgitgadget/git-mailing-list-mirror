Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFF51F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfIBSPi (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:15:38 -0400
Received: from sonic316-14.consmr.mail.bf2.yahoo.com ([74.6.130.124]:34436
        "EHLO sonic316-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbfIBSPi (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Sep 2019 14:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1567448136; bh=tmWoDAgAB4d20UmjQF/bTytWVrcf+EYGui+BExnaKuw=; h=From:To:Cc:References:In-Reply-To:Subject:Date:From:Subject; b=cbrJh+PxcgmcSpopBZq8xvxHatgDEnovcs5IyclqsPWOfCpIxq5TMWPuo4aCxxXWBxzztXcJ/awcKpd8P+i6C/BDulb7jtmRQuvGi4ck0yg/n4LFu1g+Uo5DBmPub/MTdQBc3LNnyk7nweU886BDulz8Nix6mz1oVGVkNRKAnvuCbs/pRXmQeowmbZSiUG8lL6gFj3CPbgAxgtm0aFoKKPJhV8gtb+RW/VF+zv2yuqh1V7agQRnY8y+kiiGKuQBf71rZ1mt/iog6ankna0jsJ/uBSbw30lk3iw2BCIJSkzcnzAtAMmqvYbviF401MiO2C4ExPDkFuqnxpIOCD63O0w==
X-YMail-OSG: qeay0SgVM1muZobcdHJWnN5qCzcuK1wbUTFHHD.zrbNn0PnaJf.DccdhMV3RCC5
 6AgU97y58lftGB5HClvH_ODXz7K3S0aeLdQLGSc8NqndCRqd6b16rkQcgpDt9r1FoiuEra3tQqPy
 RcC_Z4_VuAW_VmTDUXuVuXzR9RpZxmeB3b2zfprdJd_EWYVEGo5_R02X4rjL5Qu6ETtGPJOVjdV3
 l5gh7LALi2xRgflEAZYhkkZdB0pL5u6H7xY23QWyIozGomYt6G9NLMZ52o9YinT_YKoJTUAJ9RfC
 gVv32Sb2oBV9HNXPF9v3LYpKQo3GDlnb7CMQxDrq9h9Whbt3SQTPKM3JrLQbZB3AHgFO7oJm5u9J
 JrYs.gLSuHX10bfsEQFexvfbJfoLyHjOAp6rsNbqjjOxY1lGbUjFZfJPW41NEp2To16DVdGraUeK
 lSnxrhC_yFonzNlQwC3zTzXaB24yZ8U3.GrfwDSzVdaX2.JGiIwKIH2YUB1PEbu6Ax1oKJNoIdtm
 kzHZ_0SlWjw7_ZGGf7F.148QM.wuTNqZg3iQcFsZXPgPpL3Sh3r9MRa8U2Ae4IhHdCzHgIujPgvG
 EwcMA789EKDS.CcMD9eCL477TwLmgmSdnp8Jn_Vo1I6PINdSy2A1giX43Zw98DgRjnPVbJJpSxVc
 P28jaqTri9n1Fl04_Tc3b9r.shFdDBxMXVFTqVq5M5F1uWuwIkx1sGNWaFy8R0PHFz2p46cWJGli
 tp2gkCl.yp0FbcIsO7dGdu2buiK1L9OCUTS5xq.IVs_DB4vI6uZ7BEO1OvNb1RqpV6LEYI2r4Sr9
 aD7UXxErgY0dsy8cCl15J3PzU7uv.yZetYfGdDOebF0Aizf.JSGT0ric23ah2noQthNqx5f.UMN1
 J2w.pGciQt.HLWSiXTEn1jgdy.6EzIMYNLwiVRuAnS6lcNOEJlJ0wqaOpn6ZsIxNGXtrWbAjtIV1
 ffxH46_6aJ.hRxCuJ8AdgyVBl5wi7illFymxdhYnBcXpZu.h8N_Q1Wxd9CKlGItoNlfGRb.X1_NE
 j2dMMebfNsKozOO92r7DMoPJ.4eKhpzv9nEJNQhCvnMf6b6lJ6hOtMAP2R7mqKWdslF1iNgftMav
 q0uGS5EJTUA0yNaX4u.T8IfzZtvZ.GT7ntcMIbdeIRDfJeNfzCEu2M2R1h_ST4pD7vBDb8kUc1oE
 zsmD9QSOTa5y77fmZvUvd6tzbRZnCQ1qRZQxbDln0znJLPVSO8n5mPeJlja2FKCMt.nODflvZ6ug
 axFSuaQ0IWDNAbkerlCWN56i2RJLHRHLxZ_kJZ21CzkZ05FLpUy5sMi9Tais3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 2 Sep 2019 18:15:36 +0000
Received: by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d0eb40ad546664a111b48d2d6f080142;
          Mon, 02 Sep 2019 18:15:35 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     "'Philip Oakley'" <philipoakley@iee.email>,
        <002901d55e8f$e4a4af70$adee0e50$@rogers.com>
Cc:     <git@vger.kernel.org>
References: <20190902130128.GA2843@instance-1.europe-west6-a.c.vaulted-journal-250706.internal> <966960ff-a8bb-42bb-0b0a-13cd00852068@iee.email>
In-Reply-To: <966960ff-a8bb-42bb-0b0a-13cd00852068@iee.email>
Subject: RE: [BUG} stash show does not show untracked files stashed (reposted)
Date:   Mon, 2 Sep 2019 14:15:33 -0400
Message-ID: <006301d561ba$69ca61e0$3d5f25a0$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGZV4LCvIfBhJB9BkX6qXoYx4YPvgGM8R9zp4Rc7cA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Philip Oakley <philipoakley@iee.email>
> Sent: September 2, 2019 11:56 AM
> To: 002901d55e8f$e4a4af70$adee0e50$@rogers.com;
> randall.s.becker@rogers.com
> Cc: git@vger.kernel.org
> Subject: Re: [BUG} stash show does not show untracked files stashed
> (reposted)
>=20
> On 02/09/2019 14:01, Giuseppe Crin=C3=B2 wrote:
> >> Suppose I have files a,b,c,d modified, but only file d is in the =
index.
> >> After stash push  (or save) --include-untracked, stash show only
> >> displays file d. A subsequent pop will restore files a,b,c,d. So
> >> functionally push and pop are fine, but stash show appears to =
ignores files
> in the stash.
> > This is more of an enhancement, isn't it?
> >
> > To reproduce
> >
> > $ touch a b c d
> > $ git add d
> > $ git stash push --include-untracked
> > $ git stash show
> >   d | 0
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> >
> > What is the output that you think should be printed?
> >
>=20
> I'd guess
>=20
>   1 file changed, 0 insertions(+), 0 deletions(-), *3 files untracked*
>=20
> as they are what's meant to be in the stash... (obviously format to =
taste)

More like this, from git stash show -p, to be consistent with git show =
-p 4ef9fc3 (the ref for the untracked files), showing 0000000 indicating =
that the file is not tracked.

diff --git a/d b/d
index e3e2f1d..f246285 100644
--- a/a
+++ b/a
@@ -2,3 +2,4 @@ This is file 1
 Yet another line
 New line
 New line 2
+ another line
diff --git a/a b/a
new file mode 100644
index 0000000..64d8b7a
--- /dev/null
+++ b/a
@@ -0,0 +1 @@
+line in a
diff --git a/b b/b
new file mode 100644
index 0000000..9aeb214
--- /dev/null
+++ b/b
@@ -0,0 +1 @@
+line in b
diff --git a/c b/c
new file mode 100644
index 0000000..87bb92b
--- /dev/null
+++ b/c
@@ -0,0 +1 @@
+line in c


