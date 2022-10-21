Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E507EC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 10:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJUKb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJUKbu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 06:31:50 -0400
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Oct 2022 03:31:45 PDT
Received: from qs51p00im-qukt01071901.me.com (qs51p00im-qukt01071901.me.com [17.57.155.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609A3BC5F
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1666347869;
        bh=hlGB/LUZEKkJ68UrrDkVvZ4WX0DjJ39Tarc9UtSJeIk=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=r3/5RANylZ1OkHjnOMkLXdh9oZai6ZknKBqnMZ+N8DVpk7a9Rv6FJJfv2+EhH7G3G
         kLR08BGm1vZT39tgNEmAlaaFry18GJ7+Fya1BLICzD5B/ucCa8L1PWdLjEzcaJZ3K2
         GMy0vV+qDmmtAQIWjlOr5PSFVSlwOPT8Pg7aYDOQKz8hHq8gO6Pm/diNWMMs81J31v
         uAHBNJuRkIb3JM3l5YqUIFvKdaJtgXglwDyMPT+yZfgRYJu2k3J3sEOi+ZaX1OaQXz
         j/OJQ4mOB6k8BpVEMrLfu4eFvOFoAyiN7dJEWHk42jkuuef41vha1z1/obh5tYM2Yk
         l/HNRQIWK/Egw==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071901.me.com (Postfix) with ESMTPSA id 412736280533;
        Fri, 21 Oct 2022 10:24:18 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH] git-gui: added Turkish translation
From:   Emir SARI <emir_sari@icloud.com>
In-Reply-To: <20220113130705.55378-1-emir_sari@icloud.com>
Date:   Fri, 21 Oct 2022 13:24:03 +0300
Cc:     patthoyts@users.sourceforge.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5640442-7F17-453D-AF99-70F4E3DBE0FA@icloud.com>
References: <20220113130705.55378-1-emir_sari@icloud.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Proofpoint-GUID: Fh2cSrc-u27PVMA9N6ytnZmuSrwR93hS
X-Proofpoint-ORIG-GUID: Fh2cSrc-u27PVMA9N6ytnZmuSrwR93hS
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210060
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It=E2=80=99s been a while since I=E2=80=99ve submitted translations for =
the git-gui as well (I=E2=80=99m the Git Turkish coordinator). Just =
pinging regarding the patch approval.

Thanks in advance!

> Emir SARI <emir_sari@icloud.com> =C5=9Funlar=C4=B1 yazd=C4=B1 (13 Oca =
2022 16:07):
>=20
> Signed-off-by: Emir SARI <emir_sari@icloud.com>
> ---
> git-gui/po/tr.po | 2829 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 2829 insertions(+)
> create mode 100755 git-gui/po/tr.po
>=20
> diff --git a/git-gui/po/tr.po b/git-gui/po/tr.po
> new file mode 100755
> index 0000000000..648595e9f5
> --- /dev/null
> +++ b/git-gui/po/tr.po
> @@ -0,0 +1,2829 @@
> +# Turkish translations for Git GUI
> +# Git grafik kullan=C4=B1c=C4=B1 arabirimi T=C3=BCrk=C3=A7e =
=C3=A7evirileri
> +# Copyright (C) 2022 Emir SARI <emir_sari@msn.com>
> +# This file is distributed under the same license as the Git package.
> +# Emir SARI <emir_sari@msn.com>, 2022
> +#
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: Git GUI Turkish Localization Project\n"
> +"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
> +"POT-Creation-Date: 2021-11-10 08:55+0800\n"
> +"PO-Revision-Date: 2022-01-13 18:00+0300\n"
> +"Last-Translator: Emir SARI <emir_sari@msn.com>\n"
> +"Language-Team: Turkish (https://github.com/bitigchi/git-po/)\n"
> +"Language: tr\n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=3DUTF-8\n"
> +"Content-Transfer-Encoding: 8bit\n"
> +"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
> +
> +#: git-gui.sh:847
> +#, tcl-format
> +msgid "Invalid font specified in %s:"
> +msgstr "%s i=C3=A7inde ge=C3=A7ersiz yaz=C4=B1tipi belirtimi:"
> +
> +#: git-gui.sh:901
> +msgid "Main Font"
> +msgstr "Ana Yaz=C4=B1tipi"
> +
> +#: git-gui.sh:902
> +msgid "Diff/Console Font"
> +msgstr "Diff/Konsol Yaz=C4=B1tipi"
> +
> +#: git-gui.sh:917 git-gui.sh:931 git-gui.sh:944 git-gui.sh:1034 =
git-gui.sh:1053
> +#: git-gui.sh:3212
> +msgid "git-gui: fatal error"
> +msgstr "git-gui: Onulmaz hata"
> +
> +#: git-gui.sh:918
> +msgid "Cannot find git in PATH."
> +msgstr "git, PATH i=C3=A7inde bulunam=C4=B1yor."
> +
> +#: git-gui.sh:945
> +msgid "Cannot parse Git version string:"
> +msgstr "Git s=C3=BCr=C3=BCm dizisi ayr=C4=B1=C5=9Ft=C4=B1r=C4=B1lam=C4=B1=
yor:"
> +
> +#: git-gui.sh:970
> +#, tcl-format
> +msgid ""
> +"Git version cannot be determined.\n"
> +"\n"
> +"%s claims it is version '%s'.\n"
> +"\n"
> +"%s requires at least Git 1.5.0 or later.\n"
> +"\n"
> +"Assume '%s' is version 1.5.0?\n"
> +msgstr ""
> +"Git s=C3=BCr=C3=BCm=C3=BC belirlenemedi.\n"
> +"\n"
> +"%s, s=C3=BCr=C3=BCm '%s' oldu=C4=9Funu iddia ediyor.\n"
> +"\n"
> +"%s, en az Git 1.5.0 veya sonras=C4=B1 gerektiriyor.\n"
> +"\n"
> +"'%s', s=C3=BCr=C3=BCm 1.5.0 olarak varsay=C4=B1ls=C4=B1n m=C4=B1?\n"
> +
> +#: git-gui.sh:1267
> +msgid "Git directory not found:"
> +msgstr "Git dizini bulunamad=C4=B1:"
> +
> +#: git-gui.sh:1301
> +msgid "Cannot move to top of working directory:"
> +msgstr "=C3=87al=C4=B1=C5=9Fma dizininin en tepesine ta=C5=9F=C4=B1nam=C4=
=B1yor:"
> +
> +#: git-gui.sh:1309
> +msgid "Cannot use bare repository:"
> +msgstr "=C3=87=C4=B1plak depo kullan=C4=B1lam=C4=B1yor:"
> +
> +#: git-gui.sh:1317
> +msgid "No working directory"
> +msgstr "=C3=87al=C4=B1=C5=9Fma dizini yok"
> +
> +#: git-gui.sh:1491 lib/checkout_op.tcl:306
> +msgid "Refreshing file status..."
> +msgstr "Dosya durumu yenileniyor..."
> +
> +#: git-gui.sh:1551
> +msgid "Scanning for modified files ..."
> +msgstr "De=C4=9Fi=C5=9Ftirilen dosyalar i=C3=A7in taran=C4=B1yor..."
> +
> +#: git-gui.sh:1629
> +msgid "Calling prepare-commit-msg hook..."
> +msgstr "prepare-commit-msg kancas=C4=B1 =C3=A7a=C4=9Fr=C4=B1l=C4=B1yor.=
.."
> +
> +#: git-gui.sh:1646
> +msgid "Commit declined by prepare-commit-msg hook."
> +msgstr "=C4=B0=C5=9Fleme, prepare-commit-hook taraf=C4=B1ndan =
reddedildi."
> +
> +#: git-gui.sh:1804 lib/browser.tcl:252
> +msgid "Ready."
> +msgstr "Haz=C4=B1r."
> +
> +#: git-gui.sh:1968
> +#, tcl-format
> +msgid ""
> +"Display limit (gui.maxfilesdisplayed =3D %s) reached, not showing =
all %s files."
> +msgstr ""
> +"G=C3=B6r=C3=BCnt=C3=BCleme limitine (gui.maxfilesdisplayed =3D%s) =
eri=C5=9Fildi, t=C3=BCm %s dosya "
> +"g=C3=B6sterilmiyor."
> +
> +#: git-gui.sh:2091
> +msgid "Unmodified"
> +msgstr "De=C4=9Fi=C5=9Ftirilmemi=C5=9F"
> +
> +#: git-gui.sh:2093
> +msgid "Modified, not staged"
> +msgstr "De=C4=9Fi=C5=9Ftirilmi=C5=9F, haz=C4=B1rlanmam=C4=B1=C5=9F"
> +
> +#: git-gui.sh:2094 git-gui.sh:2106
> +msgid "Staged for commit"
> +msgstr "=C4=B0=C5=9Fleme i=C3=A7in haz=C4=B1rlanm=C4=B1=C5=9F"
> +
> +#: git-gui.sh:2095 git-gui.sh:2107
> +msgid "Portions staged for commit"
> +msgstr "=C4=B0=C5=9Fleme i=C3=A7in haz=C4=B1rlanan k=C4=B1s=C4=B1mlar"
> +
> +#: git-gui.sh:2096 git-gui.sh:2108
> +msgid "Staged for commit, missing"
> +msgstr "=C4=B0=C5=9Fleme i=C3=A7in haz=C4=B1rlanm=C4=B1=C5=9F, eksik"
> +
> +#: git-gui.sh:2098
> +msgid "File type changed, not staged"
> +msgstr "Dosya t=C3=BCr=C3=BC de=C4=9Fi=C5=9Ftirilmi=C5=9F, =
haz=C4=B1rlanmam=C4=B1=C5=9F"
> +
> +#: git-gui.sh:2099 git-gui.sh:2100
> +msgid "File type changed, old type staged for commit"
> +msgstr "Dosya t=C3=BCr=C3=BC de=C4=9Fi=C5=9Ftirilmi=C5=9F, eski t=C3=BC=
r i=C5=9Fleme i=C3=A7in haz=C4=B1rlanm=C4=B1=C5=9F"
> +
> +#: git-gui.sh:2101
> +msgid "File type changed, staged"
> +msgstr "Dosya t=C3=BCr=C3=BC de=C4=9Fi=C5=9Ftirilmi=C5=9F, =
haz=C4=B1rlanm=C4=B1=C5=9F"
> +
> +#: git-gui.sh:2102
> +msgid "File type change staged, modification not staged"
> +msgstr "Dosya t=C3=BCr=C3=BC de=C4=9Fi=C5=9Fikli=C4=9Fi =
haz=C4=B1rlanm=C4=B1=C5=9F, de=C4=9Fi=C5=9Fiklik haz=C4=B1rlanmam=C4=B1=C5=
=9F"
> +
> +#: git-gui.sh:2103
> +msgid "File type change staged, file missing"
> +msgstr "Dosya t=C3=BCr=C3=BC de=C4=9Fi=C5=9Fikli=C4=9Fi =
haz=C4=B1rlanm=C4=B1=C5=9F, dosya eksik"
> +
> +#: git-gui.sh:2105
> +msgid "Untracked, not staged"
> +msgstr "=C4=B0zlenmeyen, haz=C4=B1rlanmam=C4=B1=C5=9F"
> +
> +#: git-gui.sh:2110
> +msgid "Missing"
> +msgstr "Eksik"
> +
> +#: git-gui.sh:2111
> +msgid "Staged for removal"
> +msgstr "Kald=C4=B1rma i=C3=A7in haz=C4=B1rlanm=C4=B1=C5=9F"
> +
> +#: git-gui.sh:2112
> +msgid "Staged for removal, still present"
> +msgstr "Kald=C4=B1rma i=C3=A7in haz=C4=B1rlanm=C4=B1=C5=9F, h=C3=A2l=C3=
=A2 mevcut"
> +
> +#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
> +#: git-gui.sh:2118 git-gui.sh:2119
> +msgid "Requires merge resolution"
> +msgstr "Birle=C5=9Ftirme =C3=A7=C3=B6z=C3=BCm=C3=BC gerektiriyor"
> +
> +#: git-gui.sh:2164
> +msgid "Couldn't find gitk in PATH"
> +msgstr "gitk, PATH i=C3=A7inde bulunamad=C4=B1"
> +
> +#: git-gui.sh:2210 git-gui.sh:2245
> +#, tcl-format
> +msgid "Starting %s... please wait..."
> +msgstr "%s ba=C5=9Flat=C4=B1l=C4=B1yor... l=C3=BCtfen bekleyin..."
> +
> +#: git-gui.sh:2224
> +msgid "Couldn't find git gui in PATH"
> +msgstr "git-gui, PATH i=C3=A7inde bulunamad=C4=B1"
> +
> +#: git-gui.sh:2726 lib/choose_repository.tcl:53
> +msgid "Repository"
> +msgstr "Depo"
> +
> +#: git-gui.sh:2727
> +msgid "Edit"
> +msgstr "D=C3=BCzen"
> +
> +#: git-gui.sh:2729 lib/choose_rev.tcl:567
> +msgid "Branch"
> +msgstr "Dal"
> +
> +#: git-gui.sh:2732 lib/choose_rev.tcl:554
> +msgid "Commit@@noun"
> +msgstr "=C4=B0=C5=9Fleme@@noun"
> +
> +#: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
> +msgid "Merge"
> +msgstr "Birle=C5=9Ftir"
> +
> +#: git-gui.sh:2736 lib/choose_rev.tcl:563
> +msgid "Remote"
> +msgstr "Uzak Konum"
> +
> +#: git-gui.sh:2739
> +msgid "Tools"
> +msgstr "Ara=C3=A7lar"
> +
> +#: git-gui.sh:2748
> +msgid "Explore Working Copy"
> +msgstr "=C3=87al=C4=B1=C5=9Fma Kopyas=C4=B1n=C4=B1 Ara=C5=9Ft=C4=B1r"
> +
> +#: git-gui.sh:2763
> +msgid "Git Bash"
> +msgstr "Git Bash"
> +
> +#: git-gui.sh:2772
> +msgid "Browse Current Branch's Files"
> +msgstr "Ge=C3=A7erli Dal Dosyalar=C4=B1na G=C3=B6z At"
> +
> +#: git-gui.sh:2776
> +msgid "Browse Branch Files..."
> +msgstr "Dal Dosyalar=C4=B1na G=C3=B6z At..."
> +
> +#: git-gui.sh:2781
> +msgid "Visualize Current Branch's History"
> +msgstr "Ge=C3=A7erli Dal Ge=C3=A7mi=C5=9Fini G=C3=B6rselle=C5=9Ftir"
> +
> +#: git-gui.sh:2785
> +msgid "Visualize All Branch History"
> +msgstr "T=C3=BCm Dal Ge=C3=A7mi=C5=9Fini G=C3=B6rselle=C5=9Ftir"
> +
> +#: git-gui.sh:2792
> +#, tcl-format
> +msgid "Browse %s's Files"
> +msgstr "%s Dosyalar=C4=B1na G=C3=B6z At"
> +
> +#: git-gui.sh:2794
> +#, tcl-format
> +msgid "Visualize %s's History"
> +msgstr "%s Ge=C3=A7mi=C5=9Fini G=C3=B6rselle=C5=9Ftir"
> +
> +#: git-gui.sh:2799 lib/database.tcl:40
> +msgid "Database Statistics"
> +msgstr "Veritaban=C4=B1 =C4=B0statistikleri"
> +
> +#: git-gui.sh:2802 lib/database.tcl:33
> +msgid "Compress Database"
> +msgstr "Veritaban=C4=B1n=C4=B1 S=C4=B1k=C4=B1=C5=9Ft=C4=B1r"
> +
> +#: git-gui.sh:2805
> +msgid "Verify Database"
> +msgstr "Veritaban=C4=B1n=C4=B1 Do=C4=9Frula"
> +
> +#: git-gui.sh:2812 git-gui.sh:2816 git-gui.sh:2820
> +msgid "Create Desktop Icon"
> +msgstr "Masa=C3=BCst=C3=BC Simgesi Olu=C5=9Ftur"
> +
> +#: git-gui.sh:2828 lib/choose_repository.tcl:209 =
lib/choose_repository.tcl:217
> +msgid "Quit"
> +msgstr "=C3=87=C4=B1k"
> +
> +#: git-gui.sh:2836
> +msgid "Undo"
> +msgstr "Geri Al"
> +
> +#: git-gui.sh:2839
> +msgid "Redo"
> +msgstr "Yinele"
> +
> +#: git-gui.sh:2843 git-gui.sh:3461
> +msgid "Cut"
> +msgstr "Kes"
> +
> +#: git-gui.sh:2846 git-gui.sh:3464 git-gui.sh:3540 git-gui.sh:3633
> +#: lib/console.tcl:69
> +msgid "Copy"
> +msgstr "Kopyala"
> +
> +#: git-gui.sh:2849 git-gui.sh:3467
> +msgid "Paste"
> +msgstr "Yap=C4=B1=C5=9Ft=C4=B1r"
> +
> +#: git-gui.sh:2852 git-gui.sh:3470 lib/remote_branch_delete.tcl:39
> +#: lib/branch_delete.tcl:28
> +msgid "Delete"
> +msgstr "Sil"
> +
> +#: git-gui.sh:2856 git-gui.sh:3474 git-gui.sh:3637 lib/console.tcl:71
> +msgid "Select All"
> +msgstr "T=C3=BCm=C3=BCn=C3=BC Se=C3=A7"
> +
> +#: git-gui.sh:2865
> +msgid "Create..."
> +msgstr "Olu=C5=9Ftur..."
> +
> +#: git-gui.sh:2871
> +msgid "Checkout..."
> +msgstr "=C3=87=C4=B1k=C4=B1=C5=9F Yap..."
> +
> +#: git-gui.sh:2877
> +msgid "Rename..."
> +msgstr "Yeniden Adland=C4=B1r..."
> +
> +#: git-gui.sh:2882
> +msgid "Delete..."
> +msgstr "Sil..."
> +
> +#: git-gui.sh:2887
> +msgid "Reset..."
> +msgstr "S=C4=B1f=C4=B1rla..."
> +
> +#: git-gui.sh:2897
> +msgid "Done"
> +msgstr "Tamam"
> +
> +#: git-gui.sh:2899
> +msgid "Commit@@verb"
> +msgstr "=C4=B0=C5=9Fle@@verb"
> +
> +#: git-gui.sh:2908 git-gui.sh:3400
> +msgid "Amend Last Commit"
> +msgstr "Son =C4=B0=C5=9Flemeyi De=C4=9Fi=C5=9Ftir"
> +
> +#: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
> +msgid "Rescan"
> +msgstr "Yeniden Tara"
> +
> +#: git-gui.sh:2924
> +msgid "Stage To Commit"
> +msgstr "=C4=B0=C5=9Fleme =C4=B0=C3=A7in Haz=C4=B1rla"
> +
> +#: git-gui.sh:2930
> +msgid "Stage Changed Files To Commit"
> +msgstr "De=C4=9Fi=C5=9Ftirilen Dosyalar=C4=B1 =C4=B0=C5=9Fleme =C4=B0=C3=
=A7in Haz=C4=B1rla"
> +
> +#: git-gui.sh:2936
> +msgid "Unstage =46rom Commit"
> +msgstr "=C4=B0=C5=9Fleme Haz=C4=B1rl=C4=B1=C4=9F=C4=B1ndan =C3=87=C4=B1=
kar"
> +
> +#: git-gui.sh:2942 lib/index.tcl:521
> +msgid "Revert Changes"
> +msgstr "De=C4=9Fi=C5=9Fiklikleri Geri Al"
> +
> +#: git-gui.sh:2950 git-gui.sh:3700 git-gui.sh:3731
> +msgid "Show Less Context"
> +msgstr "Daha Az Ba=C4=9Flam G=C3=B6ster"
> +
> +#: git-gui.sh:2954 git-gui.sh:3704 git-gui.sh:3735
> +msgid "Show More Context"
> +msgstr "Daha =C3=87ok Ba=C4=9Flam G=C3=B6ster"
> +
> +#: git-gui.sh:2961 git-gui.sh:3374 git-gui.sh:3485
> +msgid "Sign Off"
> +msgstr "=C4=B0mzala"
> +
> +#: git-gui.sh:2977
> +msgid "Local Merge..."
> +msgstr "Yerel Birle=C5=9Ftirme..."
> +
> +#: git-gui.sh:2982
> +msgid "Abort Merge..."
> +msgstr "Birle=C5=9Ftirmeyi =C4=B0ptal Et..."
> +
> +#: git-gui.sh:2994 git-gui.sh:3022
> +msgid "Add..."
> +msgstr "Ekle..."
> +
> +#: git-gui.sh:2998
> +msgid "Push..."
> +msgstr "=C4=B0t..."
> +
> +#: git-gui.sh:3002
> +msgid "Delete Branch..."
> +msgstr "Dal Sil..."
> +
> +#: git-gui.sh:3012 git-gui.sh:3666
> +msgid "Options..."
> +msgstr "Se=C3=A7enekler..."
> +
> +#: git-gui.sh:3023
> +msgid "Remove..."
> +msgstr "Kald=C4=B1r..."
> +
> +#: git-gui.sh:3032 lib/choose_repository.tcl:67
> +msgid "Help"
> +msgstr "Yard=C4=B1m"
> +
> +#: git-gui.sh:3036 git-gui.sh:3040 lib/choose_repository.tcl:61
> +#: lib/choose_repository.tcl:70 lib/about.tcl:14
> +#, tcl-format
> +msgid "About %s"
> +msgstr "%s Hakk=C4=B1nda"
> +
> +#: git-gui.sh:3064
> +msgid "Online Documentation"
> +msgstr "=C3=87evrimi=C3=A7i Belgelendirme"
> +
> +#: git-gui.sh:3067 lib/choose_repository.tcl:64 =
lib/choose_repository.tcl:73
> +msgid "Show SSH Key"
> +msgstr "SSH Anahtar=C4=B1n=C4=B1 G=C3=B6ster"
> +
> +#: git-gui.sh:3097 git-gui.sh:3229
> +msgid "usage:"
> +msgstr "kullan=C4=B1m:"
> +
> +#: git-gui.sh:3101 git-gui.sh:3233
> +msgid "Usage"
> +msgstr "Kullan=C4=B1m"
> +
> +#: git-gui.sh:3182 lib/blame.tcl:575
> +msgid "Error"
> +msgstr "Hata"
> +
> +#: git-gui.sh:3213
> +#, tcl-format
> +msgid "fatal: cannot stat path %s: No such file or directory"
> +msgstr "Onulmaz: %s yolu istatistikleri =C3=A7=C4=B1kar=C4=B1lam=C4=B1y=
or: B=C3=B6yle bir dosya veya "
> +"dizin yok"
> +
> +#: git-gui.sh:3246
> +msgid "Current Branch:"
> +msgstr "Ge=C3=A7erli Dal:"
> +
> +#: git-gui.sh:3271
> +msgid "Unstaged Changes"
> +msgstr "Haz=C4=B1rlanmam=C4=B1=C5=9F De=C4=9Fi=C5=9Fiklikler"
> +
> +#: git-gui.sh:3293
> +msgid "Staged Changes (Will Commit)"
> +msgstr "Haz=C4=B1rlanm=C4=B1=C5=9F De=C4=9Fi=C5=9Fiklikler =
(=C4=B0=C5=9Flenecek)"
> +
> +#: git-gui.sh:3367
> +msgid "Stage Changed"
> +msgstr "De=C4=9Fi=C5=9Fiklikleri Haz=C4=B1rla"
> +
> +#: git-gui.sh:3386 lib/transport.tcl:137
> +msgid "Push"
> +msgstr "=C4=B0t"
> +
> +#: git-gui.sh:3413
> +msgid "Initial Commit Message:"
> +msgstr "=C4=B0lk =C4=B0=C5=9Fleme =C4=B0letisi:"
> +
> +#: git-gui.sh:3414
> +msgid "Amended Commit Message:"
> +msgstr "De=C4=9Fi=C5=9Ftirilmi=C5=9F =C4=B0=C5=9Fleme =C4=B0letisi:"
> +
> +#: git-gui.sh:3415
> +msgid "Amended Initial Commit Message:"
> +msgstr "De=C4=9Fi=C5=9Ftirilmi=C5=9F =C4=B0lk =C4=B0=C5=9Fleme =
=C4=B0letisi:"
> +
> +#: git-gui.sh:3416
> +msgid "Amended Merge Commit Message:"
> +msgstr "De=C4=9Fi=C5=9Ftirilmi=C5=9F Birle=C5=9Ftirme =C4=B0=C5=9Flemes=
i =C4=B0letisi:"
> +
> +#: git-gui.sh:3417
> +msgid "Merge Commit Message:"
> +msgstr "Birle=C5=9Ftirme =C4=B0=C5=9Flemesi =C4=B0letisi:"
> +
> +#: git-gui.sh:3418
> +msgid "Commit Message:"
> +msgstr "=C4=B0=C5=9Fleme =C4=B0letisi:"
> +
> +#: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
> +msgid "Copy All"
> +msgstr "T=C3=BCm=C3=BCn=C3=BC Kopyala"
> +
> +#: git-gui.sh:3501 lib/blame.tcl:106
> +msgid "File:"
> +msgstr "Dosya:"
> +
> +#: git-gui.sh:3549 lib/choose_repository.tcl:1100
> +msgid "Open"
> +msgstr "A=C3=A7"
> +
> +#: git-gui.sh:3629
> +msgid "Refresh"
> +msgstr "Yenile"
> +
> +#: git-gui.sh:3650
> +msgid "Decrease Font Size"
> +msgstr "Yaz=C4=B1tipi Boyutunu Azalt"
> +
> +#: git-gui.sh:3654
> +msgid "Increase Font Size"
> +msgstr "Yaz=C4=B1tipi Boyutunu Art=C4=B1r"
> +
> +#: git-gui.sh:3662 lib/blame.tcl:296
> +msgid "Encoding"
> +msgstr "Kodlama"
> +
> +#: git-gui.sh:3673
> +msgid "Apply/Reverse Hunk"
> +msgstr "Par=C3=A7a Uygula/Geri Al"
> +
> +#: git-gui.sh:3678
> +msgid "Apply/Reverse Line"
> +msgstr "Sat=C4=B1r Uygula/Geri Al"
> +
> +#: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
> +msgid "Revert Hunk"
> +msgstr "Par=C3=A7ay=C4=B1 Geri Al"
> +
> +#: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
> +msgid "Revert Line"
> +msgstr "Sat=C4=B1r=C4=B1 Geri Al"
> +
> +#: git-gui.sh:3694 git-gui.sh:3791
> +msgid "Undo Last Revert"
> +msgstr "Son Geri Almay=C4=B1 =C4=B0ptal Et"
> +
> +#: git-gui.sh:3713
> +msgid "Run Merge Tool"
> +msgstr "Birle=C5=9Ftirme Arac=C4=B1n=C4=B1 =C3=87al=C4=B1=C5=9Ft=C4=B1r=
"
> +
> +#: git-gui.sh:3718
> +msgid "Use Remote Version"
> +msgstr "Uzak Konum S=C3=BCr=C3=BCm=C3=BCn=C3=BC Kullan"
> +
> +#: git-gui.sh:3722
> +msgid "Use Local Version"
> +msgstr "Yerel S=C3=BCr=C3=BCm=C3=BC Kullan"
> +
> +#: git-gui.sh:3726
> +msgid "Revert To Base"
> +msgstr "Temele Geri Al"
> +
> +#: git-gui.sh:3744
> +msgid "Visualize These Changes In The Submodule"
> +msgstr "Bu De=C4=9Fi=C5=9Fiklikleri Altmod=C3=BClde G=C3=B6rselle=C5=9F=
tir"
> +
> +#: git-gui.sh:3748
> +msgid "Visualize Current Branch History In The Submodule"
> +msgstr "Ge=C3=A7erli Dal Ge=C3=A7mi=C5=9Fini Altmod=C3=BClde =
G=C3=B6rselle=C5=9Ftir"
> +
> +#: git-gui.sh:3752
> +msgid "Visualize All Branch History In The Submodule"
> +msgstr "T=C3=BCm Dal Ge=C3=A7mi=C5=9Fini Altmod=C3=BClde =
G=C3=B6rselle=C5=9Ftir"
> +
> +#: git-gui.sh:3757
> +msgid "Start git gui In The Submodule"
> +msgstr "git-gui'yi Altmod=C3=BClde Ba=C5=9Flat"
> +
> +#: git-gui.sh:3793
> +msgid "Unstage Hunk =46rom Commit"
> +msgstr "Par=C3=A7ay=C4=B1 =C4=B0=C5=9Fleme Haz=C4=B1rl=C4=B1=C4=9F=C4=B1=
ndan =C3=87=C4=B1kar"
> +
> +#: git-gui.sh:3797
> +msgid "Unstage Lines =46rom Commit"
> +msgstr "Sat=C4=B1rlar=C4=B1 =C4=B0=C5=9Fleme Haz=C4=B1rl=C4=B1=C4=9F=C4=
=B1ndan =C3=87=C4=B1kar"
> +
> +#: git-gui.sh:3798 git-gui.sh:3809
> +msgid "Revert Lines"
> +msgstr "Sat=C4=B1rlar=C4=B1 Geri Al"
> +
> +#: git-gui.sh:3800
> +msgid "Unstage Line =46rom Commit"
> +msgstr "Sat=C4=B1r=C4=B1 =C4=B0=C5=9Fleme Haz=C4=B1rl=C4=B1=C4=9F=C4=B1=
ndan =C3=87=C4=B1kar"
> +
> +#: git-gui.sh:3804
> +msgid "Stage Hunk For Commit"
> +msgstr "Par=C3=A7ay=C4=B1 =C4=B0=C5=9Fleme =C4=B0=C3=A7in Haz=C4=B1rla"=

> +
> +#: git-gui.sh:3808
> +msgid "Stage Lines For Commit"
> +msgstr "Sat=C4=B1rlar=C4=B1 =C4=B0=C5=9Fleme =C4=B0=C3=A7in Haz=C4=B1rl=
a"
> +
> +#: git-gui.sh:3811
> +msgid "Stage Line For Commit"
> +msgstr "Sat=C4=B1r=C4=B1 =C4=B0=C5=9Fleme =C4=B0=C3=A7in Haz=C4=B1rla"
> +
> +#: git-gui.sh:3861
> +msgid "Initializing..."
> +msgstr "=C4=B0lklendiriliyor..."
> +
> +#: git-gui.sh:4017
> +#, tcl-format
> +msgid ""
> +"Possible environment issues exist.\n"
> +"\n"
> +"The following environment variables are probably\n"
> +"going to be ignored by any Git subprocess run\n"
> +"by %s:\n"
> +"\n"
> +msgstr ""
> +"Olas=C4=B1 ortam sorunlar=C4=B1 mevcut.\n"
> +"\n"
> +"A=C5=9Fa=C4=9F=C4=B1daki ortam de=C4=9Fi=C5=9Fkenleri b=C3=BCy=C3=BCk =
olas=C4=B1l=C4=B1kla\n"
> +"=C5=9Funun taraf=C4=B1ndan =C3=A7al=C4=B1=C5=9Ft=C4=B1r=C4=B1lan =
herhangi bir Git\n"
> +"alt i=C5=9Flemi taraf=C4=B1ndan yok say=C4=B1lacaklar: %s:\n"
> +"\n"
> +
> +#: git-gui.sh:4046
> +msgid ""
> +"\n"
> +"This is due to a known issue with the\n"
> +"Tcl binary distributed by Cygwin."
> +msgstr ""
> +"\n"
> +"Bu, Cygwin taraf=C4=B1ndan da=C4=9F=C4=B1t=C4=B1lan Tcl =
ikilisinin\n"
> +"bilinen bir sorunu."
> +
> +#: git-gui.sh:4051
> +#, tcl-format
> +msgid ""
> +"\n"
> +"\n"
> +"A good replacement for %s\n"
> +"is placing values for the user.name and\n"
> +"user.email settings into your personal\n"
> +"~/.gitconfig file.\n"
> +msgstr ""
> +"\n"
> +"\n"
> +"%s i=C3=A7in iyi bir ikame,\n"
> +"user.name ve user.email de=C4=9Ferlerini kendi\n"
> +"ki=C5=9Fisel ~/.gitconfig dosyas=C4=B1na koyman=C4=B1z\n"
> +"olabilir.\n"
> +
> +#: lib/spellcheck.tcl:57
> +msgid "Unsupported spell checker"
> +msgstr "Desteklenmeyen yaz=C4=B1m denetimci"
> +
> +#: lib/spellcheck.tcl:65
> +msgid "Spell checking is unavailable"
> +msgstr "Yaz=C4=B1m denetimi kullan=C4=B1lam=C4=B1yor"
> +
> +#: lib/spellcheck.tcl:68
> +msgid "Invalid spell checking configuration"
> +msgstr "Ge=C3=A7ersiz yaz=C4=B1m denetimi yap=C4=B1land=C4=B1rmas=C4=B1=
"
> +
> +#: lib/spellcheck.tcl:70
> +#, tcl-format
> +msgid "Reverting dictionary to %s."
> +msgstr "S=C3=B6zl=C3=BCk =C5=9Funa geri al=C4=B1n=C4=B1yor: %s."
> +
> +#: lib/spellcheck.tcl:73
> +msgid "Spell checker silently failed on startup"
> +msgstr "Yaz=C4=B1m denetimci ba=C5=9Flarken sessizce =C3=A7=C3=B6kt=C3=BC=
"
> +
> +#: lib/spellcheck.tcl:80
> +msgid "Unrecognized spell checker"
> +msgstr "Tan=C4=B1mlanamayan yaz=C4=B1m denetimci"
> +
> +#: lib/spellcheck.tcl:186
> +msgid "No Suggestions"
> +msgstr "=C3=96neri Yok"
> +
> +#: lib/spellcheck.tcl:388
> +msgid "Unexpected EOF from spell checker"
> +msgstr "Yaz=C4=B1m denetimciden beklenmeyen dosya sonu"
> +
> +#: lib/spellcheck.tcl:392
> +msgid "Spell Checker Failed"
> +msgstr "Yaz=C4=B1m Denetimci Ba=C5=9Far=C4=B1s=C4=B1z Oldu"
> +
> +#: lib/transport.tcl:6 lib/remote_add.tcl:132
> +#, tcl-format
> +msgid "fetch %s"
> +msgstr "%s =C3=B6gesini getir"
> +
> +#: lib/transport.tcl:7
> +#, tcl-format
> +msgid "Fetching new changes from %s"
> +msgstr "%s konumundan yeni de=C4=9Fi=C5=9Fiklikler getiriliyor"
> +
> +#: lib/transport.tcl:18
> +#, tcl-format
> +msgid "remote prune %s"
> +msgstr "%s =C3=B6gesini uzaktan buda"
> +
> +#: lib/transport.tcl:19
> +#, tcl-format
> +msgid "Pruning tracking branches deleted from %s"
> +msgstr "%s =C3=B6gesinden silinen izleme dallar=C4=B1 budan=C4=B1yor"
> +
> +#: lib/transport.tcl:25
> +msgid "fetch all remotes"
> +msgstr "t=C3=BCm uzak konumlar=C4=B1 getir"
> +
> +#: lib/transport.tcl:26
> +msgid "Fetching new changes from all remotes"
> +msgstr "T=C3=BCm uzak konumlardan yeni de=C4=9Fi=C5=9Fiklikler =
getiriliyor"
> +
> +#: lib/transport.tcl:40
> +msgid "remote prune all remotes"
> +msgstr "t=C3=BCm uzak konumlar=C4=B1 uzaktan buda"
> +
> +#: lib/transport.tcl:41
> +msgid "Pruning tracking branches deleted from all remotes"
> +msgstr "T=C3=BCm uzak konumlardan silinen izleme dallar=C4=B1 =
budan=C4=B1yor"
> +
> +#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
> +#: lib/remote_add.tcl:162
> +#, tcl-format
> +msgid "push %s"
> +msgstr "%s =C3=B6gesini it"
> +
> +#: lib/transport.tcl:55
> +#, tcl-format
> +msgid "Pushing changes to %s"
> +msgstr "De=C4=9Fi=C5=9Fiklikler %s konumuna itiliyor"
> +
> +#: lib/transport.tcl:93
> +#, tcl-format
> +msgid "Mirroring to %s"
> +msgstr "%s konumuna yans=C4=B1lan=C4=B1yor"
> +
> +#: lib/transport.tcl:111
> +#, tcl-format
> +msgid "Pushing %s %s to %s"
> +msgstr "%s %s, %s konumuna itiliyor"
> +
> +#: lib/transport.tcl:132
> +msgid "Push Branches"
> +msgstr "Dallar=C4=B1 =C4=B0t"
> +
> +#: lib/transport.tcl:141 lib/checkout_op.tcl:580 =
lib/remote_add.tcl:34
> +#: lib/browser.tcl:292 lib/branch_checkout.tcl:30 =
lib/branch_rename.tcl:32
> +#: lib/choose_font.tcl:45 lib/option.tcl:127 lib/tools_dlg.tcl:41
> +#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 =
lib/remote_branch_delete.tcl:43
> +#: lib/branch_create.tcl:37 lib/branch_delete.tcl:34 =
lib/merge.tcl:178
> +msgid "Cancel"
> +msgstr "=C4=B0ptal"
> +
> +#: lib/transport.tcl:147
> +msgid "Source Branches"
> +msgstr "Kaynak Dallar"
> +
> +#: lib/transport.tcl:162
> +msgid "Destination Repository"
> +msgstr "Hedef Depo"
> +
> +#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
> +msgid "Remote:"
> +msgstr "Uzak Konum:"
> +
> +#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
> +msgid "Arbitrary Location:"
> +msgstr "Geli=C5=9Fig=C3=BCzel Konum:"
> +
> +#: lib/transport.tcl:205
> +msgid "Transfer Options"
> +msgstr "Aktar=C4=B1m Se=C3=A7enekleri"
> +
> +#: lib/transport.tcl:207
> +msgid "Force overwrite existing branch (may discard changes)"
> +msgstr "Var olan dal=C4=B1n =C3=BCzerine zorla yaz (de=C4=9Fi=C5=9Fikli=
kleri atabilir)"
> +
> +#: lib/transport.tcl:211
> +msgid "Use thin pack (for slow network connections)"
> +msgstr "=C4=B0nce paket kullan (yava=C5=9F a=C4=9F ba=C4=9Flant=C4=B1la=
r=C4=B1 i=C3=A7in)"
> +
> +#: lib/transport.tcl:215
> +msgid "Include tags"
> +msgstr "Etiketleri i=C3=A7er"
> +
> +#: lib/transport.tcl:229
> +#, tcl-format
> +msgid "%s (%s): Push"
> +msgstr "%s (%s): =C4=B0t"
> +
> +#: lib/checkout_op.tcl:85
> +#, tcl-format
> +msgid "Fetching %s from %s"
> +msgstr "%s =C3=B6gesi %s konumundan getiriliyor"
> +
> +#: lib/checkout_op.tcl:133
> +#, tcl-format
> +msgid "fatal: Cannot resolve %s"
> +msgstr "Onulmaz: %s =C3=A7=C3=B6z=C3=BClemiyor"
> +
> +#: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
> +#: lib/database.tcl:30
> +msgid "Close"
> +msgstr "Kapat"
> +
> +#: lib/checkout_op.tcl:175
> +#, tcl-format
> +msgid "Branch '%s' does not exist."
> +msgstr "'%s' dal=C4=B1 mevcut de=C4=9Fil."
> +
> +#: lib/checkout_op.tcl:194
> +#, tcl-format
> +msgid "Failed to configure simplified git-pull for '%s'."
> +msgstr "'%s' i=C3=A7in yal=C4=B1nla=C5=9Ft=C4=B1r=C4=B1lm=C4=B1=C5=9F =
git-pull yap=C4=B1land=C4=B1r=C4=B1lam=C4=B1yor."
> +
> +#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
> +#, tcl-format
> +msgid "Branch '%s' already exists."
> +msgstr "'%s' dal=C4=B1 halihaz=C4=B1rda mevcut."
> +
> +#: lib/checkout_op.tcl:229
> +#, tcl-format
> +msgid ""
> +"Branch '%s' already exists.\n"
> +"\n"
> +"It cannot fast-forward to %s.\n"
> +"A merge is required."
> +msgstr ""
> +"'%s' dal=C4=B1 halihaz=C4=B1rda mevcut.\n"
> +"\n"
> +"%s konumuna ileri sar=C4=B1lam=C4=B1yor.\n"
> +"Bir birle=C5=9Ftirme gerekli."
> +
> +#: lib/checkout_op.tcl:243
> +#, tcl-format
> +msgid "Merge strategy '%s' not supported."
> +msgstr "Birle=C5=9Ftirme stratejisi '%s' desteklenmiyor."
> +
> +#: lib/checkout_op.tcl:262
> +#, tcl-format
> +msgid "Failed to update '%s'."
> +msgstr "'%s' g=C3=BCncellenemedi."
> +
> +#: lib/checkout_op.tcl:274
> +msgid "Staging area (index) is already locked."
> +msgstr "Haz=C4=B1rlama alan=C4=B1 (indeks) halihaz=C4=B1rda kilitli."
> +
> +#: lib/checkout_op.tcl:289
> +msgid ""
> +"Last scanned state does not match repository state.\n"
> +"\n"
> +"Another Git program has modified this repository since the last =
scan.  A "
> +"rescan must be performed before the current branch can be =
changed.\n"
> +"\n"
> +"The rescan will be automatically started now.\n"
> +msgstr ""
> +"Son tarama durumu depo durumu ile e=C5=9Fle=C5=9Fmiyor.\n"
> +"\n"
> +"Ba=C5=9Fka bir Git program=C4=B1 bu depoyu son taramadan beri =
de=C4=9Fi=C5=9Ftirmi=C5=9F. Ge=C3=A7erli "
> +"deponun de=C4=9Fi=C5=9Ftirilebilmesi i=C3=A7in bir yeniden tarama =
ger=C3=A7ekle=C5=9Ftirilmelidir.\n"
> +"\n"
> +"Yeniden tarama =C5=9Fimdi kendili=C4=9Finden ba=C5=9Flat=C4=B1lacak.\n=
"
> +
> +#: lib/checkout_op.tcl:345
> +#, tcl-format
> +msgid "Updating working directory to '%s'..."
> +msgstr "=C3=87al=C4=B1=C5=9Fma dizini =C5=9Funa g=C3=BCncelleniyor: =
'%s'..."
> +
> +#: lib/checkout_op.tcl:346
> +msgid "files checked out"
> +msgstr "=C3=A7=C4=B1k=C4=B1=C5=9F=C4=B1 yap=C4=B1lan dosyalar"
> +
> +#: lib/checkout_op.tcl:377
> +#, tcl-format
> +msgid "Aborted checkout of '%s' (file level merging is required)."
> +msgstr "'%s' =C3=A7=C4=B1k=C4=B1=C5=9F=C4=B1 iptal edildi (dosya =
d=C3=BCzeyinde birle=C5=9Ftirme gerekiyor)."
> +
> +#: lib/checkout_op.tcl:378
> +msgid "File level merge required."
> +msgstr "Dosya d=C3=BCzeyinde birle=C5=9Ftirme gerekiyor."
> +
> +#: lib/checkout_op.tcl:382
> +#, tcl-format
> +msgid "Staying on branch '%s'."
> +msgstr "'%s' dal=C4=B1nda kal=C4=B1n=C4=B1yor."
> +
> +#: lib/checkout_op.tcl:453
> +msgid ""
> +"You are no longer on a local branch.\n"
> +"\n"
> +"If you wanted to be on a branch, create one now starting from 'This =
Detached "
> +"Checkout'."
> +msgstr ""
> +"Art=C4=B1k yerel bir dalda de=C4=9Filsiniz.\n"
> +"\n"
> +"E=C4=9Fer bir dalda olmak istediyseniz 'Bu Ayr=C4=B1k =C3=87=C4=B1k=C4=
=B1=C5=9F'tan ba=C5=9Flayarak bir tane "
> +"olu=C5=9Fturun."
> +
> +#: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
> +#, tcl-format
> +msgid "Checked out '%s'."
> +msgstr "'%s' =C3=A7=C4=B1k=C4=B1=C5=9F=C4=B1 yap=C4=B1ld=C4=B1."
> +
> +#: lib/checkout_op.tcl:536
> +#, tcl-format
> +msgid "Resetting '%s' to '%s' will lose the following commits:"
> +msgstr "'%s' =C3=B6gesini '%s' olarak s=C4=B1f=C4=B1rlamak =
a=C5=9Fa=C4=9F=C4=B1daki i=C5=9Flemeleri kaybedecek:"
> +
> +#: lib/checkout_op.tcl:558
> +msgid "Recovering lost commits may not be easy."
> +msgstr "Kay=C4=B1p i=C5=9Flemeleri kurtarmak kolay olmayabilir."
> +
> +#: lib/checkout_op.tcl:563
> +#, tcl-format
> +msgid "Reset '%s'?"
> +msgstr "'%s' =C3=B6gesi s=C4=B1f=C4=B1rlans=C4=B1n m=C4=B1?"
> +
> +#: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
> +msgid "Visualize"
> +msgstr "G=C3=B6rselle=C5=9Ftir"
> +
> +#: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
> +msgid "Reset"
> +msgstr "S=C4=B1f=C4=B1rla"
> +
> +#: lib/checkout_op.tcl:636
> +#, tcl-format
> +msgid ""
> +"Failed to set current branch.\n"
> +"\n"
> +"This working directory is only partially switched.  We successfully =
updated "
> +"your files, but failed to update an internal Git file.\n"
> +"\n"
> +"This should not have occurred.  %s will now close and give up."
> +msgstr ""
> +"Ge=C3=A7erli dal ayarlanamad=C4=B1.\n"
> +"\n"
> +"Bu =C3=A7al=C4=B1=C5=9Fma dizinine yaln=C4=B1zca k=C4=B1s=C4=B1msal =
olarak ge=C3=A7ilmi=C5=9F. Dosyalar=C4=B1n=C4=B1z=C4=B1 "
> +"ba=C5=9Far=C4=B1yla g=C3=BCncelledik; ancak dahili Git dosyas=C4=B1n=C4=
=B1 g=C3=BCncelleyemedik.\n"
> +"\n"
> +"Bu olay ger=C3=A7ekle=C5=9Fmemeliydi. %s =C5=9Fimdi kapanacak ve =
s=C3=BCrd=C3=BCrmeyecek."
> +
> +#: lib/remote_add.tcl:20
> +#, tcl-format
> +msgid "%s (%s): Add Remote"
> +msgstr "%s (%s): Uzak Konum Ekle"
> +
> +#: lib/remote_add.tcl:25
> +msgid "Add New Remote"
> +msgstr "Yeni Uzak Konum Ekle"
> +
> +#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
> +msgid "Add"
> +msgstr "Ekle"
> +
> +#: lib/remote_add.tcl:39
> +msgid "Remote Details"
> +msgstr "Uzak Konum Ayr=C4=B1nt=C4=B1lar=C4=B1"
> +
> +#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 =
lib/branch_create.tcl:44
> +msgid "Name:"
> +msgstr "Ad:"
> +
> +#: lib/remote_add.tcl:50
> +msgid "Location:"
> +msgstr "Konum:"
> +
> +#: lib/remote_add.tcl:60
> +msgid "Further Action"
> +msgstr "Sonraki Eylem"
> +
> +#: lib/remote_add.tcl:63
> +msgid "Fetch Immediately"
> +msgstr "Hemen Getir"
> +
> +#: lib/remote_add.tcl:69
> +msgid "Initialize Remote Repository and Push"
> +msgstr "Uzak Depoyu =C4=B0lklendir ve =C4=B0t"
> +
> +#: lib/remote_add.tcl:75
> +msgid "Do Nothing Else Now"
> +msgstr "=C5=9Eimdi Ba=C5=9Fka Bir =C5=9Eey Yapma"
> +
> +#: lib/remote_add.tcl:100
> +msgid "Please supply a remote name."
> +msgstr "Bir uzak konum ad=C4=B1 sa=C4=9Flay=C4=B1n."
> +
> +#: lib/remote_add.tcl:113
> +#, tcl-format
> +msgid "'%s' is not an acceptable remote name."
> +msgstr "'%s', kabul edilebilir bir uzak konum ad=C4=B1 de=C4=9Fil."
> +
> +#: lib/remote_add.tcl:124
> +#, tcl-format
> +msgid "Failed to add remote '%s' of location '%s'."
> +msgstr "'%s' uzak konumu eklenemedi, konum: '%s'."
> +
> +#: lib/remote_add.tcl:133
> +#, tcl-format
> +msgid "Fetching the %s"
> +msgstr "%s getiriliyor"
> +
> +#: lib/remote_add.tcl:156
> +#, tcl-format
> +msgid "Do not know how to initialize repository at location '%s'."
> +msgstr "'%s' konumunda bir deponun nice ilklendirilece=C4=9Fi =
bilinmiyor."
> +
> +#: lib/remote_add.tcl:163
> +#, tcl-format
> +msgid "Setting up the %s (at %s)"
> +msgstr "%s ayarlan=C4=B1yor (%s konumunda)"
> +
> +#: lib/browser.tcl:17
> +msgid "Starting..."
> +msgstr "Ba=C5=9Flat=C4=B1l=C4=B1yor..."
> +
> +#: lib/browser.tcl:27
> +#, tcl-format
> +msgid "%s (%s): File Browser"
> +msgstr "%s (%s): Dosya Y=C3=B6neticisi"
> +
> +#: lib/browser.tcl:132 lib/browser.tcl:149
> +#, tcl-format
> +msgid "Loading %s..."
> +msgstr "%s y=C3=BCkleniyor..."
> +
> +#: lib/browser.tcl:193
> +msgid "[Up To Parent]"
> +msgstr "[=C3=9Cst =C3=96geye Git]"
> +
> +#: lib/browser.tcl:275
> +#, tcl-format
> +msgid "%s (%s): Browse Branch Files"
> +msgstr "%s (%s): Dal Dosyalar=C4=B1na G=C3=B6z At"
> +
> +#: lib/browser.tcl:282
> +msgid "Browse Branch Files"
> +msgstr "Dal Dosyalar=C4=B1na G=C3=B6z At"
> +
> +#: lib/browser.tcl:288 lib/choose_repository.tcl:437
> +#: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
> +#: lib/choose_repository.tcl:1115
> +msgid "Browse"
> +msgstr "G=C3=B6z At"
> +
> +#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 =
lib/tools_dlg.tcl:321
> +msgid "Revision"
> +msgstr "Revizyon"
> +
> +#: lib/index.tcl:6
> +msgid "Unable to unlock the index."
> +msgstr "=C4=B0ndeks kilitlenemiyor."
> +
> +#: lib/index.tcl:30
> +msgid "Index Error"
> +msgstr "=C4=B0ndeks Hatas=C4=B1"
> +
> +#: lib/index.tcl:32
> +msgid ""
> +"Updating the Git index failed.  A rescan will be automatically =
started to "
> +"resynchronize git-gui."
> +msgstr ""
> +"Git indeksini g=C3=BCncelleme ba=C5=9Far=C4=B1s=C4=B1z. git-gui'nin =
e=C5=9Fitlenebilmesi i=C3=A7in bir "
> +"yeniden tarama kendili=C4=9Finden ba=C5=9Flat=C4=B1lacak."
> +
> +#: lib/index.tcl:43
> +msgid "Continue"
> +msgstr "S=C3=BCrd=C3=BCr"
> +
> +#: lib/index.tcl:46
> +msgid "Unlock Index"
> +msgstr "=C4=B0ndeks Kilidini A=C3=A7"
> +
> +#: lib/index.tcl:77 lib/index.tcl:146 lib/index.tcl:220 =
lib/index.tcl:587
> +#: lib/choose_repository.tcl:999
> +msgid "files"
> +msgstr "dosyalar"
> +
> +#: lib/index.tcl:326
> +msgid "Unstaging selected files from commit"
> +msgstr "Se=C3=A7ili dosyalar i=C5=9Fleme haz=C4=B1rl=C4=B1=C4=9F=C4=B1n=
dan =C3=A7=C4=B1kar=C4=B1l=C4=B1yor"
> +
> +#: lib/index.tcl:330
> +#, tcl-format
> +msgid "Unstaging %s from commit"
> +msgstr "%s, i=C5=9Fleme haz=C4=B1rl=C4=B1=C4=9F=C4=B1ndan =
=C3=A7=C4=B1kar=C4=B1l=C4=B1yor"
> +
> +#: lib/index.tcl:369
> +msgid "Ready to commit."
> +msgstr "=C4=B0=C5=9Flemeye haz=C4=B1r."
> +
> +#: lib/index.tcl:378
> +msgid "Adding selected files"
> +msgstr "Se=C3=A7ili dosyalar ekleniyor"
> +
> +#: lib/index.tcl:382
> +#, tcl-format
> +msgid "Adding %s"
> +msgstr "%s ekleniyor"
> +
> +#: lib/index.tcl:412
> +#, tcl-format
> +msgid "Stage %d untracked files?"
> +msgstr "%d izlenmeyen dosya haz=C4=B1rlans=C4=B1n m=C4=B1?"
> +
> +#: lib/index.tcl:420
> +msgid "Adding all changed files"
> +msgstr "T=C3=BCm de=C4=9Fi=C5=9Ftirilen dosyalar ekleniyor"
> +
> +#: lib/index.tcl:503
> +#, tcl-format
> +msgid "Revert changes in file %s?"
> +msgstr "%s dosyas=C4=B1ndaki de=C4=9Fi=C5=9Fiklikler geri al=C4=B1ns=C4=
=B1n m=C4=B1?"
> +
> +#: lib/index.tcl:508
> +#, tcl-format
> +msgid "Revert changes in these %i files?"
> +msgstr "Bu %i dosyadaki de=C4=9Fi=C5=9Fiklikler geri al=C4=B1ns=C4=B1n =
m=C4=B1?"
> +
> +#: lib/index.tcl:517
> +msgid "Any unstaged changes will be permanently lost by the revert."
> +msgstr "Haz=C4=B1rlanmayan t=C3=BCm de=C4=9Fi=C5=9Fiklikler bu geri =
alma ile t=C3=BCm=C3=BCyle kaybolacak."
> +
> +#: lib/index.tcl:520 lib/index.tcl:563
> +msgid "Do Nothing"
> +msgstr "Bir =C5=9Eey Yapma"
> +
> +#: lib/index.tcl:545
> +#, tcl-format
> +msgid "Delete untracked file %s?"
> +msgstr "=C4=B0zlenmeyen dosya %s silinsin mi?"
> +
> +#: lib/index.tcl:550
> +#, tcl-format
> +msgid "Delete these %i untracked files?"
> +msgstr "Bu izlenmeyen %i dosya silinsin mi?"
> +
> +#: lib/index.tcl:560
> +msgid "Files will be permanently deleted."
> +msgstr "Dosyalar kal=C4=B1c=C4=B1 olarak silinecek."
> +
> +#: lib/index.tcl:564
> +msgid "Delete Files"
> +msgstr "Dosyalar=C4=B1 Sil"
> +
> +#: lib/index.tcl:586
> +msgid "Deleting"
> +msgstr "Siliniyor"
> +
> +#: lib/index.tcl:665
> +msgid "Encountered errors deleting files:\n"
> +msgstr "Dosya silerken hatalarla kar=C5=9F=C4=B1la=C5=9F=C4=B1ld=C4=B1:=
\n"
> +
> +#: lib/index.tcl:674
> +#, tcl-format
> +msgid "None of the %d selected files could be deleted."
> +msgstr "Se=C3=A7ili %d dosyan=C4=B1n hi=C3=A7biri silinemedi."
> +
> +#: lib/index.tcl:679
> +#, tcl-format
> +msgid "%d of the %d selected files could not be deleted."
> +msgstr "%d/%d se=C3=A7ili dosya silinemedi."
> +
> +#: lib/index.tcl:726
> +msgid "Reverting selected files"
> +msgstr "Se=C3=A7ili dosyalar geri al=C4=B1n=C4=B1yor"
> +
> +#: lib/index.tcl:730
> +#, tcl-format
> +msgid "Reverting %s"
> +msgstr "%s geri al=C4=B1n=C4=B1yor"
> +
> +#: lib/branch_checkout.tcl:16
> +#, tcl-format
> +msgid "%s (%s): Checkout Branch"
> +msgstr "%s (%s): Dal=C4=B1 =C3=87=C4=B1k=C4=B1=C5=9F Yap"
> +
> +#: lib/branch_checkout.tcl:21
> +msgid "Checkout Branch"
> +msgstr "Dal=C4=B1 =C3=87=C4=B1k=C4=B1=C5=9F Yap"
> +
> +#: lib/branch_checkout.tcl:26
> +msgid "Checkout"
> +msgstr "=C3=87=C4=B1k=C4=B1=C5=9F Yap"
> +
> +#: lib/branch_checkout.tcl:39 lib/option.tcl:310 =
lib/branch_create.tcl:69
> +msgid "Options"
> +msgstr "Se=C3=A7enekler"
> +
> +#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
> +msgid "Fetch Tracking Branch"
> +msgstr "=C4=B0zleme Dal=C4=B1n=C4=B1 Getir"
> +
> +#: lib/branch_checkout.tcl:47
> +msgid "Detach =46rom Local Branch"
> +msgstr "Yerel Daldan Ay=C4=B1r"
> +
> +#: lib/status_bar.tcl:263
> +#, tcl-format
> +msgid "%s ... %*i of %*i %s (%3i%%)"
> +msgstr "%s ... %*i/%*i %s (%3i%%)"
> +
> +#: lib/remote.tcl:200
> +msgid "Push to"
> +msgstr "=C5=9Euraya =C4=B0t"
> +
> +#: lib/remote.tcl:218
> +msgid "Remove Remote"
> +msgstr "Uzak Konum Kald=C4=B1r"
> +
> +#: lib/remote.tcl:223
> +msgid "Prune from"
> +msgstr "=C5=9Euradan Buda"
> +
> +#: lib/remote.tcl:228
> +msgid "Fetch from"
> +msgstr "=C5=9Euradan Getir"
> +
> +#: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 =
lib/remote.tcl:264
> +msgid "All"
> +msgstr "T=C3=BCm=C3=BC"
> +
> +#: lib/branch_rename.tcl:15
> +#, tcl-format
> +msgid "%s (%s): Rename Branch"
> +msgstr "%s (%s): Dal=C4=B1 Yeniden Adland=C4=B1r"
> +
> +#: lib/branch_rename.tcl:23
> +msgid "Rename Branch"
> +msgstr "Dal=C4=B1 Yeniden Adland=C4=B1r"
> +
> +#: lib/branch_rename.tcl:28
> +msgid "Rename"
> +msgstr "Yeniden Adland=C4=B1r"
> +
> +#: lib/branch_rename.tcl:38
> +msgid "Branch:"
> +msgstr "Dal:"
> +
> +#: lib/branch_rename.tcl:46
> +msgid "New Name:"
> +msgstr "Yeni Ad:"
> +
> +#: lib/branch_rename.tcl:81
> +msgid "Please select a branch to rename."
> +msgstr "Yeniden adland=C4=B1rmak i=C3=A7in bir dal se=C3=A7in."
> +
> +#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
> +msgid "Please supply a branch name."
> +msgstr "Bir dal ad=C4=B1 sa=C4=9Flay=C4=B1n."
> +
> +#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
> +#, tcl-format
> +msgid "'%s' is not an acceptable branch name."
> +msgstr "'%s', kabul edilebilir bir dal ad=C4=B1 de=C4=9Fil."
> +
> +#: lib/branch_rename.tcl:123
> +#, tcl-format
> +msgid "Failed to rename '%s'."
> +msgstr "'%s', yeniden adland=C4=B1r=C4=B1lamad=C4=B1."
> +
> +#: lib/choose_font.tcl:41
> +msgid "Select"
> +msgstr "Se=C3=A7"
> +
> +#: lib/choose_font.tcl:55
> +msgid "Font Family"
> +msgstr "Yaz=C4=B1tipi Ailesi"
> +
> +#: lib/choose_font.tcl:76
> +msgid "Font Size"
> +msgstr "Yaz=C4=B1tipi Boyutu"
> +
> +#: lib/choose_font.tcl:93
> +msgid "Font Example"
> +msgstr "Yaz=C4=B1tipi =C3=96rne=C4=9Fi"
> +
> +#: lib/choose_font.tcl:105
> +msgid ""
> +"This is example text.\n"
> +"If you like this text, it can be your font."
> +msgstr ""
> +"Bu, =C3=B6rnek bir metindir.\n"
> +"Ho=C5=9Funuza gittiyse yaz=C4=B1tipi olarak ayarlayabilirsiniz."
> +
> +#: lib/option.tcl:11
> +#, tcl-format
> +msgid "Invalid global encoding '%s'"
> +msgstr "Ge=C3=A7ersiz global kodlama '%s'"
> +
> +#: lib/option.tcl:19
> +#, tcl-format
> +msgid "Invalid repo encoding '%s'"
> +msgstr "Ge=C3=A7ersiz depo kodlamas=C4=B1 '%s'"
> +
> +#: lib/option.tcl:119
> +msgid "Restore Defaults"
> +msgstr "=C3=96ntan=C4=B1ml=C4=B1lar=C4=B1 Uygula"
> +
> +#: lib/option.tcl:123
> +msgid "Save"
> +msgstr "Kaydet"
> +
> +#: lib/option.tcl:133
> +#, tcl-format
> +msgid "%s Repository"
> +msgstr "%s Deposu"
> +
> +#: lib/option.tcl:134
> +msgid "Global (All Repositories)"
> +msgstr "Global (T=C3=BCm Depolar)"
> +
> +#: lib/option.tcl:140
> +msgid "User Name"
> +msgstr "Kullan=C4=B1c=C4=B1 Ad=C4=B1"
> +
> +#: lib/option.tcl:141
> +msgid "Email Address"
> +msgstr "E-posta Adresi"
> +
> +#: lib/option.tcl:143
> +msgid "Summarize Merge Commits"
> +msgstr "Birle=C5=9Ftirme =C4=B0=C5=9Flemelerini =C3=96zetle"
> +
> +#: lib/option.tcl:144
> +msgid "Merge Verbosity"
> +msgstr "Birle=C5=9Ftirme S=C3=B6zelli=C4=9Fi"
> +
> +#: lib/option.tcl:145
> +msgid "Show Diffstat After Merge"
> +msgstr "Birle=C5=9Ftirme Sonras=C4=B1 Diffstat G=C3=B6ster"
> +
> +#: lib/option.tcl:146
> +msgid "Use Merge Tool"
> +msgstr "Birle=C5=9Ftirme Arac=C4=B1 Kullan"
> +
> +#: lib/option.tcl:148
> +msgid "Trust File Modification Timestamps"
> +msgstr "Dosya De=C4=9Fi=C5=9Fiklik Zaman Damgalar=C4=B1na G=C3=BCven"
> +
> +#: lib/option.tcl:149
> +msgid "Prune Tracking Branches During Fetch"
> +msgstr "Getirme S=C4=B1ras=C4=B1nda =C4=B0zleme Dallar=C4=B1n=C4=B1 =
Buda"
> +
> +#: lib/option.tcl:150
> +msgid "Match Tracking Branches"
> +msgstr "=C4=B0zleme Dallar=C4=B1n=C4=B1 E=C5=9Fle=C5=9Ftir"
> +
> +#: lib/option.tcl:151
> +msgid "Use Textconv For Diffs and Blames"
> +msgstr "Diff'ler ve Su=C3=A7lamalar i=C3=A7in Textconv Kullan"
> +
> +#: lib/option.tcl:152
> +msgid "Blame Copy Only On Changed Files"
> +msgstr "Yaln=C4=B1zca De=C4=9Fi=C5=9Fikliklerde Kopyay=C4=B1 Su=C3=A7la=
"
> +
> +#: lib/option.tcl:153
> +msgid "Maximum Length of Recent Repositories List"
> +msgstr "Son Kullan=C4=B1lan Depolar Uzunlu=C4=9Fu"
> +
> +#: lib/option.tcl:154
> +msgid "Minimum Letters To Blame Copy On"
> +msgstr "Kopyan=C4=B1n Su=C3=A7lanaca=C4=9F=C4=B1 En Az Harf"
> +
> +#: lib/option.tcl:155
> +msgid "Blame History Context Radius (days)"
> +msgstr "Su=C3=A7lama Ge=C3=A7mi=C5=9Fi Ba=C4=9Flam Etki Alan=C4=B1 =
(g=C3=BCn)"
> +
> +#: lib/option.tcl:156
> +msgid "Number of Diff Context Lines"
> +msgstr "Diff Ba=C4=9Flam Sat=C4=B1rlar=C4=B1 Say=C4=B1s=C4=B1"
> +
> +#: lib/option.tcl:157
> +msgid "Additional Diff Parameters"
> +msgstr "Ek Diff Parametreleri"
> +
> +#: lib/option.tcl:158
> +msgid "Commit Message Text Width"
> +msgstr "=C4=B0=C5=9Fleme =C4=B0letisi Metin Geni=C5=9Fli=C4=9Fi"
> +
> +#: lib/option.tcl:159
> +msgid "New Branch Name Template"
> +msgstr "Yeni Dal Ad=C4=B1 =C5=9Eablonu"
> +
> +#: lib/option.tcl:160
> +msgid "Default File Contents Encoding"
> +msgstr "=C3=96ntan=C4=B1ml=C4=B1 Dosya =C4=B0=C3=A7eri=C4=9Fi =
Kodlamas=C4=B1"
> +
> +#: lib/option.tcl:161
> +msgid "Warn before committing to a detached head"
> +msgstr "Ayr=C4=B1k bir kafaya i=C5=9Flemeden =C3=B6nce uyar"
> +
> +#: lib/option.tcl:162
> +msgid "Staging of untracked files"
> +msgstr "=C4=B0zlenmeyen dosyalar=C4=B1n haz=C4=B1rlanmas=C4=B1"
> +
> +#: lib/option.tcl:163
> +msgid "Show untracked files"
> +msgstr "=C4=B0zlenmeyen dosyalar=C4=B1 g=C3=B6ster"
> +
> +#: lib/option.tcl:164
> +msgid "Tab spacing"
> +msgstr "Sekme aral=C4=B1=C4=9F=C4=B1"
> +
> +#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 =
lib/option.tcl:282
> +#: lib/database.tcl:57
> +#, tcl-format
> +msgid "%s:"
> +msgstr "%s:"
> +
> +#: lib/option.tcl:210
> +msgid "Change"
> +msgstr "De=C4=9Fi=C5=9Ftir"
> +
> +#: lib/option.tcl:254
> +msgid "Spelling Dictionary:"
> +msgstr "Yaz=C4=B1m S=C3=B6zl=C3=BC=C4=9F=C3=BC:"
> +
> +#: lib/option.tcl:284
> +msgid "Change Font"
> +msgstr "Yaz=C4=B1tipini De=C4=9Fi=C5=9Ftir"
> +
> +#: lib/option.tcl:288
> +#, tcl-format
> +msgid "Choose %s"
> +msgstr "%s =C3=B6gesini se=C3=A7"
> +
> +#: lib/option.tcl:294
> +msgid "pt."
> +msgstr "nk."
> +
> +#: lib/option.tcl:308
> +msgid "Preferences"
> +msgstr "Tercihler"
> +
> +#: lib/option.tcl:345
> +msgid "Failed to completely save options:"
> +msgstr "Se=C3=A7enekler t=C3=BCm=C3=BCyle kaydedilemedi:"
> +
> +#: lib/encoding.tcl:443
> +msgid "Default"
> +msgstr "=C3=96ntan=C4=B1ml=C4=B1"
> +
> +#: lib/encoding.tcl:448
> +#, tcl-format
> +msgid "System (%s)"
> +msgstr "Sistem (%s)"
> +
> +#: lib/encoding.tcl:459 lib/encoding.tcl:465
> +msgid "Other"
> +msgstr "Di=C4=9Fer"
> +
> +#: lib/tools.tcl:76
> +#, tcl-format
> +msgid "Running %s requires a selected file."
> +msgstr "%s =C3=B6gesini =C3=A7al=C4=B1=C5=9Ft=C4=B1rma bir se=C3=A7ili =
dosya gerektirir."
> +
> +#: lib/tools.tcl:92
> +#, tcl-format
> +msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
> +msgstr "\"%2$s\" =C3=BCzerinde %1$s =C3=A7al=C4=B1=C5=9Ft=C4=B1rmak =
istedi=C4=9Finizden emin misiniz?"
> +
> +#: lib/tools.tcl:96
> +#, tcl-format
> +msgid "Are you sure you want to run %s?"
> +msgstr "%s =C3=A7al=C4=B1=C5=9Ft=C4=B1rmak istedi=C4=9Finizden emin =
misiniz?"
> +
> +#: lib/tools.tcl:118
> +#, tcl-format
> +msgid "Tool: %s"
> +msgstr "Ara=C3=A7: %s"
> +
> +#: lib/tools.tcl:119
> +#, tcl-format
> +msgid "Running: %s"
> +msgstr "=C3=87al=C4=B1=C5=9F=C4=B1yor: %s"
> +
> +#: lib/tools.tcl:158
> +#, tcl-format
> +msgid "Tool completed successfully: %s"
> +msgstr "Ara=C3=A7 ba=C5=9Far=C4=B1yla tamamland=C4=B1: %s"
> +
> +#: lib/tools.tcl:160
> +#, tcl-format
> +msgid "Tool failed: %s"
> +msgstr "Ara=C3=A7 ba=C5=9Far=C4=B1s=C4=B1z oldu: %s"
> +
> +#: lib/mergetool.tcl:8
> +msgid "Force resolution to the base version?"
> +msgstr "=C3=87=C3=B6z=C3=BCm taban s=C3=BCr=C3=BCme zorlans=C4=B1n =
m=C4=B1?"
> +
> +#: lib/mergetool.tcl:9
> +msgid "Force resolution to this branch?"
> +msgstr "=C3=87=C3=B6z=C3=BCm bu dala zorlans=C4=B1n m=C4=B1?"
> +
> +#: lib/mergetool.tcl:10
> +msgid "Force resolution to the other branch?"
> +msgstr "=C3=87=C3=B6z=C3=BCm ba=C5=9Fka dala zorlans=C4=B1n m=C4=B1?"
> +
> +#: lib/mergetool.tcl:14
> +#, tcl-format
> +msgid ""
> +"Note that the diff shows only conflicting changes.\n"
> +"\n"
> +"%s will be overwritten.\n"
> +"\n"
> +"This operation can be undone only by restarting the merge."
> +msgstr ""
> +"diff'in yaln=C4=B1zca =C3=A7ak=C4=B1=C5=9Fan de=C4=9Fi=C5=9Fiklikleri =
g=C3=B6sterdi=C4=9Fini unutmay=C4=B1n.\n"
> +"\n"
> +"%s =C3=B6gesinin =C3=BCzerine yaz=C4=B1lacak.\n"
> +"\n"
> +"Bu i=C5=9Flem yaln=C4=B1zca birle=C5=9Ftirmeyi yeniden ba=C5=9Flatarak=
 geri al=C4=B1nabilir."
