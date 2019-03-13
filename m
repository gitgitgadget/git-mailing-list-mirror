Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56CE20248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCMM2u (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:28:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35961 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCMM2t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:28:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so1343455edi.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=394nKedtGTn1FjhRcVq6XlRAFDSHdxuK4hzWg5A89r8=;
        b=PiAh5wS0PyieuUn/iSg9uxECrdsJiHP407nddyICqJ2U5naORM9ssJwWHjt5T/0qea
         6lxbQhCoDwAyJtGaf60JQKypn+xjw4j66BC5MaZOhcu/c7sqv2RFIulAZXtUbSP7yzra
         faaBWqMypEZgzELCHz6P53jOKnD+VpwgEZO6MhkPXP+wQ0dB+3nA5FxQh4ra+r2mpNY2
         TWr5RaUqYQCe93YhsiNQ9ycWY7H1lbnXPHTUefJfVc/F90v1IVr/QlMtvTPk7STJ5uhs
         VbAa+MY+bN53oxnkGxWsLXj9XTnLAjkbXh34B36UqcubMe/bP0crmPnVF8LGCR28HmJj
         kaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=394nKedtGTn1FjhRcVq6XlRAFDSHdxuK4hzWg5A89r8=;
        b=O5ZY2w/8WhOuJ6N+t3hfsbvl+zwgvkqu8+TrHgSp6r1Dcy2CTlMnqOrbbvGO2Rb+m2
         zrP3WBmV7PiVu/PZ/Ngj45lzH/YHy12ya/EKTWE9xbIfgLrryQnkR54uaPa0kJnohlsN
         2tM94mJ+0lEd4DxcR9Kwix8TD1bNqrAMxgBjSatMxVNbNZClQg1VCey8K5/9K8sEnNUb
         A4nBFCewobiiOx9BcY6T6e+U2rDes4rDS1ZqhZCoWBKBwuBkkJ7Dc0mVdy0j+Z3KOqIO
         M7nFF9E7P5f0XI5ahOLBDRqxDOmSNgOzjLAUTjcJms1DngN/Ap5Gt8EDqMwk7hiwZpgH
         YWGg==
X-Gm-Message-State: APjAAAXXTTQEs4OTHOdkTBi/2KT19ajyc6tRHD9W8wIiUXGZ0QZ67tHF
        6i+F+wyku+Dbebs+z+MesICMPA==
X-Google-Smtp-Source: APXvYqyqF8xKKUKl3yN5T1PaKzGnPwbm5fNypDPiNxuPEgQ7YVRgb8LI3PuUi8caC6nZh86Ng3S2mg==
X-Received: by 2002:a17:906:f114:: with SMTP id gv20mr30158708ejb.124.1552480125258;
        Wed, 13 Mar 2019 05:28:45 -0700 (PDT)
Received: from ashopov-C02X544YJHD3.corp.uber.com ([213.208.239.150])
        by smtp.gmail.com with ESMTPSA id e21sm570298edb.27.2019.03.13.05.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:28:44 -0700 (PDT)
From:   Alexander Shopov <ash@kambanaria.org>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 1/1] gitk: Update Bulgarian translation (317t)
Date:   Wed, 13 Mar 2019 13:28:33 +0100
Message-Id: <20190313122833.15897-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313120646.14248-1-ash@kambanaria.org>
References: <20190313120646.14248-1-ash@kambanaria.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 660 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 343 insertions(+), 317 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 407d5550b1..87ab1fac24 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -1,15 +1,15 @@
 # Bulgarian translation of gitk po-file.
-# Copyright (C) 2014, 2015 Alexander Shopov <ash@kambanaria.org>.
+# Copyright (C) 2014, 2015, 2019 Alexander Shopov <ash@kambanaria.org>.
 # This file is distributed under the same license as the git package.
-# Alexander Shopov <ash@kambanaria.org>, 2014, 2015.
+# Alexander Shopov <ash@kambanaria.org>, 2014, 2015, 2019.
 #
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: gitk master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-12-19 11:48+0200\n"
-"PO-Revision-Date: 2015-12-19 11:49+0200\n"
+"POT-Creation-Date: 2019-03-04 11:27+0100\n"
+"PO-Revision-Date: 2019-03-04 11:39+0100\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -22,17 +22,17 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Списъкът с неслети файлове не може да бъде получен:"
 
-#: gitk:212 gitk:2399
+#: gitk:212 gitk:2403
 msgid "Color words"
 msgstr "Оцветяване на думите"
 
-#: gitk:217 gitk:2399 gitk:8239 gitk:8272
+#: gitk:217 gitk:2403 gitk:8249 gitk:8282
 msgid "Markup words"
 msgstr "Отбелязване на думите"
 
 #: gitk:324
 msgid "Error parsing revisions:"
-msgstr "Грешка при разбор на версиите:"
+msgstr "Грешка при анализ на версиите:"
 
 #: gitk:380
 msgid "Error executing --argscmd command:"
@@ -59,314 +59,318 @@ msgstr "Грешка при изпълнение на „git log“:"
 msgid "Reading"
 msgstr "Прочитане"
 
-#: gitk:496 gitk:4544
+#: gitk:496 gitk:4549
 msgid "Reading commits..."
 msgstr "Прочитане на подаванията…"
 
-#: gitk:499 gitk:1637 gitk:4547
+#: gitk:499 gitk:1641 gitk:4552
 msgid "No commits selected"
 msgstr "Не са избрани подавания"
 
-#: gitk:1445 gitk:4064 gitk:12469
+#: gitk:1449 gitk:4069 gitk:12583
 msgid "Command line"
 msgstr "Команден ред"
 
-#: gitk:1511
+#: gitk:1515
 msgid "Can't parse git log output:"
 msgstr "Изходът от „git log“ не може да се анализира:"
 
-#: gitk:1740
+#: gitk:1744
 msgid "No commit information available"
 msgstr "Липсва информация за подавания"
 
