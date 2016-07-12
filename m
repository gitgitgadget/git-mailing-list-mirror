Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2712018E
	for <e@80x24.org>; Tue, 12 Jul 2016 09:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbcGLJKx (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 05:10:53 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33972 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbcGLJKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 05:10:34 -0400
Received: by mail-lf0-f47.google.com with SMTP id h129so6914893lfh.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 02:10:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcZieWV9fdNODOS1qkjfy/9u83Lu2Eh1SK4uP7gxQIg=;
        b=G2qduvZxSK9YJgOE7psNwLnbSgH14Fq0cC3to+6o65LdYUDPI1Mq4KsNjURIhnB7oU
         aHuApLjG8xm21VqKHDBu3UL/dzbjTRtdpXJe5lxTuZOXSuViZd3dyQQWE3Kvf6QlptAR
         gN4sfZadCbDABPOMtWX5o9HEV4zIDzTluuRNemECa4ZIICDF18b/gynvl0+HsAo8EQuz
         DzjeXn9I50rjQ9RsyQvRRM+shkff3Eo1HYGsQT/XCaEVT1AvqXo4USB4W5A1n8uC4/dJ
         IWZdV3k07+HaYmYujcQ6p7nn5/gwBx9fM3EPCj6UrNzZpjmtFABWJY6Zh3EGNbPxiT8n
         qRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcZieWV9fdNODOS1qkjfy/9u83Lu2Eh1SK4uP7gxQIg=;
        b=md/GemDtY4ZinqY2Pjr8aDjbBL8tEDEz+MhxCJGN2lX46zYey6T6/FOjAme0FAS0mG
         dT5PAydlUxX8IG/Kld5VGGS21IyAevv+ewlOgY+ihS85N2Bps+2YCzfzxS/mSRioWR08
         GOAGGgo554v/H3OL6hNTsoDQoZpXRlFXDLCoAlpaX4sjntOjfy/5bINpALmqquQnnxEM
         0g/1gWMFdbRXiwhR/NJgSUMbh/EiFkIedPhL1yqLh4obZm3s9zYLWkjgYMQ+5kAPyrbW
         u2RLbkJRlI0vyeCN85NPO2k5/zWq97Itc99t6/CcL7b726TNybEvMGPYs17cfjF9XRdd
         7tUA==
X-Gm-Message-State: ALyK8tIr4BviCeWUSSPN3Bzc8QZg+3sNHqcDe+UVkC7gJbK74APgT6xGWydEcwihibDr5w==
X-Received: by 10.46.0.151 with SMTP id e23mr397733lji.57.1468314631830;
        Tue, 12 Jul 2016 02:10:31 -0700 (PDT)
Received: from Prog004.devcubestudio.com (mail.devcubestudio.com. [193.93.53.184])
        by smtp.gmail.com with ESMTPSA id g62sm5213396ljg.40.2016.07.12.02.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 02:10:30 -0700 (PDT)
From:	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To:	git@vger.kernel.org
Cc:	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Subject: [PATCH] gitk: ru.po: Update Russian translation
Date:	Tue, 12 Jul 2016 12:10:26 +0300
Message-Id: <20160712091026.30944-1-dimitriy.ryazantcev@gmail.com>
X-Mailer: git-send-email 2.9.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
---
 po/ru.po | 640 ++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 328 insertions(+), 312 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 17ed026..6a00dc2 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -3,15 +3,15 @@
 # Translators:
 # 0xAX <kuleshovmail@gmail.com>, 2014
 # Alex Riesen <raa.lkml@gmail.com>, 2015
-# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015
+# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015-2016
 # Dmitry Potapov <dpotapov@gmail.com>, 2009
 # Skip <bsvskip@rambler.ru>, 2011
 msgid ""
 msgstr ""
 "Project-Id-Version: Git Russian Localization Project\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2015-05-17 14:32+1000\n"
-"PO-Revision-Date: 2015-10-12 10:14+0000\n"
+"POT-Creation-Date: 2016-06-30 16:40+0300\n"
+"PO-Revision-Date: 2016-06-30 13:49+0000\n"
 "Last-Translator: Dimitriy Ryazantcev <DJm00n@mail.ru>\n"
 "Language-Team: Russian (http://www.transifex.com/djm00n/git-po-ru/language/ru/)\n"
 "MIME-Version: 1.0\n"
@@ -24,11 +24,11 @@ msgstr ""
 msgid "Couldn't get list of unmerged files:"
 msgstr "Невозможно получить список файлов незавершённой операции слияния:"
 
-#: gitk:212 gitk:2381
+#: gitk:212 gitk:2399
 msgid "Color words"
 msgstr "Цветные слова"
 
-#: gitk:217 gitk:2381 gitk:8220 gitk:8253
+#: gitk:217 gitk:2399 gitk:8239 gitk:8272
 msgid "Markup words"
 msgstr "Помеченые слова"
 
@@ -58,15 +58,15 @@ msgstr "Ошибка запуска git log:"
 msgid "Reading"
 msgstr "Чтение"
 
-#: gitk:496 gitk:4525
+#: gitk:496 gitk:4544
 msgid "Reading commits..."
 msgstr "Чтение коммитов..."
 
-#: gitk:499 gitk:1637 gitk:4528
+#: gitk:499 gitk:1637 gitk:4547
 msgid "No commits selected"
 msgstr "Ничего не выбрано"
 
-#: gitk:1445 gitk:4045 gitk:12432
+#: gitk:1445 gitk:4064 gitk:12469
 msgid "Command line"
 msgstr "Командная строка"
 
@@ -78,1252 +78,1268 @@ msgstr "Ошибка обработки вывода команды git log:"
 msgid "No commit information available"
 msgstr "Нет информации о коммите"
 
-#: gitk:1903 gitk:1932 gitk:4315 gitk:9669 gitk:11241 gitk:11521
+#: gitk:1903 gitk:1932 gitk:4334 gitk:9702 gitk:11274 gitk:11554
 msgid "OK"
 msgstr "Ok"
 
-#: gitk:1934 gitk:4317 gitk:9196 gitk:9275 gitk:9391 gitk:9440 gitk:9671
-#: gitk:11242 gitk:11522
+#: gitk:1934 gitk:4336 gitk:9215 gitk:9294 gitk:9424 gitk:9473 gitk:9704
+#: gitk:11275 gitk:11555
 msgid "Cancel"
 msgstr "Отмена"
 
-#: gitk:2069
+#: gitk:2083
 msgid "&Update"
 msgstr "Обновить"
 
-#: gitk:2070
+#: gitk:2084
 msgid "&Reload"
 msgstr "Перечитать"
 
-#: gitk:2071
+#: gitk:2085
 msgid "Reread re&ferences"
 msgstr "Обновить список ссылок"
 
-#: gitk:2072
+#: gitk:2086
 msgid "&List references"
 msgstr "Список ссылок"
 
-#: gitk:2074
+#: gitk:2088
 msgid "Start git &gui"
 msgstr "Запустить git gui"
 
-#: gitk:2076
+#: gitk:2090
 msgid "&Quit"
 msgstr "Завершить"
 
-#: gitk:2068
+#: gitk:2082
 msgid "&File"
 msgstr "Файл"
 
-#: gitk:2080
+#: gitk:2094
 msgid "&Preferences"
 msgstr "Настройки"
 
-#: gitk:2079
+#: gitk:2093
 msgid "&Edit"
 msgstr "Редактировать"
 
-#: gitk:2084
+#: gitk:2098
 msgid "&New view..."
 msgstr "Новое представление..."
 
-#: gitk:2085
+#: gitk:2099
 msgid "&Edit view..."
 msgstr "Редактировать представление..."
 
-#: gitk:2086
+#: gitk:2100
 msgid "&Delete view"
 msgstr "Удалить представление"
 
-#: gitk:2088 gitk:4043
+#: gitk:2102
 msgid "&All files"
 msgstr "Все файлы"
 
-#: gitk:2083 gitk:4067
+#: gitk:2097
 msgid "&View"
 msgstr "Представление"
 
-#: gitk:2093 gitk:2103 gitk:3012
+#: gitk:2107 gitk:2117
 msgid "&About gitk"
 msgstr "О gitk"
 
-#: gitk:2094 gitk:2108
+#: gitk:2108 gitk:2122
 msgid "&Key bindings"
 msgstr "Назначения клавиатуры"
 
-#: gitk:2092 gitk:2107
+#: gitk:2106 gitk:2121
 msgid "&Help"
 msgstr "Подсказка"
 
-#: gitk:2185 gitk:8652
+#: gitk:2199 gitk:8671
 msgid "SHA1 ID:"
 msgstr "SHA1 ID:"
 
-#: gitk:2229
+#: gitk:2243
 msgid "Row"
 msgstr "Строка"
 
-#: gitk:2267
+#: gitk:2281
 msgid "Find"
 msgstr "Поиск"
 
-#: gitk:2295
+#: gitk:2309
 msgid "commit"
 msgstr "коммит"
 
-#: gitk:2299 gitk:2301 gitk:4687 gitk:4710 gitk:4734 gitk:6755 gitk:6827
-#: gitk:6912
+#: gitk:2313 gitk:2315 gitk:4706 gitk:4729 gitk:4753 gitk:6774 gitk:6846
+#: gitk:6931
 msgid "containing:"
 msgstr "содержащее:"
 
-#: gitk:2302 gitk:3526 gitk:3531 gitk:4763
+#: gitk:2316 gitk:3545 gitk:3550 gitk:4782
 msgid "touching paths:"
 msgstr "касательно файлов:"
 
-#: gitk:2303 gitk:4777
+#: gitk:2317 gitk:4796
 msgid "adding/removing string:"
 msgstr "добавив/удалив строку:"
 
-#: gitk:2304 gitk:4779
+#: gitk:2318 gitk:4798
 msgid "changing lines matching:"
 msgstr "изменяя совпадающие строки:"
 
-#: gitk:2313 gitk:2315 gitk:4766
+#: gitk:2327 gitk:2329 gitk:4785
 msgid "Exact"
 msgstr "Точно"
 
-#: gitk:2315 gitk:4854 gitk:6723
+#: gitk:2329 gitk:4873 gitk:6742
 msgid "IgnCase"
 msgstr "Игнорировать большие/маленькие"
 
-#: gitk:2315 gitk:4736 gitk:4852 gitk:6719
+#: gitk:2329 gitk:4755 gitk:4871 gitk:6738
 msgid "Regexp"
 msgstr "Регулярные выражения"
 
-#: gitk:2317 gitk:2318 gitk:4874 gitk:4904 gitk:4911 gitk:6848 gitk:6916
+#: gitk:2331 gitk:2332 gitk:4893 gitk:4923 gitk:4930 gitk:6867 gitk:6935
 msgid "All fields"
 msgstr "Во всех полях"
 
-#: gitk:2318 gitk:4871 gitk:4904 gitk:6786
+#: gitk:2332 gitk:4890 gitk:4923 gitk:6805
 msgid "Headline"
 msgstr "Заголовок"
 
-#: gitk:2319 gitk:4871 gitk:6786 gitk:6916 gitk:7389
+#: gitk:2333 gitk:4890 gitk:6805 gitk:6935 gitk:7408
 msgid "Comments"
 msgstr "Комментарии"
 
-#: gitk:2319 gitk:4871 gitk:4876 gitk:4911 gitk:6786 gitk:7324 gitk:8830
-#: gitk:8845
+#: gitk:2333 gitk:4890 gitk:4895 gitk:4930 gitk:6805 gitk:7343 gitk:8849
+#: gitk:8864
 msgid "Author"
 msgstr "Автор"
 
-#: gitk:2319 gitk:4871 gitk:6786 gitk:7326
+#: gitk:2333 gitk:4890 gitk:6805 gitk:7345
 msgid "Committer"
 msgstr "Коммитер"
 
-#: gitk:2350
+#: gitk:2367
 msgid "Search"
 msgstr "Найти"
 
-#: gitk:2358
+#: gitk:2375
 msgid "Diff"
 msgstr "Сравнить"
 
-#: gitk:2360
+#: gitk:2377
 msgid "Old version"
 msgstr "Старая версия"
 
-#: gitk:2362
+#: gitk:2379
 msgid "New version"
 msgstr "Новая версия"
 
-#: gitk:2364
+#: gitk:2382
 msgid "Lines of context"
 msgstr "Строк контекста"
 
-#: gitk:2374
+#: gitk:2392
 msgid "Ignore space change"
 msgstr "Игнорировать пробелы"
 
-#: gitk:2378 gitk:2380 gitk:7959 gitk:8206
+#: gitk:2396 gitk:2398 gitk:7978 gitk:8225
 msgid "Line diff"
 msgstr "Изменения строк"
 
-#: gitk:2445
+#: gitk:2463
 msgid "Patch"
 msgstr "Патч"
 
-#: gitk:2447
+#: gitk:2465
 msgid "Tree"
 msgstr "Файлы"
 
-#: gitk:2617 gitk:2637
+#: gitk:2635 gitk:2656
 msgid "Diff this -> selected"
 msgstr "Сравнить этот коммит с выделенным"
 
-#: gitk:2618 gitk:2638
+#: gitk:2636 gitk:2657
 msgid "Diff selected -> this"
 msgstr "Сравнить выделенный с этим коммитом"
 
-#: gitk:2619 gitk:2639
+#: gitk:2637 gitk:2658
 msgid "Make patch"
 msgstr "Создать патч"
 
-#: gitk:2620 gitk:9254
+#: gitk:2638 gitk:9273
 msgid "Create tag"
 msgstr "Создать метку"
 
-#: gitk:2621 gitk:9371
+#: gitk:2639
+msgid "Copy commit summary"
+msgstr "Копировать информацию о коммите"
+
+#: gitk:2640 gitk:9404
 msgid "Write commit to file"
 msgstr "Сохранить коммит в файл"
 
-#: gitk:2622 gitk:9428
+#: gitk:2641 gitk:9461
 msgid "Create new branch"
 msgstr "Создать ветку"
 
-#: gitk:2623
+#: gitk:2642
 msgid "Cherry-pick this commit"
-msgstr "Отбор лучшего для этого коммита"
+msgstr "Копировать этот коммит в текущую ветку"
 
-#: gitk:2624
+#: gitk:2643
 msgid "Reset HEAD branch to here"
 msgstr "Установить HEAD на этот коммит"
 
-#: gitk:2625
+#: gitk:2644
 msgid "Mark this commit"
 msgstr "Пометить этот коммит"
 
-#: gitk:2626
+#: gitk:2645
 msgid "Return to mark"
 msgstr "Вернуться на пометку"
 
-#: gitk:2627
+#: gitk:2646
 msgid "Find descendant of this and mark"
 msgstr "Найти и пометить потомка этого коммита"
 
-#: gitk:2628
+#: gitk:2647
 msgid "Compare with marked commit"
 msgstr "Сравнить с помеченным коммитом"
 
-#: gitk:2629 gitk:2640
+#: gitk:2648 gitk:2659
 msgid "Diff this -> marked commit"
 msgstr "Сравнить выделенное с помеченным коммитом"
 
-#: gitk:2630 gitk:2641
+#: gitk:2649 gitk:2660
 msgid "Diff marked commit -> this"
 msgstr "Сравнить помеченный с этим коммитом"
 
-#: gitk:2631
+#: gitk:2650
 msgid "Revert this commit"
-msgstr "Возврат этого коммита"
+msgstr "Обратить изменения этого коммита"
 
-#: gitk:2647
+#: gitk:2666
 msgid "Check out this branch"
 msgstr "Перейти на эту ветку"
 
-#: gitk:2648
+#: gitk:2667
 msgid "Remove this branch"
 msgstr "Удалить эту ветку"
 
-#: gitk:2649
+#: gitk:2668
 msgid "Copy branch name"
 msgstr "Копировать имя ветки"
 
-#: gitk:2656
+#: gitk:2675
 msgid "Highlight this too"
 msgstr "Подсветить этот тоже"
 
-#: gitk:2657
+#: gitk:2676
 msgid "Highlight this only"
 msgstr "Подсветить только этот"
 
-#: gitk:2658
+#: gitk:2677
 msgid "External diff"
 msgstr "Программа сравнения"
 
-#: gitk:2659
+#: gitk:2678
 msgid "Blame parent commit"
 msgstr "Авторы изменений родительского коммита"
 
-#: gitk:2660
+#: gitk:2679
 msgid "Copy path"
 msgstr "Копировать путь"
 
-#: gitk:2667
+#: gitk:2686
 msgid "Show origin of this line"
 msgstr "Показать источник этой строки"
 
-#: gitk:2668
+#: gitk:2687
 msgid "Run git gui blame on this line"
 msgstr "Запустить git gui blame для этой строки"
 
-#: gitk:3014
+#: gitk:3031
+msgid "About gitk"
+msgstr "О gitk"
+
+#: gitk:3033
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
 "\n"
-"Copyright  2005-2014 Paul Mackerras\n"
+"Copyright © 2005-2014 Paul Mackerras\n"
 "\n"
 "Use and redistribute under the terms of the GNU General Public License"
-msgstr "\nGitk - программа просмотра истории репозиториев git\n\n©  2005-2014 Paul Mackerras\n\nИспользование и распространение согласно условиям GNU General Public License"
+msgstr "\nGitk — программа просмотра истории репозиториев git\n\n© 2005-2014 Paul Mackerras\n\nИспользование и распространение согласно условиям GNU General Public License"
 
-#: gitk:3022 gitk:3089 gitk:9857
+#: gitk:3041 gitk:3108 gitk:9890
 msgid "Close"
 msgstr "Закрыть"
 
-#: gitk:3043
+#: gitk:3062
 msgid "Gitk key bindings"
 msgstr "Назначения клавиатуры в Gitk"
 
-#: gitk:3046
+#: gitk:3065
 msgid "Gitk key bindings:"
 msgstr "Назначения клавиатуры в Gitk:"
 
-#: gitk:3048
+#: gitk:3067
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tЗавершить"
 
-#: gitk:3049
+#: gitk:3068
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-W>\t\tЗакрыть окно"
 
-#: gitk:3050
+#: gitk:3069
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tПерейти к первому коммиту"
 
-#: gitk:3051
+#: gitk:3070
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tПерейти к последнему коммиту"
 
-#: gitk:3052
+#: gitk:3071
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Up>, p, k\tПерейти на один коммит вверх"
 
-#: gitk:3053
+#: gitk:3072
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Down>, n, j\tПерейти на один коммит вниз"
 
-#: gitk:3054
+#: gitk:3073
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Left>, z, h\tПоказать ранее посещённое состояние"
 
-#: gitk:3055
+#: gitk:3074
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\tПоказать следующий посещённый коммит"
 
-#: gitk:3056
+#: gitk:3075
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\tПерейти на n родителя от текущего коммита"
 
-#: gitk:3057
+#: gitk:3076
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tПерейти на страницу выше в списке коммитов"
 
-#: gitk:3058
+#: gitk:3077
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tПерейти на страницу ниже в списке коммитов"
 
-#: gitk:3059
+#: gitk:3078
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tПерейти на начало списка коммитов"
 
-#: gitk:3060
+#: gitk:3079
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tПерейти на конец списка коммитов"
 
-#: gitk:3061
+#: gitk:3080
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\tПровернуть список коммитов вверх"
 
-#: gitk:3062
+#: gitk:3081
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\tПровернуть список коммитов вниз"
 
-#: gitk:3063
+#: gitk:3082
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tПровернуть список коммитов на страницу вверх"
 
-#: gitk:3064
+#: gitk:3083
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tПровернуть список коммитов на страницу вниз"
 
-#: gitk:3065
+#: gitk:3084
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\tПоиск в обратном порядке (вверх, среди новых коммитов)"
 
-#: gitk:3066
+#: gitk:3085
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr "<Shift-Down>\tПоиск (вниз, среди старых коммитов)"
 
-#: gitk:3067
+#: gitk:3086
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tПрокрутить список изменений на страницу выше"
 
-#: gitk:3068
+#: gitk:3087
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\tПрокрутить список изменений на страницу выше"
 
-#: gitk:3069
+#: gitk:3088
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Leertaste>\t\tПрокрутить список изменений на страницу ниже"
 
-#: gitk:3070
+#: gitk:3089
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\tПрокрутить список изменений на 18 строк вверх"
 
-#: gitk:3071
+#: gitk:3090
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\tПрокрутить список изменений на 18 строк вниз"
 
-#: gitk:3072
+#: gitk:3091
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tПоиск"
 
-#: gitk:3073
+#: gitk:3092
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tПерейти к следующему найденному коммиту"
 
-#: gitk:3074
+#: gitk:3093
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\tПерейти к следующему найденному коммиту"
 
-#: gitk:3075
+#: gitk:3094
 msgid "g\t\tGo to commit"
 msgstr "g\t\tПерейти на коммит"
 
-#: gitk:3076
+#: gitk:3095
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tПерейти к полю поиска"
 
-#: gitk:3077
+#: gitk:3096
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tПерейти к предыдущему найденному коммиту"
 
-#: gitk:3078
+#: gitk:3097
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tПрокрутить список изменений к следующему файлу"
 
-#: gitk:3079
+#: gitk:3098
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tПродолжить поиск в списке изменений"
 
-#: gitk:3080
+#: gitk:3099
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tПерейти к предыдущему найденному тексту в списке изменений"
 
-#: gitk:3081
+#: gitk:3100
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\tУвеличить размер шрифта"
 
-#: gitk:3082
+#: gitk:3101
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tУвеличить размер шрифта"
 
-#: gitk:3083
+#: gitk:3102
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\tУменьшить размер шрифта"
 
-#: gitk:3084
+#: gitk:3103
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tУменьшить размер шрифта"
 
-#: gitk:3085
+#: gitk:3104
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tОбновить"
 
-#: gitk:3550 gitk:3559
+#: gitk:3569 gitk:3578
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Ошибка создания временного каталога %s:"
 
-#: gitk:3572
+#: gitk:3591
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Ошибка получения «%s» из %s:"
 
-#: gitk:3635
+#: gitk:3654
 msgid "command failed:"
 msgstr "ошибка выполнения команды:"
 
-#: gitk:3784
+#: gitk:3803
 msgid "No such commit"
 msgstr "Коммит не найден"
 
-#: gitk:3798
+#: gitk:3817
 msgid "git gui blame: command failed:"
 msgstr "git gui blame: ошибка выполнения команды:"
 
-#: gitk:3829
+#: gitk:3848
 #, tcl-format
 msgid "Couldn't read merge head: %s"
 msgstr "Ошибка чтения MERGE_HEAD: %s"
 
-#: gitk:3837
+#: gitk:3856
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Ошибка чтения индекса: %s"
 
-#: gitk:3862
+#: gitk:3881
 #, tcl-format
 msgid "Couldn't start git blame: %s"
 msgstr "Ошибка запуска git blame: %s"
 
-#: gitk:3865 gitk:6754
+#: gitk:3884 gitk:6773
 msgid "Searching"
 msgstr "Поиск"
 
-#: gitk:3897
+#: gitk:3916
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Ошибка выполнения git blame: %s"
 
-#: gitk:3925
+#: gitk:3944
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "Эта строка принадлежит коммиту %s, который не показан в этом представлении"
 
-#: gitk:3939
+#: gitk:3958
 msgid "External diff viewer failed:"
 msgstr "Ошибка выполнения программы сравнения:"
 
-#: gitk:4070
+#: gitk:4062
+msgid "All files"
+msgstr "Все файлы"
+
+#: gitk:4086
+msgid "View"
+msgstr "Представление"
+
+#: gitk:4089
 msgid "Gitk view definition"
 msgstr "Gitk определение представлений"
 
-#: gitk:4074
+#: gitk:4093
 msgid "Remember this view"
 msgstr "Запомнить представление"
 
-#: gitk:4075
+#: gitk:4094
 msgid "References (space separated list):"
 msgstr "Ссылки (разделённые пробелом):"
 
-#: gitk:4076
+#: gitk:4095
 msgid "Branches & tags:"
 msgstr "Ветки и метки"
 
-#: gitk:4077
+#: gitk:4096
 msgid "All refs"
 msgstr "Все ссылки"
 
-#: gitk:4078
+#: gitk:4097
 msgid "All (local) branches"
 msgstr "Все (локальные) ветки"
 
-#: gitk:4079
+#: gitk:4098
 msgid "All tags"
 msgstr "Все метки"
 
-#: gitk:4080
+#: gitk:4099
 msgid "All remote-tracking branches"
 msgstr "Все внешние отслеживаемые ветки"
 
-#: gitk:4081
+#: gitk:4100
 msgid "Commit Info (regular expressions):"
 msgstr "Информация о коммите (регулярные выражения):"
 
-#: gitk:4082
+#: gitk:4101
 msgid "Author:"
 msgstr "Автор:"
 
-#: gitk:4083
+#: gitk:4102
 msgid "Committer:"
 msgstr "Коммитер:"
 
-#: gitk:4084
+#: gitk:4103
 msgid "Commit Message:"
 msgstr "Сообщение коммита:"
 
-#: gitk:4085
+#: gitk:4104
 msgid "Matches all Commit Info criteria"
 msgstr "Совпадает со всеми условиями информации о коммите"
 
-#: gitk:4086
+#: gitk:4105
 msgid "Matches no Commit Info criteria"
 msgstr "Не совпадает с условиями информации о коммите"
 
-#: gitk:4087
+#: gitk:4106
 msgid "Changes to Files:"
 msgstr "Изменения файлов:"
 
-#: gitk:4088
+#: gitk:4107
 msgid "Fixed String"
 msgstr "Обычная строка"
 
-#: gitk:4089
+#: gitk:4108
 msgid "Regular Expression"
 msgstr "Регулярное выражение:"
 
-#: gitk:4090
+#: gitk:4109
 msgid "Search string:"
 msgstr "Строка для поиска:"
 
-#: gitk:4091
+#: gitk:4110
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
 msgstr "Даты коммита («2 недели назад», «2009-03-17 15:27:38», «17 марта 2009 15:27:38»):"
 
-#: gitk:4092
+#: gitk:4111
 msgid "Since:"
 msgstr "С даты:"
 
-#: gitk:4093
+#: gitk:4112
 msgid "Until:"
 msgstr "По дату:"
 
-#: gitk:4094
+#: gitk:4113
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr "Ограничить и/или пропустить количество редакций (положительное число):"
 
-#: gitk:4095
+#: gitk:4114
 msgid "Number to show:"
 msgstr "Показать количество:"
 
-#: gitk:4096
+#: gitk:4115
 msgid "Number to skip:"
 msgstr "Пропустить количество:"
 
-#: gitk:4097
+#: gitk:4116
 msgid "Miscellaneous options:"
 msgstr "Различные опции:"
 
-#: gitk:4098
+#: gitk:4117
 msgid "Strictly sort by date"
 msgstr "Строгая сортировка по дате"
 
-#: gitk:4099
+#: gitk:4118
 msgid "Mark branch sides"
 msgstr "Отметить стороны веток"
 
-#: gitk:4100
+#: gitk:4119
 msgid "Limit to first parent"
 msgstr "Ограничить первым предком"
 
-#: gitk:4101
+#: gitk:4120
 msgid "Simple history"
 msgstr "Упрощенная история"
 
-#: gitk:4102
+#: gitk:4121
 msgid "Additional arguments to git log:"
 msgstr "Дополнительные аргументы для git log:"
 
-#: gitk:4103
+#: gitk:4122
 msgid "Enter files and directories to include, one per line:"
 msgstr "Файлы и каталоги для ограничения истории, по одному на строку:"
 
-#: gitk:4104
+#: gitk:4123
 msgid "Command to generate more commits to include:"
 msgstr "Дополнительная команда для списка коммитов:"
 
-#: gitk:4228
+#: gitk:4247
 msgid "Gitk: edit view"
 msgstr "Gitk: изменить представление"
 
-#: gitk:4236
+#: gitk:4255
 msgid "-- criteria for selecting revisions"
 msgstr "— критерий поиска редакций"
 
-#: gitk:4241
+#: gitk:4260
 msgid "View Name"
 msgstr "Имя представления"
 
-#: gitk:4316
+#: gitk:4335
 msgid "Apply (F5)"
 msgstr "Применить (F5)"
 
-#: gitk:4354
+#: gitk:4373
 msgid "Error in commit selection arguments:"
 msgstr "Ошибка в параметрах выбора коммитов:"
 
-#: gitk:4409 gitk:4462 gitk:4924 gitk:4938 gitk:6208 gitk:12373 gitk:12374
+#: gitk:4428 gitk:4481 gitk:4943 gitk:4957 gitk:6227 gitk:12410 gitk:12411
 msgid "None"
 msgstr "Ни одного"
 
-#: gitk:5021 gitk:5026
+#: gitk:5040 gitk:5045
 msgid "Descendant"
 msgstr "Порождённое"
 
-#: gitk:5022
+#: gitk:5041
 msgid "Not descendant"
 msgstr "Не порождённое"
 
-#: gitk:5029 gitk:5034
+#: gitk:5048 gitk:5053
 msgid "Ancestor"
 msgstr "Предок"
 
-#: gitk:5030
+#: gitk:5049
 msgid "Not ancestor"
 msgstr "Не предок"
 
-#: gitk:5324
+#: gitk:5343
 msgid "Local changes checked in to index but not committed"
 msgstr "Проиндексированные изменения"
 
-#: gitk:5360
+#: gitk:5379
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Непроиндексированные изменения"
 
-#: gitk:7134
+#: gitk:7153
 msgid "and many more"
 msgstr "и многое другое"
 
-#: gitk:7137
+#: gitk:7156
 msgid "many"
 msgstr "много"
 
-#: gitk:7328
+#: gitk:7347
 msgid "Tags:"
 msgstr "Метки:"
 
-#: gitk:7345 gitk:7351 gitk:8825
+#: gitk:7364 gitk:7370 gitk:8844
 msgid "Parent"
 msgstr "Предок"
 
-#: gitk:7356
+#: gitk:7375
 msgid "Child"
 msgstr "Потомок"
 
-#: gitk:7365
+#: gitk:7384
 msgid "Branch"
 msgstr "Ветка"
 
-#: gitk:7368
+#: gitk:7387
 msgid "Follows"
 msgstr "Следует за"
 
-#: gitk:7371
+#: gitk:7390
 msgid "Precedes"
 msgstr "Предшествует"
 
-#: gitk:7966
+#: gitk:7985
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Ошибка получения изменений: %s"
 
-#: gitk:8650
+#: gitk:8669
 msgid "Goto:"
 msgstr "Перейти к:"
 
-#: gitk:8671
+#: gitk:8690
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Сокращённый SHA1 идентификатор %s неоднозначен"
 
-#: gitk:8678
+#: gitk:8697
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Редакция %s не найдена"
 
-#: gitk:8688
+#: gitk:8707
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "SHA1 идентификатор %s не найден"
 
-#: gitk:8690
+#: gitk:8709
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Редакция %s не найдена в текущем представлении"
 
-#: gitk:8832 gitk:8847
+#: gitk:8851 gitk:8866
 msgid "Date"
 msgstr "Дата"
 
-#: gitk:8835
+#: gitk:8854
 msgid "Children"
 msgstr "Потомки"
 
-#: gitk:8898
+#: gitk:8917
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Сбросить ветку %s на этот коммит"
 
-#: gitk:8900
+#: gitk:8919
 msgid "Detached head: can't reset"
 msgstr "Коммит не принадлежит ни одной ветке, сбросить невозможно"
 
-#: gitk:9005 gitk:9011
+#: gitk:9024 gitk:9030
 msgid "Skipping merge commit "
 msgstr "Пропускаю коммит-слияние"
 
-#: gitk:9020 gitk:9025
+#: gitk:9039 gitk:9044
 msgid "Error getting patch ID for "
 msgstr "Не удалось получить идентификатор патча для "
 
-#: gitk:9021 gitk:9026
+#: gitk:9040 gitk:9045
 msgid " - stopping\n"
 msgstr " — останов\n"
 
-#: gitk:9031 gitk:9034 gitk:9042 gitk:9056 gitk:9065
+#: gitk:9050 gitk:9053 gitk:9061 gitk:9075 gitk:9084
 msgid "Commit "
 msgstr "Коммит"
 
-#: gitk:9035
+#: gitk:9054
 msgid ""
 " is the same patch as\n"
 "       "
 msgstr " такой же патч, как и\n       "
 
-#: gitk:9043
+#: gitk:9062
 msgid ""
 " differs from\n"
 "       "
 msgstr " отличается от\n       "
 
-#: gitk:9045
+#: gitk:9064
 msgid ""
 "Diff of commits:\n"
 "\n"
 msgstr "Различия коммитов:\n\n"
 
-#: gitk:9057 gitk:9066
+#: gitk:9076 gitk:9085
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " является %s потомком — останов\n"
 
-#: gitk:9085
+#: gitk:9104
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Произошла ошибка при записи коммита в файл: %s"
 
-#: gitk:9091
+#: gitk:9110
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Произошла ошибка при выводе различий коммитов: %s"
 
-#: gitk:9137
+#: gitk:9156
 msgid "Top"
 msgstr "Верх"
 
-#: gitk:9138
+#: gitk:9157
 msgid "From"
 msgstr "От"
 
-#: gitk:9143
+#: gitk:9162
 msgid "To"
 msgstr "До"
 
-#: gitk:9167
+#: gitk:9186
 msgid "Generate patch"
 msgstr "Создать патч"
 
-#: gitk:9169
+#: gitk:9188
 msgid "From:"
 msgstr "От:"
 
-#: gitk:9178
+#: gitk:9197
 msgid "To:"
 msgstr "До:"
 
-#: gitk:9187
+#: gitk:9206
 msgid "Reverse"
 msgstr "В обратном порядке"
 
-#: gitk:9189 gitk:9385
+#: gitk:9208 gitk:9418
 msgid "Output file:"
 msgstr "Файл для сохранения:"
 
-#: gitk:9195
+#: gitk:9214
 msgid "Generate"
 msgstr "Создать"
 
-#: gitk:9233
+#: gitk:9252
 msgid "Error creating patch:"
 msgstr "Ошибка создания патча:"
 
-#: gitk:9256 gitk:9373 gitk:9430
+#: gitk:9275 gitk:9406 gitk:9463
 msgid "ID:"
 msgstr "ID:"
 
-#: gitk:9265
+#: gitk:9284
 msgid "Tag name:"
 msgstr "Имя метки:"
 
-#: gitk:9268
+#: gitk:9287
 msgid "Tag message is optional"
 msgstr "Описание метки указывать не обязательно"
 
-#: gitk:9270
+#: gitk:9289
 msgid "Tag message:"
 msgstr "Описание метки:"
 
-#: gitk:9274 gitk:9439
+#: gitk:9293 gitk:9472
 msgid "Create"
 msgstr "Создать"
 
-#: gitk:9292
+#: gitk:9311
 msgid "No tag name specified"
 msgstr "Не задано имя метки"
 
-#: gitk:9296
+#: gitk:9315
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Метка «%s» уже существует"
 
-#: gitk:9306
+#: gitk:9325
 msgid "Error creating tag:"
 msgstr "Ошибка создания метки:"
 
-#: gitk:9382
+#: gitk:9415
 msgid "Command:"
 msgstr "Команда:"
 
-#: gitk:9390
+#: gitk:9423
 msgid "Write"
 msgstr "Запись"
 
-#: gitk:9408
+#: gitk:9441
 msgid "Error writing commit:"
 msgstr "Произошла ошибка при записи коммита:"
 
-#: gitk:9435
+#: gitk:9468
 msgid "Name:"
 msgstr "Имя:"
 
-#: gitk:9458
+#: gitk:9491
 msgid "Please specify a name for the new branch"
 msgstr "Укажите имя для новой ветки"
 
-#: gitk:9463
+#: gitk:9496
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
 msgstr "Ветка «%s» уже существует. Переписать?"
 
-#: gitk:9530
+#: gitk:9563
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr "Коммит %s уже включён в ветку %s. Продолжить операцию?"
 
-#: gitk:9535
+#: gitk:9568
 msgid "Cherry-picking"
-msgstr "Копирование изменений"
+msgstr "Копирование коммита"
 
-#: gitk:9544
+#: gitk:9577
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
 "Please commit, reset or stash your changes and try again."
-msgstr "Отбор лучшего невозможен из-за изменений в файле «%s».\nЗакомитьте, сбросьте или спрячьте изменения и повторите операцию."
+msgstr "Копирование коммита невозможно из-за изменений в файле «%s».\nЗакоммитьте, сбросьте или спрячьте изменения и повторите операцию."
 
-#: gitk:9550
+#: gitk:9583
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
 msgstr "Копирование изменений невозможно из-за незавершённой операции слияния.\nЗапустить git citool для завершения этой операции?"
 
-#: gitk:9566 gitk:9624
+#: gitk:9599 gitk:9657
 msgid "No changes committed"
 msgstr "Изменения не закоммичены"
 
-#: gitk:9593
+#: gitk:9626
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
 msgstr "Коммит %s не включён в ветку %s. Продолжить операцию?"
 
-#: gitk:9598
+#: gitk:9631
 msgid "Reverting"
-msgstr "Возврат изменений"
+msgstr "Обращение изменений"
 
-#: gitk:9606
+#: gitk:9639
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Please "
 "commit, reset or stash  your changes and try again."
-msgstr "Возврат изменений коммита не удался из-за локальных изменений в указанных файлах: %s\nЗакомитьте, сбросьте или спрячьте изменения и повторите операцию."
+msgstr "Возврат изменений коммита не удался из-за локальных изменений в указанных файлах: %s\nЗакоммитьте, сбросьте или спрячьте изменения и повторите операцию."
 
-#: gitk:9610
+#: gitk:9643
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
 msgstr "Возврат изменений невозможен из-за незавершённой операции слияния.\nЗапустить git citool для завершения этой операции?"
 
-#: gitk:9653
+#: gitk:9686
 msgid "Confirm reset"
 msgstr "Подтвердите операцию перехода"
 
-#: gitk:9655
+#: gitk:9688
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Сбросить ветку %s на коммит %s?"
 
-#: gitk:9657
+#: gitk:9690
 msgid "Reset type:"
 msgstr "Тип операции перехода:"
 
-#: gitk:9660
+#: gitk:9693
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Лёгкий: оставить рабочий каталог и индекс неизменными"
 
-#: gitk:9663
+#: gitk:9696
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Смешанный: оставить рабочий каталог неизменным, установить индекс"
 
-#: gitk:9666
+#: gitk:9699
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
 msgstr "Жесткий: переписать индекс и рабочий каталог\n(все изменения в рабочем каталоге будут потеряны)"
 
-#: gitk:9683
+#: gitk:9716
 msgid "Resetting"
 msgstr "Сброс"
 
-#: gitk:9743
+#: gitk:9776
 msgid "Checking out"
 msgstr "Переход"
 
-#: gitk:9796
+#: gitk:9829
 msgid "Cannot delete the currently checked-out branch"
 msgstr "Активная ветка не может быть удалена"
 
-#: gitk:9802
+#: gitk:9835
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
 "Really delete branch %s?"
 msgstr "Коммиты из ветки %s не принадлежат больше никакой другой ветке.\nДействительно удалить ветку %s?"
 
-#: gitk:9833
+#: gitk:9866
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Метки и ветки: %s"
 
-#: gitk:9850
+#: gitk:9883
 msgid "Filter"
 msgstr "Фильтровать"
 
-#: gitk:10146
+#: gitk:10179
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
 msgstr "Ошибка чтения истории проекта; информация о ветках и коммитах вокруг меток (до/после) может быть неполной."
 
-#: gitk:11123
+#: gitk:11156
 msgid "Tag"
 msgstr "Метка"
 
-#: gitk:11127
+#: gitk:11160
 msgid "Id"
 msgstr "Id"
 
-#: gitk:11210
+#: gitk:11243
 msgid "Gitk font chooser"
 msgstr "Шрифт Gitk"
 
-#: gitk:11227
+#: gitk:11260
 msgid "B"
 msgstr "Ж"
 
-#: gitk:11230
+#: gitk:11263
 msgid "I"
 msgstr "К"
 
-#: gitk:11348
+#: gitk:11381
 msgid "Commit list display options"
 msgstr "Параметры показа списка коммитов"
 
-#: gitk:11351
+#: gitk:11384
 msgid "Maximum graph width (lines)"
 msgstr "Макс. ширина графа (строк)"
 
-#: gitk:11355
+#: gitk:11388
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Макс. ширина графа (% ширины панели)"
 
-#: gitk:11358
+#: gitk:11391
 msgid "Show local changes"
 msgstr "Показывать изменения в рабочем каталоге"
 
-#: gitk:11361
+#: gitk:11394
 msgid "Auto-select SHA1 (length)"
 msgstr "Автоматически выделить SHA1 (длинна)"
 
-#: gitk:11365
+#: gitk:11398
 msgid "Hide remote refs"
 msgstr "Скрыть внешние ссылки"
 
-#: gitk:11369
+#: gitk:11402
 msgid "Diff display options"
 msgstr "Параметры показа изменений"
 
-#: gitk:11371
+#: gitk:11404
 msgid "Tab spacing"
 msgstr "Ширина табуляции"
 
-#: gitk:11374
+#: gitk:11407
 msgid "Display nearby tags/heads"
 msgstr "Показывать близкие метки/ветки"
 
-#: gitk:11377
+#: gitk:11410
 msgid "Maximum # tags/heads to show"
 msgstr "Показывать максимальное количество меток/веток"
 
-#: gitk:11380
+#: gitk:11413
 msgid "Limit diffs to listed paths"
 msgstr "Ограничить показ изменений выбранными файлами"
 
-#: gitk:11383
+#: gitk:11416
 msgid "Support per-file encodings"
 msgstr "Поддержка кодировок в отдельных файлах"
 
-#: gitk:11389 gitk:11536
+#: gitk:11422 gitk:11569
 msgid "External diff tool"
 msgstr "Программа для показа изменений"
 
-#: gitk:11390
+#: gitk:11423
 msgid "Choose..."
 msgstr "Выберите..."
 
-#: gitk:11395
+#: gitk:11428
 msgid "General options"
 msgstr "Общие опции"
 
-#: gitk:11398
+#: gitk:11431
 msgid "Use themed widgets"
 msgstr "Использовать стили виджетов"
 
-#: gitk:11400
+#: gitk:11433
 msgid "(change requires restart)"
 msgstr "(изменение потребует перезапуск)"
 
-#: gitk:11402
+#: gitk:11435
 msgid "(currently unavailable)"
 msgstr "(недоступно в данный момент)"
 
-#: gitk:11413
+#: gitk:11446
 msgid "Colors: press to choose"
 msgstr "Цвета: нажмите для выбора"
 
-#: gitk:11416
+#: gitk:11449
 msgid "Interface"
 msgstr "Интерфейс"
 
-#: gitk:11417
+#: gitk:11450
 msgid "interface"
 msgstr "интерфейс"
 
-#: gitk:11420
+#: gitk:11453
 msgid "Background"
 msgstr "Фон"
 
-#: gitk:11421 gitk:11451
+#: gitk:11454 gitk:11484
 msgid "background"
 msgstr "фон"
 
-#: gitk:11424
+#: gitk:11457
 msgid "Foreground"
 msgstr "Передний план"
 
-#: gitk:11425
+#: gitk:11458
 msgid "foreground"
 msgstr "передний план"
 
-#: gitk:11428
+#: gitk:11461
 msgid "Diff: old lines"
 msgstr "Изменения: старый текст"
 
-#: gitk:11429
+#: gitk:11462
 msgid "diff old lines"
 msgstr "старый текст изменения"
 
-#: gitk:11433
+#: gitk:11466
 msgid "Diff: new lines"
 msgstr "Изменения: новый текст"
 
-#: gitk:11434
+#: gitk:11467
 msgid "diff new lines"
 msgstr "новый текст изменения"
 
-#: gitk:11438
+#: gitk:11471
 msgid "Diff: hunk header"
 msgstr "Изменения: заголовок блока"
 
-#: gitk:11440
+#: gitk:11473
 msgid "diff hunk header"
 msgstr "заголовок блока изменений"
 
-#: gitk:11444
+#: gitk:11477
 msgid "Marked line bg"
 msgstr "Фон выбранной строки"
 
-#: gitk:11446
+#: gitk:11479
 msgid "marked line background"
 msgstr "фон выбранной строки"
 
-#: gitk:11450
+#: gitk:11483
 msgid "Select bg"
 msgstr "Выберите фон"
 
-#: gitk:11459
+#: gitk:11492
 msgid "Fonts: press to choose"
 msgstr "Шрифт: нажмите для выбора"
 
-#: gitk:11461
+#: gitk:11494
 msgid "Main font"
 msgstr "Основной шрифт"
 
-#: gitk:11462
+#: gitk:11495
 msgid "Diff display font"
 msgstr "Шрифт показа изменений"
 
-#: gitk:11463
+#: gitk:11496
 msgid "User interface font"
 msgstr "Шрифт интерфейса"
 
-#: gitk:11485
+#: gitk:11518
 msgid "Gitk preferences"
 msgstr "Настройки Gitk"
 
-#: gitk:11494
+#: gitk:11527
 msgid "General"
 msgstr "Общие"
 
-#: gitk:11495
+#: gitk:11528
 msgid "Colors"
 msgstr "Цвета"
 
-#: gitk:11496
+#: gitk:11529
 msgid "Fonts"
 msgstr "Шрифты"
 
-#: gitk:11546
+#: gitk:11579
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: выберите цвет для %s"
 
-#: gitk:12059
+#: gitk:12092
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr "К сожалению gitk не может работать с этой версий Tcl/Tk.\nТребуется как минимум Tcl/Tk 8.4."
 
-#: gitk:12269
+#: gitk:12302
 msgid "Cannot find a git repository here."
 msgstr "Git-репозитарий не найден в текущем каталоге."
 
-#: gitk:12316
+#: gitk:12349
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Неоднозначный аргумент «%s»: существует как редакция и как имя файла"
 
-#: gitk:12328
+#: gitk:12361
 msgid "Bad arguments to gitk:"
 msgstr "Неправильные аргументы для gitk:"
-- 
2.9.0.windows.1