> +
> +#: lib/mergetool.tcl:45
> +#, tcl-format
> +msgid "File %s seems to have unresolved conflicts, still stage?"
> +msgstr "%s dosyas=C4=B1n=C4=B1n h=C3=A2l=C3=A2 =C3=A7=C3=B6z=C3=BClmemi=
=C5=9F =C3=A7ak=C4=B1=C5=9Fmalar=C4=B1 var g=C3=B6r=C3=BCn=C3=BCyor, =
yine de "
> +"birle=C5=9Ftirilsin mi?"
> +
> +#: lib/mergetool.tcl:60
> +#, tcl-format
> +msgid "Adding resolution for %s"
> +msgstr "%s i=C3=A7in =C3=A7=C3=B6z=C3=BCm ekleniyor"
> +
> +#: lib/mergetool.tcl:141
> +msgid "Cannot resolve deletion or link conflicts using a tool"
> +msgstr "Bir ara=C3=A7 kullanarak silme veya ba=C4=9Flant=C4=B1 =
=C3=A7ak=C4=B1=C5=9Fmalar=C4=B1 =C3=A7=C3=B6z=C3=BClemiyor"
> +
> +#: lib/mergetool.tcl:146
> +msgid "Conflict file does not exist"
> +msgstr "=C3=87ak=C4=B1=C5=9Fan dosya mevcut de=C4=9Fil"
> +
> +#: lib/mergetool.tcl:246
> +#, tcl-format
> +msgid "Not a GUI merge tool: '%s'"
> +msgstr "Bir grafik arabirim birle=C5=9Ftirme arac=C4=B1 de=C4=9Fil: =
'%s'"
> +
> +#: lib/mergetool.tcl:275
> +#, tcl-format
> +msgid "Unsupported merge tool '%s'"
> +msgstr "Desteklenmeyen birle=C5=9Ftirme arac=C4=B1 '%s'"
> +
> +#: lib/mergetool.tcl:310
> +msgid "Merge tool is already running, terminate it?"
> +msgstr "Birle=C5=9Ftirme arac=C4=B1 halihaz=C4=B1rda =C3=A7al=C4=B1=C5=9F=
=C4=B1yor, sonland=C4=B1r=C4=B1ls=C4=B1n m=C4=B1?"
> +
> +#: lib/mergetool.tcl:330
> +#, tcl-format
> +msgid ""
> +"Error retrieving versions:\n"
> +"%s"
> +msgstr ""
> +"S=C3=BCr=C3=BCmler al=C4=B1n=C4=B1rken hata:\n"
> +"%s"
> +
> +#: lib/mergetool.tcl:350
> +#, tcl-format
> +msgid ""
> +"Could not start the merge tool:\n"
> +"\n"
> +"%s"
> +msgstr ""
> +"Birle=C5=9Ftirme arac=C4=B1 ba=C5=9Flat=C4=B1lamad=C4=B1:\n"
> +"\n"
> +"%s"
> +
> +#: lib/mergetool.tcl:354
> +msgid "Running merge tool..."
> +msgstr "Birle=C5=9Ftirme arac=C4=B1 =C3=A7al=C4=B1=C5=9F=C4=B1yor..."
> +
> +#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
> +msgid "Merge tool failed."
> +msgstr "Birle=C5=9Ftirme arac=C4=B1 ba=C5=9Far=C4=B1s=C4=B1z oldu."
> +
> +#: lib/tools_dlg.tcl:22
> +#, tcl-format
> +msgid "%s (%s): Add Tool"
> +msgstr "%s (%s): Ekleme Arac=C4=B1"
> +
> +#: lib/tools_dlg.tcl:28
> +msgid "Add New Tool Command"
> +msgstr "Yeni Ara=C3=A7 Komutu Ekle"
> +
> +#: lib/tools_dlg.tcl:34
> +msgid "Add globally"
> +msgstr "Global olarak ekle"
> +
> +#: lib/tools_dlg.tcl:46
> +msgid "Tool Details"
> +msgstr "Ara=C3=A7 Ayr=C4=B1nt=C4=B1lar=C4=B1"
> +
> +#: lib/tools_dlg.tcl:49
> +msgid "Use '/' separators to create a submenu tree:"
> +msgstr "Bir alt men=C3=BC a=C4=9Fac=C4=B1 olu=C5=9Fturmak i=C3=A7in =
'/' kullan=C4=B1n:"
> +
> +#: lib/tools_dlg.tcl:60
> +msgid "Command:"
> +msgstr "Komut:"
> +
> +#: lib/tools_dlg.tcl:71
> +msgid "Show a dialog before running"
> +msgstr "=C3=87al=C4=B1=C5=9Ft=C4=B1rma =C3=B6ncesinde bir ileti=C5=9Fim=
 kutusu g=C3=B6ster"