-#: gitk:1903 gitk:1932 gitk:4334 gitk:9702 gitk:11274 gitk:11554
+#: gitk:1907 gitk:1936 gitk:4339 gitk:9789 gitk:11388 gitk:11668
 msgid "OK"
 msgstr "Добре"
 
-#: gitk:1934 gitk:4336 gitk:9215 gitk:9294 gitk:9424 gitk:9473 gitk:9704
-#: gitk:11275 gitk:11555
+#: gitk:1938 gitk:4341 gitk:9225 gitk:9304 gitk:9434 gitk:9520 gitk:9791
+#: gitk:11389 gitk:11669
 msgid "Cancel"
 msgstr "Отказ"
 
-#: gitk:2083
+#: gitk:2087
 msgid "&Update"
 msgstr "&Обновяване"
 
-#: gitk:2084
+#: gitk:2088
 msgid "&Reload"
 msgstr "&Презареждане"
 
-#: gitk:2085
+#: gitk:2089
 msgid "Reread re&ferences"
-msgstr "&Наново прочитане на настройките"
+msgstr "&Наново прочитане"
 
-#: gitk:2086
+#: gitk:2090
 msgid "&List references"
 msgstr "&Изброяване на указателите"
 
-#: gitk:2088
+#: gitk:2092
 msgid "Start git &gui"
 msgstr "&Стартиране на „git gui“"
 
-#: gitk:2090
+#: gitk:2094
 msgid "&Quit"
 msgstr "&Спиране на програмата"
 
-#: gitk:2082
+#: gitk:2086
 msgid "&File"
 msgstr "&Файл"
 
-#: gitk:2094
+#: gitk:2098
 msgid "&Preferences"
 msgstr "&Настройки"
 
-#: gitk:2093
+#: gitk:2097
 msgid "&Edit"
 msgstr "&Редактиране"
 
-#: gitk:2098
+#: gitk:2102
 msgid "&New view..."
 msgstr "&Нов изглед…"
 
-#: gitk:2099
+#: gitk:2103
 msgid "&Edit view..."
 msgstr "&Редактиране на изгледа…"
 
-#: gitk:2100
+#: gitk:2104
 msgid "&Delete view"
 msgstr "&Изтриване на изгледа"
 
-#: gitk:2102
+#: gitk:2106
 msgid "&All files"
 msgstr "&Всички файлове"
 
-#: gitk:2097
+#: gitk:2101
 msgid "&View"
 msgstr "&Изглед"
 
-#: gitk:2107 gitk:2117
+#: gitk:2111 gitk:2121
 msgid "&About gitk"
 msgstr "&Относно gitk"
 
-#: gitk:2108 gitk:2122
+#: gitk:2112 gitk:2126
 msgid "&Key bindings"
 msgstr "&Клавишни комбинации"
 
-#: gitk:2106 gitk:2121
+#: gitk:2110 gitk:2125
 msgid "&Help"
 msgstr "Помо&щ"
 
-#: gitk:2199 gitk:8671
+#: gitk:2203 gitk:8681
 msgid "SHA1 ID:"
 msgstr "SHA1:"
 
-#: gitk:2243
+#: gitk:2247
 msgid "Row"
 msgstr "Ред"
 
-#: gitk:2281
+#: gitk:2285
 msgid "Find"
 msgstr "Търсене"
 
-#: gitk:2309
+#: gitk:2313
 msgid "commit"
 msgstr "подаване"
 
-#: gitk:2313 gitk:2315 gitk:4706 gitk:4729 gitk:4753 gitk:6774 gitk:6846
-#: gitk:6931
+#: gitk:2317 gitk:2319 gitk:4711 gitk:4734 gitk:4758 gitk:6779 gitk:6851
+#: gitk:6936
 msgid "containing:"
 msgstr "съдържащо:"
 
-#: gitk:2316 gitk:3545 gitk:3550 gitk:4782
+#: gitk:2320 gitk:3550 gitk:3555 gitk:4787
 msgid "touching paths:"
-msgstr "засягащо пътищата:"
+msgstr "в пътищата:"
 
-#: gitk:2317 gitk:4796
+#: gitk:2321 gitk:4801
 msgid "adding/removing string:"
 msgstr "добавящо/премахващо низ"
 
-#: gitk:2318 gitk:4798
+#: gitk:2322 gitk:4803
 msgid "changing lines matching:"
 msgstr "променящо редове напасващи:"
 
-#: gitk:2327 gitk:2329 gitk:4785
+#: gitk:2331 gitk:2333 gitk:4790
 msgid "Exact"
 msgstr "Точно"
 
-#: gitk:2329 gitk:4873 gitk:6742
+#: gitk:2333 gitk:4878 gitk:6747
 msgid "IgnCase"
 msgstr "Без регистър"
 
-#: gitk:2329 gitk:4755 gitk:4871 gitk:6738
+#: gitk:2333 gitk:4760 gitk:4876 gitk:6743
 msgid "Regexp"
 msgstr "Рег. израз"
 
-#: gitk:2331 gitk:2332 gitk:4893 gitk:4923 gitk:4930 gitk:6867 gitk:6935
+#: gitk:2335 gitk:2336 gitk:4898 gitk:4928 gitk:4935 gitk:6872 gitk:6940
 msgid "All fields"
 msgstr "Всички полета"
 
-#: gitk:2332 gitk:4890 gitk:4923 gitk:6805
+#: gitk:2336 gitk:4895 gitk:4928 gitk:6810
 msgid "Headline"
 msgstr "Първи ред"
 
-#: gitk:2333 gitk:4890 gitk:6805 gitk:6935 gitk:7408
+#: gitk:2337 gitk:4895 gitk:6810 gitk:6940 gitk:7413
 msgid "Comments"
 msgstr "Коментари"
 
-#: gitk:2333 gitk:4890 gitk:4895 gitk:4930 gitk:6805 gitk:7343 gitk:8849
-#: gitk:8864
+#: gitk:2337 gitk:4895 gitk:4900 gitk:4935 gitk:6810 gitk:7348 gitk:8859
+#: gitk:8874
 msgid "Author"
 msgstr "Автор"
 
