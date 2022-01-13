Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F5C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiAMNNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:13:14 -0500
Received: from mr85p00im-ztdg06011801.me.com ([17.58.23.199]:40122 "EHLO
        mr85p00im-ztdg06011801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbiAMNNN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 08:13:13 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 08:13:13 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1642079247;
        bh=u1ffwgW76DpKGI/VqpBc8jz/K4qGhDxmXjgCs2oRNdk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=YP8bPvyAQ8Df5HI9YIC85BRXzvMOvymi2U6pXh2hGxpekW6AytWrB1fyMa8M/moBz
         8eAL5u4QsBr+/sbpzTH/vU4jcPsI8lLj5/oDjkHxNRNk6AXjjaX+4RpzzDsHd36uwF
         YkRBBZbJwQmXSPnsnUptu21f3lXSCF9/SVNSkkTQ1O00ZYlP+rzctIcVL4fL/QEzf+
         WQ3PpLZo2liuMaopwfw2HwiT+HuHFYUubxTg6ppzK+Rd20F5X0o8c0Dyg7Nc/Vabns
         HlpHEHbTXNac6ADTNpuLjxGlhGkrCjNoMj513+oRqwFtUqiQMt7gtLMkvrXYVku+1M
         gi/LVBnkZTYEQ==
Received: from localhost.localdomain (unknown [85.98.169.27])
        by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id 8E36D9C1560;
        Thu, 13 Jan 2022 13:07:23 +0000 (UTC)
From:   Emir SARI <emir_sari@icloud.com>
To:     git@vger.kernel.org
Cc:     patthoyts@users.sourceforge.net, Emir SARI <emir_sari@icloud.com>
Subject: [PATCH] git-gui: added Turkish translation
Date:   Thu, 13 Jan 2022 16:07:05 +0300
Message-Id: <20220113130705.55378-1-emir_sari@icloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-13=5F04:2022-01-13=5F01,2022-01-13=5F04,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2201130080
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Emir SARI <emir_sari@icloud.com>
---
 git-gui/po/tr.po | 2829 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2829 insertions(+)
 create mode 100755 git-gui/po/tr.po

diff --git a/git-gui/po/tr.po b/git-gui/po/tr.po
new file mode 100755
index 0000000000..648595e9f5
--- /dev/null
+++ b/git-gui/po/tr.po
@@ -0,0 +1,2829 @@
+# Turkish translations for Git GUI
+# Git grafik kullanıcı arabirimi Türkçe çevirileri
+# Copyright (C) 2022 Emir SARI <emir_sari@msn.com>
+# This file is distributed under the same license as the Git package.
+# Emir SARI <emir_sari@msn.com>, 2022
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: Git GUI Turkish Localization Project\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2021-11-10 08:55+0800\n"
+"PO-Revision-Date: 2022-01-13 18:00+0300\n"
+"Last-Translator: Emir SARI <emir_sari@msn.com>\n"
+"Language-Team: Turkish (https://github.com/bitigchi/git-po/)\n"
+"Language: tr\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=UTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=2; plural=(n != 1);\n"
+
+#: git-gui.sh:847
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "%s içinde geçersiz yazıtipi belirtimi:"
+
+#: git-gui.sh:901
+msgid "Main Font"
+msgstr "Ana Yazıtipi"
+
+#: git-gui.sh:902
+msgid "Diff/Console Font"
+msgstr "Diff/Konsol Yazıtipi"
+
+#: git-gui.sh:917 git-gui.sh:931 git-gui.sh:944 git-gui.sh:1034 git-gui.sh:1053
+#: git-gui.sh:3212
+msgid "git-gui: fatal error"
+msgstr "git-gui: Onulmaz hata"
+
+#: git-gui.sh:918
+msgid "Cannot find git in PATH."
+msgstr "git, PATH içinde bulunamıyor."
+
+#: git-gui.sh:945
+msgid "Cannot parse Git version string:"
+msgstr "Git sürüm dizisi ayrıştırılamıyor:"
+
+#: git-gui.sh:970
+#, tcl-format
+msgid ""
+"Git version cannot be determined.\n"
+"\n"
+"%s claims it is version '%s'.\n"
+"\n"
+"%s requires at least Git 1.5.0 or later.\n"
+"\n"
+"Assume '%s' is version 1.5.0?\n"
+msgstr ""
+"Git sürümü belirlenemedi.\n"
+"\n"
+"%s, sürüm '%s' olduğunu iddia ediyor.\n"
+"\n"
+"%s, en az Git 1.5.0 veya sonrası gerektiriyor.\n"
+"\n"
+"'%s', sürüm 1.5.0 olarak varsayılsın mı?\n"
+
+#: git-gui.sh:1267
+msgid "Git directory not found:"
+msgstr "Git dizini bulunamadı:"
+
+#: git-gui.sh:1301
+msgid "Cannot move to top of working directory:"
+msgstr "Çalışma dizininin en tepesine taşınamıyor:"
+
+#: git-gui.sh:1309
+msgid "Cannot use bare repository:"
+msgstr "Çıplak depo kullanılamıyor:"
+
+#: git-gui.sh:1317
+msgid "No working directory"
+msgstr "Çalışma dizini yok"
+
+#: git-gui.sh:1491 lib/checkout_op.tcl:306
+msgid "Refreshing file status..."
+msgstr "Dosya durumu yenileniyor..."
+
+#: git-gui.sh:1551
+msgid "Scanning for modified files ..."
+msgstr "Değiştirilen dosyalar için taranıyor..."
+
+#: git-gui.sh:1629
+msgid "Calling prepare-commit-msg hook..."
+msgstr "prepare-commit-msg kancası çağrılıyor..."
+
+#: git-gui.sh:1646
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "İşleme, prepare-commit-hook tarafından reddedildi."
+
+#: git-gui.sh:1804 lib/browser.tcl:252
+msgid "Ready."
+msgstr "Hazır."
+
+#: git-gui.sh:1968
+#, tcl-format
+msgid ""
+"Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
+msgstr ""
+"Görüntüleme limitine (gui.maxfilesdisplayed =%s) erişildi, tüm %s dosya "
+"gösterilmiyor."
+
+#: git-gui.sh:2091
+msgid "Unmodified"
+msgstr "Değiştirilmemiş"
+
+#: git-gui.sh:2093
+msgid "Modified, not staged"
+msgstr "Değiştirilmiş, hazırlanmamış"
+
+#: git-gui.sh:2094 git-gui.sh:2106
+msgid "Staged for commit"
+msgstr "İşleme için hazırlanmış"
+
+#: git-gui.sh:2095 git-gui.sh:2107
+msgid "Portions staged for commit"
+msgstr "İşleme için hazırlanan kısımlar"
+
+#: git-gui.sh:2096 git-gui.sh:2108
+msgid "Staged for commit, missing"
+msgstr "İşleme için hazırlanmış, eksik"
+
+#: git-gui.sh:2098
+msgid "File type changed, not staged"
+msgstr "Dosya türü değiştirilmiş, hazırlanmamış"
+
+#: git-gui.sh:2099 git-gui.sh:2100
+msgid "File type changed, old type staged for commit"
+msgstr "Dosya türü değiştirilmiş, eski tür işleme için hazırlanmış"
+
+#: git-gui.sh:2101
+msgid "File type changed, staged"
+msgstr "Dosya türü değiştirilmiş, hazırlanmış"
+
+#: git-gui.sh:2102
+msgid "File type change staged, modification not staged"
+msgstr "Dosya türü değişikliği hazırlanmış, değişiklik hazırlanmamış"
+
+#: git-gui.sh:2103
+msgid "File type change staged, file missing"
+msgstr "Dosya türü değişikliği hazırlanmış, dosya eksik"
+
+#: git-gui.sh:2105
+msgid "Untracked, not staged"
+msgstr "İzlenmeyen, hazırlanmamış"
+
+#: git-gui.sh:2110
+msgid "Missing"
+msgstr "Eksik"
+
+#: git-gui.sh:2111
+msgid "Staged for removal"
+msgstr "Kaldırma için hazırlanmış"
+
+#: git-gui.sh:2112
+msgid "Staged for removal, still present"
+msgstr "Kaldırma için hazırlanmış, hâlâ mevcut"
+
+#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
+#: git-gui.sh:2118 git-gui.sh:2119
+msgid "Requires merge resolution"
+msgstr "Birleştirme çözümü gerektiriyor"
+
+#: git-gui.sh:2164
+msgid "Couldn't find gitk in PATH"
+msgstr "gitk, PATH içinde bulunamadı"
+
+#: git-gui.sh:2210 git-gui.sh:2245
+#, tcl-format
+msgid "Starting %s... please wait..."
+msgstr "%s başlatılıyor... lütfen bekleyin..."
+
+#: git-gui.sh:2224
+msgid "Couldn't find git gui in PATH"
+msgstr "git-gui, PATH içinde bulunamadı"
+
+#: git-gui.sh:2726 lib/choose_repository.tcl:53
+msgid "Repository"
+msgstr "Depo"
+
+#: git-gui.sh:2727
+msgid "Edit"
+msgstr "Düzen"
+
+#: git-gui.sh:2729 lib/choose_rev.tcl:567
+msgid "Branch"
+msgstr "Dal"
+
+#: git-gui.sh:2732 lib/choose_rev.tcl:554
+msgid "Commit@@noun"
+msgstr "İşleme@@noun"
+
+#: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
+msgid "Merge"
+msgstr "Birleştir"
+
+#: git-gui.sh:2736 lib/choose_rev.tcl:563
+msgid "Remote"
+msgstr "Uzak Konum"
+
+#: git-gui.sh:2739
+msgid "Tools"
+msgstr "Araçlar"
+
+#: git-gui.sh:2748
+msgid "Explore Working Copy"
+msgstr "Çalışma Kopyasını Araştır"
+
+#: git-gui.sh:2763
+msgid "Git Bash"
+msgstr "Git Bash"
+
+#: git-gui.sh:2772
+msgid "Browse Current Branch's Files"
+msgstr "Geçerli Dal Dosyalarına Göz At"
+
+#: git-gui.sh:2776
+msgid "Browse Branch Files..."
+msgstr "Dal Dosyalarına Göz At..."
+
+#: git-gui.sh:2781
+msgid "Visualize Current Branch's History"
+msgstr "Geçerli Dal Geçmişini Görselleştir"
+
+#: git-gui.sh:2785
+msgid "Visualize All Branch History"
+msgstr "Tüm Dal Geçmişini Görselleştir"
+
+#: git-gui.sh:2792
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "%s Dosyalarına Göz At"
+
+#: git-gui.sh:2794
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "%s Geçmişini Görselleştir"
+
+#: git-gui.sh:2799 lib/database.tcl:40
+msgid "Database Statistics"
+msgstr "Veritabanı İstatistikleri"
+
+#: git-gui.sh:2802 lib/database.tcl:33
+msgid "Compress Database"
+msgstr "Veritabanını Sıkıştır"
+
+#: git-gui.sh:2805
+msgid "Verify Database"
+msgstr "Veritabanını Doğrula"
+
+#: git-gui.sh:2812 git-gui.sh:2816 git-gui.sh:2820
+msgid "Create Desktop Icon"
+msgstr "Masaüstü Simgesi Oluştur"
+
+#: git-gui.sh:2828 lib/choose_repository.tcl:209 lib/choose_repository.tcl:217
+msgid "Quit"
+msgstr "Çık"
+
+#: git-gui.sh:2836
+msgid "Undo"
+msgstr "Geri Al"
+
+#: git-gui.sh:2839
+msgid "Redo"
+msgstr "Yinele"
+
+#: git-gui.sh:2843 git-gui.sh:3461
+msgid "Cut"
+msgstr "Kes"
+
+#: git-gui.sh:2846 git-gui.sh:3464 git-gui.sh:3540 git-gui.sh:3633
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Kopyala"
+
+#: git-gui.sh:2849 git-gui.sh:3467
+msgid "Paste"
+msgstr "Yapıştır"
+
+#: git-gui.sh:2852 git-gui.sh:3470 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
+msgid "Delete"
+msgstr "Sil"
+
+#: git-gui.sh:2856 git-gui.sh:3474 git-gui.sh:3637 lib/console.tcl:71
+msgid "Select All"
+msgstr "Tümünü Seç"
+
+#: git-gui.sh:2865
+msgid "Create..."
+msgstr "Oluştur..."
+
+#: git-gui.sh:2871
+msgid "Checkout..."
+msgstr "Çıkış Yap..."
+
+#: git-gui.sh:2877
+msgid "Rename..."
+msgstr "Yeniden Adlandır..."
+
+#: git-gui.sh:2882
+msgid "Delete..."
+msgstr "Sil..."
+
+#: git-gui.sh:2887
+msgid "Reset..."
+msgstr "Sıfırla..."
+
+#: git-gui.sh:2897
+msgid "Done"
+msgstr "Tamam"
+
+#: git-gui.sh:2899
+msgid "Commit@@verb"
+msgstr "İşle@@verb"
+
+#: git-gui.sh:2908 git-gui.sh:3400
+msgid "Amend Last Commit"
+msgstr "Son İşlemeyi Değiştir"
+
+#: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
+msgid "Rescan"
+msgstr "Yeniden Tara"
+
+#: git-gui.sh:2924
+msgid "Stage To Commit"
+msgstr "İşleme İçin Hazırla"
+
+#: git-gui.sh:2930
+msgid "Stage Changed Files To Commit"
+msgstr "Değiştirilen Dosyaları İşleme İçin Hazırla"
+
+#: git-gui.sh:2936
+msgid "Unstage From Commit"
+msgstr "İşleme Hazırlığından Çıkar"
+
+#: git-gui.sh:2942 lib/index.tcl:521
+msgid "Revert Changes"
+msgstr "Değişiklikleri Geri Al"
+
+#: git-gui.sh:2950 git-gui.sh:3700 git-gui.sh:3731
+msgid "Show Less Context"
+msgstr "Daha Az Bağlam Göster"
+
+#: git-gui.sh:2954 git-gui.sh:3704 git-gui.sh:3735
+msgid "Show More Context"
+msgstr "Daha Çok Bağlam Göster"
+
+#: git-gui.sh:2961 git-gui.sh:3374 git-gui.sh:3485
+msgid "Sign Off"
+msgstr "İmzala"
+
+#: git-gui.sh:2977
+msgid "Local Merge..."
+msgstr "Yerel Birleştirme..."
+
+#: git-gui.sh:2982
+msgid "Abort Merge..."
+msgstr "Birleştirmeyi İptal Et..."
+
+#: git-gui.sh:2994 git-gui.sh:3022
+msgid "Add..."
+msgstr "Ekle..."
+
+#: git-gui.sh:2998
+msgid "Push..."
+msgstr "İt..."
+
+#: git-gui.sh:3002
+msgid "Delete Branch..."
+msgstr "Dal Sil..."
+
+#: git-gui.sh:3012 git-gui.sh:3666
+msgid "Options..."
+msgstr "Seçenekler..."
+
+#: git-gui.sh:3023
+msgid "Remove..."
+msgstr "Kaldır..."
+
+#: git-gui.sh:3032 lib/choose_repository.tcl:67
+msgid "Help"
+msgstr "Yardım"
+
+#: git-gui.sh:3036 git-gui.sh:3040 lib/choose_repository.tcl:61
+#: lib/choose_repository.tcl:70 lib/about.tcl:14
+#, tcl-format
+msgid "About %s"
+msgstr "%s Hakkında"
+
+#: git-gui.sh:3064
+msgid "Online Documentation"
+msgstr "Çevrimiçi Belgelendirme"
+
+#: git-gui.sh:3067 lib/choose_repository.tcl:64 lib/choose_repository.tcl:73
+msgid "Show SSH Key"
+msgstr "SSH Anahtarını Göster"
+
+#: git-gui.sh:3097 git-gui.sh:3229
+msgid "usage:"
+msgstr "kullanım:"
+
+#: git-gui.sh:3101 git-gui.sh:3233
+msgid "Usage"
+msgstr "Kullanım"
+
+#: git-gui.sh:3182 lib/blame.tcl:575
+msgid "Error"
+msgstr "Hata"
+
+#: git-gui.sh:3213
+#, tcl-format
+msgid "fatal: cannot stat path %s: No such file or directory"
+msgstr "Onulmaz: %s yolu istatistikleri çıkarılamıyor: Böyle bir dosya veya "
+"dizin yok"
+
+#: git-gui.sh:3246
+msgid "Current Branch:"
+msgstr "Geçerli Dal:"
+
+#: git-gui.sh:3271
+msgid "Unstaged Changes"
+msgstr "Hazırlanmamış Değişiklikler"
+
+#: git-gui.sh:3293
+msgid "Staged Changes (Will Commit)"
+msgstr "Hazırlanmış Değişiklikler (İşlenecek)"
+
+#: git-gui.sh:3367
+msgid "Stage Changed"
+msgstr "Değişiklikleri Hazırla"
+
+#: git-gui.sh:3386 lib/transport.tcl:137
+msgid "Push"
+msgstr "İt"
+
+#: git-gui.sh:3413
+msgid "Initial Commit Message:"
+msgstr "İlk İşleme İletisi:"
+
+#: git-gui.sh:3414
+msgid "Amended Commit Message:"
+msgstr "Değiştirilmiş İşleme İletisi:"
+
+#: git-gui.sh:3415
+msgid "Amended Initial Commit Message:"
+msgstr "Değiştirilmiş İlk İşleme İletisi:"
+
+#: git-gui.sh:3416
+msgid "Amended Merge Commit Message:"
+msgstr "Değiştirilmiş Birleştirme İşlemesi İletisi:"
+
+#: git-gui.sh:3417
+msgid "Merge Commit Message:"
+msgstr "Birleştirme İşlemesi İletisi:"
+
+#: git-gui.sh:3418
+msgid "Commit Message:"
+msgstr "İşleme İletisi:"
+
+#: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Tümünü Kopyala"
+
+#: git-gui.sh:3501 lib/blame.tcl:106
+msgid "File:"
+msgstr "Dosya:"
+
+#: git-gui.sh:3549 lib/choose_repository.tcl:1100
+msgid "Open"
+msgstr "Aç"
+
+#: git-gui.sh:3629
+msgid "Refresh"
+msgstr "Yenile"
+
+#: git-gui.sh:3650
+msgid "Decrease Font Size"
+msgstr "Yazıtipi Boyutunu Azalt"
+
+#: git-gui.sh:3654
+msgid "Increase Font Size"
+msgstr "Yazıtipi Boyutunu Artır"
+
+#: git-gui.sh:3662 lib/blame.tcl:296
+msgid "Encoding"
+msgstr "Kodlama"
+
+#: git-gui.sh:3673
+msgid "Apply/Reverse Hunk"
+msgstr "Parça Uygula/Geri Al"
+
+#: git-gui.sh:3678
+msgid "Apply/Reverse Line"
+msgstr "Satır Uygula/Geri Al"
+
+#: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
+msgid "Revert Hunk"
+msgstr "Parçayı Geri Al"
+
+#: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
+msgid "Revert Line"
+msgstr "Satırı Geri Al"
+
+#: git-gui.sh:3694 git-gui.sh:3791
+msgid "Undo Last Revert"
+msgstr "Son Geri Almayı İptal Et"
+
+#: git-gui.sh:3713
+msgid "Run Merge Tool"
+msgstr "Birleştirme Aracını Çalıştır"
+
+#: git-gui.sh:3718
+msgid "Use Remote Version"
+msgstr "Uzak Konum Sürümünü Kullan"
+
+#: git-gui.sh:3722
+msgid "Use Local Version"
+msgstr "Yerel Sürümü Kullan"
+
+#: git-gui.sh:3726
+msgid "Revert To Base"
+msgstr "Temele Geri Al"
+
+#: git-gui.sh:3744
+msgid "Visualize These Changes In The Submodule"
+msgstr "Bu Değişiklikleri Altmodülde Görselleştir"
+
+#: git-gui.sh:3748
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "Geçerli Dal Geçmişini Altmodülde Görselleştir"
+
+#: git-gui.sh:3752
+msgid "Visualize All Branch History In The Submodule"
+msgstr "Tüm Dal Geçmişini Altmodülde Görselleştir"
+
+#: git-gui.sh:3757
+msgid "Start git gui In The Submodule"
+msgstr "git-gui'yi Altmodülde Başlat"
+
+#: git-gui.sh:3793
+msgid "Unstage Hunk From Commit"
+msgstr "Parçayı İşleme Hazırlığından Çıkar"
+
+#: git-gui.sh:3797
+msgid "Unstage Lines From Commit"
+msgstr "Satırları İşleme Hazırlığından Çıkar"
+
+#: git-gui.sh:3798 git-gui.sh:3809
+msgid "Revert Lines"
+msgstr "Satırları Geri Al"
+
+#: git-gui.sh:3800
+msgid "Unstage Line From Commit"
+msgstr "Satırı İşleme Hazırlığından Çıkar"
+
+#: git-gui.sh:3804
+msgid "Stage Hunk For Commit"
+msgstr "Parçayı İşleme İçin Hazırla"
+
+#: git-gui.sh:3808
+msgid "Stage Lines For Commit"
+msgstr "Satırları İşleme İçin Hazırla"
+
+#: git-gui.sh:3811
+msgid "Stage Line For Commit"
+msgstr "Satırı İşleme İçin Hazırla"
+
+#: git-gui.sh:3861
+msgid "Initializing..."
+msgstr "İlklendiriliyor..."
+
+#: git-gui.sh:4017
+#, tcl-format
+msgid ""
+"Possible environment issues exist.\n"
+"\n"
+"The following environment variables are probably\n"
+"going to be ignored by any Git subprocess run\n"
+"by %s:\n"
+"\n"
+msgstr ""
+"Olası ortam sorunları mevcut.\n"
+"\n"
+"Aşağıdaki ortam değişkenleri büyük olasılıkla\n"
+"şunun tarafından çalıştırılan herhangi bir Git\n"
+"alt işlemi tarafından yok sayılacaklar: %s:\n"
+"\n"
+
+#: git-gui.sh:4046
+msgid ""
+"\n"
+"This is due to a known issue with the\n"
+"Tcl binary distributed by Cygwin."
+msgstr ""
+"\n"
+"Bu, Cygwin tarafından dağıtılan Tcl ikilisinin\n"
+"bilinen bir sorunu."
+
+#: git-gui.sh:4051
+#, tcl-format
+msgid ""
+"\n"
+"\n"
+"A good replacement for %s\n"
+"is placing values for the user.name and\n"
+"user.email settings into your personal\n"
+"~/.gitconfig file.\n"
+msgstr ""
+"\n"
+"\n"
+"%s için iyi bir ikame,\n"
+"user.name ve user.email değerlerini kendi\n"
+"kişisel ~/.gitconfig dosyasına koymanız\n"
+"olabilir.\n"
+
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Desteklenmeyen yazım denetimci"
+
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Yazım denetimi kullanılamıyor"
+
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Geçersiz yazım denetimi yapılandırması"
+
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
+msgstr "Sözlük şuna geri alınıyor: %s."
+
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "Yazım denetimci başlarken sessizce çöktü"
+
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Tanımlanamayan yazım denetimci"
+
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "Öneri Yok"
+
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "Yazım denetimciden beklenmeyen dosya sonu"
+
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Yazım Denetimci Başarısız Oldu"
+
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
+#, tcl-format
+msgid "fetch %s"
+msgstr "%s ögesini getir"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "%s konumundan yeni değişiklikler getiriliyor"
+
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "%s ögesini uzaktan buda"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "%s ögesinden silinen izleme dalları budanıyor"
+
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr "tüm uzak konumları getir"
+
+#: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr "Tüm uzak konumlardan yeni değişiklikler getiriliyor"
+
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr "tüm uzak konumları uzaktan buda"
+
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "Tüm uzak konumlardan silinen izleme dalları budanıyor"
+
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
+#, tcl-format
+msgid "push %s"
+msgstr "%s ögesini it"
+
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Değişiklikler %s konumuna itiliyor"
+
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "%s konumuna yansılanıyor"
+
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "%s %s, %s konumuna itiliyor"
+
+#: lib/transport.tcl:132
+msgid "Push Branches"
+msgstr "Dalları İt"
+
+#: lib/transport.tcl:141 lib/checkout_op.tcl:580 lib/remote_add.tcl:34
+#: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/branch_rename.tcl:32
+#: lib/choose_font.tcl:45 lib/option.tcl:127 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/remote_branch_delete.tcl:43
+#: lib/branch_create.tcl:37 lib/branch_delete.tcl:34 lib/merge.tcl:178
+msgid "Cancel"
+msgstr "İptal"
+
+#: lib/transport.tcl:147
+msgid "Source Branches"
+msgstr "Kaynak Dallar"
+
+#: lib/transport.tcl:162
+msgid "Destination Repository"
+msgstr "Hedef Depo"
+
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
+msgstr "Uzak Konum:"
+
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
+msgstr "Gelişigüzel Konum:"
+
+#: lib/transport.tcl:205
+msgid "Transfer Options"
+msgstr "Aktarım Seçenekleri"
+
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "Var olan dalın üzerine zorla yaz (değişiklikleri atabilir)"
+
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
+msgstr "İnce paket kullan (yavaş ağ bağlantıları için)"
+
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr "Etiketleri içer"
+
+#: lib/transport.tcl:229
+#, tcl-format
+msgid "%s (%s): Push"
+msgstr "%s (%s): İt"
+
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "%s ögesi %s konumundan getiriliyor"
+
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "Onulmaz: %s çözülemiyor"
+
+#: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
+#: lib/database.tcl:30
+msgid "Close"
+msgstr "Kapat"
+
+#: lib/checkout_op.tcl:175
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "'%s' dalı mevcut değil."
+
+#: lib/checkout_op.tcl:194
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "'%s' için yalınlaştırılmış git-pull yapılandırılamıyor."
+
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "'%s' dalı halihazırda mevcut."
+
+#: lib/checkout_op.tcl:229
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"'%s' dalı halihazırda mevcut.\n"
+"\n"
+"%s konumuna ileri sarılamıyor.\n"
+"Bir birleştirme gerekli."
+
+#: lib/checkout_op.tcl:243
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "Birleştirme stratejisi '%s' desteklenmiyor."
+
+#: lib/checkout_op.tcl:262
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "'%s' güncellenemedi."
+
+#: lib/checkout_op.tcl:274
+msgid "Staging area (index) is already locked."
+msgstr "Hazırlama alanı (indeks) halihazırda kilitli."
+
+#: lib/checkout_op.tcl:289
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Son tarama durumu depo durumu ile eşleşmiyor.\n"
+"\n"
+"Başka bir Git programı bu depoyu son taramadan beri değiştirmiş. Geçerli "
+"deponun değiştirilebilmesi için bir yeniden tarama gerçekleştirilmelidir.\n"
+"\n"
+"Yeniden tarama şimdi kendiliğinden başlatılacak.\n"
+
+#: lib/checkout_op.tcl:345
+#, tcl-format
+msgid "Updating working directory to '%s'..."
+msgstr "Çalışma dizini şuna güncelleniyor: '%s'..."
+
+#: lib/checkout_op.tcl:346
+msgid "files checked out"
+msgstr "çıkışı yapılan dosyalar"
+
+#: lib/checkout_op.tcl:377
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr "'%s' çıkışı iptal edildi (dosya düzeyinde birleştirme gerekiyor)."
+
+#: lib/checkout_op.tcl:378
+msgid "File level merge required."
+msgstr "Dosya düzeyinde birleştirme gerekiyor."
+
+#: lib/checkout_op.tcl:382
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "'%s' dalında kalınıyor."
+
+#: lib/checkout_op.tcl:453
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This Detached "
+"Checkout'."
+msgstr ""
+"Artık yerel bir dalda değilsiniz.\n"
+"\n"
+"Eğer bir dalda olmak istediyseniz 'Bu Ayrık Çıkış'tan başlayarak bir tane "
+"oluşturun."
+
+#: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
+#, tcl-format
+msgid "Checked out '%s'."
+msgstr "'%s' çıkışı yapıldı."
+
+#: lib/checkout_op.tcl:536
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr "'%s' ögesini '%s' olarak sıfırlamak aşağıdaki işlemeleri kaybedecek:"
+
+#: lib/checkout_op.tcl:558
+msgid "Recovering lost commits may not be easy."
+msgstr "Kayıp işlemeleri kurtarmak kolay olmayabilir."
+
+#: lib/checkout_op.tcl:563
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "'%s' ögesi sıfırlansın mı?"
+
+#: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
+msgid "Visualize"
+msgstr "Görselleştir"
+
+#: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
+msgid "Reset"
+msgstr "Sıfırla"
+
+#: lib/checkout_op.tcl:636
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully updated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"Geçerli dal ayarlanamadı.\n"
+"\n"
+"Bu çalışma dizinine yalnızca kısımsal olarak geçilmiş. Dosyalarınızı "
+"başarıyla güncelledik; ancak dahili Git dosyasını güncelleyemedik.\n"
+"\n"
+"Bu olay gerçekleşmemeliydi. %s şimdi kapanacak ve sürdürmeyecek."
+
+#: lib/remote_add.tcl:20
+#, tcl-format
+msgid "%s (%s): Add Remote"
+msgstr "%s (%s): Uzak Konum Ekle"
+
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
+msgstr "Yeni Uzak Konum Ekle"
+
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
+msgstr "Ekle"
+
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
+msgstr "Uzak Konum Ayrıntıları"
+
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
+msgstr "Ad:"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Konum:"
+
+#: lib/remote_add.tcl:60
+msgid "Further Action"
+msgstr "Sonraki Eylem"
+
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
+msgstr "Hemen Getir"
+
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
+msgstr "Uzak Depoyu İlklendir ve İt"
+
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
+msgstr "Şimdi Başka Bir Şey Yapma"
+
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
+msgstr "Bir uzak konum adı sağlayın."
+
+#: lib/remote_add.tcl:113
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s', kabul edilebilir bir uzak konum adı değil."
+
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "'%s' uzak konumu eklenemedi, konum: '%s'."
+
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "%s getiriliyor"
+
+#: lib/remote_add.tcl:156
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "'%s' konumunda bir deponun nice ilklendirileceği bilinmiyor."
+
+#: lib/remote_add.tcl:163
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "%s ayarlanıyor (%s konumunda)"
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Başlatılıyor..."
+
+#: lib/browser.tcl:27
+#, tcl-format
+msgid "%s (%s): File Browser"
+msgstr "%s (%s): Dosya Yöneticisi"
+
+#: lib/browser.tcl:132 lib/browser.tcl:149
+#, tcl-format
+msgid "Loading %s..."
+msgstr "%s yükleniyor..."
+
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
+msgstr "[Üst Ögeye Git]"
+
+#: lib/browser.tcl:275
+#, tcl-format
+msgid "%s (%s): Browse Branch Files"
+msgstr "%s (%s): Dal Dosyalarına Göz At"
+
+#: lib/browser.tcl:282
+msgid "Browse Branch Files"
+msgstr "Dal Dosyalarına Göz At"
+
+#: lib/browser.tcl:288 lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
+#: lib/choose_repository.tcl:1115
+msgid "Browse"
+msgstr "Göz At"
+
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:321
+msgid "Revision"
+msgstr "Revizyon"
+
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "İndeks kilitlenemiyor."
+
+#: lib/index.tcl:30
+msgid "Index Error"
+msgstr "İndeks Hatası"
+
+#: lib/index.tcl:32
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
+msgstr ""
+"Git indeksini güncelleme başarısız. git-gui'nin eşitlenebilmesi için bir "
+"yeniden tarama kendiliğinden başlatılacak."
+
+#: lib/index.tcl:43
+msgid "Continue"
+msgstr "Sürdür"
+
+#: lib/index.tcl:46
+msgid "Unlock Index"
+msgstr "İndeks Kilidini Aç"
+
+#: lib/index.tcl:77 lib/index.tcl:146 lib/index.tcl:220 lib/index.tcl:587
+#: lib/choose_repository.tcl:999
+msgid "files"
+msgstr "dosyalar"
+
+#: lib/index.tcl:326
+msgid "Unstaging selected files from commit"
+msgstr "Seçili dosyalar işleme hazırlığından çıkarılıyor"
+
+#: lib/index.tcl:330
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "%s, işleme hazırlığından çıkarılıyor"
+
+#: lib/index.tcl:369
+msgid "Ready to commit."
+msgstr "İşlemeye hazır."
+
+#: lib/index.tcl:378
+msgid "Adding selected files"
+msgstr "Seçili dosyalar ekleniyor"
+
+#: lib/index.tcl:382
+#, tcl-format
+msgid "Adding %s"
+msgstr "%s ekleniyor"
+
+#: lib/index.tcl:412
+#, tcl-format
+msgid "Stage %d untracked files?"
+msgstr "%d izlenmeyen dosya hazırlansın mı?"
+
+#: lib/index.tcl:420
+msgid "Adding all changed files"
+msgstr "Tüm değiştirilen dosyalar ekleniyor"
+
+#: lib/index.tcl:503
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "%s dosyasındaki değişiklikler geri alınsın mı?"
+
+#: lib/index.tcl:508
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Bu %i dosyadaki değişiklikler geri alınsın mı?"
+
+#: lib/index.tcl:517
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr "Hazırlanmayan tüm değişiklikler bu geri alma ile tümüyle kaybolacak."
+
+#: lib/index.tcl:520 lib/index.tcl:563
+msgid "Do Nothing"
+msgstr "Bir Şey Yapma"
+
+#: lib/index.tcl:545
+#, tcl-format
+msgid "Delete untracked file %s?"
+msgstr "İzlenmeyen dosya %s silinsin mi?"
+
+#: lib/index.tcl:550
+#, tcl-format
+msgid "Delete these %i untracked files?"
+msgstr "Bu izlenmeyen %i dosya silinsin mi?"
+
+#: lib/index.tcl:560
+msgid "Files will be permanently deleted."
+msgstr "Dosyalar kalıcı olarak silinecek."
+
+#: lib/index.tcl:564
+msgid "Delete Files"
+msgstr "Dosyaları Sil"
+
+#: lib/index.tcl:586
+msgid "Deleting"
+msgstr "Siliniyor"
+
+#: lib/index.tcl:665
+msgid "Encountered errors deleting files:\n"
+msgstr "Dosya silerken hatalarla karşılaşıldı:\n"
+
+#: lib/index.tcl:674
+#, tcl-format
+msgid "None of the %d selected files could be deleted."
+msgstr "Seçili %d dosyanın hiçbiri silinemedi."
+
+#: lib/index.tcl:679
+#, tcl-format
+msgid "%d of the %d selected files could not be deleted."
+msgstr "%d/%d seçili dosya silinemedi."
+
+#: lib/index.tcl:726
+msgid "Reverting selected files"
+msgstr "Seçili dosyalar geri alınıyor"
+
+#: lib/index.tcl:730
+#, tcl-format
+msgid "Reverting %s"
+msgstr "%s geri alınıyor"
+
+#: lib/branch_checkout.tcl:16
+#, tcl-format
+msgid "%s (%s): Checkout Branch"
+msgstr "%s (%s): Dalı Çıkış Yap"
+
+#: lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
+msgstr "Dalı Çıkış Yap"
+
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
+msgstr "Çıkış Yap"
+
+#: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl:69
+msgid "Options"
+msgstr "Seçenekler"
+
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "İzleme Dalını Getir"
+
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
+msgstr "Yerel Daldan Ayır"
+
+#: lib/status_bar.tcl:263
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i/%*i %s (%3i%%)"
+
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "Şuraya İt"
+
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "Uzak Konum Kaldır"
+
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "Şuradan Buda"
+
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "Şuradan Getir"
+
+#: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
+msgid "All"
+msgstr "Tümü"
+
+#: lib/branch_rename.tcl:15
+#, tcl-format
+msgid "%s (%s): Rename Branch"
+msgstr "%s (%s): Dalı Yeniden Adlandır"
+
+#: lib/branch_rename.tcl:23
+msgid "Rename Branch"
+msgstr "Dalı Yeniden Adlandır"
+
+#: lib/branch_rename.tcl:28
+msgid "Rename"
+msgstr "Yeniden Adlandır"
+
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
+msgstr "Dal:"
+
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
+msgstr "Yeni Ad:"
+
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
+msgstr "Yeniden adlandırmak için bir dal seçin."
+
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
+msgstr "Bir dal adı sağlayın."
+
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s', kabul edilebilir bir dal adı değil."
+
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "'%s', yeniden adlandırılamadı."
+
+#: lib/choose_font.tcl:41
+msgid "Select"
+msgstr "Seç"
+
+#: lib/choose_font.tcl:55
+msgid "Font Family"
+msgstr "Yazıtipi Ailesi"
+
+#: lib/choose_font.tcl:76
+msgid "Font Size"
+msgstr "Yazıtipi Boyutu"
+
+#: lib/choose_font.tcl:93
+msgid "Font Example"
+msgstr "Yazıtipi Örneği"
+
+#: lib/choose_font.tcl:105
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"Bu, örnek bir metindir.\n"
+"Hoşunuza gittiyse yazıtipi olarak ayarlayabilirsiniz."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Geçersiz global kodlama '%s'"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Geçersiz depo kodlaması '%s'"
+
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr "Öntanımlıları Uygula"
+
+#: lib/option.tcl:123
+msgid "Save"
+msgstr "Kaydet"
+
+#: lib/option.tcl:133
+#, tcl-format
+msgid "%s Repository"
+msgstr "%s Deposu"
+
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
+msgstr "Global (Tüm Depolar)"
+
+#: lib/option.tcl:140
+msgid "User Name"
+msgstr "Kullanıcı Adı"
+
+#: lib/option.tcl:141
+msgid "Email Address"
+msgstr "E-posta Adresi"
+
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
+msgstr "Birleştirme İşlemelerini Özetle"
+
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
+msgstr "Birleştirme Sözelliği"
+
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
+msgstr "Birleştirme Sonrası Diffstat Göster"
+
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
+msgstr "Birleştirme Aracı Kullan"
+
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
+msgstr "Dosya Değişiklik Zaman Damgalarına Güven"
+
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Getirme Sırasında İzleme Dallarını Buda"
+
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
+msgstr "İzleme Dallarını Eşleştir"
+
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "Diff'ler ve Suçlamalar için Textconv Kullan"
+
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
+msgstr "Yalnızca Değişikliklerde Kopyayı Suçla"
+
+#: lib/option.tcl:153
+msgid "Maximum Length of Recent Repositories List"
+msgstr "Son Kullanılan Depolar Uzunluğu"
+
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Kopyanın Suçlanacağı En Az Harf"
+
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
+msgstr "Suçlama Geçmişi Bağlam Etki Alanı (gün)"
+
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
+msgstr "Diff Bağlam Satırları Sayısı"
+
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
+msgstr "Ek Diff Parametreleri"
+
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
+msgstr "İşleme İletisi Metin Genişliği"
+
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
+msgstr "Yeni Dal Adı Şablonu"
+
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
+msgstr "Öntanımlı Dosya İçeriği Kodlaması"
+
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
+msgstr "Ayrık bir kafaya işlemeden önce uyar"
+
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
+msgstr "İzlenmeyen dosyaların hazırlanması"
+
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr "İzlenmeyen dosyaları göster"
+
+#: lib/option.tcl:164
+msgid "Tab spacing"
+msgstr "Sekme aralığı"
+
+#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
+#: lib/database.tcl:57
+#, tcl-format
+msgid "%s:"
+msgstr "%s:"
+
+#: lib/option.tcl:210
+msgid "Change"
+msgstr "Değiştir"
+
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
+msgstr "Yazım Sözlüğü:"
+
+#: lib/option.tcl:284
+msgid "Change Font"
+msgstr "Yazıtipini Değiştir"
+
+#: lib/option.tcl:288
+#, tcl-format
+msgid "Choose %s"
+msgstr "%s ögesini seç"
+
+#: lib/option.tcl:294
+msgid "pt."
+msgstr "nk."
+
+#: lib/option.tcl:308
+msgid "Preferences"
+msgstr "Tercihler"
+
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
+msgstr "Seçenekler tümüyle kaydedilemedi:"
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Öntanımlı"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Sistem (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Diğer"
+
+#: lib/tools.tcl:76
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "%s ögesini çalıştırma bir seçili dosya gerektirir."
+
+#: lib/tools.tcl:92
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "\"%2$s\" üzerinde %1$s çalıştırmak istediğinizden emin misiniz?"
+
+#: lib/tools.tcl:96
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "%s çalıştırmak istediğinizden emin misiniz?"
+
+#: lib/tools.tcl:118
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Araç: %s"
+
+#: lib/tools.tcl:119
+#, tcl-format
+msgid "Running: %s"
+msgstr "Çalışıyor: %s"
+
+#: lib/tools.tcl:158
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "Araç başarıyla tamamlandı: %s"
+
+#: lib/tools.tcl:160
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Araç başarısız oldu: %s"
+
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "Çözüm taban sürüme zorlansın mı?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "Çözüm bu dala zorlansın mı?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "Çözüm başka dala zorlansın mı?"
+
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"diff'in yalnızca çakışan değişiklikleri gösterdiğini unutmayın.\n"
+"\n"
+"%s ögesinin üzerine yazılacak.\n"
+"\n"
+"Bu işlem yalnızca birleştirmeyi yeniden başlatarak geri alınabilir."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "%s dosyasının hâlâ çözülmemiş çakışmaları var görünüyor, yine de "
+"birleştirilsin mi?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "%s için çözüm ekleniyor"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "Bir araç kullanarak silme veya bağlantı çakışmaları çözülemiyor"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "Çakışan dosya mevcut değil"
+
+#: lib/mergetool.tcl:246
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "Bir grafik arabirim birleştirme aracı değil: '%s'"
+
+#: lib/mergetool.tcl:275
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Desteklenmeyen birleştirme aracı '%s'"
+
+#: lib/mergetool.tcl:310
+msgid "Merge tool is already running, terminate it?"
+msgstr "Birleştirme aracı halihazırda çalışıyor, sonlandırılsın mı?"
+
+#: lib/mergetool.tcl:330
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Sürümler alınırken hata:\n"
+"%s"
+
+#: lib/mergetool.tcl:350
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"Birleştirme aracı başlatılamadı:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:354
+msgid "Running merge tool..."
+msgstr "Birleştirme aracı çalışıyor..."
+
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
+msgid "Merge tool failed."
+msgstr "Birleştirme aracı başarısız oldu."
+
+#: lib/tools_dlg.tcl:22
+#, tcl-format
+msgid "%s (%s): Add Tool"
+msgstr "%s (%s): Ekleme Aracı"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Yeni Araç Komutu Ekle"
+
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
+msgstr "Global olarak ekle"
+
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
+msgstr "Araç Ayrıntıları"
+
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Bir alt menü ağacı oluşturmak için '/' kullanın:"
+
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
+msgstr "Komut:"
+
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
+msgstr "Çalıştırma öncesinde bir iletişim kutusu göster"
+
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Kullanıcıya bir revizyon seçmesini söyle ($REVISION ayarlar)"
+
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Kullanıcıya ek argümanlar koymasını söyle ($ARGS ayarlar)"
+
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
+msgstr "Komut çıktı penceresini gösterme"
+
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Yalnızca bir diff seçiliyse çalıştır ($FILENAME boş değil)"
+
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
+msgstr "Araç için yeni bir ad sağlayın."
+
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "'%s' aracı halihazırda mevcut."
+
+#: lib/tools_dlg.tcl:148
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr "Araç eklenemedi:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:187
+#, tcl-format
+msgid "%s (%s): Remove Tool"
+msgstr "%s (%s): Araç Kaldır"
+
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr "Araç Komutlarını Kaldır"
+
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
+msgstr "Kaldır"
+
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Mavi renk, depoya özel araçları belirtir)"
+
+#: lib/tools_dlg.tcl:283
+#, tcl-format
+msgid "%s (%s):"
+msgstr "%s (%s):"
+
+#: lib/tools_dlg.tcl:292
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Komut Çalıştır: %s"
+
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
+msgstr "Argümanlar"
+
+#: lib/tools_dlg.tcl:341
+msgid "OK"
+msgstr "Tamam"
+
+#: lib/search.tcl:48
+msgid "Find:"
+msgstr "Bul:"
+
+#: lib/search.tcl:50
+msgid "Next"
+msgstr "Sonraki"
+
+#: lib/search.tcl:51
+msgid "Prev"
+msgstr "Önceki"
+
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr "Düzenli İfade"
+
+#: lib/search.tcl:54
+msgid "Case"
+msgstr "BÜYÜK/küçük harf"
+
+#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
+#, tcl-format
+msgid "%s (%s): Create Desktop Icon"
+msgstr "%s (%s): Masaüstü Simgesi Oluştur"
+
+#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
+msgid "Cannot write shortcut:"
+msgstr "Kısayol yazılamıyor:"
+
+#: lib/shortcut.tcl:140
+msgid "Cannot write icon:"
+msgstr "Simge yazılamıyor:"
+
+#: lib/remote_branch_delete.tcl:29
+#, tcl-format
+msgid "%s (%s): Delete Branch Remotely"
+msgstr "%s (%s): Dalı Uzaktan Sil"
+
+#: lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "Dalı Uzaktan Sil"
+
+#: lib/remote_branch_delete.tcl:48
+msgid "From Repository"
+msgstr "Depodan"
+
+#: lib/remote_branch_delete.tcl:88
+msgid "Branches"
+msgstr "Dallar"
+
+#: lib/remote_branch_delete.tcl:110
+msgid "Delete Only If"
+msgstr "Silme Ölçütü"
+
+#: lib/remote_branch_delete.tcl:112
+msgid "Merged Into:"
+msgstr "Birleştirme Konumu:"
+
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr "Her Zaman (Birleştirme denetimlerini uygulama)"
+
+#: lib/remote_branch_delete.tcl:153
+msgid "A branch is required for 'Merged Into'."
+msgstr "'Birleştirme Konumu' için bir dal gerekli."
+
+#: lib/remote_branch_delete.tcl:185
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr ""
+"Aşağıdaki dallar %s üzerine tümüyle birleştirilmemiş:\n"
+"\n"
+" - %s"
+
+#: lib/remote_branch_delete.tcl:190
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Bir veya daha çok birleştirme sınaması başarısız oldu; çünkü gerekli "
+"işlemeleri getirmediniz. Önce %s konumundan getirmeyi deneyin."
+
+#: lib/remote_branch_delete.tcl:208
+msgid "Please select one or more branches to delete."
+msgstr "Silmek için bir veya daha çok dal seçin."
+
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Silinen dalların geri getirilmesi pek güçtür.\n"
+"\n"
+"Seçili dallar silinsin mi?"
+
+#: lib/remote_branch_delete.tcl:227
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Dallar %s konumundan siliniyor"
+
+#: lib/remote_branch_delete.tcl:300
+msgid "No repository selected."
+msgstr "Hiçbir depo seçilmedi."
+
+#: lib/remote_branch_delete.tcl:305
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "%s taranıyor..."
+
+#: lib/choose_repository.tcl:45
+msgid "Git Gui"
+msgstr "Git Grafik Arabirim"
+
+#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
+msgid "Create New Repository"
+msgstr "Yeni Depo Oluştur"
+
+#: lib/choose_repository.tcl:110
+msgid "New..."
+msgstr "Yeni..."
+
+#: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
+msgid "Clone Existing Repository"
+msgstr "Var Olan Depoyu Klonla"
+
+#: lib/choose_repository.tcl:128
+msgid "Clone..."
+msgstr "Klonla..."
+
+#: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
+msgid "Open Existing Repository"
+msgstr "Var Olan Depoyu Aç"
+
+#: lib/choose_repository.tcl:141
+msgid "Open..."
+msgstr "Aç..."
+
+#: lib/choose_repository.tcl:154
+msgid "Recent Repositories"
+msgstr "Son Kullanılan Depolar"
+
+#: lib/choose_repository.tcl:164
+msgid "Open Recent Repository:"
+msgstr "Son Kullanılan Depoyu Aç:"
+
+#: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
+#: lib/choose_repository.tcl:345
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "%s deposu oluşturulamadı:"
+
+#: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
+msgid "Create"
+msgstr "Oluştur"
+
+#: lib/choose_repository.tcl:432
+msgid "Directory:"
+msgstr "Dizin:"
+
+#: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:1139
+msgid "Git Repository"
+msgstr "Git Deposu"
+
+#: lib/choose_repository.tcl:487
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "%s dizini halihazırda mevcut."
+
+#: lib/choose_repository.tcl:491
+#, tcl-format
+msgid "File %s already exists."
+msgstr "%s dosyası halihazırda mevcut."
+
+#: lib/choose_repository.tcl:506
+msgid "Clone"
+msgstr "Klonla"
+
+#: lib/choose_repository.tcl:519
+msgid "Source Location:"
+msgstr "Kaynak Konumu:"
+
+#: lib/choose_repository.tcl:528
+msgid "Target Directory:"
+msgstr "Hedef Dizin:"
+
+#: lib/choose_repository.tcl:538
+msgid "Clone Type:"
+msgstr "Klonlama Türü:"
+
+#: lib/choose_repository.tcl:543
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Standart (Hızlı, Kısmi Gerekli, Sabit Bağlantılar)"
+
+#: lib/choose_repository.tcl:548
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Tam Kopya (Daha Yavaş, Bütün Yedekler)"
+
+#: lib/choose_repository.tcl:553
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Paylaşılan (En Hızlı, Önerilmez, Yedeksiz)"
+
+#: lib/choose_repository.tcl:560
+msgid "Recursively clone submodules too"
+msgstr "Özyineli olarak altmodülleri de klonla"
+
+#: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
+#: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "Bir Git deposu değil: %s"
+
+#: lib/choose_repository.tcl:630
+msgid "Standard only available for local repository."
+msgstr "Standart, yalnızca yerel depo için kullanılabilir."
+
+#: lib/choose_repository.tcl:634
+msgid "Shared only available for local repository."
+msgstr "Paylaşılan, yalnızca yerel depo için kullanılabilir."
+
+#: lib/choose_repository.tcl:655
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "%s konumu halihazırda var."
+
+#: lib/choose_repository.tcl:666
+msgid "Failed to configure origin"
+msgstr "Köken yapılandırılamadı"
+
+#: lib/choose_repository.tcl:678
+msgid "Counting objects"
+msgstr "Nesneler sayılıyor"
+
+#: lib/choose_repository.tcl:679
+msgid "buckets"
+msgstr "kovalar"
+
+#: lib/choose_repository.tcl:703
+#, tcl-format
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "Nesneler/bilgi/alternatifler kopyalanamıyor: %s"
+
+#: lib/choose_repository.tcl:740
+#, tcl-format
+msgid "Nothing to clone from %s."
+msgstr "%s konumundan klonlanacak bir şey yok."
+
+#: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:974
+msgid "The 'master' branch has not been initialized."
+msgstr "'master' dalı ilklendirilmedi."
+
+#: lib/choose_repository.tcl:755
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Sabit bağlantılar kullanılamıyor. Yerine, kopyalama kullanılıyor."
+
+#: lib/choose_repository.tcl:769
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "%s konumundan klonlanıyor"
+
+#: lib/choose_repository.tcl:800
+msgid "Copying objects"
+msgstr "Nesneler kopyalanıyor"
+
+#: lib/choose_repository.tcl:801
+msgid "KiB"
+msgstr "KiB"
+
+#: lib/choose_repository.tcl:825
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "Nesne kopyalanamıyor: %s"
+
+#: lib/choose_repository.tcl:837
+msgid "Linking objects"
+msgstr "Nesneler bağlanıyor"
+
+#: lib/choose_repository.tcl:838
+msgid "objects"
+msgstr "nesneler"
+
+#: lib/choose_repository.tcl:846
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "Nesne sabit bağlantısı yapılamıyor: %s"
+
+#: lib/choose_repository.tcl:903
+msgid "Cannot fetch branches and objects.  See console output for details."
+msgstr "Dallar ve nesneler getirilemiyor. Ayrıntılar için konsol çıktısına "
+"bakın."
+
+#: lib/choose_repository.tcl:914
+msgid "Cannot fetch tags.  See console output for details."
+msgstr "Etiketler getirilemiyor. Ayrıntılar için konsol çıktısına bakın."
+
+#: lib/choose_repository.tcl:938
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr "HEAD belirlenemiyor. Ayrıntılar için konsol çıktısına bakın."
+
+#: lib/choose_repository.tcl:947
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr "%s temizlenıp toparlanamıyor"
+
+#: lib/choose_repository.tcl:953
+msgid "Clone failed."
+msgstr "Klonlama başarısız."
+
+#: lib/choose_repository.tcl:960
+msgid "No default branch obtained."
+msgstr "Öntanımlı bir dal alınamadı."
+
+#: lib/choose_repository.tcl:971
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr "%s, bir işleme olarak çözülemiyor."
+
+#: lib/choose_repository.tcl:998
+msgid "Creating working directory"
+msgstr "Çalışma dizini oluşturuluyor"
+
+#: lib/choose_repository.tcl:1028
+msgid "Initial file checkout failed."
+msgstr "İlk dosya çıkışı başarısız."
+
+#: lib/choose_repository.tcl:1072
+msgid "Cloning submodules"
+msgstr "Altmodüller klonlanıyor"
+
+#: lib/choose_repository.tcl:1087
+msgid "Cannot clone submodules."
+msgstr "Altmodüller klonlanamıyor."
+
+#: lib/choose_repository.tcl:1110
+msgid "Repository:"
+msgstr "Depo:"
+
+#: lib/choose_repository.tcl:1159
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "%s deposu açılamadı:"
+
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - Git için bir grafik kullanıcı arabirimi."
+
+#: lib/blame.tcl:74
+#, tcl-format
+msgid "%s (%s): File Viewer"
+msgstr "%s (%s): Dosya Görüntüleyici"
+
+#: lib/blame.tcl:80
+msgid "Commit:"
+msgstr "İşleme:"
+
+#: lib/blame.tcl:282
+msgid "Copy Commit"
+msgstr "İşleme Kopyala"
+
+#: lib/blame.tcl:286
+msgid "Find Text..."
+msgstr "Metin Bul..."
+
+#: lib/blame.tcl:290
+msgid "Goto Line..."
+msgstr "Satıra Git..."
+
+#: lib/blame.tcl:299
+msgid "Do Full Copy Detection"
+msgstr "Tam Kopya Algılaması Yap"
+
+#: lib/blame.tcl:303
+msgid "Show History Context"
+msgstr "Geçmiş Bağlamını Göster"
+
+#: lib/blame.tcl:306
+msgid "Blame Parent Commit"
+msgstr "Üst İşlemeyi Suçla"
+
+#: lib/blame.tcl:468
+#, tcl-format
+msgid "Reading %s..."
+msgstr "%s okunuyor..."
+
+#: lib/blame.tcl:596
+msgid "Loading copy/move tracking annotations..."
+msgstr "Kopyala/Taşı izleme ek açıklamaları yükleniyor..."
+
+#: lib/blame.tcl:613
+msgid "lines annotated"
+msgstr "satıra açıklama eklendi"
+
+#: lib/blame.tcl:815
+msgid "Loading original location annotations..."
+msgstr "Özgün konum ek açıklamaları yükleniyor..."
+
+#: lib/blame.tcl:818
+msgid "Annotation complete."
+msgstr "Ek açıklamalar tamamlandı."
+
+#: lib/blame.tcl:849
+msgid "Busy"
+msgstr "Meşgul"
+
+#: lib/blame.tcl:850
+msgid "Annotation process is already running."
+msgstr "Açıklamalandırma işlemi halihazırda çalışıyor."
+
+#: lib/blame.tcl:889
+msgid "Running thorough copy detection..."
+msgstr "Ayrıntılı kopya algılaması çalışıyor..."
+
+#: lib/blame.tcl:957
+msgid "Loading annotation..."
+msgstr "Ek açıklama yükleniyor..."
+
+#: lib/blame.tcl:1010
+msgid "Author:"
+msgstr "Yazar:"
+
+#: lib/blame.tcl:1014
+msgid "Committer:"
+msgstr "İşleyici:"
+
+#: lib/blame.tcl:1019
+msgid "Original File:"
+msgstr "Özgün Dosya:"
+
+#: lib/blame.tcl:1067
+msgid "Cannot find HEAD commit:"
+msgstr "HEAD işlemesi bulunamıyor:"
+
+#: lib/blame.tcl:1122
+msgid "Cannot find parent commit:"
+msgstr "Üst işleme bulunamıyor:"
+
+#: lib/blame.tcl:1137
+msgid "Unable to display parent"
+msgstr "Üst öge görüntülenemiyor"
+
+#: lib/blame.tcl:1138 lib/diff.tcl:345
+msgid "Error loading diff:"
+msgstr "diff yüklenirken hata:"
+
+#: lib/blame.tcl:1279
+msgid "Originally By:"
+msgstr "İlk Yazan:"
+
+#: lib/blame.tcl:1285
+msgid "In File:"
+msgstr "Şu Dosyada:"
+
+#: lib/blame.tcl:1290
+msgid "Copied Or Moved Here By:"
+msgstr "Buraya Kopyalayan/Taşıyan:"
+
+#: lib/diff.tcl:77
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+"Değişikliğe rastlanmadı.\n"
+"\n"
+"%s ögesinde değişiklik yok.\n"
+"\n"
+"Bu dosyanın değişiklik tarihi özniteliği başka bir uygulama tarafından "
+"güncellenmiş; ancak dosya içeriğine dokunulmamış.\n"
+"\n"
+"Buna benzer bir durumda olan başka bir dosya olup olmadığını algılamak "
+"için bir yeniden tarama kendiliğinden başlatılacak."
+
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "%s dosyasının diff'i yükleniyor..."
+
+#: lib/diff.tcl:143
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"YEREL: Silindi\n"
+"UZAK KONUM:\n"
+
+#: lib/diff.tcl:148
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"UZAK KONUM: Silindi\n"
+"YEREL:\n"
+
+#: lib/diff.tcl:155
+msgid "LOCAL:\n"
+msgstr "YEREL:\n"
+
+#: lib/diff.tcl:158
+msgid "REMOTE:\n"
+msgstr "UZAK KONUM:\n"
+
+#: lib/diff.tcl:220 lib/diff.tcl:344
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "%s görüntülenemiyor"
+
+#: lib/diff.tcl:221
+msgid "Error loading file:"
+msgstr "Dosya yüklenirken hata:"
+
+#: lib/diff.tcl:227
+msgid "Git Repository (subproject)"
+msgstr "Git Deposu (altproje)"
+
+#: lib/diff.tcl:239
+msgid "* Binary file (not showing content)."
+msgstr "* İkili dosya (içerik gösterilmiyor)."
+
+#: lib/diff.tcl:244
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* İzlenmeyen dosya %d bayt.\n"
+"* Yalnızca ilk %d baytı gösteriliyor.\n"
+
+#: lib/diff.tcl:250
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* İzlenmeyen dosya burada %s kadar kırpılmış.\n"
+"* Tüm dosyası görmek için bir dış düzenleyici kullanın.\n"
+
+#: lib/diff.tcl:583
+msgid "Failed to unstage selected hunk."
+msgstr "Seçili parça hazırlıktan çıkarılamadı."
+
+#: lib/diff.tcl:591
+msgid "Failed to revert selected hunk."
+msgstr "Seçili parça geri alınamadı."
+
+#: lib/diff.tcl:594
+msgid "Failed to stage selected hunk."
+msgstr "Seçili parça hazırlanamadı."
+
+#: lib/diff.tcl:687
+msgid "Failed to unstage selected line."
+msgstr "Seçili satır hazırlıktan çıkarılamadı."
+
+#: lib/diff.tcl:696
+msgid "Failed to revert selected line."
+msgstr "Seçili satır geri alınamadı."
+
+#: lib/diff.tcl:700
+msgid "Failed to stage selected line."
+msgstr "Seçili satır hazırlanamadı."
+
+#: lib/diff.tcl:889
+msgid "Failed to undo last revert."
+msgstr "Son geri alma işlemi iptal edilemedi."
+
+#: lib/sshkey.tcl:34
+msgid "No keys found."
+msgstr "Anahtar bulunamadı."
+
+#: lib/sshkey.tcl:37
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Şurada bir genel anahtar bulundu: %s"
+
+#: lib/sshkey.tcl:43
+msgid "Generate Key"
+msgstr "Anahtar Oluştur"
+
+#: lib/sshkey.tcl:61
+msgid "Copy To Clipboard"
+msgstr "Panoya Kopyala"
+
+#: lib/sshkey.tcl:75
+msgid "Your OpenSSH Public Key"
+msgstr "OpenSSH Genel Anahtarınız"
+
+#: lib/sshkey.tcl:83
+msgid "Generating..."
+msgstr "Oluşturuluyor..."
+
+#: lib/sshkey.tcl:89
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"ssh-keygen başlatılamadı:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:116
+msgid "Generation failed."
+msgstr "Oluşturma başarısız."
+
+#: lib/sshkey.tcl:123
+msgid "Generation succeeded, but no keys found."
+msgstr "Oluşturma başarılı; ancak bir anahtar bulunamadı."
+
+#: lib/sshkey.tcl:126
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Anahtarınız şurada: %s"
+
+#: lib/branch_create.tcl:23
+#, tcl-format
+msgid "%s (%s): Create Branch"
+msgstr "%s (%s): Dal Oluştur"
+
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
+msgstr "Yeni Dal Oluştur"
+
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
+msgstr "Dal Adı"
+
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
+msgstr "İzleyen Dal Adı ile Eşleş"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Başlama Revizyonu"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Var Olan Dalı Güncelle:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Hayır"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Yalnızca İleri Sarım"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Oluşturduktan Sonra Çıkış Yap"
+
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
+msgstr "Bir izleme dalı seçin."
+
+#: lib/branch_create.tcl:141
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "İzleme dalı %s, uzak depoda bir dal değil."
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "Çalışıyor... lütfen bekleyin..."
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Başarılı"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Hata: Komut Başarısız"
+
+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr "Satıra Git:"
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr "Git"
+
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
+msgstr "Bu Ayrık Çıkış"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Revizyon İfadesi:"
+
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr "Yerel Dal"
+
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr "İzleyen Dal"
+
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
+msgstr "Etiket"
+
+#: lib/choose_rev.tcl:321
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Geçersiz revizyon: %s"
+
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
+msgstr "Hiçbir revizyon seçilmedi."
+
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr "Revizyon ifadesi boş."
+
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr "Güncellendi"
+
+#: lib/choose_rev.tcl:565
+msgid "URL"
+msgstr "URL"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
+msgstr ""
+"Değiştirilecek bir şey yok.\n"
+"\n"
+"İlk işlemeyi oluşturmak üzeresiniz. Bundan önce değiştirilecek bir işleme "
+"yok.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
+msgstr ""
+"Birleştirme sırasında değiştirme yapılamaz.\n"
+"\n"
+"Şu anda tümüyle bitmemiş bir birleştirmenin ortasındasınız. Geçerli "
+"birleştirme etkinliğini iptal etmediğiniz sürece bir önceki işlemeyi "
+"değiştiremezsiniz.\n"
+
+#: lib/commit.tcl:56
+msgid "Error loading commit data for amend:"
+msgstr "Değiştirme için işleme verisini yüklerken hata:"
+
+#: lib/commit.tcl:83
+msgid "Unable to obtain your identity:"
+msgstr "Kimliğiniz tanımlanamıyor:"
+
+#: lib/commit.tcl:88
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Geçersiz GIT_COMMITTER_IDENT:"
+
+#: lib/commit.tcl:138
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "uyarı: Tcl, '%s' kodlamasını desteklemiyor."
+
+#: lib/commit.tcl:158
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Son taranan durum depo durumu ile eşleşmiyor.\n"
+"\n"
+"Başka bir Git programı, bu depoyu son taramadan beri değiştirmiş. Başka "
+"bir işlemenin oluşturabilmesi için bir yeniden tarama gerçekleştirilmelidir.\n"
+"\n"
+"Yeniden tarama şimdi kendiliğinden başlatılacak.\n"
+
+#: lib/commit.tcl:182
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Birleştirilmemiş dosyalar işlenemez.\n"
+"\n"
+"%s dosyasında birleştirme çakışmaları mevcut. İşlemeden önce bu çakışmaları "
+"çözmeli ve dosyayı hazırlamalısınız.\n"
+
+#: lib/commit.tcl:190
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"%s bilinmeyen dosya durumu algılandı.\n"
+"\n"
+"%s dosyası bu program tarafından işlenemez.\n"
+
+#: lib/commit.tcl:198
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"İşlenecek bir değişiklik yok.\n"
+"\n"
+"İşleme yapmadan önce en az bir dosyayı hazırlamalısınız.\n"
+
+#: lib/commit.tcl:213
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Lütfen bir işleme iletisi sağlayın.\n"
+"\n"
+"İyi bir işleme iletisi aşağıdaki biçime göre hazırlanır:\n"
+"\n"
+"- İlk satır: Ne yaptığınızı bir tümce ile açıklayın.\n"
+"- İkinci satır: Boş\n"
+"- Kalan satırlar: Bu değişikliğin neden iyi olduğunu açıklayın.\n"
+
+#: lib/commit.tcl:244
+msgid "Calling pre-commit hook..."
+msgstr "pre-commit kancası çağrılıyor..."
+
+#: lib/commit.tcl:259
+msgid "Commit declined by pre-commit hook."
+msgstr "İşleme, pre-commit kancası tarafından reddedildi."
+
+#: lib/commit.tcl:278
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+"Ayrık bir HEAD üzerinde işleme yapmak üzeresiniz. Bu genelde yapılması "
+"önerilmeyen bir şeydir; çünkü başka bir dala geçerseniz değişikliklerinizi "
+"kaybedeceksiniz ve daha sonra onları başvuru günlüğünden kurtarmak güç "
+"olabilir. Bu işlemeyi iptal etmeli ve sürdürmek için yeni bir dal "
+"oluşturmalısınız.\n"
+" \n"
+" Gerçekten işlemek istediğinize emin misiniz?"
+
+#: lib/commit.tcl:299
+msgid "Calling commit-msg hook..."
+msgstr "commit-msg kancası çağrılıyor..."
+
+#: lib/commit.tcl:314
+msgid "Commit declined by commit-msg hook."
+msgstr "İşleme, commit-msg kancası tarafından reddedildi."
+
+#: lib/commit.tcl:327
+msgid "Committing changes..."
+msgstr "Değişiklikler işleniyor..."
+
+#: lib/commit.tcl:344
+msgid "write-tree failed:"
+msgstr "write-tree başarısız oldu:"
+
+#: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
+msgid "Commit failed."
+msgstr "İşleme başarısız."
+
+#: lib/commit.tcl:362
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "%s işlemesi hasarlı gibi görünüyor"
+
+#: lib/commit.tcl:367
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"İşlenecek bir değişiklik yok.\n"
+"\n"
+"Herhangi bir dosya değiştirilmedi ve bir birleştirme işlemesi de değildi.\n"
+"\n"
+"Bir yeniden tarama şimdi kendiliğinden başlatılacak.\n"
+
+#: lib/commit.tcl:374
+msgid "No changes to commit."
+msgstr "İşlenecek bir değişiklik yok."
+
+#: lib/commit.tcl:394
+msgid "commit-tree failed:"
+msgstr "commit-tree başarısız oldu:"
+
+#: lib/commit.tcl:421
+msgid "update-ref failed:"
+msgstr "update-ref başarısız oldu:"
+
+#: lib/commit.tcl:514
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "%s işlemesi oluşturuldu: %s"
+
+#: lib/branch_delete.tcl:16
+#, tcl-format
+msgid "%s (%s): Delete Branch"
+msgstr "%s (%s): Dal Sil"
+
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr "Yerel Dal Sil"
+
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr "Yerel Dallar"
+
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
+msgstr "Yalnızca Birleştirilmişse Sil"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Aşağıdaki dallar %s içine tümüyle birleştirilmemiş:"
+
+#: lib/branch_delete.tcl:131
+#, tcl-format
+msgid " - %s:"
+msgstr " - %s:"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Dal(lar) silinemedi:\n"
+"%s"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Geçersiz Git tarihi: %s"
+
+#: lib/database.tcl:42
+msgid "Number of loose objects"
+msgstr "Gevşek nesnelerin sayısı"
+
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
+msgstr "Gevşek nesneler tarafından kullanılan disk alanı"
+
+#: lib/database.tcl:44
+msgid "Number of packed objects"
+msgstr "Paketlenmiş nesnelerin sayısı"
+
+#: lib/database.tcl:45
+msgid "Number of packs"
+msgstr "Paket sayısı"
+
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
+msgstr "Paketlenmiş nesneler tarafından kullanılan disk alanı"
+
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
+msgstr "Budanmak için bekleyen paketlenmiş nesneler"
+
+#: lib/database.tcl:48
+msgid "Garbage files"
+msgstr "Çöp dosyalar"
+
+#: lib/database.tcl:66
+#, tcl-format
+msgid "%s (%s): Database Statistics"
+msgstr "%s (%s): Veritabanı İstatistikleri"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Nesne veritabanı sıkıştırılıyor"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Nesne veritabanı, fsck-objects ile doğrulanıyor"
+
+#: lib/database.tcl:107
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you compress "
+"the database.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Bu depoda şu anda yaklaşık %i gevşek nesne var.\n"
+"\n"
+"Başarımı  en iyi düzeyde tutmak için veritabanını sıkıştırmanız önerilir.\n"
+"\n"
+"Veritabanı şimdi sıkıştırılsın mı?"
+
+#: lib/error.tcl:20
+#, tcl-format
+msgid "%s: error"
+msgstr "%s: Hata"
+
+#: lib/error.tcl:36
+#, tcl-format
+msgid "%s: warning"
+msgstr "%s: Uyarı"
+
+#: lib/error.tcl:80
+#, tcl-format
+msgid "%s hook failed:"
+msgstr "%s kancası başarısız oldu:"
+
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
+msgstr "İşlemeden önce yukarıdaki hataları düzeltmelisiniz."
+
+#: lib/error.tcl:116
+#, tcl-format
+msgid "%s (%s): error"
+msgstr "%s (%s): Hata"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Bir değişikliğin ortasındasınız.\n"
+"\n"
+"%s dosyası değiştirildi.\n"
+"\n"
+"Bir birleştirme başlatmadan önce geçerli işlemeyi tamamlamalısınız. Bunu "
+"yapmak, gerek olursa başarısız bir birleştirmeyi iptal etmenize yardımcı "
+"olur.\n"
+
+#: lib/merge.tcl:108
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s/%s"
+
+#: lib/merge.tcl:126
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "%s ve %s birleştiriliyor..."
+
+#: lib/merge.tcl:137
+msgid "Merge completed successfully."
+msgstr "Birleştirme başarıyla tamamlandı."
+
+#: lib/merge.tcl:139
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Birleştirme başarısız. Çakışma çözümü gerekiyor."
+
+#: lib/merge.tcl:156
+#, tcl-format
+msgid "%s (%s): Merge"
+msgstr "%s (%s): Birleştir"
+
+#: lib/merge.tcl:164
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "%s İçine Birleştir"
+
+#: lib/merge.tcl:183
+msgid "Revision To Merge"
+msgstr "Birleştirilecek Revizyon"
+
+#: lib/merge.tcl:218
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Değişiklik sırasında iptal yapılamaz.\n"
+"\n"
+"Bu işlemeyi değiştirmeyi bitirmelisiniz.\n"
+
+#: lib/merge.tcl:228
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Birleştirme iptal edilsin mi?\n"
+"\n"
+"İptal işlemi, tüm işlenmemiş değişikliklerin kaybolmasına yol açar.\n"
+"\n"
+"Geçerli birleştirmeyi iptal işlemi sürdürülsün mü?"
+
+#: lib/merge.tcl:234
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Değişiklikler sıfırlansın mı?\n"
+"\n"
+"Sıfırlama işlemi, tüm işlenmemiş değişikliklerin kaybolmasına yol açar.\n"
+"\n"
+"Geçerli değişiklikleri sıfırlama sürdürülsün mü?"
+
+#: lib/merge.tcl:246
+msgid "Aborting"
+msgstr "İptal ediliyor"
+
+#: lib/merge.tcl:247
+msgid "files reset"
+msgstr "dosya sıfırlandı"
+
+#: lib/merge.tcl:277
+msgid "Abort failed."
+msgstr "İptal etme başarısız."
+
+#: lib/merge.tcl:279
+msgid "Abort completed.  Ready."
+msgstr "İptal işlemi tamamlandı. Hazır."
-- 
2.34.1