> +
> +#: lib/tools_dlg.tcl:77
> +msgid "Ask the user to select a revision (sets $REVISION)"
> +msgstr "Kullan=C4=B1c=C4=B1ya bir revizyon se=C3=A7mesini s=C3=B6yle =
($REVISION ayarlar)"
> +
> +#: lib/tools_dlg.tcl:82
> +msgid "Ask the user for additional arguments (sets $ARGS)"
> +msgstr "Kullan=C4=B1c=C4=B1ya ek arg=C3=BCmanlar koymas=C4=B1n=C4=B1 =
s=C3=B6yle ($ARGS ayarlar)"
> +
> +#: lib/tools_dlg.tcl:89
> +msgid "Don't show the command output window"
> +msgstr "Komut =C3=A7=C4=B1kt=C4=B1 penceresini g=C3=B6sterme"
> +
> +#: lib/tools_dlg.tcl:94
> +msgid "Run only if a diff is selected ($FILENAME not empty)"
> +msgstr "Yaln=C4=B1zca bir diff se=C3=A7iliyse =C3=A7al=C4=B1=C5=9Ft=C4=B1=
r ($FILENAME bo=C5=9F de=C4=9Fil)"
> +
> +#: lib/tools_dlg.tcl:118
> +msgid "Please supply a name for the tool."
> +msgstr "Ara=C3=A7 i=C3=A7in yeni bir ad sa=C4=9Flay=C4=B1n."
> +
> +#: lib/tools_dlg.tcl:126
> +#, tcl-format
> +msgid "Tool '%s' already exists."
> +msgstr "'%s' arac=C4=B1 halihaz=C4=B1rda mevcut."
> +
> +#: lib/tools_dlg.tcl:148
> +#, tcl-format
> +msgid ""
> +"Could not add tool:\n"
> +"%s"
> +msgstr "Ara=C3=A7 eklenemedi:\n"
> +"%s"
> +
> +#: lib/tools_dlg.tcl:187
> +#, tcl-format
> +msgid "%s (%s): Remove Tool"
> +msgstr "%s (%s): Ara=C3=A7 Kald=C4=B1r"
> +
> +#: lib/tools_dlg.tcl:193
> +msgid "Remove Tool Commands"
> +msgstr "Ara=C3=A7 Komutlar=C4=B1n=C4=B1 Kald=C4=B1r"
> +
> +#: lib/tools_dlg.tcl:198
> +msgid "Remove"
> +msgstr "Kald=C4=B1r"
> +
> +#: lib/tools_dlg.tcl:231
> +msgid "(Blue denotes repository-local tools)"
> +msgstr "(Mavi renk, depoya =C3=B6zel ara=C3=A7lar=C4=B1 belirtir)"
> +
> +#: lib/tools_dlg.tcl:283
> +#, tcl-format
> +msgid "%s (%s):"
> +msgstr "%s (%s):"
> +
> +#: lib/tools_dlg.tcl:292
> +#, tcl-format
> +msgid "Run Command: %s"
> +msgstr "Komut =C3=87al=C4=B1=C5=9Ft=C4=B1r: %s"
> +
> +#: lib/tools_dlg.tcl:306
> +msgid "Arguments"
> +msgstr "Arg=C3=BCmanlar"
> +
> +#: lib/tools_dlg.tcl:341
> +msgid "OK"
> +msgstr "Tamam"
> +
> +#: lib/search.tcl:48
> +msgid "Find:"
> +msgstr "Bul:"
> +
> +#: lib/search.tcl:50
> +msgid "Next"
> +msgstr "Sonraki"
> +
> +#: lib/search.tcl:51
> +msgid "Prev"
> +msgstr "=C3=96nceki"
> +
> +#: lib/search.tcl:52
> +msgid "RegExp"
> +msgstr "D=C3=BCzenli =C4=B0fade"
> +
> +#: lib/search.tcl:54
> +msgid "Case"
> +msgstr "B=C3=9CY=C3=9CK/k=C3=BC=C3=A7=C3=BCk harf"
> +
> +#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
> +#, tcl-format
> +msgid "%s (%s): Create Desktop Icon"
> +msgstr "%s (%s): Masa=C3=BCst=C3=BC Simgesi Olu=C5=9Ftur"
> +
> +#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
> +msgid "Cannot write shortcut:"
> +msgstr "K=C4=B1sayol yaz=C4=B1lam=C4=B1yor:"
> +
> +#: lib/shortcut.tcl:140
> +msgid "Cannot write icon:"
> +msgstr "Simge yaz=C4=B1lam=C4=B1yor:"
> +
> +#: lib/remote_branch_delete.tcl:29
> +#, tcl-format
> +msgid "%s (%s): Delete Branch Remotely"
> +msgstr "%s (%s): Dal=C4=B1 Uzaktan Sil"
> +
> +#: lib/remote_branch_delete.tcl:34
> +msgid "Delete Branch Remotely"
> +msgstr "Dal=C4=B1 Uzaktan Sil"
> +
> +#: lib/remote_branch_delete.tcl:48
> +msgid "=46rom Repository"
> +msgstr "Depodan"
> +
> +#: lib/remote_branch_delete.tcl:88
> +msgid "Branches"
> +msgstr "Dallar"
> +
> +#: lib/remote_branch_delete.tcl:110
> +msgid "Delete Only If"
> +msgstr "Silme =C3=96l=C3=A7=C3=BCt=C3=BC"
> +
> +#: lib/remote_branch_delete.tcl:112
> +msgid "Merged Into:"
> +msgstr "Birle=C5=9Ftirme Konumu:"
> +
> +#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
> +msgid "Always (Do not perform merge checks)"
> +msgstr "Her Zaman (Birle=C5=9Ftirme denetimlerini uygulama)"
> +
> +#: lib/remote_branch_delete.tcl:153
> +msgid "A branch is required for 'Merged Into'."
> +msgstr "'Birle=C5=9Ftirme Konumu' i=C3=A7in bir dal gerekli."
> +
> +#: lib/remote_branch_delete.tcl:185
> +#, tcl-format
> +msgid ""
> +"The following branches are not completely merged into %s:\n"
> +"\n"
> +" - %s"
> +msgstr ""
> +"A=C5=9Fa=C4=9F=C4=B1daki dallar %s =C3=BCzerine t=C3=BCm=C3=BCyle =
birle=C5=9Ftirilmemi=C5=9F:\n"
> +"\n"
> +" - %s"
> +
> +#: lib/remote_branch_delete.tcl:190
> +#, tcl-format
> +msgid ""
> +"One or more of the merge tests failed because you have not fetched =
the "
> +"necessary commits.  Try fetching from %s first."
> +msgstr ""
> +"Bir veya daha =C3=A7ok birle=C5=9Ftirme s=C4=B1namas=C4=B1 =
ba=C5=9Far=C4=B1s=C4=B1z oldu; =C3=A7=C3=BCnk=C3=BC gerekli "
> +"i=C5=9Flemeleri getirmediniz. =C3=96nce %s konumundan getirmeyi =
deneyin."
> +
> +#: lib/remote_branch_delete.tcl:208
> +msgid "Please select one or more branches to delete."
> +msgstr "Silmek i=C3=A7in bir veya daha =C3=A7ok dal se=C3=A7in."
> +
> +#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
> +msgid ""
> +"Recovering deleted branches is difficult.\n"
> +"\n"
> +"Delete the selected branches?"
> +msgstr ""
> +"Silinen dallar=C4=B1n geri getirilmesi pek g=C3=BC=C3=A7t=C3=BCr.\n"
> +"\n"
> +"Se=C3=A7ili dallar silinsin mi?"
> +
> +#: lib/remote_branch_delete.tcl:227
> +#, tcl-format
> +msgid "Deleting branches from %s"
> +msgstr "Dallar %s konumundan siliniyor"
> +
> +#: lib/remote_branch_delete.tcl:300
> +msgid "No repository selected."
> +msgstr "Hi=C3=A7bir depo se=C3=A7ilmedi."
> +
> +#: lib/remote_branch_delete.tcl:305
> +#, tcl-format
> +msgid "Scanning %s..."
> +msgstr "%s taran=C4=B1yor..."
> +
> +#: lib/choose_repository.tcl:45
> +msgid "Git Gui"
> +msgstr "Git Grafik Arabirim"
> +
> +#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
> +msgid "Create New Repository"
> +msgstr "Yeni Depo Olu=C5=9Ftur"
> +
> +#: lib/choose_repository.tcl:110
> +msgid "New..."
> +msgstr "Yeni..."
> +
> +#: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
> +msgid "Clone Existing Repository"
> +msgstr "Var Olan Depoyu Klonla"
> +
> +#: lib/choose_repository.tcl:128
> +msgid "Clone..."
> +msgstr "Klonla..."
> +
> +#: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
> +msgid "Open Existing Repository"
> +msgstr "Var Olan Depoyu A=C3=A7"
> +
> +#: lib/choose_repository.tcl:141
> +msgid "Open..."
> +msgstr "A=C3=A7..."
> +
> +#: lib/choose_repository.tcl:154
> +msgid "Recent Repositories"
> +msgstr "Son Kullan=C4=B1lan Depolar"
> +
> +#: lib/choose_repository.tcl:164
> +msgid "Open Recent Repository:"
> +msgstr "Son Kullan=C4=B1lan Depoyu A=C3=A7:"
> +
> +#: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
> +#: lib/choose_repository.tcl:345
> +#, tcl-format
> +msgid "Failed to create repository %s:"
> +msgstr "%s deposu olu=C5=9Fturulamad=C4=B1:"
> +
> +#: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
> +msgid "Create"
> +msgstr "Olu=C5=9Ftur"
> +
> +#: lib/choose_repository.tcl:432
> +msgid "Directory:"
> +msgstr "Dizin:"
> +
> +#: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
> +#: lib/choose_repository.tcl:1139
> +msgid "Git Repository"
> +msgstr "Git Deposu"
> +
> +#: lib/choose_repository.tcl:487
> +#, tcl-format
> +msgid "Directory %s already exists."
> +msgstr "%s dizini halihaz=C4=B1rda mevcut."
> +
> +#: lib/choose_repository.tcl:491
> +#, tcl-format
> +msgid "File %s already exists."
> +msgstr "%s dosyas=C4=B1 halihaz=C4=B1rda mevcut."
> +
> +#: lib/choose_repository.tcl:506
> +msgid "Clone"
> +msgstr "Klonla"
> +
> +#: lib/choose_repository.tcl:519
> +msgid "Source Location:"
> +msgstr "Kaynak Konumu:"
> +
> +#: lib/choose_repository.tcl:528
> +msgid "Target Directory:"
> +msgstr "Hedef Dizin:"
> +
> +#: lib/choose_repository.tcl:538
> +msgid "Clone Type:"
> +msgstr "Klonlama T=C3=BCr=C3=BC:"
> +
> +#: lib/choose_repository.tcl:543
> +msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
> +msgstr "Standart (H=C4=B1zl=C4=B1, K=C4=B1smi Gerekli, Sabit =
Ba=C4=9Flant=C4=B1lar)"
> +
> +#: lib/choose_repository.tcl:548
> +msgid "Full Copy (Slower, Redundant Backup)"
> +msgstr "Tam Kopya (Daha Yava=C5=9F, B=C3=BCt=C3=BCn Yedekler)"
> +
> +#: lib/choose_repository.tcl:553
> +msgid "Shared (Fastest, Not Recommended, No Backup)"
> +msgstr "Payla=C5=9F=C4=B1lan (En H=C4=B1zl=C4=B1, =C3=96nerilmez, =
Yedeksiz)"
> +
> +#: lib/choose_repository.tcl:560
> +msgid "Recursively clone submodules too"
> +msgstr "=C3=96zyineli olarak altmod=C3=BClleri de klonla"
> +
> +#: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
> +#: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
> +#: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
> +#, tcl-format
> +msgid "Not a Git repository: %s"
> +msgstr "Bir Git deposu de=C4=9Fil: %s"
> +
> +#: lib/choose_repository.tcl:630
> +msgid "Standard only available for local repository."
> +msgstr "Standart, yaln=C4=B1zca yerel depo i=C3=A7in =
kullan=C4=B1labilir."
> +
> +#: lib/choose_repository.tcl:634
> +msgid "Shared only available for local repository."
> +msgstr "Payla=C5=9F=C4=B1lan, yaln=C4=B1zca yerel depo i=C3=A7in =
kullan=C4=B1labilir."
> +
> +#: lib/choose_repository.tcl:655
> +#, tcl-format
> +msgid "Location %s already exists."
> +msgstr "%s konumu halihaz=C4=B1rda var."
> +
> +#: lib/choose_repository.tcl:666
> +msgid "Failed to configure origin"
> +msgstr "K=C3=B6ken yap=C4=B1land=C4=B1r=C4=B1lamad=C4=B1"
> +
> +#: lib/choose_repository.tcl:678
> +msgid "Counting objects"
> +msgstr "Nesneler say=C4=B1l=C4=B1yor"
> +
> +#: lib/choose_repository.tcl:679
> +msgid "buckets"
> +msgstr "kovalar"
> +
> +#: lib/choose_repository.tcl:703
> +#, tcl-format
> +msgid "Unable to copy objects/info/alternates: %s"
> +msgstr "Nesneler/bilgi/alternatifler kopyalanam=C4=B1yor: %s"
> +
> +#: lib/choose_repository.tcl:740
> +#, tcl-format
> +msgid "Nothing to clone from %s."
> +msgstr "%s konumundan klonlanacak bir =C5=9Fey yok."
> +
> +#: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
> +#: lib/choose_repository.tcl:974
> +msgid "The 'master' branch has not been initialized."
> +msgstr "'master' dal=C4=B1 ilklendirilmedi."
> +
> +#: lib/choose_repository.tcl:755
> +msgid "Hardlinks are unavailable.  Falling back to copying."
> +msgstr "Sabit ba=C4=9Flant=C4=B1lar kullan=C4=B1lam=C4=B1yor. Yerine, =
kopyalama kullan=C4=B1l=C4=B1yor."
> +
> +#: lib/choose_repository.tcl:769
> +#, tcl-format
> +msgid "Cloning from %s"
> +msgstr "%s konumundan klonlan=C4=B1yor"
> +
> +#: lib/choose_repository.tcl:800
> +msgid "Copying objects"
> +msgstr "Nesneler kopyalan=C4=B1yor"
> +
> +#: lib/choose_repository.tcl:801
> +msgid "KiB"
> +msgstr "KiB"
> +
> +#: lib/choose_repository.tcl:825
> +#, tcl-format
> +msgid "Unable to copy object: %s"
> +msgstr "Nesne kopyalanam=C4=B1yor: %s"
> +
> +#: lib/choose_repository.tcl:837
> +msgid "Linking objects"
> +msgstr "Nesneler ba=C4=9Flan=C4=B1yor"
> +
> +#: lib/choose_repository.tcl:838
> +msgid "objects"
> +msgstr "nesneler"
> +
> +#: lib/choose_repository.tcl:846
> +#, tcl-format
> +msgid "Unable to hardlink object: %s"
> +msgstr "Nesne sabit ba=C4=9Flant=C4=B1s=C4=B1 yap=C4=B1lam=C4=B1yor: =
%s"
> +
> +#: lib/choose_repository.tcl:903
> +msgid "Cannot fetch branches and objects.  See console output for =
details."
> +msgstr "Dallar ve nesneler getirilemiyor. Ayr=C4=B1nt=C4=B1lar i=C3=A7i=
n konsol =C3=A7=C4=B1kt=C4=B1s=C4=B1na "
> +"bak=C4=B1n."
> +
> +#: lib/choose_repository.tcl:914
> +msgid "Cannot fetch tags.  See console output for details."
> +msgstr "Etiketler getirilemiyor. Ayr=C4=B1nt=C4=B1lar i=C3=A7in =
konsol =C3=A7=C4=B1kt=C4=B1s=C4=B1na bak=C4=B1n."
> +
> +#: lib/choose_repository.tcl:938
> +msgid "Cannot determine HEAD.  See console output for details."
> +msgstr "HEAD belirlenemiyor. Ayr=C4=B1nt=C4=B1lar i=C3=A7in konsol =
=C3=A7=C4=B1kt=C4=B1s=C4=B1na bak=C4=B1n."
> +
> +#: lib/choose_repository.tcl:947
> +#, tcl-format
> +msgid "Unable to cleanup %s"
> +msgstr "%s temizlen=C4=B1p toparlanam=C4=B1yor"
> +
> +#: lib/choose_repository.tcl:953
> +msgid "Clone failed."
> +msgstr "Klonlama ba=C5=9Far=C4=B1s=C4=B1z."
> +
> +#: lib/choose_repository.tcl:960
> +msgid "No default branch obtained."
> +msgstr "=C3=96ntan=C4=B1ml=C4=B1 bir dal al=C4=B1namad=C4=B1."
> +
> +#: lib/choose_repository.tcl:971
> +#, tcl-format
> +msgid "Cannot resolve %s as a commit."
> +msgstr "%s, bir i=C5=9Fleme olarak =C3=A7=C3=B6z=C3=BClemiyor."
> +
> +#: lib/choose_repository.tcl:998
> +msgid "Creating working directory"
> +msgstr "=C3=87al=C4=B1=C5=9Fma dizini olu=C5=9Fturuluyor"
> +
> +#: lib/choose_repository.tcl:1028
> +msgid "Initial file checkout failed."
> +msgstr "=C4=B0lk dosya =C3=A7=C4=B1k=C4=B1=C5=9F=C4=B1 ba=C5=9Far=C4=B1=
s=C4=B1z."
> +
> +#: lib/choose_repository.tcl:1072
> +msgid "Cloning submodules"
> +msgstr "Altmod=C3=BCller klonlan=C4=B1yor"
> +
> +#: lib/choose_repository.tcl:1087
> +msgid "Cannot clone submodules."
> +msgstr "Altmod=C3=BCller klonlanam=C4=B1yor."
> +
> +#: lib/choose_repository.tcl:1110
> +msgid "Repository:"
> +msgstr "Depo:"
> +
> +#: lib/choose_repository.tcl:1159
> +#, tcl-format
> +msgid "Failed to open repository %s:"
> +msgstr "%s deposu a=C3=A7=C4=B1lamad=C4=B1:"
> +
> +#: lib/about.tcl:26
> +msgid "git-gui - a graphical user interface for Git."
> +msgstr "git-gui - Git i=C3=A7in bir grafik kullan=C4=B1c=C4=B1 =
arabirimi."
> +
> +#: lib/blame.tcl:74
> +#, tcl-format
> +msgid "%s (%s): File Viewer"
> +msgstr "%s (%s): Dosya G=C3=B6r=C3=BCnt=C3=BCleyici"
> +
> +#: lib/blame.tcl:80
> +msgid "Commit:"
> +msgstr "=C4=B0=C5=9Fleme:"
> +
> +#: lib/blame.tcl:282
> +msgid "Copy Commit"
> +msgstr "=C4=B0=C5=9Fleme Kopyala"
> +
> +#: lib/blame.tcl:286
> +msgid "Find Text..."
> +msgstr "Metin Bul..."
> +
> +#: lib/blame.tcl:290
> +msgid "Goto Line..."
> +msgstr "Sat=C4=B1ra Git..."
> +
> +#: lib/blame.tcl:299
> +msgid "Do Full Copy Detection"
> +msgstr "Tam Kopya Alg=C4=B1lamas=C4=B1 Yap"
> +
> +#: lib/blame.tcl:303
> +msgid "Show History Context"
> +msgstr "Ge=C3=A7mi=C5=9F Ba=C4=9Flam=C4=B1n=C4=B1 G=C3=B6ster"
> +
> +#: lib/blame.tcl:306
> +msgid "Blame Parent Commit"
> +msgstr "=C3=9Cst =C4=B0=C5=9Flemeyi Su=C3=A7la"
> +
> +#: lib/blame.tcl:468
> +#, tcl-format
> +msgid "Reading %s..."
> +msgstr "%s okunuyor..."
> +
> +#: lib/blame.tcl:596
> +msgid "Loading copy/move tracking annotations..."
> +msgstr "Kopyala/Ta=C5=9F=C4=B1 izleme ek a=C3=A7=C4=B1klamalar=C4=B1 =
y=C3=BCkleniyor..."
> +
> +#: lib/blame.tcl:613
> +msgid "lines annotated"
> +msgstr "sat=C4=B1ra a=C3=A7=C4=B1klama eklendi"
> +
> +#: lib/blame.tcl:815
> +msgid "Loading original location annotations..."
> +msgstr "=C3=96zg=C3=BCn konum ek a=C3=A7=C4=B1klamalar=C4=B1 =
y=C3=BCkleniyor..."
> +
> +#: lib/blame.tcl:818
> +msgid "Annotation complete."
> +msgstr "Ek a=C3=A7=C4=B1klamalar tamamland=C4=B1."
> +
> +#: lib/blame.tcl:849
> +msgid "Busy"
> +msgstr "Me=C5=9Fgul"
> +
> +#: lib/blame.tcl:850
> +msgid "Annotation process is already running."
> +msgstr "A=C3=A7=C4=B1klamaland=C4=B1rma i=C5=9Flemi halihaz=C4=B1rda =
=C3=A7al=C4=B1=C5=9F=C4=B1yor."
> +
> +#: lib/blame.tcl:889
> +msgid "Running thorough copy detection..."
> +msgstr "Ayr=C4=B1nt=C4=B1l=C4=B1 kopya alg=C4=B1lamas=C4=B1 =
=C3=A7al=C4=B1=C5=9F=C4=B1yor..."
> +
> +#: lib/blame.tcl:957
> +msgid "Loading annotation..."
> +msgstr "Ek a=C3=A7=C4=B1klama y=C3=BCkleniyor..."
> +
> +#: lib/blame.tcl:1010
> +msgid "Author:"
> +msgstr "Yazar:"
> +
> +#: lib/blame.tcl:1014
> +msgid "Committer:"
> +msgstr "=C4=B0=C5=9Fleyici:"
> +
> +#: lib/blame.tcl:1019
> +msgid "Original File:"
> +msgstr "=C3=96zg=C3=BCn Dosya:"
> +
> +#: lib/blame.tcl:1067
> +msgid "Cannot find HEAD commit:"
> +msgstr "HEAD i=C5=9Flemesi bulunam=C4=B1yor:"
> +
> +#: lib/blame.tcl:1122
> +msgid "Cannot find parent commit:"
> +msgstr "=C3=9Cst i=C5=9Fleme bulunam=C4=B1yor:"
> +
> +#: lib/blame.tcl:1137
> +msgid "Unable to display parent"
> +msgstr "=C3=9Cst =C3=B6ge g=C3=B6r=C3=BCnt=C3=BClenemiyor"
> +
> +#: lib/blame.tcl:1138 lib/diff.tcl:345
> +msgid "Error loading diff:"
> +msgstr "diff y=C3=BCklenirken hata:"
> +
> +#: lib/blame.tcl:1279
> +msgid "Originally By:"
> +msgstr "=C4=B0lk Yazan:"
> +
> +#: lib/blame.tcl:1285
> +msgid "In File:"
> +msgstr "=C5=9Eu Dosyada:"
> +
> +#: lib/blame.tcl:1290
> +msgid "Copied Or Moved Here By:"
> +msgstr "Buraya Kopyalayan/Ta=C5=9F=C4=B1yan:"
> +
> +#: lib/diff.tcl:77
> +#, tcl-format
> +msgid ""
> +"No differences detected.\n"
> +"\n"
> +"%s has no changes.\n"
> +"\n"
> +"The modification date of this file was updated by another =
application, but "
> +"the content within the file was not changed.\n"
> +"\n"
> +"A rescan will be automatically started to find other files which may =
have "
> +"the same state."
> +msgstr ""
> +"De=C4=9Fi=C5=9Fikli=C4=9Fe rastlanmad=C4=B1.\n"
> +"\n"
> +"%s =C3=B6gesinde de=C4=9Fi=C5=9Fiklik yok.\n"
> +"\n"
> +"Bu dosyan=C4=B1n de=C4=9Fi=C5=9Fiklik tarihi =C3=B6zniteli=C4=9Fi =
ba=C5=9Fka bir uygulama taraf=C4=B1ndan "
> +"g=C3=BCncellenmi=C5=9F; ancak dosya i=C3=A7eri=C4=9Fine =
dokunulmam=C4=B1=C5=9F.\n"
> +"\n"
> +"Buna benzer bir durumda olan ba=C5=9Fka bir dosya olup =
olmad=C4=B1=C4=9F=C4=B1n=C4=B1 alg=C4=B1lamak "
> +"i=C3=A7in bir yeniden tarama kendili=C4=9Finden ba=C5=9Flat=C4=B1lacak=
."
> +
> +#: lib/diff.tcl:117
> +#, tcl-format
> +msgid "Loading diff of %s..."
> +msgstr "%s dosyas=C4=B1n=C4=B1n diff'i y=C3=BCkleniyor..."
> +
> +#: lib/diff.tcl:143
> +msgid ""
> +"LOCAL: deleted\n"
> +"REMOTE:\n"
> +msgstr ""
> +"YEREL: Silindi\n"
> +"UZAK KONUM:\n"
> +
> +#: lib/diff.tcl:148
> +msgid ""
> +"REMOTE: deleted\n"
> +"LOCAL:\n"
> +msgstr ""
> +"UZAK KONUM: Silindi\n"
> +"YEREL:\n"
> +
> +#: lib/diff.tcl:155
> +msgid "LOCAL:\n"
> +msgstr "YEREL:\n"
> +
> +#: lib/diff.tcl:158
> +msgid "REMOTE:\n"
> +msgstr "UZAK KONUM:\n"
> +
> +#: lib/diff.tcl:220 lib/diff.tcl:344
> +#, tcl-format
> +msgid "Unable to display %s"
> +msgstr "%s g=C3=B6r=C3=BCnt=C3=BClenemiyor"
> +
> +#: lib/diff.tcl:221
> +msgid "Error loading file:"
> +msgstr "Dosya y=C3=BCklenirken hata:"
> +
> +#: lib/diff.tcl:227
> +msgid "Git Repository (subproject)"
> +msgstr "Git Deposu (altproje)"
> +
> +#: lib/diff.tcl:239
> +msgid "* Binary file (not showing content)."
> +msgstr "* =C4=B0kili dosya (i=C3=A7erik g=C3=B6sterilmiyor)."
> +
> +#: lib/diff.tcl:244
> +#, tcl-format
> +msgid ""
> +"* Untracked file is %d bytes.\n"
> +"* Showing only first %d bytes.\n"
> +msgstr ""
> +"* =C4=B0zlenmeyen dosya %d bayt.\n"
> +"* Yaln=C4=B1zca ilk %d bayt=C4=B1 g=C3=B6steriliyor.\n"
> +
> +#: lib/diff.tcl:250
> +#, tcl-format
> +msgid ""
> +"\n"
> +"* Untracked file clipped here by %s.\n"
> +"* To see the entire file, use an external editor.\n"
> +msgstr ""
> +"\n"
> +"* =C4=B0zlenmeyen dosya burada %s kadar k=C4=B1rp=C4=B1lm=C4=B1=C5=9F.=
\n"
> +"* T=C3=BCm dosyas=C4=B1 g=C3=B6rmek i=C3=A7in bir d=C4=B1=C5=9F =
d=C3=BCzenleyici kullan=C4=B1n.\n"
> +
> +#: lib/diff.tcl:583
> +msgid "Failed to unstage selected hunk."
> +msgstr "Se=C3=A7ili par=C3=A7a haz=C4=B1rl=C4=B1ktan =
=C3=A7=C4=B1kar=C4=B1lamad=C4=B1."
> +
> +#: lib/diff.tcl:591
> +msgid "Failed to revert selected hunk."
> +msgstr "Se=C3=A7ili par=C3=A7a geri al=C4=B1namad=C4=B1."
> +
> +#: lib/diff.tcl:594
> +msgid "Failed to stage selected hunk."
> +msgstr "Se=C3=A7ili par=C3=A7a haz=C4=B1rlanamad=C4=B1."
> +
> +#: lib/diff.tcl:687
> +msgid "Failed to unstage selected line."
> +msgstr "Se=C3=A7ili sat=C4=B1r haz=C4=B1rl=C4=B1ktan =
=C3=A7=C4=B1kar=C4=B1lamad=C4=B1."
> +
> +#: lib/diff.tcl:696
> +msgid "Failed to revert selected line."
> +msgstr "Se=C3=A7ili sat=C4=B1r geri al=C4=B1namad=C4=B1."
> +
> +#: lib/diff.tcl:700
> +msgid "Failed to stage selected line."
> +msgstr "Se=C3=A7ili sat=C4=B1r haz=C4=B1rlanamad=C4=B1."
> +
> +#: lib/diff.tcl:889
> +msgid "Failed to undo last revert."
> +msgstr "Son geri alma i=C5=9Flemi iptal edilemedi."
> +
> +#: lib/sshkey.tcl:34
> +msgid "No keys found."
> +msgstr "Anahtar bulunamad=C4=B1."
> +
> +#: lib/sshkey.tcl:37
> +#, tcl-format
> +msgid "Found a public key in: %s"
> +msgstr "=C5=9Eurada bir genel anahtar bulundu: %s"
> +
> +#: lib/sshkey.tcl:43
> +msgid "Generate Key"
> +msgstr "Anahtar Olu=C5=9Ftur"
> +
> +#: lib/sshkey.tcl:61
> +msgid "Copy To Clipboard"
> +msgstr "Panoya Kopyala"
> +
> +#: lib/sshkey.tcl:75
> +msgid "Your OpenSSH Public Key"
> +msgstr "OpenSSH Genel Anahtar=C4=B1n=C4=B1z"
> +
> +#: lib/sshkey.tcl:83
> +msgid "Generating..."
> +msgstr "Olu=C5=9Fturuluyor..."
> +
> +#: lib/sshkey.tcl:89
> +#, tcl-format
> +msgid ""
> +"Could not start ssh-keygen:\n"
> +"\n"
> +"%s"
> +msgstr ""
> +"ssh-keygen ba=C5=9Flat=C4=B1lamad=C4=B1:\n"
> +"\n"
> +"%s"
> +
> +#: lib/sshkey.tcl:116
> +msgid "Generation failed."
> +msgstr "Olu=C5=9Fturma ba=C5=9Far=C4=B1s=C4=B1z."
> +
> +#: lib/sshkey.tcl:123
> +msgid "Generation succeeded, but no keys found."
> +msgstr "Olu=C5=9Fturma ba=C5=9Far=C4=B1l=C4=B1; ancak bir anahtar =
bulunamad=C4=B1."
> +
> +#: lib/sshkey.tcl:126
> +#, tcl-format
> +msgid "Your key is in: %s"
> +msgstr "Anahtar=C4=B1n=C4=B1z =C5=9Furada: %s"
> +
> +#: lib/branch_create.tcl:23
> +#, tcl-format
> +msgid "%s (%s): Create Branch"
> +msgstr "%s (%s): Dal Olu=C5=9Ftur"
> +
> +#: lib/branch_create.tcl:28
> +msgid "Create New Branch"
> +msgstr "Yeni Dal Olu=C5=9Ftur"
> +
> +#: lib/branch_create.tcl:42
> +msgid "Branch Name"
> +msgstr "Dal Ad=C4=B1"
> +
> +#: lib/branch_create.tcl:57
> +msgid "Match Tracking Branch Name"
> +msgstr "=C4=B0zleyen Dal Ad=C4=B1 ile E=C5=9Fle=C5=9F"
> +
> +#: lib/branch_create.tcl:66
> +msgid "Starting Revision"
> +msgstr "Ba=C5=9Flama Revizyonu"
> +
> +#: lib/branch_create.tcl:72
> +msgid "Update Existing Branch:"
> +msgstr "Var Olan Dal=C4=B1 G=C3=BCncelle:"
> +
> +#: lib/branch_create.tcl:75
> +msgid "No"
> +msgstr "Hay=C4=B1r"
> +
> +#: lib/branch_create.tcl:80
> +msgid "Fast Forward Only"
> +msgstr "Yaln=C4=B1zca =C4=B0leri Sar=C4=B1m"
> +
> +#: lib/branch_create.tcl:97
> +msgid "Checkout After Creation"
> +msgstr "Olu=C5=9Fturduktan Sonra =C3=87=C4=B1k=C4=B1=C5=9F Yap"
> +
> +#: lib/branch_create.tcl:132
> +msgid "Please select a tracking branch."
> +msgstr "Bir izleme dal=C4=B1 se=C3=A7in."
> +
> +#: lib/branch_create.tcl:141
> +#, tcl-format
> +msgid "Tracking branch %s is not a branch in the remote repository."
> +msgstr "=C4=B0zleme dal=C4=B1 %s, uzak depoda bir dal de=C4=9Fil."
> +
> +#: lib/console.tcl:59
> +msgid "Working... please wait..."
> +msgstr "=C3=87al=C4=B1=C5=9F=C4=B1yor... l=C3=BCtfen bekleyin..."
> +
> +#: lib/console.tcl:186
> +msgid "Success"
> +msgstr "Ba=C5=9Far=C4=B1l=C4=B1"
> +
> +#: lib/console.tcl:200
> +msgid "Error: Command Failed"
> +msgstr "Hata: Komut Ba=C5=9Far=C4=B1s=C4=B1z"
> +
> +#: lib/line.tcl:17
> +msgid "Goto Line:"
> +msgstr "Sat=C4=B1ra Git:"
> +
> +#: lib/line.tcl:23
> +msgid "Go"
> +msgstr "Git"
> +
> +#: lib/choose_rev.tcl:52
> +msgid "This Detached Checkout"
> +msgstr "Bu Ayr=C4=B1k =C3=87=C4=B1k=C4=B1=C5=9F"
> +
> +#: lib/choose_rev.tcl:60
> +msgid "Revision Expression:"
> +msgstr "Revizyon =C4=B0fadesi:"
> +
> +#: lib/choose_rev.tcl:72
> +msgid "Local Branch"
> +msgstr "Yerel Dal"
> +
> +#: lib/choose_rev.tcl:77
> +msgid "Tracking Branch"
> +msgstr "=C4=B0zleyen Dal"
> +
> +#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
> +msgid "Tag"
> +msgstr "Etiket"
> +
> +#: lib/choose_rev.tcl:321
> +#, tcl-format
> +msgid "Invalid revision: %s"
> +msgstr "Ge=C3=A7ersiz revizyon: %s"
> +
> +#: lib/choose_rev.tcl:342
> +msgid "No revision selected."
> +msgstr "Hi=C3=A7bir revizyon se=C3=A7ilmedi."
> +
> +#: lib/choose_rev.tcl:350
> +msgid "Revision expression is empty."
> +msgstr "Revizyon ifadesi bo=C5=9F."
> +
> +#: lib/choose_rev.tcl:537
> +msgid "Updated"
> +msgstr "G=C3=BCncellendi"
> +
> +#: lib/choose_rev.tcl:565
> +msgid "URL"
> +msgstr "URL"
> +
> +#: lib/commit.tcl:9
> +msgid ""
> +"There is nothing to amend.\n"
> +"\n"
> +"You are about to create the initial commit.  There is no commit =
before this "
> +"to amend.\n"
> +msgstr ""
> +"De=C4=9Fi=C5=9Ftirilecek bir =C5=9Fey yok.\n"
> +"\n"
> +"=C4=B0lk i=C5=9Flemeyi olu=C5=9Fturmak =C3=BCzeresiniz. Bundan =C3=B6n=
ce de=C4=9Fi=C5=9Ftirilecek bir i=C5=9Fleme "
> +"yok.\n"
> +
> +#: lib/commit.tcl:18
> +msgid ""
> +"Cannot amend while merging.\n"
> +"\n"
> +"You are currently in the middle of a merge that has not been fully "
> +"completed.  You cannot amend the prior commit unless you first abort =
the "
> +"current merge activity.\n"
> +msgstr ""
> +"Birle=C5=9Ftirme s=C4=B1ras=C4=B1nda de=C4=9Fi=C5=9Ftirme =
yap=C4=B1lamaz.\n"
> +"\n"
> +"=C5=9Eu anda t=C3=BCm=C3=BCyle bitmemi=C5=9F bir birle=C5=9Ftirmenin =
ortas=C4=B1ndas=C4=B1n=C4=B1z. Ge=C3=A7erli "
> +"birle=C5=9Ftirme etkinli=C4=9Fini iptal etmedi=C4=9Finiz s=C3=BCrece =
bir =C3=B6nceki i=C5=9Flemeyi "
> +"de=C4=9Fi=C5=9Ftiremezsiniz.\n"
> +
> +#: lib/commit.tcl:56
> +msgid "Error loading commit data for amend:"
> +msgstr "De=C4=9Fi=C5=9Ftirme i=C3=A7in i=C5=9Fleme verisini =
y=C3=BCklerken hata:"
> +
> +#: lib/commit.tcl:83
> +msgid "Unable to obtain your identity:"
> +msgstr "Kimli=C4=9Finiz tan=C4=B1mlanam=C4=B1yor:"
> +
> +#: lib/commit.tcl:88
> +msgid "Invalid GIT_COMMITTER_IDENT:"
> +msgstr "Ge=C3=A7ersiz GIT_COMMITTER_IDENT:"
> +
> +#: lib/commit.tcl:138
> +#, tcl-format
> +msgid "warning: Tcl does not support encoding '%s'."
> +msgstr "uyar=C4=B1: Tcl, '%s' kodlamas=C4=B1n=C4=B1 desteklemiyor."
> +
> +#: lib/commit.tcl:158
> +msgid ""
> +"Last scanned state does not match repository state.\n"
> +"\n"
> +"Another Git program has modified this repository since the last =
scan.  A "
> +"rescan must be performed before another commit can be created.\n"
> +"\n"
> +"The rescan will be automatically started now.\n"
> +msgstr ""
> +"Son taranan durum depo durumu ile e=C5=9Fle=C5=9Fmiyor.\n"
> +"\n"
> +"Ba=C5=9Fka bir Git program=C4=B1, bu depoyu son taramadan beri =
de=C4=9Fi=C5=9Ftirmi=C5=9F. Ba=C5=9Fka "
> +"bir i=C5=9Flemenin olu=C5=9Fturabilmesi i=C3=A7in bir yeniden tarama =
ger=C3=A7ekle=C5=9Ftirilmelidir.\n"
> +"\n"
> +"Yeniden tarama =C5=9Fimdi kendili=C4=9Finden ba=C5=9Flat=C4=B1lacak.\n=
"
> +
> +#: lib/commit.tcl:182
> +#, tcl-format
> +msgid ""
> +"Unmerged files cannot be committed.\n"
> +"\n"
> +"File %s has merge conflicts.  You must resolve them and stage the =
file "
> +"before committing.\n"
> +msgstr ""
> +"Birle=C5=9Ftirilmemi=C5=9F dosyalar i=C5=9Flenemez.\n"
> +"\n"
> +"%s dosyas=C4=B1nda birle=C5=9Ftirme =C3=A7ak=C4=B1=C5=9Fmalar=C4=B1 =
mevcut. =C4=B0=C5=9Flemeden =C3=B6nce bu =C3=A7ak=C4=B1=C5=9Fmalar=C4=B1 =
"
> +"=C3=A7=C3=B6zmeli ve dosyay=C4=B1 haz=C4=B1rlamal=C4=B1s=C4=B1n=C4=B1z=
.\n"
> +
> +#: lib/commit.tcl:190
> +#, tcl-format
> +msgid ""
> +"Unknown file state %s detected.\n"
> +"\n"
> +"File %s cannot be committed by this program.\n"
> +msgstr ""
> +"%s bilinmeyen dosya durumu alg=C4=B1land=C4=B1.\n"
> +"\n"
> +"%s dosyas=C4=B1 bu program taraf=C4=B1ndan i=C5=9Flenemez.\n"
> +
> +#: lib/commit.tcl:198
> +msgid ""
> +"No changes to commit.\n"
> +"\n"
> +"You must stage at least 1 file before you can commit.\n"
> +msgstr ""
> +"=C4=B0=C5=9Flenecek bir de=C4=9Fi=C5=9Fiklik yok.\n"
> +"\n"
> +"=C4=B0=C5=9Fleme yapmadan =C3=B6nce en az bir dosyay=C4=B1 =
haz=C4=B1rlamal=C4=B1s=C4=B1n=C4=B1z.\n"
> +
> +#: lib/commit.tcl:213
> +msgid ""
> +"Please supply a commit message.\n"
> +"\n"
> +"A good commit message has the following format:\n"
> +"\n"
> +"- First line: Describe in one sentence what you did.\n"
> +"- Second line: Blank\n"
> +"- Remaining lines: Describe why this change is good.\n"
> +msgstr ""
> +"L=C3=BCtfen bir i=C5=9Fleme iletisi sa=C4=9Flay=C4=B1n.\n"
> +"\n"
> +"=C4=B0yi bir i=C5=9Fleme iletisi a=C5=9Fa=C4=9F=C4=B1daki bi=C3=A7ime =
g=C3=B6re haz=C4=B1rlan=C4=B1r:\n"
> +"\n"
> +"- =C4=B0lk sat=C4=B1r: Ne yapt=C4=B1=C4=9F=C4=B1n=C4=B1z=C4=B1 bir =
t=C3=BCmce ile a=C3=A7=C4=B1klay=C4=B1n.\n"
> +"- =C4=B0kinci sat=C4=B1r: Bo=C5=9F\n"
> +"- Kalan sat=C4=B1rlar: Bu de=C4=9Fi=C5=9Fikli=C4=9Fin neden iyi =
oldu=C4=9Funu a=C3=A7=C4=B1klay=C4=B1n.\n"
> +
> +#: lib/commit.tcl:244
> +msgid "Calling pre-commit hook..."
> +msgstr "pre-commit kancas=C4=B1 =C3=A7a=C4=9Fr=C4=B1l=C4=B1yor..."
> +
> +#: lib/commit.tcl:259
> +msgid "Commit declined by pre-commit hook."
> +msgstr "=C4=B0=C5=9Fleme, pre-commit kancas=C4=B1 taraf=C4=B1ndan =
reddedildi."
> +
> +#: lib/commit.tcl:278
> +msgid ""
> +"You are about to commit on a detached head. This is a potentially =
dangerous "
> +"thing to do because if you switch to another branch you will lose =
your "
> +"changes and it can be difficult to retrieve them later from the =
reflog. You "
> +"should probably cancel this commit and create a new branch to =
continue.\n"
> +" \n"
> +" Do you really want to proceed with your Commit?"
> +msgstr ""
> +"Ayr=C4=B1k bir HEAD =C3=BCzerinde i=C5=9Fleme yapmak =C3=BCzeresiniz. =
Bu genelde yap=C4=B1lmas=C4=B1 "
> +"=C3=B6nerilmeyen bir =C5=9Feydir; =C3=A7=C3=BCnk=C3=BC ba=C5=9Fka =
bir dala ge=C3=A7erseniz de=C4=9Fi=C5=9Fikliklerinizi "
> +"kaybedeceksiniz ve daha sonra onlar=C4=B1 ba=C5=9Fvuru =
g=C3=BCnl=C3=BC=C4=9F=C3=BCnden kurtarmak g=C3=BC=C3=A7 "
> +"olabilir. Bu i=C5=9Flemeyi iptal etmeli ve s=C3=BCrd=C3=BCrmek i=C3=A7=
in yeni bir dal "
> +"olu=C5=9Fturmal=C4=B1s=C4=B1n=C4=B1z.\n"
> +" \n"
> +" Ger=C3=A7ekten i=C5=9Flemek istedi=C4=9Finize emin misiniz?"
> +
> +#: lib/commit.tcl:299
> +msgid "Calling commit-msg hook..."
> +msgstr "commit-msg kancas=C4=B1 =C3=A7a=C4=9Fr=C4=B1l=C4=B1yor..."
> +
> +#: lib/commit.tcl:314
> +msgid "Commit declined by commit-msg hook."
> +msgstr "=C4=B0=C5=9Fleme, commit-msg kancas=C4=B1 taraf=C4=B1ndan =
reddedildi."
> +
> +#: lib/commit.tcl:327
> +msgid "Committing changes..."
> +msgstr "De=C4=9Fi=C5=9Fiklikler i=C5=9Fleniyor..."
> +
> +#: lib/commit.tcl:344
> +msgid "write-tree failed:"
> +msgstr "write-tree ba=C5=9Far=C4=B1s=C4=B1z oldu:"
> +
> +#: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
> +msgid "Commit failed."
> +msgstr "=C4=B0=C5=9Fleme ba=C5=9Far=C4=B1s=C4=B1z."
> +
> +#: lib/commit.tcl:362
> +#, tcl-format
> +msgid "Commit %s appears to be corrupt"
> +msgstr "%s i=C5=9Flemesi hasarl=C4=B1 gibi g=C3=B6r=C3=BCn=C3=BCyor"
> +
> +#: lib/commit.tcl:367
> +msgid ""
> +"No changes to commit.\n"
> +"\n"
> +"No files were modified by this commit and it was not a merge =
commit.\n"
> +"\n"
> +"A rescan will be automatically started now.\n"
> +msgstr ""
> +"=C4=B0=C5=9Flenecek bir de=C4=9Fi=C5=9Fiklik yok.\n"
> +"\n"
> +"Herhangi bir dosya de=C4=9Fi=C5=9Ftirilmedi ve bir birle=C5=9Ftirme =
i=C5=9Flemesi de de=C4=9Fildi.\n"
> +"\n"
> +"Bir yeniden tarama =C5=9Fimdi kendili=C4=9Finden ba=C5=9Flat=C4=B1laca=
k.\n"
> +
> +#: lib/commit.tcl:374
> +msgid "No changes to commit."
> +msgstr "=C4=B0=C5=9Flenecek bir de=C4=9Fi=C5=9Fiklik yok."
> +
> +#: lib/commit.tcl:394
> +msgid "commit-tree failed:"
> +msgstr "commit-tree ba=C5=9Far=C4=B1s=C4=B1z oldu:"
> +
> +#: lib/commit.tcl:421
> +msgid "update-ref failed:"
> +msgstr "update-ref ba=C5=9Far=C4=B1s=C4=B1z oldu:"
> +
> +#: lib/commit.tcl:514
> +#, tcl-format
> +msgid "Created commit %s: %s"
> +msgstr "%s i=C5=9Flemesi olu=C5=9Fturuldu: %s"
> +
> +#: lib/branch_delete.tcl:16
> +#, tcl-format
> +msgid "%s (%s): Delete Branch"
> +msgstr "%s (%s): Dal Sil"
> +
> +#: lib/branch_delete.tcl:21
> +msgid "Delete Local Branch"
> +msgstr "Yerel Dal Sil"
> +
> +#: lib/branch_delete.tcl:39
> +msgid "Local Branches"
> +msgstr "Yerel Dallar"
> +
> +#: lib/branch_delete.tcl:51
> +msgid "Delete Only If Merged Into"
> +msgstr "Yaln=C4=B1zca Birle=C5=9Ftirilmi=C5=9Fse Sil"
> +
> +#: lib/branch_delete.tcl:103
> +#, tcl-format
> +msgid "The following branches are not completely merged into %s:"
> +msgstr "A=C5=9Fa=C4=9F=C4=B1daki dallar %s i=C3=A7ine t=C3=BCm=C3=BCyle=
 birle=C5=9Ftirilmemi=C5=9F:"