-#: gitk:2333 gitk:4890 gitk:6805 gitk:7345
+#: gitk:2337 gitk:4895 gitk:6810 gitk:7350
 msgid "Committer"
 msgstr "Подаващ"
 
-#: gitk:2367
+#: gitk:2371
 msgid "Search"
 msgstr "Търсене"
 
-#: gitk:2375
+#: gitk:2379
 msgid "Diff"
 msgstr "Разлики"
 
-#: gitk:2377
+#: gitk:2381
 msgid "Old version"
 msgstr "Стара версия"
 
-#: gitk:2379
+#: gitk:2383
 msgid "New version"
 msgstr "Нова версия"
 
-#: gitk:2382
+#: gitk:2386
 msgid "Lines of context"
 msgstr "Контекст в редове"
 
-#: gitk:2392
+#: gitk:2396
 msgid "Ignore space change"
 msgstr "Празните знаци без значение"
 
-#: gitk:2396 gitk:2398 gitk:7978 gitk:8225
+#: gitk:2400 gitk:2402 gitk:7983 gitk:8235
 msgid "Line diff"
 msgstr "Поредови разлики"
 
-#: gitk:2463
+#: gitk:2467
 msgid "Patch"
 msgstr "Кръпка"
 
-#: gitk:2465
+#: gitk:2469
 msgid "Tree"
 msgstr "Дърво"
 
-#: gitk:2635 gitk:2656
+#: gitk:2639 gitk:2660
 msgid "Diff this -> selected"
 msgstr "Разлики между това и избраното"
 
-#: gitk:2636 gitk:2657
+#: gitk:2640 gitk:2661
 msgid "Diff selected -> this"
 msgstr "Разлики между избраното и това"
 
-#: gitk:2637 gitk:2658
+#: gitk:2641 gitk:2662
 msgid "Make patch"
 msgstr "Създаване на кръпка"
 
-#: gitk:2638 gitk:9273
+#: gitk:2642 gitk:9283
 msgid "Create tag"
 msgstr "Създаване на етикет"
 
-#: gitk:2639
+#: gitk:2643
 msgid "Copy commit summary"
 msgstr "Копиране на информацията за подаване"
 
-#: gitk:2640 gitk:9404
+#: gitk:2644 gitk:9414
 msgid "Write commit to file"
 msgstr "Запазване на подаването във файл"
 
-#: gitk:2641 gitk:9461
+#: gitk:2645
 msgid "Create new branch"
 msgstr "Създаване на нов клон"
 
-#: gitk:2642
+#: gitk:2646
 msgid "Cherry-pick this commit"
 msgstr "Отбиране на това подаване"
 
-#: gitk:2643
+#: gitk:2647
 msgid "Reset HEAD branch to here"
 msgstr "Привеждане на върха на клона към текущото подаване"
 
-#: gitk:2644
+#: gitk:2648
 msgid "Mark this commit"
 msgstr "Отбелязване на това подаване"
 
-#: gitk:2645
+#: gitk:2649
 msgid "Return to mark"
 msgstr "Връщане към отбелязаното подаване"
 
-#: gitk:2646
+#: gitk:2650
 msgid "Find descendant of this and mark"
 msgstr "Откриване и отбелязване на наследниците"
 
-#: gitk:2647
+#: gitk:2651
 msgid "Compare with marked commit"
 msgstr "Сравнение с отбелязаното подаване"
 
-#: gitk:2648 gitk:2659
+#: gitk:2652 gitk:2663
 msgid "Diff this -> marked commit"
 msgstr "Разлики между това и отбелязаното"
 
-#: gitk:2649 gitk:2660
+#: gitk:2653 gitk:2664
 msgid "Diff marked commit -> this"
 msgstr "Разлики между отбелязаното и това"
 
-#: gitk:2650
+#: gitk:2654
 msgid "Revert this commit"
 msgstr "Отмяна на това подаване"
 
-#: gitk:2666
+#: gitk:2670
 msgid "Check out this branch"
 msgstr "Изтегляне на този клон"
 
-#: gitk:2667
+#: gitk:2671
+msgid "Rename this branch"
+msgstr "Преименуване на този клон"
+
+#: gitk:2672
 msgid "Remove this branch"
 msgstr "Изтриване на този клон"
 
-#: gitk:2668
+#: gitk:2673
 msgid "Copy branch name"
 msgstr "Копиране на името на клона"
 
-#: gitk:2675
+#: gitk:2680
 msgid "Highlight this too"
 msgstr "Отбелязване и на това"
 
-#: gitk:2676
+#: gitk:2681
 msgid "Highlight this only"
 msgstr "Отбелязване само на това"
 
-#: gitk:2677
+#: gitk:2682
 msgid "External diff"
 msgstr "Външна програма за разлики"
 
-#: gitk:2678
+#: gitk:2683
 msgid "Blame parent commit"
 msgstr "Анотиране на родителското подаване"
 
-#: gitk:2679
+#: gitk:2684
 msgid "Copy path"
 msgstr "Копиране на пътя"
 
-#: gitk:2686
+#: gitk:2691
 msgid "Show origin of this line"
 msgstr "Показване на произхода на този ред"
 
-#: gitk:2687
+#: gitk:2692
 msgid "Run git gui blame on this line"
 msgstr "Изпълнение на „git gui blame“ върху този ред"
 
-#: gitk:3031
+#: gitk:3036
 msgid "About gitk"
 msgstr "Относно gitk"
 
-#: gitk:3033
+#: gitk:3038
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -382,324 +386,324 @@ msgstr ""
 "\n"
 "Използвайте и разпространявайте при условията на ОПЛ на ГНУ"
 
-#: gitk:3041 gitk:3108 gitk:9890
+#: gitk:3046 gitk:3113 gitk:10004
 msgid "Close"
 msgstr "Затваряне"
 
-#: gitk:3062
+#: gitk:3067
 msgid "Gitk key bindings"
 msgstr "Клавишни комбинации"
 
-#: gitk:3065
+#: gitk:3070
 msgid "Gitk key bindings:"
 msgstr "Клавишни комбинации:"
 