> +
> +#: lib/branch_delete.tcl:131
> +#, tcl-format
> +msgid " - %s:"
> +msgstr " - %s:"
> +
> +#: lib/branch_delete.tcl:141
> +#, tcl-format
> +msgid ""
> +"Failed to delete branches:\n"
> +"%s"
> +msgstr ""
> +"Dal(lar) silinemedi:\n"
> +"%s"
> +
> +#: lib/date.tcl:25
> +#, tcl-format
> +msgid "Invalid date from Git: %s"
> +msgstr "Ge=C3=A7ersiz Git tarihi: %s"
> +
> +#: lib/database.tcl:42
> +msgid "Number of loose objects"
> +msgstr "Gev=C5=9Fek nesnelerin say=C4=B1s=C4=B1"
> +
> +#: lib/database.tcl:43
> +msgid "Disk space used by loose objects"
> +msgstr "Gev=C5=9Fek nesneler taraf=C4=B1ndan kullan=C4=B1lan disk =
alan=C4=B1"
> +
> +#: lib/database.tcl:44
> +msgid "Number of packed objects"
> +msgstr "Paketlenmi=C5=9F nesnelerin say=C4=B1s=C4=B1"
> +
> +#: lib/database.tcl:45
> +msgid "Number of packs"
> +msgstr "Paket say=C4=B1s=C4=B1"
> +
> +#: lib/database.tcl:46
> +msgid "Disk space used by packed objects"
> +msgstr "Paketlenmi=C5=9F nesneler taraf=C4=B1ndan kullan=C4=B1lan =
disk alan=C4=B1"
> +
> +#: lib/database.tcl:47
> +msgid "Packed objects waiting for pruning"
> +msgstr "Budanmak i=C3=A7in bekleyen paketlenmi=C5=9F nesneler"
> +
> +#: lib/database.tcl:48
> +msgid "Garbage files"
> +msgstr "=C3=87=C3=B6p dosyalar"
> +
> +#: lib/database.tcl:66
> +#, tcl-format
> +msgid "%s (%s): Database Statistics"
> +msgstr "%s (%s): Veritaban=C4=B1 =C4=B0statistikleri"
> +
> +#: lib/database.tcl:72
> +msgid "Compressing the object database"
> +msgstr "Nesne veritaban=C4=B1 s=C4=B1k=C4=B1=C5=9Ft=C4=B1r=C4=B1l=C4=B1=
yor"
> +
> +#: lib/database.tcl:83
> +msgid "Verifying the object database with fsck-objects"
> +msgstr "Nesne veritaban=C4=B1, fsck-objects ile do=C4=9Frulan=C4=B1yor"=