-#: gitk:3067
+#: gitk:3072
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tСпиране на програмата"
 
-#: gitk:3068
+#: gitk:3073
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-W>\t\tЗатваряне на прозореца"
 
-#: gitk:3069
+#: gitk:3074
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tКъм първото подаване"
 
-#: gitk:3070
+#: gitk:3075
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tКъм последното подаване"
 
-#: gitk:3071
+#: gitk:3076
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Up>, p, k\tЕдно подаване нагоре"
 
-#: gitk:3072
+#: gitk:3077
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Down>, n, j\tЕдно подаване надолу"
 
-#: gitk:3073
+#: gitk:3078
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Left>, z, h\tНазад в историята"
 
-#: gitk:3074
+#: gitk:3079
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\tНапред в историята"
 
-#: gitk:3075
+#: gitk:3080
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\tКъм n-тия родител на текущото подаване в историята"
 
-#: gitk:3076
+#: gitk:3081
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tСтраница нагоре в списъка с подаванията"
 
-#: gitk:3077
+#: gitk:3082
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tСтраница надолу в списъка с подаванията"
 
-#: gitk:3078
+#: gitk:3083
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tКъм началото на списъка с подаванията"
 
-#: gitk:3079
+#: gitk:3084
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tКъм края на списъка с подаванията"
 
-#: gitk:3080
+#: gitk:3085
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\tРед нагоре в списъка с подавания"
 
-#: gitk:3081
+#: gitk:3086
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\tРед надолу в списъка с подавания"
 
-#: gitk:3082
+#: gitk:3087
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tСтраница нагоре в списъка с подавания"
 
-#: gitk:3083
+#: gitk:3088
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tСтраница надолу в списъка с подавания"
 
-#: gitk:3084
+#: gitk:3089
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\tТърсене назад (визуално нагоре, исторически — последващи)"
 
-#: gitk:3085
+#: gitk:3090
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr ""
 "<Shift-Down>\tТърсене напред (визуално надолу, исторически — предхождащи)"
 
-#: gitk:3086
+#: gitk:3091
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tСтраница нагоре в изгледа за разлики"
 
-#: gitk:3087
+#: gitk:3092
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\tСтраница надолу в изгледа за разлики"
 
-#: gitk:3088
+#: gitk:3093
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Space>\t\tСтраница надолу в изгледа за разлики"
 
-#: gitk:3089
+#: gitk:3094
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\t18 реда нагоре в изгледа за разлики"
 
-#: gitk:3090
+#: gitk:3095
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\t18 реда надолу в изгледа за разлики"
 
-#: gitk:3091
+#: gitk:3096
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tТърсене"
 
-#: gitk:3092
+#: gitk:3097
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tКъм следващата поява"
 
-#: gitk:3093
+#: gitk:3098
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\tКъм следващата поява"
 
-#: gitk:3094
+#: gitk:3099
 msgid "g\t\tGo to commit"
 msgstr "g\t\tКъм последното подаване"
 
-#: gitk:3095
+#: gitk:3100
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tФокус върху полето за търсене"
 
-#: gitk:3096
+#: gitk:3101
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tКъм предишната поява"
 
-#: gitk:3097
+#: gitk:3102
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tСледващ файл в изгледа за разлики"
 
-#: gitk:3098
+#: gitk:3103
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tТърсене на следващата поява в изгледа за разлики"
 
-#: gitk:3099
+#: gitk:3104
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tТърсене на предишната поява в изгледа за разлики"
 
-#: gitk:3100
+#: gitk:3105
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\tПо-голям размер на шрифта"
 
-#: gitk:3101
+#: gitk:3106
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tПо-голям размер на шрифта"
 
-#: gitk:3102
+#: gitk:3107
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\tПо-малък размер на шрифта"
 
-#: gitk:3103
+#: gitk:3108
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tПо-малък размер на шрифта"
 
-#: gitk:3104
+#: gitk:3109
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tОбновяване"
 
-#: gitk:3569 gitk:3578
+#: gitk:3574 gitk:3583
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Грешка при създаването на временната директория „%s“:"
 
-#: gitk:3591
+#: gitk:3596
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Грешка при получаването на „%s“ от %s:"
 
-#: gitk:3654
+#: gitk:3659
 msgid "command failed:"
 msgstr "неуспешно изпълнение на команда:"
 
-#: gitk:3803
+#: gitk:3808
 msgid "No such commit"
 msgstr "Такова подаване няма"
 
-#: gitk:3817
+#: gitk:3822
 msgid "git gui blame: command failed:"
 msgstr "„git gui blame“: неуспешно изпълнение на команда:"
 
-#: gitk:3848
+#: gitk:3853
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Върхът за сливане не може да бъде прочетен: %s"
 
-#: gitk:3856
+#: gitk:3861
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Грешка при прочитане на индекса: %s"
 
-#: gitk:3881
+#: gitk:3886
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "Командата „git blame“ не може да бъде стартирана: %s"
 
-#: gitk:3884 gitk:6773
+#: gitk:3889 gitk:6778
 msgid "Searching"
 msgstr "Търсене"
 
-#: gitk:3916
+#: gitk:3921
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Грешка при изпълнението на „git blame“: %s"
 
-#: gitk:3944
+#: gitk:3949
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "Този ред идва от подаването %s, което не е в изгледа"
 
-#: gitk:3958
+#: gitk:3963
 msgid "External diff viewer failed:"
 msgstr "Неуспешно изпълнение на външната програма за разлики:"
 
-#: gitk:4062
+#: gitk:4067
 msgid "All files"
 msgstr "Всички файлове"
 
-#: gitk:4086
+#: gitk:4091
 msgid "View"
 msgstr "Изглед"
 
-#: gitk:4089
+#: gitk:4094
 msgid "Gitk view definition"
 msgstr "Дефиниция на изглед в Gitk"
 
-#: gitk:4093
+#: gitk:4098
 msgid "Remember this view"
 msgstr "Запазване на този изглед"
 
-#: gitk:4094
+#: gitk:4099
 msgid "References (space separated list):"
 msgstr "Указатели (списък с разделител интервал):"
 
-#: gitk:4095
+#: gitk:4100
 msgid "Branches & tags:"
 msgstr "Клони и етикети:"
 
-#: gitk:4096
+#: gitk:4101
 msgid "All refs"
 msgstr "Всички указатели"
 
-#: gitk:4097
+#: gitk:4102
 msgid "All (local) branches"
 msgstr "Всички (локални) клони"
 
-#: gitk:4098
+#: gitk:4103
 msgid "All tags"
 msgstr "Всички етикети"
 
-#: gitk:4099
+#: gitk:4104
 msgid "All remote-tracking branches"
 msgstr "Всички следящи клони"
 
-#: gitk:4100
+#: gitk:4105
 msgid "Commit Info (regular expressions):"
 msgstr "Информация за подаване (рег. изр.):"
 
-#: gitk:4101
+#: gitk:4106
 msgid "Author:"
 msgstr "Автор:"
 
-#: gitk:4102
+#: gitk:4107
 msgid "Committer:"
 msgstr "Подал:"
 
-#: gitk:4103
+#: gitk:4108
 msgid "Commit Message:"
 msgstr "Съобщение при подаване:"
 
-#: gitk:4104
+#: gitk:4109
 msgid "Matches all Commit Info criteria"
 msgstr "Съвпадение по всички характеристики на подаването"
 
-#: gitk:4105
+#: gitk:4110
 msgid "Matches no Commit Info criteria"
 msgstr "Не съвпада по никоя от характеристиките на подаването"
 
-#: gitk:4106
+#: gitk:4111
 msgid "Changes to Files:"
 msgstr "Промени по файловете:"
 
-#: gitk:4107
+#: gitk:4112
 msgid "Fixed String"
 msgstr "Дословен низ"
 
-#: gitk:4108
+#: gitk:4113
 msgid "Regular Expression"
 msgstr "Регулярен израз"
 
-#: gitk:4109
+#: gitk:4114
 msgid "Search string:"
 msgstr "Низ за търсене:"
 
-#: gitk:4110
+#: gitk:4115
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
@@ -707,204 +711,204 @@ msgstr ""
 "Дата на подаване („2 weeks ago“ (преди 2 седмици), „2009-03-17 15:27:38“, "
 "„March 17, 2009 15:27:38“):"
 
-#: gitk:4111
+#: gitk:4116
 msgid "Since:"
 msgstr "От:"
 
-#: gitk:4112
+#: gitk:4117
 msgid "Until:"
 msgstr "До:"
 
-#: gitk:4113
+#: gitk:4118
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr ""
 "Ограничаване и/или прескачане на определен брой версии (неотрицателно цяло "
 "число):"
 
-#: gitk:4114
+#: gitk:4119
 msgid "Number to show:"
 msgstr "Брой показани:"
 
-#: gitk:4115
+#: gitk:4120
 msgid "Number to skip:"
 msgstr "Брой прескочени:"
 
-#: gitk:4116
+#: gitk:4121
 msgid "Miscellaneous options:"
 msgstr "Разни:"
 
-#: gitk:4117
+#: gitk:4122
 msgid "Strictly sort by date"
 msgstr "Подреждане по дата"
 
-#: gitk:4118
+#: gitk:4123
 msgid "Mark branch sides"
 msgstr "Отбелязване на страните по клона"
 
-#: gitk:4119
+#: gitk:4124
 msgid "Limit to first parent"
 msgstr "Само първия родител"
 
-#: gitk:4120
+#: gitk:4125
 msgid "Simple history"
 msgstr "Опростена история"
 
-#: gitk:4121
+#: gitk:4126
 msgid "Additional arguments to git log:"
 msgstr "Допълнителни аргументи към „git log“:"
 
-#: gitk:4122
+#: gitk:4127
 msgid "Enter files and directories to include, one per line:"
 msgstr "Въведете файловете и директориите за включване, по елемент на ред"
 
-#: gitk:4123
+#: gitk:4128
 msgid "Command to generate more commits to include:"
 msgstr ""
 "Команда за генерирането на допълнителни подавания, които да бъдат включени:"
 
-#: gitk:4247
+#: gitk:4252
 msgid "Gitk: edit view"
 msgstr "Gitk: редактиране на изглед"
 
-#: gitk:4255
+#: gitk:4260
 msgid "-- criteria for selecting revisions"
 msgstr "— критерии за избор на версии"
 
-#: gitk:4260
+#: gitk:4265
 msgid "View Name"
 msgstr "Име на изглед"
 
-#: gitk:4335
+#: gitk:4340
 msgid "Apply (F5)"
 msgstr "Прилагане (F5)"
 
-#: gitk:4373
+#: gitk:4378
 msgid "Error in commit selection arguments:"
 msgstr "Грешка в аргументите за избор на подавания:"
 
-#: gitk:4428 gitk:4481 gitk:4943 gitk:4957 gitk:6227 gitk:12410 gitk:12411
+#: gitk:4433 gitk:4486 gitk:4948 gitk:4962 gitk:6232 gitk:12524 gitk:12525
 msgid "None"
 msgstr "Няма"
 
-#: gitk:5040 gitk:5045
+#: gitk:5045 gitk:5050
 msgid "Descendant"
 msgstr "Наследник"
 
-#: gitk:5041
+#: gitk:5046
 msgid "Not descendant"
 msgstr "Не е наследник"
 
-#: gitk:5048 gitk:5053
+#: gitk:5053 gitk:5058
 msgid "Ancestor"
 msgstr "Предшественик"
 
-#: gitk:5049
+#: gitk:5054
 msgid "Not ancestor"
 msgstr "Не е предшественик"
 
-#: gitk:5343
+#: gitk:5348
 msgid "Local changes checked in to index but not committed"
 msgstr "Локални промени добавени към индекса, но неподадени"
 
-#: gitk:5379
+#: gitk:5384
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Локални промени извън индекса"
 
-#: gitk:7153
+#: gitk:7158
 msgid "and many more"
 msgstr "и още много"
 