> +
> +#: lib/database.tcl:107
> +#, tcl-format
> +msgid ""
> +"This repository currently has approximately %i loose objects.\n"
> +"\n"
> +"To maintain optimal performance it is strongly recommended that you =
compress "
> +"the database.\n"
> +"\n"
> +"Compress the database now?"
> +msgstr ""
> +"Bu depoda =C5=9Fu anda yakla=C5=9F=C4=B1k %i gev=C5=9Fek nesne =
var.\n"
> +"\n"
> +"Ba=C5=9Far=C4=B1m=C4=B1  en iyi d=C3=BCzeyde tutmak i=C3=A7in =
veritaban=C4=B1n=C4=B1 s=C4=B1k=C4=B1=C5=9Ft=C4=B1rman=C4=B1z =
=C3=B6nerilir.\n"
> +"\n"
> +"Veritaban=C4=B1 =C5=9Fimdi s=C4=B1k=C4=B1=C5=9Ft=C4=B1r=C4=B1ls=C4=B1n=
 m=C4=B1?"
> +
> +#: lib/error.tcl:20
> +#, tcl-format
> +msgid "%s: error"
> +msgstr "%s: Hata"
> +
> +#: lib/error.tcl:36
> +#, tcl-format
> +msgid "%s: warning"
> +msgstr "%s: Uyar=C4=B1"
> +
> +#: lib/error.tcl:80
> +#, tcl-format
> +msgid "%s hook failed:"
> +msgstr "%s kancas=C4=B1 ba=C5=9Far=C4=B1s=C4=B1z oldu:"
> +
> +#: lib/error.tcl:96
> +msgid "You must correct the above errors before committing."
> +msgstr "=C4=B0=C5=9Flemeden =C3=B6nce yukar=C4=B1daki hatalar=C4=B1 =
d=C3=BCzeltmelisiniz."
> +
> +#: lib/error.tcl:116
> +#, tcl-format
> +msgid "%s (%s): error"
> +msgstr "%s (%s): Hata"
> +
> +#: lib/merge.tcl:13
> +msgid ""
> +"Cannot merge while amending.\n"
> +"\n"
> +"You must finish amending this commit before starting any type of =
merge.\n"
> +msgstr ""
> +
> +#: lib/merge.tcl:27
> +msgid ""
> +"Last scanned state does not match repository state.\n"
> +"\n"
> +"Another Git program has modified this repository since the last =
scan.  A "
> +"rescan must be performed before a merge can be performed.\n"
> +"\n"
> +"The rescan will be automatically started now.\n"
> +msgstr ""
> +
> +#: lib/merge.tcl:45
> +#, tcl-format
> +msgid ""
> +"You are in the middle of a conflicted merge.\n"
> +"\n"
> +"File %s has merge conflicts.\n"
> +"\n"
> +"You must resolve them, stage the file, and commit to complete the =
current "
> +"merge.  Only then can you begin another merge.\n"
> +msgstr ""
> +
> +#: lib/merge.tcl:55
> +#, tcl-format
> +msgid ""
> +"You are in the middle of a change.\n"
> +"\n"
> +"File %s is modified.\n"
> +"\n"
> +"You should complete the current commit before starting a merge.  =
Doing so "
> +"will help you abort a failed merge, should the need arise.\n"
> +msgstr ""
> +"Bir de=C4=9Fi=C5=9Fikli=C4=9Fin ortas=C4=B1ndas=C4=B1n=C4=B1z.\n"
> +"\n"
> +"%s dosyas=C4=B1 de=C4=9Fi=C5=9Ftirildi.\n"
> +"\n"
> +"Bir birle=C5=9Ftirme ba=C5=9Flatmadan =C3=B6nce ge=C3=A7erli =
i=C5=9Flemeyi tamamlamal=C4=B1s=C4=B1n=C4=B1z. Bunu "
> +"yapmak, gerek olursa ba=C5=9Far=C4=B1s=C4=B1z bir birle=C5=9Ftirmeyi =
iptal etmenize yard=C4=B1mc=C4=B1 "
> +"olur.\n"
> +
> +#: lib/merge.tcl:108
> +#, tcl-format
> +msgid "%s of %s"
> +msgstr "%s/%s"
> +
> +#: lib/merge.tcl:126
> +#, tcl-format
> +msgid "Merging %s and %s..."
> +msgstr "%s ve %s birle=C5=9Ftiriliyor..."
> +
> +#: lib/merge.tcl:137
> +msgid "Merge completed successfully."
> +msgstr "Birle=C5=9Ftirme ba=C5=9Far=C4=B1yla tamamland=C4=B1."
> +
> +#: lib/merge.tcl:139
> +msgid "Merge failed.  Conflict resolution is required."
> +msgstr "Birle=C5=9Ftirme ba=C5=9Far=C4=B1s=C4=B1z. =C3=87ak=C4=B1=C5=9F=
ma =C3=A7=C3=B6z=C3=BCm=C3=BC gerekiyor."
> +
> +#: lib/merge.tcl:156
> +#, tcl-format
> +msgid "%s (%s): Merge"
> +msgstr "%s (%s): Birle=C5=9Ftir"
> +
> +#: lib/merge.tcl:164
> +#, tcl-format
> +msgid "Merge Into %s"
> +msgstr "%s =C4=B0=C3=A7ine Birle=C5=9Ftir"
> +
> +#: lib/merge.tcl:183
> +msgid "Revision To Merge"
> +msgstr "Birle=C5=9Ftirilecek Revizyon"
> +
> +#: lib/merge.tcl:218
> +msgid ""
> +"Cannot abort while amending.\n"
> +"\n"
> +"You must finish amending this commit.\n"
> +msgstr ""
> +"De=C4=9Fi=C5=9Fiklik s=C4=B1ras=C4=B1nda iptal yap=C4=B1lamaz.\n"
> +"\n"
> +"Bu i=C5=9Flemeyi de=C4=9Fi=C5=9Ftirmeyi bitirmelisiniz.\n"
> +
> +#: lib/merge.tcl:228
> +msgid ""
> +"Abort merge?\n"
> +"\n"
> +"Aborting the current merge will cause *ALL* uncommitted changes to =
be lost.\n"
> +"\n"
> +"Continue with aborting the current merge?"
> +msgstr ""
> +"Birle=C5=9Ftirme iptal edilsin mi?\n"
> +"\n"
> +"=C4=B0ptal i=C5=9Flemi, t=C3=BCm i=C5=9Flenmemi=C5=9F =
de=C4=9Fi=C5=9Fikliklerin kaybolmas=C4=B1na yol a=C3=A7ar.\n"
> +"\n"
> +"Ge=C3=A7erli birle=C5=9Ftirmeyi iptal i=C5=9Flemi s=C3=BCrd=C3=BCr=C3=BC=
ls=C3=BCn m=C3=BC?"
> +
> +#: lib/merge.tcl:234
> +msgid ""
> +"Reset changes?\n"
> +"\n"
> +"Resetting the changes will cause *ALL* uncommitted changes to be =
lost.\n"
> +"\n"
> +"Continue with resetting the current changes?"
> +msgstr ""
> +"De=C4=9Fi=C5=9Fiklikler s=C4=B1f=C4=B1rlans=C4=B1n m=C4=B1?\n"
> +"\n"
> +"S=C4=B1f=C4=B1rlama i=C5=9Flemi, t=C3=BCm i=C5=9Flenmemi=C5=9F =
de=C4=9Fi=C5=9Fikliklerin kaybolmas=C4=B1na yol a=C3=A7ar.\n"
> +"\n"
> +"Ge=C3=A7erli de=C4=9Fi=C5=9Fiklikleri s=C4=B1f=C4=B1rlama =
s=C3=BCrd=C3=BCr=C3=BCls=C3=BCn m=C3=BC?"
> +
> +#: lib/merge.tcl:246
> +msgid "Aborting"
> +msgstr "=C4=B0ptal ediliyor"
> +
> +#: lib/merge.tcl:247
> +msgid "files reset"
> +msgstr "dosya s=C4=B1f=C4=B1rland=C4=B1"
> +
> +#: lib/merge.tcl:277
> +msgid "Abort failed."
> +msgstr "=C4=B0ptal etme ba=C5=9Far=C4=B1s=C4=B1z."
> +
> +#: lib/merge.tcl:279
> +msgid "Abort completed.  Ready."
> +msgstr "=C4=B0ptal i=C5=9Flemi tamamland=C4=B1. Haz=C4=B1r."
> --=20
> 2.34.1
>=20

Best regards,
Emir (=F0=90=B0=BD=F0=90=B0=BA=F0=90=B0=8D)

** E-mail needs to stay simple
** Use plain text e-mail