-#: gitk:7156
+#: gitk:7161
 msgid "many"
 msgstr "много"
 
-#: gitk:7347
+#: gitk:7352
 msgid "Tags:"
 msgstr "Етикети:"
 
-#: gitk:7364 gitk:7370 gitk:8844
+#: gitk:7369 gitk:7375 gitk:8854
 msgid "Parent"
 msgstr "Родител"
 
-#: gitk:7375
+#: gitk:7380
 msgid "Child"
 msgstr "Дете"
 
-#: gitk:7384
+#: gitk:7389
 msgid "Branch"
 msgstr "Клон"
 
-#: gitk:7387
+#: gitk:7392
 msgid "Follows"
 msgstr "Следва"
 
-#: gitk:7390
+#: gitk:7395
 msgid "Precedes"
 msgstr "Предшества"
 
-#: gitk:7985
+#: gitk:7990
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Грешка при получаването на разликите: %s"
 
-#: gitk:8669
+#: gitk:8679
 msgid "Goto:"
 msgstr "Към ред:"
 
-#: gitk:8690
+#: gitk:8700
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Съкратената сума по SHA1 %s не е еднозначна"
 
-#: gitk:8697
+#: gitk:8707
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Непозната версия %s"
 
-#: gitk:8707
+#: gitk:8717
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "Непозната сума по SHA1 %s"
 
-#: gitk:8709
+#: gitk:8719
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Версия %s не е в текущия изглед"
 
-#: gitk:8851 gitk:8866
+#: gitk:8861 gitk:8876
 msgid "Date"
 msgstr "Дата"
 
-#: gitk:8854
+#: gitk:8864
 msgid "Children"
 msgstr "Деца"
 
-#: gitk:8917
+#: gitk:8927
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Зануляване на клона „%s“ към текущото подаване"
 
-#: gitk:8919
+#: gitk:8929
 msgid "Detached head: can't reset"
 msgstr "Несвързан връх: невъзможно зануляване"
 
-#: gitk:9024 gitk:9030
+#: gitk:9034 gitk:9040
 msgid "Skipping merge commit "
 msgstr "Пропускане на подаването на сливането"
 
-#: gitk:9039 gitk:9044
+#: gitk:9049 gitk:9054
 msgid "Error getting patch ID for "
 msgstr "Грешка при получаването на идентификатора на "
 
-#: gitk:9040 gitk:9045
+#: gitk:9050 gitk:9055
 msgid " - stopping\n"
 msgstr " — спиране\n"
 
-#: gitk:9050 gitk:9053 gitk:9061 gitk:9075 gitk:9084
+#: gitk:9060 gitk:9063 gitk:9071 gitk:9085 gitk:9094
 msgid "Commit "
 msgstr "Подаване"
 
-#: gitk:9054
+#: gitk:9064
 msgid ""
 " is the same patch as\n"
 "       "
@@ -912,7 +916,7 @@ msgstr ""
 " е същата кръпка като\n"
 "       "
 
-#: gitk:9062
+#: gitk:9072
 msgid ""
 " differs from\n"
 "       "
@@ -920,7 +924,7 @@ msgstr ""
 " се различава от\n"
 "       "
 
-#: gitk:9064
+#: gitk:9074
 msgid ""
 "Diff of commits:\n"
 "\n"
@@ -928,130 +932,147 @@ msgstr ""
 "Разлика между подаванията:\n"
 "\n"
 
-#: gitk:9076 gitk:9085
+#: gitk:9086 gitk:9095
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " има %s деца — спиране\n"
 
-#: gitk:9104
+#: gitk:9114
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Грешка при запазването на подаването във файл: %s"
 
-#: gitk:9110
+#: gitk:9120
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Грешка при изчисляването на разликите между подаванията: %s"
 
-#: gitk:9156
+#: gitk:9166
 msgid "Top"
 msgstr "Най-горе"
 
-#: gitk:9157
+#: gitk:9167
 msgid "From"
 msgstr "От"
 
-#: gitk:9162
+#: gitk:9172
 msgid "To"
 msgstr "До"
 
-#: gitk:9186
+#: gitk:9196
 msgid "Generate patch"
 msgstr "Генериране на кръпка"
 
-#: gitk:9188
+#: gitk:9198
 msgid "From:"
 msgstr "От:"
 
-#: gitk:9197
+#: gitk:9207
 msgid "To:"
 msgstr "До:"
 
-#: gitk:9206
+#: gitk:9216
 msgid "Reverse"
 msgstr "Обръщане"
 
-#: gitk:9208 gitk:9418
+#: gitk:9218 gitk:9428
 msgid "Output file:"
 msgstr "Запазване във файла:"
 
-#: gitk:9214
+#: gitk:9224
 msgid "Generate"
 msgstr "Генериране"
 
-#: gitk:9252
+#: gitk:9262
 msgid "Error creating patch:"
 msgstr "Грешка при създаването на кръпка:"
 
-#: gitk:9275 gitk:9406 gitk:9463
+#: gitk:9285 gitk:9416 gitk:9504
 msgid "ID:"
 msgstr "Идентификатор:"
 
-#: gitk:9284
+#: gitk:9294
 msgid "Tag name:"
 msgstr "Име на етикет:"
 
-#: gitk:9287
+#: gitk:9297
 msgid "Tag message is optional"
 msgstr "Съобщението за етикет е незадължително"
 
-#: gitk:9289
+#: gitk:9299
 msgid "Tag message:"
 msgstr "Съобщение за етикет:"
 
-#: gitk:9293 gitk:9472
+#: gitk:9303 gitk:9474
 msgid "Create"
 msgstr "Създаване"
 
-#: gitk:9311
+#: gitk:9321
 msgid "No tag name specified"
 msgstr "Липсва име на етикет"
 
-#: gitk:9315
+#: gitk:9325
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Етикетът „%s“ вече съществува"
 
-#: gitk:9325
+#: gitk:9335
 msgid "Error creating tag:"
 msgstr "Грешка при създаването на етикет:"
 
-#: gitk:9415
+#: gitk:9425
 msgid "Command:"
 msgstr "Команда:"
 
-#: gitk:9423
+#: gitk:9433
 msgid "Write"
 msgstr "Запазване"
 
-#: gitk:9441
+#: gitk:9451
 msgid "Error writing commit:"
 msgstr "Грешка при запазването на подаването:"
 
-#: gitk:9468
+#: gitk:9473
+msgid "Create branch"
+msgstr "Създаване на клон"
+
+#: gitk:9489
+#, tcl-format
+msgid "Rename branch %s"
+msgstr "Преименуване на клона „%s“"
+
+#: gitk:9490
+msgid "Rename"
+msgstr "Преименуване"
+
+#: gitk:9514
 msgid "Name:"
 msgstr "Име:"
 
-#: gitk:9491
+#: gitk:9538
 msgid "Please specify a name for the new branch"
 msgstr "Укажете име за новия клон"
 
-#: gitk:9496
+#: gitk:9543
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Клонът „%s“ вече съществува. Да бъде ли презаписан?"
 
-#: gitk:9563
+#: gitk:9587
+msgid "Please specify a new name for the branch"
+msgstr "Укажете ново име за клона"
+
+#: gitk:9650
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
 "Подаването „%s“ вече е включено в клона „%s“ — да бъде ли приложено отново?"
 
-#: gitk:9568
+#: gitk:9655
 msgid "Cherry-picking"
 msgstr "Отбиране"
 
-#: gitk:9577
+#: gitk:9664
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1060,7 +1081,7 @@ msgstr ""
 "Неуспешно отбиране, защото във файла „%s“ има локални промени.\n"
 "Подайте, занулете или ги скатайте и пробвайте отново."
 
-#: gitk:9583
+#: gitk:9670
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1068,29 +1089,29 @@ msgstr ""
 "Неуспешно отбиране поради конфликти при сливане.\n"
 "Искате ли да ги коригирате чрез „git citool“?"
 
-#: gitk:9599 gitk:9657
+#: gitk:9686 gitk:9744
 msgid "No changes committed"
 msgstr "Не са подадени промени"
 
-#: gitk:9626
+#: gitk:9713
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
 msgstr "Подаването „%s“ не е включено в клона „%s“. Да бъде ли отменено?"
 
-#: gitk:9631
+#: gitk:9718
 msgid "Reverting"
 msgstr "Отмяна"
 
-#: gitk:9639
+#: gitk:9726
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Please "
 "commit, reset or stash  your changes and try again."
 msgstr ""
 "Неуспешна отмяна, защото във файла „%s“ има локални промени.\n"
-"Подайте, занулете или ги скатайте и пробвайте отново.<"
+"Подайте, занулете или ги скатайте и пробвайте отново."
 
-#: gitk:9643
+#: gitk:9730
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1098,66 +1119,71 @@ msgstr ""
 "Неуспешно отмяна поради конфликти при сливане.\n"
 "Искате ли да ги коригирате чрез „git citool“?"
 
-#: gitk:9686
+#: gitk:9773
 msgid "Confirm reset"
 msgstr "Потвърждаване на зануляването"
 
-#: gitk:9688
+#: gitk:9775
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Да се занули ли клонът „%s“ към „%s“?"
 
-#: gitk:9690
+#: gitk:9777
 msgid "Reset type:"
 msgstr "Вид зануляване:"
 
-#: gitk:9693
+#: gitk:9780
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Слабо: работното дърво и индекса остават същите"
 
-#: gitk:9696
+#: gitk:9783
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Смесено: работното дърво остава същото, индексът се занулява"
 
-#: gitk:9699
+#: gitk:9786
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
 msgstr ""
 "Силно: зануляване и на работното дърво, и на индекса\n"
-"(*ВСИЧКИ* локални промени ще бъдат безвъзвратно загубени)"
+"(ВСИЧКИ локални промени ще бъдат безвъзвратно загубени)"
 
-#: gitk:9716
+#: gitk:9803
 msgid "Resetting"
 msgstr "Зануляване"
 
-#: gitk:9776
+#: gitk:9876
+#, tcl-format
+msgid "A local branch named %s exists already"
+msgstr "Вече съществува локален клон „%s“."
+
+#: gitk:9884
 msgid "Checking out"
 msgstr "Изтегляне"
 
-#: gitk:9829
+#: gitk:9943
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Текущо изтегленият клон не може да бъде изтрит"
 
-#: gitk:9835
+#: gitk:9949
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
 "Really delete branch %s?"
 msgstr ""
 "Подаванията на клона „%s“ не са на никой друг клон.\n"
-"Наистина ли да се изтрие клонът „%s“?"
+"Наистина ли искате да изтриете клона „%s“?"
 
-#: gitk:9866
+#: gitk:9980
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Етикети и върхове: %s"
 
-#: gitk:9883
+#: gitk:9997
 msgid "Filter"
 msgstr "Филтриране"
 
-#: gitk:10179
+#: gitk:10293
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
@@ -1165,201 +1191,201 @@ msgstr ""
 "Грешка при прочитането на топологията на подаванията. Информацията за клона "
 "и предшестващите/следващите етикети ще е непълна."
 
-#: gitk:11156
+#: gitk:11270
 msgid "Tag"
 msgstr "Етикет"
 
-#: gitk:11160
+#: gitk:11274
 msgid "Id"
 msgstr "Идентификатор"
 
-#: gitk:11243
+#: gitk:11357
 msgid "Gitk font chooser"
 msgstr "Избор на шрифт за Gitk"
 
-#: gitk:11260
+#: gitk:11374
 msgid "B"
 msgstr "Ч"
 
-#: gitk:11263
+#: gitk:11377
 msgid "I"
 msgstr "К"
 
-#: gitk:11381
+#: gitk:11495
 msgid "Commit list display options"
 msgstr "Настройки на списъка с подавания"
 
-#: gitk:11384
+#: gitk:11498
 msgid "Maximum graph width (lines)"
 msgstr "Максимална широчина на графа (в редове)"
 
-#: gitk:11388
+#: gitk:11502
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Максимална широчина на графа (% от панела)"
 
-#: gitk:11391
+#: gitk:11505
 msgid "Show local changes"
 msgstr "Показване на локалните промени"
 
-#: gitk:11394
+#: gitk:11508
 msgid "Auto-select SHA1 (length)"
 msgstr "Автоматично избиране на SHA1 (дължина)"
 
-#: gitk:11398
+#: gitk:11512
 msgid "Hide remote refs"
 msgstr "Скриване на отдалечените указатели"
 
-#: gitk:11402
+#: gitk:11516
 msgid "Diff display options"
 msgstr "Настройки на показването на разликите"
 
-#: gitk:11404
+#: gitk:11518
 msgid "Tab spacing"
 msgstr "Широчина на табулатора"
 
-#: gitk:11407
+#: gitk:11521
 msgid "Display nearby tags/heads"
 msgstr "Извеждане на близките етикети и върхове"
 
-#: gitk:11410
+#: gitk:11524
 msgid "Maximum # tags/heads to show"
 msgstr "Максимален брой етикети/върхове за показване"
 
-#: gitk:11413
+#: gitk:11527
 msgid "Limit diffs to listed paths"
 msgstr "Разлика само в избраните пътища"
 
-#: gitk:11416
+#: gitk:11530
 msgid "Support per-file encodings"
 msgstr "Поддръжка на различни кодирания за всеки файл"
 
-#: gitk:11422 gitk:11569
+#: gitk:11536 gitk:11683
 msgid "External diff tool"
 msgstr "Външен инструмент за разлики"
 
-#: gitk:11423
+#: gitk:11537
 msgid "Choose..."
 msgstr "Избор…"
 
-#: gitk:11428
+#: gitk:11542
 msgid "General options"
 msgstr "Общи настройки"
 
-#: gitk:11431
+#: gitk:11545
 msgid "Use themed widgets"
 msgstr "Използване на тема за графичните обекти"
 
-#: gitk:11433
+#: gitk:11547
 msgid "(change requires restart)"
 msgstr "(промяната изисква рестартиране на Gitk)"
 
-#: gitk:11435
+#: gitk:11549
 msgid "(currently unavailable)"
 msgstr "(в момента недостъпно)"
 
-#: gitk:11446
+#: gitk:11560
 msgid "Colors: press to choose"
 msgstr "Цветове: избира се с натискане"
 
-#: gitk:11449
+#: gitk:11563
 msgid "Interface"
 msgstr "Интерфейс"
 
-#: gitk:11450
+#: gitk:11564
 msgid "interface"
 msgstr "интерфейс"
 
-#: gitk:11453
+#: gitk:11567
 msgid "Background"
 msgstr "Фон"
 
-#: gitk:11454 gitk:11484
+#: gitk:11568 gitk:11598
 msgid "background"
 msgstr "фон"
 
-#: gitk:11457
+#: gitk:11571
 msgid "Foreground"
 msgstr "Знаци"
 
-#: gitk:11458
+#: gitk:11572
 msgid "foreground"
 msgstr "знаци"
 
-#: gitk:11461
+#: gitk:11575
 msgid "Diff: old lines"
 msgstr "Разлика: стари редове"
 
-#: gitk:11462
+#: gitk:11576
 msgid "diff old lines"
 msgstr "разлика, стари редове"
 
-#: gitk:11466
+#: gitk:11580
 msgid "Diff: new lines"
 msgstr "Разлика: нови редове"
 
-#: gitk:11467
+#: gitk:11581
 msgid "diff new lines"
 msgstr "разлика, нови редове"
 
-#: gitk:11471
+#: gitk:11585
 msgid "Diff: hunk header"
 msgstr "Разлика: начало на парче"
 
-#: gitk:11473
+#: gitk:11587
 msgid "diff hunk header"
 msgstr "разлика, начало на парче"
 
-#: gitk:11477
+#: gitk:11591
 msgid "Marked line bg"
 msgstr "Фон на отбелязан ред"
 
-#: gitk:11479
+#: gitk:11593
 msgid "marked line background"
 msgstr "фон на отбелязан ред"
 
-#: gitk:11483
+#: gitk:11597
 msgid "Select bg"
 msgstr "Избор на фон"
 
-#: gitk:11492
+#: gitk:11606
 msgid "Fonts: press to choose"
 msgstr "Шрифтове: избира се с натискане"
 
-#: gitk:11494
+#: gitk:11608
 msgid "Main font"
 msgstr "Основен шрифт"
 
-#: gitk:11495
+#: gitk:11609
 msgid "Diff display font"
 msgstr "Шрифт за разликите"
 
-#: gitk:11496
+#: gitk:11610
 msgid "User interface font"
 msgstr "Шрифт на интерфейса"
 
-#: gitk:11518
+#: gitk:11632
 msgid "Gitk preferences"
 msgstr "Настройки на Gitk"
 
-#: gitk:11527
+#: gitk:11641
 msgid "General"
 msgstr "Общи"
 
-#: gitk:11528
+#: gitk:11642
 msgid "Colors"
 msgstr "Цветове"
 
-#: gitk:11529
+#: gitk:11643
 msgid "Fonts"
 msgstr "Шрифтове"
 
-#: gitk:11579
+#: gitk:11693
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: избор на цвят на „%s“"
 
-#: gitk:12092
+#: gitk:12206
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -1367,15 +1393,15 @@ msgstr ""
 "Тази версия на Tcl/Tk не се поддържа от Gitk.\n"
 " Необходима ви е поне Tcl/Tk 8.4."
 
-#: gitk:12302
+#: gitk:12416
 msgid "Cannot find a git repository here."
 msgstr "Тук липсва хранилище на Git."
 
-#: gitk:12349
+#: gitk:12463
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Нееднозначен аргумент „%s“: има и такава версия, и такъв файл"
 
-#: gitk:12361
+#: gitk:12475
 msgid "Bad arguments to gitk:"
 msgstr "Неправилни аргументи на gitk:"
-- 
2.21.0

