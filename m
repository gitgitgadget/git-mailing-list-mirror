Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972622018E
	for <e@80x24.org>; Tue, 12 Jul 2016 09:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbcGLJI1 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 05:08:27 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34981 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcGLJIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 05:08:21 -0400
Received: by mail-lf0-f51.google.com with SMTP id f93so6838564lfi.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 02:08:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqwaCvzC/UAEWpVWpXdQVcKRHkn5jWO1B1X8ZPXiI9I=;
        b=npIsHO6yhiRIOawcrIDlPclgeInSBdyQr/zZws9mpu2VKzyKt9tviwGy9wPhp0+nVB
         KRgBZl7n8NykiPd8+l/Ow3M60iaeMRqlzw1SbDx4gtcFHcsz0+iibNRpk3p3i9TsEJBh
         oRNOGk/mrwEFCXAqZzvZvVeV8/D0DdJhZ1Jym+gXzcgSjtKEf79tECzTKt+N4/ZLt57Y
         FbDzaj0VoqvbpmcvdOaXUCigr19Zaxfknd7W4+voRd04RkTbB/m3J61bigVOhXS1BwW0
         maxB59HTiyiX5DOEhiOHhduITrGgV+jrfiT/Vy2SamYaB6K5hiNJHufRhNbu0tfGliPa
         Y5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oqwaCvzC/UAEWpVWpXdQVcKRHkn5jWO1B1X8ZPXiI9I=;
        b=UUYJqE6+AiKvCkRxk4lLqXb1adlFOTwU2z/l4Sha89Xk9WxULU4RziJHWwxWUgy58X
         RpmWZFuRiy4ZNCMaPFJw6FNGINyFyNCx0Ihf+5qHAtcHcxFPhbGaGjcnK0y1zD2Mv0aW
         115ronQaWYpRxo1XPuuQnhG0Cg1nujVvKt+r7MneCL2io+wH7Ikxes111VAYtN2OBXH7
         NW8bO57Y+vgApL48McfQWhzmgQj5l8LRPkGKgHzvzsrWGHZKKhxlSLzyutrzFDJ3794Y
         aymJKa6FoJPlg8VRgJ6RjUjMPmzWMjO7nqteTahQg5zPekmjHZw4o0y8vPnKvyImBUTO
         USFw==
X-Gm-Message-State: ALyK8tKVGWRA+WBhhRTJi90pXsML0A2BTP6z8T8639p3ZzP6Xcarjbv6m6TGYoKtzhEo7A==
X-Received: by 10.25.142.2 with SMTP id q2mr350928lfd.11.1468314496884;
        Tue, 12 Jul 2016 02:08:16 -0700 (PDT)
Received: from Prog004.devcubestudio.com (mail.devcubestudio.com. [193.93.53.184])
        by smtp.gmail.com with ESMTPSA id 205sm2474550ljj.47.2016.07.12.02.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 02:08:16 -0700 (PDT)
From:	Dmitry Ryazantsev <dimitriy.ryazantcev@gmail.com>
X-Google-Original-From:	Dmitry Ryazantsev <dmitry.ryazantsev@devcubestudio.com>
To:	git@vger.kernel.org
Cc:	Dmitry Ryazantsev <dmitry.ryazantsev@devcubestudio.com>
Subject: [PATCH] git-gui: ru.po: Update Russian translation
Date:	Tue, 12 Jul 2016 12:07:10 +0300
Message-Id: <20160712090710.30380-1-dmitry.ryazantsev@devcubestudio.com>
X-Mailer: git-send-email 2.9.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Dmitry Ryazantsev <dmitry.ryazantsev@devcubestudio.com>
---
 po/ru.po | 680 +++++++++++++++++++++++----------------------------------------
 1 file changed, 249 insertions(+), 431 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index ca4343b..9f5305c 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -1,19 +1,22 @@
 # Translation of git-gui to russian
 # Copyright (C) 2007 Shawn Pearce
 # This file is distributed under the same license as the git-gui package.
-# Irina Riesen <irina.riesen@gmail.com>, 2007.
-#
+# Translators:
+# Dimitriy Ryazantcev <DJm00n@mail.ru>, 2015-2016
+# Irina Riesen <irina.riesen@gmail.com>, 2007
 msgid ""
 msgstr ""
-"Project-Id-Version: git-gui\n"
+"Project-Id-Version: Git Russian Localization Project\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2010-01-26 15:47-0800\n"
-"PO-Revision-Date: 2007-10-22 22:30-0200\n"
-"Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
-"Language-Team: Russian Translation <git@vger.kernel.org>\n"
+"PO-Revision-Date: 2016-06-30 12:39+0000\n"
+"Last-Translator: Dimitriy Ryazantcev <DJm00n@mail.ru>\n"
+"Language-Team: Russian (http://www.transifex.com/djm00n/git-po-ru/language/ru/)\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"Language: ru\n"
+"Plural-Forms: nplurals=4; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<12 || n%100>14) ? 1 : n%10==0 || (n%10>=5 && n%10<=9) || (n%100>=11 && n%100<=14)? 2 : 3);\n"
 
 #: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.sh:903
 #: git-gui.sh:922
@@ -51,14 +54,7 @@ msgid ""
 "%s requires at least Git 1.5.0 or later.\n"
 "\n"
 "Assume '%s' is version 1.5.0?\n"
-msgstr ""
-"Невозможно определить версию Git\n"
-"\n"
-"%s указывает на версию '%s'.\n"
-"\n"
-"для %s требуется версия Git, начиная с 1.5.0\n"
-"\n"
-"Принять '%s' как версию 1.5.0?\n"
+msgstr "Невозможно определить версию Git\n\n%s указывает на версию «%s».\n\nдля %s требуется версия Git, начиная с 1.5.0\n\nПредположить, что «%s» и есть версия 1.5.0?\n"
 
 #: git-gui.sh:1128
 msgid "Git directory not found:"
@@ -78,20 +74,19 @@ msgstr "Отсутствует рабочий каталог"
 
 #: git-gui.sh:1334 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
-msgstr "Обновление информации о состоянии файлов..."
+msgstr "Обновление информации о состоянии файлов…"
 
 #: git-gui.sh:1390
 msgid "Scanning for modified files ..."
-msgstr "Поиск измененных файлов..."
+msgstr "Поиск измененных файлов…"
 
 #: git-gui.sh:1454
 msgid "Calling prepare-commit-msg hook..."
-msgstr "Вызов программы поддержки репозитория prepare-commit-msg..."
+msgstr "Вызов перехватчика prepare-commit-msg…"
 
 #: git-gui.sh:1471
 msgid "Commit declined by prepare-commit-msg hook."
-msgstr ""
-"Сохранение прервано программой поддержки репозитория prepare-commit-msg"
+msgstr "Коммит прерван перехватчиком prepare-commit-msg."
 
 #: git-gui.sh:1629 lib/browser.tcl:246
 msgid "Ready."
@@ -108,31 +103,31 @@ msgstr "Не изменено"
 
 #: git-gui.sh:1915
 msgid "Modified, not staged"
-msgstr "Изменено, не подготовлено"
+msgstr "Изменено, не в индексе"
 
 #: git-gui.sh:1916 git-gui.sh:1924
 msgid "Staged for commit"
-msgstr "Подготовлено для сохранения"
+msgstr "В индексе для коммита"
 
 #: git-gui.sh:1917 git-gui.sh:1925
 msgid "Portions staged for commit"
-msgstr "Части, подготовленные для сохранения"
+msgstr "Части, в индексе для коммита"
 
 #: git-gui.sh:1918 git-gui.sh:1926
 msgid "Staged for commit, missing"
-msgstr "Подготовлено для сохранения, отсутствует"
+msgstr "В индексе для коммита, отсутствует"
 
 #: git-gui.sh:1920
 msgid "File type changed, not staged"
-msgstr "Тип файла изменён, не подготовлено"
+msgstr "Тип файла изменён, не в индексе"
 
 #: git-gui.sh:1921
 msgid "File type changed, staged"
-msgstr "Тип файла изменён, подготовлено"
+msgstr "Тип файла изменён, в индексе"
 
 #: git-gui.sh:1923
 msgid "Untracked, not staged"
-msgstr "Не отслеживается, не подготовлено"
+msgstr "Не отслеживается, не в индексе"
 
 #: git-gui.sh:1928
 msgid "Missing"
@@ -140,11 +135,11 @@ msgstr "Отсутствует"
 
 #: git-gui.sh:1929
 msgid "Staged for removal"
-msgstr "Подготовлено для удаления"
+msgstr "В индексе для удаления"
 
 #: git-gui.sh:1930
 msgid "Staged for removal, still present"
-msgstr "Подготовлено для удаления, еще не удалено"
+msgstr "В индексе для удаления, еще не удалено"
 
 #: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
 #: git-gui.sh:1936 git-gui.sh:1937
@@ -153,7 +148,7 @@ msgstr "Требуется разрешение конфликта при сли
 
 #: git-gui.sh:1972
 msgid "Starting gitk... please wait..."
-msgstr "Запускается gitk... Подождите, пожалуйста..."
+msgstr "Запускается gitk… Подождите, пожалуйста…"
 
 #: git-gui.sh:1984
 msgid "Couldn't find gitk in PATH"
@@ -173,11 +168,11 @@ msgstr "Редактировать"
 
 #: git-gui.sh:2458 lib/choose_rev.tcl:561
 msgid "Branch"
-msgstr "Ветвь"
+msgstr "Ветка"
 
 #: git-gui.sh:2461 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
-msgstr "Состояние"
+msgstr "Коммит"
 
 #: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
 msgid "Merge"
@@ -197,29 +192,29 @@ msgstr "Просмотр рабочего каталога"
 
 #: git-gui.sh:2483
 msgid "Browse Current Branch's Files"
-msgstr "Просмотреть файлы текущей ветви"
+msgstr "Просмотреть файлы текущей ветки"
 
 #: git-gui.sh:2487
 msgid "Browse Branch Files..."
-msgstr "Показать файлы ветви..."
+msgstr "Показать файлы ветки…"
 
 #: git-gui.sh:2492
 msgid "Visualize Current Branch's History"
-msgstr "Показать историю текущей ветви"
+msgstr "Показать историю текущей ветки"
 
 #: git-gui.sh:2496
 msgid "Visualize All Branch History"
-msgstr "Показать историю всех ветвей"
+msgstr "Показать историю всех веток"
 
 #: git-gui.sh:2503
 #, tcl-format
 msgid "Browse %s's Files"
-msgstr "Показать файлы ветви %s"
+msgstr "Показать файлы ветки %s"
 
 #: git-gui.sh:2505
 #, tcl-format
 msgid "Visualize %s's History"
-msgstr "Показать историю ветви %s"
+msgstr "Показать историю ветки %s"
 
 #: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
@@ -274,23 +269,23 @@ msgstr "Выделить все"
 
 #: git-gui.sh:2576
 msgid "Create..."
-msgstr "Создать..."
+msgstr "Создать…"
 
 #: git-gui.sh:2582
 msgid "Checkout..."
-msgstr "Перейти..."
+msgstr "Перейти…"
 
 #: git-gui.sh:2588
 msgid "Rename..."
-msgstr "Переименовать..."
+msgstr "Переименовать…"
 
 #: git-gui.sh:2593
 msgid "Delete..."
-msgstr "Удалить..."
+msgstr "Удалить…"
 
 #: git-gui.sh:2598
 msgid "Reset..."
-msgstr "Сбросить..."
+msgstr "Сбросить…"
 
 #: git-gui.sh:2608
 msgid "Done"
@@ -298,15 +293,15 @@ msgstr "Завершено"
 
 #: git-gui.sh:2610
 msgid "Commit@@verb"
-msgstr "Сохранить"
+msgstr "Закоммитить"
 
 #: git-gui.sh:2619 git-gui.sh:3050
 msgid "New Commit"
-msgstr "Новое состояние"
+msgstr "Новый коммит"
 
 #: git-gui.sh:2627 git-gui.sh:3057
 msgid "Amend Last Commit"
-msgstr "Исправить последнее состояние"
+msgstr "Исправить последний коммит"
 
 #: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
@@ -314,19 +309,19 @@ msgstr "Перечитать"
 
 #: git-gui.sh:2643
 msgid "Stage To Commit"
-msgstr "Подготовить для сохранения"
+msgstr "Добавить в индекс"
 
 #: git-gui.sh:2649
 msgid "Stage Changed Files To Commit"
-msgstr "Подготовить измененные файлы для сохранения"
+msgstr "Добавить изменённые файлы в индекс"
 
 #: git-gui.sh:2655
 msgid "Unstage From Commit"
-msgstr "Убрать из подготовленного"
+msgstr "Убрать из издекса"
 
 #: git-gui.sh:2661 lib/index.tcl:412
 msgid "Revert Changes"
-msgstr "Отменить изменения"
+msgstr "Обратить изменения"
 
 #: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
 msgid "Show Less Context"
@@ -342,31 +337,31 @@ msgstr "Вставить Signed-off-by"
 
 #: git-gui.sh:2696
 msgid "Local Merge..."
-msgstr "Локальное слияние..."
+msgstr "Локальное слияние…"
 
 #: git-gui.sh:2701
 msgid "Abort Merge..."
-msgstr "Прервать слияние..."
+msgstr "Прервать слияние…"
 
 #: git-gui.sh:2713 git-gui.sh:2741
 msgid "Add..."
-msgstr "Добавить..."
+msgstr "Добавить…"
 
 #: git-gui.sh:2717
 msgid "Push..."
-msgstr "Отправить..."
+msgstr "Отправить…"
 
 #: git-gui.sh:2721
 msgid "Delete Branch..."
-msgstr "Удалить ветвь..."
+msgstr "Удалить ветку…"
 
 #: git-gui.sh:2731 git-gui.sh:3292
 msgid "Options..."
-msgstr "Настройки..."
+msgstr "Настройки…"
 
 #: git-gui.sh:2742
 msgid "Remove..."
-msgstr "Удалить..."
+msgstr "Удалить…"
 
 #: git-gui.sh:2751 lib/choose_repository.tcl:50
 msgid "Help"
@@ -393,11 +388,11 @@ msgstr "критическая ошибка: %s: нет такого файла
 
 #: git-gui.sh:2926
 msgid "Current Branch:"
-msgstr "Текущая ветвь:"
+msgstr "Текущая ветка:"
 
 #: git-gui.sh:2947
 msgid "Staged Changes (Will Commit)"
-msgstr "Подготовлено (будет сохранено)"
+msgstr "Изменения в индексе (будут закоммичены)"
 
 #: git-gui.sh:2967
 msgid "Unstaged Changes"
@@ -405,7 +400,7 @@ msgstr "Изменено (не будет сохранено)"
 
 #: git-gui.sh:3017
 msgid "Stage Changed"
-msgstr "Подготовить все"
+msgstr "Индексировать всё"
 
 #: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
@@ -413,27 +408,27 @@ msgstr "Отправить"
 
 #: git-gui.sh:3071
 msgid "Initial Commit Message:"
-msgstr "Комментарий к первому состоянию:"
+msgstr "Сообщение первого коммита:"
 
 #: git-gui.sh:3072
 msgid "Amended Commit Message:"
-msgstr "Комментарий к исправленному состоянию:"
+msgstr "Сообщение исправленного коммита:"
 
 #: git-gui.sh:3073
 msgid "Amended Initial Commit Message:"
-msgstr "Комментарий к исправленному первоначальному состоянию:"
+msgstr "Сообщение исправленного первого коммита:"
 
 #: git-gui.sh:3074
 msgid "Amended Merge Commit Message:"
-msgstr "Комментарий к исправленному слиянию:"
+msgstr "Сообщение исправленного слияния:"
 
 #: git-gui.sh:3075
 msgid "Merge Commit Message:"
-msgstr "Комментарий к слиянию:"
+msgstr "Сообщение слияния:"
 
 #: git-gui.sh:3076
 msgid "Commit Message:"
-msgstr "Комментарий к состоянию:"
+msgstr "Сообщение коммита:"
 
 #: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
 msgid "Copy All"
@@ -481,51 +476,51 @@ msgstr "Взять локальную версию"
 
 #: git-gui.sh:3336
 msgid "Revert To Base"
-msgstr "Отменить изменения"
+msgstr "Обратить изменения"
 
 #: git-gui.sh:3354
 msgid "Visualize These Changes In The Submodule"
-msgstr ""
+msgstr "Показать эти изменения подмодуля"
 
 #: git-gui.sh:3358
 msgid "Visualize Current Branch History In The Submodule"
-msgstr "Показать историю текущей ветви подмодуля"
+msgstr "Показать историю текущей ветки подмодуля"
 
 #: git-gui.sh:3362
 msgid "Visualize All Branch History In The Submodule"
-msgstr "Показать историю всех ветвей подмодуля"
+msgstr "Показать историю всех веток подмодуля"
 
 #: git-gui.sh:3367
 msgid "Start git gui In The Submodule"
-msgstr ""
+msgstr "Запустить git gui в подмодуле"
 
 #: git-gui.sh:3389
 msgid "Unstage Hunk From Commit"
-msgstr "Не сохранять часть"
+msgstr "Убрать блок из индекса"
 
 #: git-gui.sh:3391
 msgid "Unstage Lines From Commit"
-msgstr "Убрать строки из подготовленного"
+msgstr "Убрать строки из индекса"
 
 #: git-gui.sh:3393
 msgid "Unstage Line From Commit"
-msgstr "Убрать строку из подготовленного"
+msgstr "Убрать строку из индекса"
 
 #: git-gui.sh:3396
 msgid "Stage Hunk For Commit"
-msgstr "Подготовить часть для сохранения"
+msgstr "Добавить блок в индекс"
 
 #: git-gui.sh:3398
 msgid "Stage Lines For Commit"
-msgstr "Подготовить строки для сохранения"
+msgstr "Добавить строки в индекс"
 
 #: git-gui.sh:3400
 msgid "Stage Line For Commit"
-msgstr "Подготовить строку для сохранения"
+msgstr "Добавить строку в индекс"
 
 #: git-gui.sh:3424
 msgid "Initializing..."
-msgstr "Инициализация..."
+msgstr "Инициализация…"
 
 #: git-gui.sh:3541
 #, tcl-format
@@ -536,23 +531,14 @@ msgid ""
 "going to be ignored by any Git subprocess run\n"
 "by %s:\n"
 "\n"
-msgstr ""
-"Возможны ошибки в переменных окружения.\n"
-"\n"
-"Переменные окружения, которые возможно\n"
-"будут проигнорированы командами Git,\n"
-"запущенными из %s\n"
-"\n"
+msgstr "Возможны ошибки в переменных окружения.\n\nПеременные окружения, которые возможно\nбудут проигнорированы командами Git,\nзапущенными из %s\n\n"
 
 #: git-gui.sh:3570
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
-msgstr ""
-"\n"
-"Это известная проблема с Tcl,\n"
-"распространяемым Cygwin."
+msgstr "\nЭто известная проблема с Tcl,\nраспространяемым Cygwin."
 
 #: git-gui.sh:3575
 #, tcl-format
@@ -563,13 +549,7 @@ msgid ""
 "is placing values for the user.name and\n"
 "user.email settings into your personal\n"
 "~/.gitconfig file.\n"
-msgstr ""
-"\n"
-"\n"
-"Вместо использования %s можно\n"
-"сохранить значения user.name и\n"
-"user.email в Вашем персональном\n"
-"файле ~/.gitconfig.\n"
+msgstr "\n\nВместо использования %s можно\nсохранить значения user.name и\nuser.email в Вашем персональном\nфайле ~/.gitconfig.\n"
 
 #: lib/about.tcl:26
 msgid "git-gui - a graphical user interface for Git."
@@ -581,15 +561,15 @@ msgstr "Просмотр файла"
 
 #: lib/blame.tcl:78
 msgid "Commit:"
-msgstr "Сохраненное состояние:"
+msgstr "Коммит:"
 
 #: lib/blame.tcl:271
 msgid "Copy Commit"
-msgstr "Скопировать SHA-1"
+msgstr "Копировать SHA-1"
 
 #: lib/blame.tcl:275
 msgid "Find Text..."
-msgstr "Найти текст..."
+msgstr "Найти текст…"
 
 #: lib/blame.tcl:284
 msgid "Do Full Copy Detection"
@@ -601,16 +581,16 @@ msgstr "Показать исторический контекст"
 
 #: lib/blame.tcl:291
 msgid "Blame Parent Commit"
-msgstr "Рассмотреть состояние предка"
+msgstr "Авторы родительского коммита"
 
 #: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
-msgstr "Чтение %s..."
+msgstr "Чтение %s…"
 
 #: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
-msgstr "Загрузка аннотации копирований/переименований..."
+msgstr "Загрузка аннотации копирований/переименований…"
 
 #: lib/blame.tcl:577
 msgid "lines annotated"
@@ -618,7 +598,7 @@ msgstr "строк прокомментировано"
 
 #: lib/blame.tcl:769
 msgid "Loading original location annotations..."
-msgstr "Загрузка аннотаций первоначального положения объекта..."
+msgstr "Загрузка аннотаций первоначального положения объекта…"
 
 #: lib/blame.tcl:772
 msgid "Annotation complete."
@@ -634,11 +614,11 @@ msgstr "Аннотация уже запущена"
 
 #: lib/blame.tcl:842
 msgid "Running thorough copy detection..."
-msgstr "Выполнение полного поиска копий..."
+msgstr "Выполнение полного поиска копий…"
 
 #: lib/blame.tcl:910
 msgid "Loading annotation..."
-msgstr "Загрузка аннотации..."
+msgstr "Загрузка аннотации…"
 
 #: lib/blame.tcl:963
 msgid "Author:"
@@ -646,7 +626,7 @@ msgstr "Автор:"
 
 #: lib/blame.tcl:967
 msgid "Committer:"
-msgstr "Сохранил:"
+msgstr "Коммитер:"
 
 #: lib/blame.tcl:972
 msgid "Original File:"
@@ -654,11 +634,11 @@ msgstr "Исходный файл:"
 
 #: lib/blame.tcl:1020
 msgid "Cannot find HEAD commit:"
-msgstr "Невозможно найти текущее состояние:"
+msgstr "Не удалось найти текущее состояние:"
 
 #: lib/blame.tcl:1075
 msgid "Cannot find parent commit:"
-msgstr "Невозможно найти состояние предка:"
+msgstr "Не удалось найти родительское состояние:"
 
 #: lib/blame.tcl:1090
 msgid "Unable to display parent"
@@ -682,7 +662,7 @@ msgstr "Скопировано/перемещено в:"
 
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
-msgstr "Перейти на ветвь"
+msgstr "Перейти на ветку"
 
 #: lib/branch_checkout.tcl:23
 msgid "Checkout"
@@ -707,19 +687,19 @@ msgstr "Настройки"
 
 #: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
 msgid "Fetch Tracking Branch"
-msgstr "Получить изменения из внешней ветви"
+msgstr "Извлечь изменения из внешней ветки"
 
 #: lib/branch_checkout.tcl:44
 msgid "Detach From Local Branch"
-msgstr "Отсоединить от локальной ветви"
+msgstr "Отсоединить от локальной ветки"
 
 #: lib/branch_create.tcl:22
 msgid "Create Branch"
-msgstr "Создание ветви"
+msgstr "Создать ветку"
 
 #: lib/branch_create.tcl:27
 msgid "Create New Branch"
-msgstr "Создать новую ветвь"
+msgstr "Создать новую ветку"
 
 #: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
 msgid "Create"
@@ -727,7 +707,7 @@ msgstr "Создать"
 
 #: lib/branch_create.tcl:40
 msgid "Branch Name"
-msgstr "Название ветви"
+msgstr "Имя ветки"
 
 #: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
@@ -735,7 +715,7 @@ msgstr "Название:"
 
 #: lib/branch_create.tcl:58
 msgid "Match Tracking Branch Name"
-msgstr "Взять из имен ветвей слежения"
+msgstr "Соответствовать имени отслеживаемой ветки"
 
 #: lib/branch_create.tcl:66
 msgid "Starting Revision"
@@ -743,7 +723,7 @@ msgstr "Начальная версия"
 
 #: lib/branch_create.tcl:72
 msgid "Update Existing Branch:"
-msgstr "Обновить имеющуюся ветвь:"
+msgstr "Обновить имеющуюся ветку:"
 
 #: lib/branch_create.tcl:75
 msgid "No"
@@ -763,33 +743,33 @@ msgstr "После создания сделать текущей"
 
 #: lib/branch_create.tcl:131
 msgid "Please select a tracking branch."
-msgstr "Укажите ветвь слежения."
+msgstr "Укажите отлеживаемую ветку."
 
 #: lib/branch_create.tcl:140
 #, tcl-format
 msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Ветвь слежения %s не является ветвью во внешнем репозитории."
+msgstr "Отслеживаемая ветка %s не является веткой на внешнем репозитории."
 
 #: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
 msgid "Please supply a branch name."
-msgstr "Укажите название ветви."
+msgstr "Укажите имя ветки."
 
 #: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
 #, tcl-format
 msgid "'%s' is not an acceptable branch name."
-msgstr "Недопустимое название ветви '%s'."
+msgstr "Недопустимое имя ветки «%s»."
 
 #: lib/branch_delete.tcl:15
 msgid "Delete Branch"
-msgstr "Удаление ветви"
+msgstr "Удаление ветки"
 
 #: lib/branch_delete.tcl:20
 msgid "Delete Local Branch"
-msgstr "Удалить локальную ветвь"
+msgstr "Удалить локальную ветку"
 
 #: lib/branch_delete.tcl:37
 msgid "Local Branches"
-msgstr "Локальные ветви"
+msgstr "Локальные ветки"
 
 #: lib/branch_delete.tcl:52
 msgid "Delete Only If Merged Into"
@@ -802,30 +782,25 @@ msgstr "Всегда (не выполнять проверку на слияни
 #: lib/branch_delete.tcl:103
 #, tcl-format
 msgid "The following branches are not completely merged into %s:"
-msgstr "Ветви, которые не полностью сливаются с %s:"
+msgstr "Ветки, которые не полностью сливаются с %s:"
 
 #: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
 msgid ""
 "Recovering deleted branches is difficult.\n"
 "\n"
 "Delete the selected branches?"
-msgstr ""
-"Восстановить удаленные ветви сложно.\n"
-"\n"
-"Продолжить?"
+msgstr "Восстановить удаленные ветки сложно.\n\nПродолжить?"
 
 #: lib/branch_delete.tcl:141
 #, tcl-format
 msgid ""
 "Failed to delete branches:\n"
 "%s"
-msgstr ""
-"Не удалось удалить ветви:\n"
-"%s"
+msgstr "Не удалось удалить ветки:\n%s"
 
 #: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
 msgid "Rename Branch"
-msgstr "Переименование ветви"
+msgstr "Переименование ветки"
 
 #: lib/branch_rename.tcl:26
 msgid "Rename"
@@ -833,7 +808,7 @@ msgstr "Переименовать"
 
 #: lib/branch_rename.tcl:36
 msgid "Branch:"
-msgstr "Ветвь:"
+msgstr "Ветка:"
 
 #: lib/branch_rename.tcl:39
 msgid "New Name:"
@@ -841,21 +816,21 @@ msgstr "Новое название:"
 
 #: lib/branch_rename.tcl:75
 msgid "Please select a branch to rename."
-msgstr "Укажите ветвь для переименования."
+msgstr "Укажите ветку для переименования."
 
 #: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
 #, tcl-format
 msgid "Branch '%s' already exists."
-msgstr "Ветвь '%s' уже существует."
+msgstr "Ветка «%s» уже существует."
 
 #: lib/branch_rename.tcl:117
 #, tcl-format
 msgid "Failed to rename '%s'."
-msgstr "Не удалось переименовать '%s'. "
+msgstr "Не удалось переименовать «%s». "
 
 #: lib/browser.tcl:17
 msgid "Starting..."
-msgstr "Запуск..."
+msgstr "Запуск…"
 
 #: lib/browser.tcl:26
 msgid "File Browser"
@@ -864,7 +839,7 @@ msgstr "Просмотр списка файлов"
 #: lib/browser.tcl:126 lib/browser.tcl:143
 #, tcl-format
 msgid "Loading %s..."
-msgstr "Загрузка %s..."
+msgstr "Загрузка %s…"
 
 #: lib/browser.tcl:187
 msgid "[Up To Parent]"
@@ -872,7 +847,7 @@ msgstr "[На уровень выше]"
 
 #: lib/browser.tcl:267 lib/browser.tcl:273
 msgid "Browse Branch Files"
-msgstr "Показать файлы ветви"
+msgstr "Показать файлы ветки"
 
 #: lib/browser.tcl:278 lib/choose_repository.tcl:398
 #: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
@@ -883,7 +858,7 @@ msgstr "Показать"
 #: lib/checkout_op.tcl:85
 #, tcl-format
 msgid "Fetching %s from %s"
-msgstr "Получение %s из %s "
+msgstr "Извлечение %s из %s "
 
 #: lib/checkout_op.tcl:133
 #, tcl-format
@@ -898,12 +873,12 @@ msgstr "Закрыть"
 #: lib/checkout_op.tcl:175
 #, tcl-format
 msgid "Branch '%s' does not exist."
-msgstr "Ветвь '%s' не существует "
+msgstr "Ветка «%s» не существует."
 
 #: lib/checkout_op.tcl:194
 #, tcl-format
 msgid "Failed to configure simplified git-pull for '%s'."
-msgstr "Ошибка создания упрощённой конфигурации git pull для '%s'."
+msgstr "Ошибка создания упрощённой конфигурации git pull для «%s»."
 
 #: lib/checkout_op.tcl:229
 #, tcl-format
@@ -912,21 +887,17 @@ msgid ""
 "\n"
 "It cannot fast-forward to %s.\n"
 "A merge is required."
-msgstr ""
-"Ветвь '%s' уже существует.\n"
-"\n"
-"Она не может быть прокручена(fast-forward) к %s.\n"
-"Требуется слияние."
+msgstr "Ветка «%s» уже существует.\n\nОна не может быть перемотана вперед к %s.\nТребуется слияние."
 
 #: lib/checkout_op.tcl:243
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
-msgstr "Неизвестная стратегия слияния: '%s'."
+msgstr "Неизвестная стратегия слияния «%s»."
 
 #: lib/checkout_op.tcl:262
 #, tcl-format
 msgid "Failed to update '%s'."
-msgstr "Не удалось обновить '%s'."
+msgstr "Не удалось обновить «%s»."
 
 #: lib/checkout_op.tcl:274
 msgid "Staging area (index) is already locked."
@@ -936,22 +907,15 @@ msgstr "Рабочая область заблокирована другим п
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before the current branch can be changed.\n"
+"Another Git program has modified this repository since the last scan.  A rescan must be performed before the current branch can be changed.\n"
 "\n"
 "The rescan will be automatically started now.\n"
-msgstr ""
-"Последнее прочитанное состояние репозитория не соответствует текущему.\n"
-"\n"
-"С момента последней проверки репозиторий был изменен другой программой Git. "
-"Необходимо перечитать репозиторий, прежде чем изменять текущую ветвь.\n"
-"\n"
-"Это будет сделано сейчас автоматически.\n"
+msgstr "Последнее прочитанное состояние репозитория не соответствует текущему.\n\nС момента последней проверки репозиторий был изменен другой программой Git. Необходимо перечитать репозиторий, прежде чем текущая ветка может быть изменена.\n\nЭто будет сделано сейчас автоматически.\n"
 
 #: lib/checkout_op.tcl:345
 #, tcl-format
 msgid "Updating working directory to '%s'..."
-msgstr "Обновление рабочего каталога из '%s'..."
+msgstr "Обновление рабочего каталога из «%s»…"
 
 #: lib/checkout_op.tcl:346
 msgid "files checked out"
@@ -960,7 +924,7 @@ msgstr "файлы извлечены"
 #: lib/checkout_op.tcl:376
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
-msgstr "Прерван переход на '%s' (требуется слияние содержания файлов)"
+msgstr "Прерван переход на «%s» (требуется слияние содержимого файлов)"
 
 #: lib/checkout_op.tcl:377
 msgid "File level merge required."
@@ -969,38 +933,33 @@ msgstr "Требуется слияние содержания файлов."
 #: lib/checkout_op.tcl:381
 #, tcl-format
 msgid "Staying on branch '%s'."
-msgstr "Ветвь '%s' остается текущей."
+msgstr "Ветка «%s» остаётся текущей."
 
 #: lib/checkout_op.tcl:452
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
-"If you wanted to be on a branch, create one now starting from 'This Detached "
-"Checkout'."
-msgstr ""
-"Вы находитесь не в локальной ветви.\n"
-"\n"
-"Если вы хотите снова вернуться к какой-нибудь ветви, создайте ее сейчас, "
-"начиная с 'Текущего отсоединенного состояния'."
+"If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."
+msgstr "Вы более не находитесь на локальной ветке.\n\nЕсли вы хотите снова вернуться к какой-нибудь ветке, создайте её сейчас, начиная с «Текущего отсоединенного состояния»."
 
 #: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
 #, tcl-format
 msgid "Checked out '%s'."
-msgstr "Ветвь '%s' сделана текущей."
+msgstr "Выполнен переход на «%s»."
 
 #: lib/checkout_op.tcl:535
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
-msgstr "Сброс '%s' в '%s' приведет к потере следующих сохраненных состояний: "
+msgstr "Сброс «%s»  на «%s» приведет к потере следующих коммитов:"
 
 #: lib/checkout_op.tcl:557
 msgid "Recovering lost commits may not be easy."
-msgstr "Восстановить потерянные сохраненные состояния будет сложно."
+msgstr "Восстановить потерянные коммиты будет сложно."
 
 #: lib/checkout_op.tcl:562
 #, tcl-format
 msgid "Reset '%s'?"
-msgstr "Сбросить '%s'?"
+msgstr "Сбросить «%s»?"
 
 #: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
@@ -1011,17 +970,10 @@ msgstr "Наглядно"
 msgid ""
 "Failed to set current branch.\n"
 "\n"
-"This working directory is only partially switched.  We successfully updated "
-"your files, but failed to update an internal Git file.\n"
+"This working directory is only partially switched.  We successfully updated your files, but failed to update an internal Git file.\n"
 "\n"
 "This should not have occurred.  %s will now close and give up."
-msgstr ""
-"Не удалось установить текущую ветвь.\n"
-"\n"
-"Ваш рабочий каталог обновлен только частично. Были обновлены все файлы кроме "
-"служебных файлов Git. \n"
-"\n"
-"Этого не должно было произойти. %s завершается."
+msgstr "Не удалось установить текущую ветку.\n\nВаш рабочий каталог обновлён только частично. Были обновлены все файлы кроме служебных файлов Git. \n\nЭтого не должно было произойти. %s завершается."
 
 #: lib/choose_font.tcl:39
 msgid "Select"
@@ -1043,9 +995,7 @@ msgstr "Пример текста"
 msgid ""
 "This is example text.\n"
 "If you like this text, it can be your font."
-msgstr ""
-"Это пример текста.\n"
-"Если Вам нравится этот текст, это может быть Ваш шрифт."
+msgstr "Это пример текста.\nЕсли Вам нравится этот текст, это может быть Ваш шрифт."
 
 #: lib/choose_repository.tcl:28
 msgid "Git Gui"
@@ -1057,7 +1007,7 @@ msgstr "Создать новый репозиторий"
 
 #: lib/choose_repository.tcl:93
 msgid "New..."
-msgstr "Новый..."
+msgstr "Новый…"
 
 #: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
 msgid "Clone Existing Repository"
@@ -1065,7 +1015,7 @@ msgstr "Склонировать существующий репозиторий
 
 #: lib/choose_repository.tcl:106
 msgid "Clone..."
-msgstr "Склонировать..."
+msgstr "Клонировать…"
 
 #: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
 msgid "Open Existing Repository"
@@ -1073,7 +1023,7 @@ msgstr "Выбрать существующий репозиторий"
 
 #: lib/choose_repository.tcl:119
 msgid "Open..."
-msgstr "Открыть..."
+msgstr "Открыть…"
 
 #: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
@@ -1126,7 +1076,7 @@ msgstr "Тип клона:"
 
 #: lib/choose_repository.tcl:508
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr "Стандартный (Быстрый, полуизбыточный, \"жесткие\" ссылки)"
+msgstr "Стандартный (Быстрый, полуизбыточный, «жесткие» ссылки)"
 
 #: lib/choose_repository.tcl:514
 msgid "Full Copy (Slower, Redundant Backup)"
@@ -1166,7 +1116,7 @@ msgstr "Считаю объекты"
 
 #: lib/choose_repository.tcl:641
 msgid "buckets"
-msgstr ""
+msgstr "блоки"
 
 #: lib/choose_repository.tcl:665
 #, tcl-format
@@ -1181,11 +1131,11 @@ msgstr "Нечего клонировать с %s."
 #: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
 #: lib/choose_repository.tcl:929
 msgid "The 'master' branch has not been initialized."
-msgstr "Не инициализирована ветвь 'master'."
+msgstr "Не инициализирована ветвь «master»."
 
 #: lib/choose_repository.tcl:716
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "\"Жесткие ссылки\" недоступны. Будет использовано копирование."
+msgstr "«Жесткие ссылки» недоступны. Будет использовано копирование."
 
 #: lib/choose_repository.tcl:728
 #, tcl-format
@@ -1216,16 +1166,15 @@ msgstr "объекты"
 #: lib/choose_repository.tcl:803
 #, tcl-format
 msgid "Unable to hardlink object: %s"
-msgstr "Не могу \"жестко связать\" объект: %s"
+msgstr "Не могу создать «жесткую ссылку» на объект: %s"
 
 #: lib/choose_repository.tcl:858
 msgid "Cannot fetch branches and objects.  See console output for details."
-msgstr ""
-"Не могу получить ветви и объекты. Дополнительная информация на консоли."
+msgstr "Не удалось извлечь ветки и объекты. Дополнительная информация на консоли."
 
 #: lib/choose_repository.tcl:869
 msgid "Cannot fetch tags.  See console output for details."
-msgstr "Не могу получить метки. Дополнительная информация на консоли."
+msgstr "Не удалось извлечь метки. Дополнительная информация на консоли."
 
 #: lib/choose_repository.tcl:893
 msgid "Cannot determine HEAD.  See console output for details."
@@ -1242,12 +1191,12 @@ msgstr "Клонирование не удалось."
 
 #: lib/choose_repository.tcl:915
 msgid "No default branch obtained."
-msgstr "Не было получено ветви по умолчанию."
+msgstr "Ветка по умолчанию не была получена."
 
 #: lib/choose_repository.tcl:926
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
-msgstr "Не могу распознать %s как состояние."
+msgstr "Не могу распознать %s как коммит."
 
 #: lib/choose_repository.tcl:938
 msgid "Creating working directory"
@@ -1285,11 +1234,11 @@ msgstr "Выражение для определения версии:"
 
 #: lib/choose_rev.tcl:74
 msgid "Local Branch"
-msgstr "Локальная ветвь:"
+msgstr "Локальная ветка:"
 
 #: lib/choose_rev.tcl:79
 msgid "Tracking Branch"
-msgstr "Ветвь слежения"
+msgstr "Отслеживаемая ветка"
 
 #: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
 msgid "Tag"
@@ -1320,29 +1269,19 @@ msgstr "Ссылка"
 msgid ""
 "There is nothing to amend.\n"
 "\n"
-"You are about to create the initial commit.  There is no commit before this "
-"to amend.\n"
-msgstr ""
-"Отсутствует состояние для исправления.\n"
-"\n"
-"Вы создаете первое состояние в репозитории, здесь еще нечего исправлять.\n"
+"You are about to create the initial commit.  There is no commit before this to amend.\n"
+msgstr "Отсутствует коммиты для исправления.\n\nВы создаете начальный коммит, здесь еще нечего исправлять.\n"
 
 #: lib/commit.tcl:18
 msgid ""
 "Cannot amend while merging.\n"
 "\n"
-"You are currently in the middle of a merge that has not been fully "
-"completed.  You cannot amend the prior commit unless you first abort the "
-"current merge activity.\n"
-msgstr ""
-"Невозможно исправить состояние во время операции слияния.\n"
-"\n"
-"Текущее слияние не завершено. Невозможно исправить предыдущее сохраненное "
-"состояние, не прерывая эту операцию.\n"
+"You are currently in the middle of a merge that has not been fully completed.  You cannot amend the prior commit unless you first abort the current merge activity.\n"
+msgstr "Невозможно исправить коммит во время слияния.\n\nТекущее слияние не завершено. Невозможно исправить предыдуий коммит, не прерывая эту операцию.\n"
 
 #: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
-msgstr "Ошибка при загрузке данных для исправления сохраненного состояния:"
+msgstr "Ошибка при загрузке данных для исправления коммита:"
 
 #: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
@@ -1350,41 +1289,29 @@ msgstr "Невозможно получить информацию об авто
 
 #: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
-msgstr "Неверный GIT_COMMITTER_IDENT:"
+msgstr "Недопустимый GIT_COMMITTER_IDENT:"
 
 #: lib/commit.tcl:129
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
-msgstr "предупреждение: Tcl не поддерживает кодировку '%s'."
+msgstr "предупреждение: Tcl не поддерживает кодировку «%s»."
 
 #: lib/commit.tcl:149
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before another commit can be created.\n"
+"Another Git program has modified this repository since the last scan.  A rescan must be performed before another commit can be created.\n"
 "\n"
 "The rescan will be automatically started now.\n"
-msgstr ""
-"Последнее прочитанное состояние репозитория не соответствует текущему.\n"
-"\n"
-"С момента последней проверки репозиторий был изменен другой программой Git. "
-"Необходимо перечитать репозиторий, прежде чем изменять текущую ветвь. \n"
-"\n"
-"Это будет сделано сейчас автоматически.\n"
+msgstr "Последнее прочитанное состояние репозитория не соответствует текущему.\n\nС момента последней проверки репозиторий был изменен другой программой Git. Необходимо перечитать репозиторий, прежде чем изменять текущую ветвь. \n\nЭто будет сделано сейчас автоматически.\n"
 
 #: lib/commit.tcl:172
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
 "\n"
-"File %s has merge conflicts.  You must resolve them and stage the file "
-"before committing.\n"
-msgstr ""
-"Нельзя сохранить файлы с незавершённой операцией слияния.\n"
-"\n"
-"Для файла %s возник конфликт слияния. Разрешите конфликт и добавьте к "
-"подготовленным файлам перед сохранением.\n"
+"File %s has merge conflicts.  You must resolve them and stage the file before committing.\n"
+msgstr "Нельзя выполнить коммит с незавершённой операцией слияния.\n\nДля файла %s возник конфликт слияния. Разрешите конфликт и добавьте их в индекс перед выполнением коммита.\n"
 
 #: lib/commit.tcl:180
 #, tcl-format
@@ -1392,20 +1319,14 @@ msgid ""
 "Unknown file state %s detected.\n"
 "\n"
 "File %s cannot be committed by this program.\n"
-msgstr ""
-"Обнаружено неизвестное состояние файла %s.\n"
-"\n"
-"Файл %s не может быть сохранен данной программой.\n"
+msgstr "Обнаружено неизвестное состояние файла %s.\n\nФайл %s не может быть закоммичен этой программой.\n"
 
 #: lib/commit.tcl:188
 msgid ""
 "No changes to commit.\n"
 "\n"
 "You must stage at least 1 file before you can commit.\n"
-msgstr ""
-"Отсутствуют изменения для сохранения.\n"
-"\n"
-"Подготовьте хотя бы один файл до создания сохраненного состояния.\n"
+msgstr "Отсутствуют изменения для сохранения.\n\nДобавьте в индекс хотя бы один файл перед выполнением коммита.\n"
 
 #: lib/commit.tcl:203
 msgid ""
@@ -1416,34 +1337,27 @@ msgid ""
 "- First line: Describe in one sentence what you did.\n"
 "- Second line: Blank\n"
 "- Remaining lines: Describe why this change is good.\n"
-msgstr ""
-"Напишите комментарий к сохраненному состоянию.\n"
-"\n"
-"Рекомендуется следующий формат комментария:\n"
-"\n"
-"- первая строка: краткое описание сделанных изменений.\n"
-"- вторая строка пустая\n"
-"- оставшиеся строки: опишите, что дают ваши изменения.\n"
+msgstr "Укажите сообщение коммита.\n\nРекомендуется следующий формат сообщения:\n\n- в первой строке краткое описание сделанных изменений\n- вторая строка пустая\n- в оставшихся строках опишите, что дают ваши изменения\n"
 
 #: lib/commit.tcl:234
 msgid "Calling pre-commit hook..."
-msgstr "Вызов программы поддержки репозитория pre-commit..."
+msgstr "Вызов перехватчика pre-commit…"
 
 #: lib/commit.tcl:249
 msgid "Commit declined by pre-commit hook."
-msgstr "Сохранение прервано программой поддержки репозитория pre-commit"
+msgstr "Коммит прерван переватчиком pre-commit."
 
 #: lib/commit.tcl:272
 msgid "Calling commit-msg hook..."
-msgstr "Вызов программы поддержки репозитория commit-msg..."
+msgstr "Вызов перехватчика commit-msg…"
 
 #: lib/commit.tcl:287
 msgid "Commit declined by commit-msg hook."
-msgstr "Сохранение прервано программой поддержки репозитория commit-msg"
+msgstr "Коммит прерван переватчиком commit-msg"
 
 #: lib/commit.tcl:300
 msgid "Committing changes..."
-msgstr "Сохранение изменений..."
+msgstr "Коммит изменений…"
 
 #: lib/commit.tcl:316
 msgid "write-tree failed:"
@@ -1451,12 +1365,12 @@ msgstr "Программа write-tree завершилась с ошибкой:"
 
 #: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
 msgid "Commit failed."
-msgstr "Сохранить состояние не удалось."
+msgstr "Не удалось закоммитить изменения."
 
 #: lib/commit.tcl:334
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
-msgstr "Состояние %s выглядит поврежденным"
+msgstr "Коммит %s похоже поврежден"
 
 #: lib/commit.tcl:339
 msgid ""
@@ -1465,16 +1379,11 @@ msgid ""
 "No files were modified by this commit and it was not a merge commit.\n"
 "\n"
 "A rescan will be automatically started now.\n"
-msgstr ""
-"Отсутствуют изменения для сохранения.\n"
-"\n"
-"Ни один файл не был изменен и не было слияния.\n"
-"\n"
-"Сейчас автоматически запустится перечитывание репозитория.\n"
+msgstr "Нет изменения для коммита.\n\nНи один файл не был изменен и не было слияния.\n\nСейчас автоматически запустится перечитывание репозитория.\n"
 
 #: lib/commit.tcl:346
 msgid "No changes to commit."
-msgstr "Отсутствуют изменения для сохранения."
+msgstr "Нет изменения для коммита."
 
 #: lib/commit.tcl:360
 msgid "commit-tree failed:"
@@ -1487,11 +1396,11 @@ msgstr "Программа update-ref завершилась с ошибкой:"
 #: lib/commit.tcl:469
 #, tcl-format
 msgid "Created commit %s: %s"
-msgstr "Создано состояние %s: %s "
+msgstr "Создан коммит %s: %s "
 
 #: lib/console.tcl:59
 msgid "Working... please wait..."
-msgstr "В процессе... пожалуйста, ждите..."
+msgstr "В процессе… пожалуйста, ждите…"
 
 #: lib/console.tcl:186
 msgid "Success"
@@ -1542,16 +1451,10 @@ msgstr "Проверка базы объектов при помощи fsck"
 msgid ""
 "This repository currently has approximately %i loose objects.\n"
 "\n"
-"To maintain optimal performance it is strongly recommended that you compress "
-"the database.\n"
+"To maintain optimal performance it is strongly recommended that you compress the database.\n"
 "\n"
 "Compress the database now?"
-msgstr ""
-"Этот репозиторий сейчас содержит примерно %i свободных объектов\n"
-"\n"
-"Для лучшей производительности рекомендуется сжать базу данных.\n"
-"\n"
-"Сжать базу данных сейчас?"
+msgstr "Этот репозиторий сейчас содержит примерно %i свободных объектов\n\nДля лучшей производительности рекомендуется сжать базу данных.\n\nСжать базу данных сейчас?"
 
 #: lib/date.tcl:25
 #, tcl-format
@@ -1565,41 +1468,27 @@ msgid ""
 "\n"
 "%s has no changes.\n"
 "\n"
-"The modification date of this file was updated by another application, but "
-"the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may have "
-"the same state."
-msgstr ""
-"Изменений не обнаружено.\n"
+"The modification date of this file was updated by another application, but the content within the file was not changed.\n"
 "\n"
-"в %s отсутствуют изменения.\n"
-"\n"
-"Дата изменения файла была обновлена другой программой, но содержимое файла "
-"осталось прежним.\n"
-"\n"
-"Сейчас будет запущено перечитывание репозитория, чтобы найти подобные файлы."
+"A rescan will be automatically started to find other files which may have the same state."
+msgstr "Изменений не обнаружено.\n\nв %s отсутствуют изменения.\n\nДата изменения файла была обновлена другой программой, но содержимое файла осталось прежним.\n\nСейчас будет запущено перечитывание репозитория, чтобы найти подобные файлы."
 
 #: lib/diff.tcl:104
 #, tcl-format
 msgid "Loading diff of %s..."
-msgstr "Загрузка изменений в %s..."
+msgstr "Загрузка изменений %s…"
 
 #: lib/diff.tcl:125
 msgid ""
 "LOCAL: deleted\n"
 "REMOTE:\n"
-msgstr ""
-"ЛОКАЛЬНО: удалён\n"
-"ВНЕШНИЙ:\n"
+msgstr "ЛОКАЛЬНО: удалён\nВНЕШНИЙ:\n"
 
 #: lib/diff.tcl:130
 msgid ""
 "REMOTE: deleted\n"
 "LOCAL:\n"
-msgstr ""
-"ВНЕШНИЙ: удалён\n"
-"ЛОКАЛЬНО:\n"
+msgstr "ВНЕШНИЙ: удалён\nЛОКАЛЬНО:\n"
 
 #: lib/diff.tcl:137
 msgid "LOCAL:\n"
@@ -1631,9 +1520,7 @@ msgstr "* Двоичный файл (содержимое не показано)
 msgid ""
 "* Untracked file is %d bytes.\n"
 "* Showing only first %d bytes.\n"
-msgstr ""
-"* Размер неподготовленного файла %d байт.\n"
-"* Показано первых %d байт.\n"
+msgstr "* Размер неотслеживаемого файла %d байт.\n* Показано первых %d байт.\n"
 
 #: lib/diff.tcl:233
 #, tcl-format
@@ -1641,10 +1528,7 @@ msgid ""
 "\n"
 "* Untracked file clipped here by %s.\n"
 "* To see the entire file, use an external editor.\n"
-msgstr ""
-"\n"
-"* Неподготовленный файл обрезан: %s.\n"
-"* Чтобы увидеть весь файл, используйте программу-редактор.\n"
+msgstr "\n* Неотслеживаемый файл обрезан: %s.\n* Чтобы увидеть весь файл, используйте внешний редактор.\n"
 
 #: lib/diff.tcl:482
 msgid "Failed to unstage selected hunk."
@@ -1652,7 +1536,7 @@ msgstr "Не удалось исключить выбранную часть."
 
 #: lib/diff.tcl:489
 msgid "Failed to stage selected hunk."
-msgstr "Не удалось подготовить к сохранению выбранную часть."
+msgstr "Не удалось проиндексировать выбранный блок изменений."
 
 #: lib/diff.tcl:568
 msgid "Failed to unstage selected line."
@@ -1660,7 +1544,7 @@ msgstr "Не удалось исключить выбранную строку."
 
 #: lib/diff.tcl:576
 msgid "Failed to stage selected line."
-msgstr "Не удалось подготовить к сохранению выбранную строку."
+msgstr "Не удалось проиндексировать выбранную строку."
 
 #: lib/encoding.tcl:443
 msgid "Default"
@@ -1685,7 +1569,7 @@ msgstr "предупреждение"
 
 #: lib/error.tcl:94
 msgid "You must correct the above errors before committing."
-msgstr "Прежде чем сохранить, исправьте вышеуказанные ошибки."
+msgstr "Перед коммитом, исправьте вышеуказанные ошибки."
 
 #: lib/index.tcl:6
 msgid "Unable to unlock the index."
@@ -1699,9 +1583,7 @@ msgstr "Ошибка в индексе"
 msgid ""
 "Updating the Git index failed.  A rescan will be automatically started to "
 "resynchronize git-gui."
-msgstr ""
-"Не удалось обновить индекс Git. Состояние репозитория будет перечитано "
-"автоматически."
+msgstr "Не удалось обновить индекс Git. Состояние репозитория будет перечитано автоматически."
 
 #: lib/index.tcl:28
 msgid "Continue"
@@ -1714,32 +1596,30 @@ msgstr "Разблокировать индекс"
 #: lib/index.tcl:289
 #, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "Удаление %s из подготовленного"
+msgstr "Удаление %s из индекса"
 
 #: lib/index.tcl:328
 msgid "Ready to commit."
-msgstr "Подготовлено для сохранения"
+msgstr "Готов для коммита."
 
 #: lib/index.tcl:341
 #, tcl-format
 msgid "Adding %s"
-msgstr "Добавление %s..."
+msgstr "Добавление %s…"
 
 #: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in file %s?"
-msgstr "Отменить изменения в файле %s?"
+msgstr "Обратить изменения в файле %s?"
 
 #: lib/index.tcl:400
 #, tcl-format
 msgid "Revert changes in these %i files?"
-msgstr "Отменить изменения в %i файле(-ах)?"
+msgstr "Обратить изменения в %i файле(-ах)?"
 
 #: lib/index.tcl:408
 msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr ""
-"Любые изменения, не подготовленные к сохранению, будут потеряны при данной "
-"операции."
+msgstr "Любые непроиндексированные изменения, будут потеряны при обращении изменений."
 
 #: lib/index.tcl:411
 msgid "Do Nothing"
@@ -1747,38 +1627,28 @@ msgstr "Ничего не делать"
 
 #: lib/index.tcl:429
 msgid "Reverting selected files"
-msgstr "Удаление изменений в выбранных файлах"
+msgstr "Обращение изменений в выбранных файлах"
 
 #: lib/index.tcl:433
 #, tcl-format
 msgid "Reverting %s"
-msgstr "Отмена изменений в %s"
+msgstr "Обращение изменений в %s"
 
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
 "\n"
 "You must finish amending this commit before starting any type of merge.\n"
-msgstr ""
-"Невозможно выполнить слияние во время исправления.\n"
-"\n"
-"Завершите исправление данного состояния перед выполнением операции слияния.\n"
+msgstr "Невозможно выполнить слияние во время исправления.\n\nЗавершите исправление данного коммита перед выполнением операции слияния.\n"
 
 #: lib/merge.tcl:27
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before a merge can be performed.\n"
+"Another Git program has modified this repository since the last scan.  A rescan must be performed before a merge can be performed.\n"
 "\n"
 "The rescan will be automatically started now.\n"
-msgstr ""
-"Последнее прочитанное состояние репозитория не соответствует текущему.\n"
-"\n"
-"С момента последней проверки репозиторий был изменен другой программой Git. "
-"Необходимо перечитать репозиторий, прежде чем изменять текущую ветвь.\n"
-"\n"
-"Это будет сделано сейчас автоматически.\n"
+msgstr "Последнее прочитанное состояние репозитория не соответствует текущему.\n\nС момента последней проверки репозиторий был изменен другой программой Git. Необходимо перечитать репозиторий, прежде чем слияние может быть сделано.\n\nЭто будет сделано сейчас автоматически.\n"
 
 #: lib/merge.tcl:45
 #, tcl-format
@@ -1787,15 +1657,8 @@ msgid ""
 "\n"
 "File %s has merge conflicts.\n"
 "\n"
-"You must resolve them, stage the file, and commit to complete the current "
-"merge.  Only then can you begin another merge.\n"
-msgstr ""
-"Предыдущее слияние не завершено из-за конфликта.\n"
-"\n"
-"Для файла %s возник конфликт слияния.\n"
-"\n"
-"Разрешите конфликт, подготовьте файл и сохраните. Только после этого можно "
-"начать следующее слияние.\n"
+"You must resolve them, stage the file, and commit to complete the current merge.  Only then can you begin another merge.\n"
+msgstr "Предыдущее слияние не завершено из-за конфликта.\n\nДля файла %s возник конфликт слияния.\n\nРазрешите конфликт, добавьте файл в индекс и закоммитьте. Только после этого можно начать следующее слияние.\n"
 
 #: lib/merge.tcl:55
 #, tcl-format
@@ -1804,15 +1667,8 @@ msgid ""
 "\n"
 "File %s is modified.\n"
 "\n"
-"You should complete the current commit before starting a merge.  Doing so "
-"will help you abort a failed merge, should the need arise.\n"
-msgstr ""
-"Изменения не сохранены.\n"
-"\n"
-"Файл %s изменен.\n"
-"\n"
-"Подготовьте и сохраните изменения перед началом слияния. В случае "
-"необходимости это позволит прервать операцию слияния.\n"
+"You should complete the current commit before starting a merge.  Doing so will help you abort a failed merge, should the need arise.\n"
+msgstr "Вы находитесь в процессе изменений.\n\nФайл %s изменён.\n\nВы должны завершить текущий коммит перед началом слияния. В случае необходимости, это позволит прервать операцию слияния.\n"
 
 #: lib/merge.tcl:107
 #, tcl-format
@@ -1822,7 +1678,7 @@ msgstr "%s из %s"
 #: lib/merge.tcl:120
 #, tcl-format
 msgid "Merging %s and %s..."
-msgstr "Слияние %s и %s..."
+msgstr "Слияние %s и %s…"
 
 #: lib/merge.tcl:131
 msgid "Merge completed successfully."
@@ -1846,10 +1702,7 @@ msgid ""
 "Cannot abort while amending.\n"
 "\n"
 "You must finish amending this commit.\n"
-msgstr ""
-"Невозможно прервать исправление.\n"
-"\n"
-"Завершите текущее исправление сохраненного состояния.\n"
+msgstr "Невозможно прервать исправление.\n\nЗавершите текущее исправление коммита.\n"
 
 #: lib/merge.tcl:222
 msgid ""
@@ -1858,12 +1711,7 @@ msgid ""
 "Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
 "\n"
 "Continue with aborting the current merge?"
-msgstr ""
-"Прервать операцию слияния?\n"
-"\n"
-"Прерывание этой операции приведет к потере *ВСЕХ* несохраненных изменений.\n"
-"\n"
-"Продолжить?"
+msgstr "Прервать операцию слияния?\n\nПрерывание текущего слияния приведет к потере *ВСЕХ* несохраненных изменений.\n\nПродолжить?"
 
 #: lib/merge.tcl:228
 msgid ""
@@ -1872,12 +1720,7 @@ msgid ""
 "Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
 "\n"
 "Continue with resetting the current changes?"
-msgstr ""
-"Прервать операцию слияния?\n"
-"\n"
-"Прерывание этой операции приведет к потере *ВСЕХ* несохраненных изменений.\n"
-"\n"
-"Продолжить?"
+msgstr "Сбросить изменения?\n\nСброс изменений приведет к потере *ВСЕХ* несохраненных изменений.\n\nПродолжить?"
 
 #: lib/merge.tcl:239
 msgid "Aborting"
@@ -1901,11 +1744,11 @@ msgstr "Использовать базовую версию для разреш
 
 #: lib/mergetool.tcl:9
 msgid "Force resolution to this branch?"
-msgstr "Использовать версию этой ветви для разрешения конфликта?"
+msgstr "Использовать версию из этой ветки для разрешения конфликта?"
 
 #: lib/mergetool.tcl:10
 msgid "Force resolution to the other branch?"
-msgstr "Использовать версию другой ветви для разрешения конфликта?"
+msgstr "Использовать версию из другой ветки для разрешения конфликта?"
 
 #: lib/mergetool.tcl:14
 #, tcl-format
@@ -1915,19 +1758,12 @@ msgid ""
 "%s will be overwritten.\n"
 "\n"
 "This operation can be undone only by restarting the merge."
-msgstr ""
-"Внимание! Список изменений показывает только конфликтующие отличия.\n"
-"\n"
-"%s будет переписан.\n"
-"\n"
-"Это действие можно отменить только перезапуском операции слияния."
+msgstr "Внимание! Список изменений показывает только конфликтующие отличия.\n\n%s будет переписан.\n\nЭто действие можно отменить только перезапуском операции слияния."
 
 #: lib/mergetool.tcl:45
 #, tcl-format
 msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr ""
-"Файл %s, похоже, содержит необработанные конфликты. Продолжить подготовку к "
-"сохранению?"
+msgstr "Похоже, что файл %s содержит неразрешенные конфликты. Продолжить индексацию?"
 
 #: lib/mergetool.tcl:60
 #, tcl-format
@@ -1936,8 +1772,7 @@ msgstr "Добавляю результат разрешения для %s"
 
 #: lib/mergetool.tcl:141
 msgid "Cannot resolve deletion or link conflicts using a tool"
-msgstr ""
-"Программа слияния не обрабатывает конфликты с удалением или участием ссылок"
+msgstr "Программа слияния не обрабатывает конфликты с удалением или участием ссылок"
 
 #: lib/mergetool.tcl:146
 msgid "Conflict file does not exist"
@@ -1946,12 +1781,12 @@ msgstr "Конфликтующий файл не существует"
 #: lib/mergetool.tcl:264
 #, tcl-format
 msgid "Not a GUI merge tool: '%s'"
-msgstr "'%s' не является программой слияния"
+msgstr "«%s» не является программой слияния"
 
 #: lib/mergetool.tcl:268
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
-msgstr "Неизвестная программа слияния '%s'"
+msgstr "Неподдерживаемая программа слияния «%s»"
 
 #: lib/mergetool.tcl:303
 msgid "Merge tool is already running, terminate it?"
@@ -1962,9 +1797,7 @@ msgstr "Программа слияния уже работает. Прерва
 msgid ""
 "Error retrieving versions:\n"
 "%s"
-msgstr ""
-"Ошибка получения версий:\n"
-"%s"
+msgstr "Ошибка получения версий:\n%s"
 
 #: lib/mergetool.tcl:343
 #, tcl-format
@@ -1972,14 +1805,11 @@ msgid ""
 "Could not start the merge tool:\n"
 "\n"
 "%s"
-msgstr ""
-"Ошибка запуска программы слияния:\n"
-"\n"
-"%s"
+msgstr "Ошибка запуска программы слияния:\n\n%s"
 
 #: lib/mergetool.tcl:347
 msgid "Running merge tool..."
-msgstr "Запуск программы слияния..."
+msgstr "Запуск программы слияния…"
 
 #: lib/mergetool.tcl:375 lib/mergetool.tcl:383
 msgid "Merge tool failed."
@@ -1988,12 +1818,12 @@ msgstr "Ошибка выполнения программы слияния."
 #: lib/option.tcl:11
 #, tcl-format
 msgid "Invalid global encoding '%s'"
-msgstr "Ошибка в глобальной установке кодировки '%s'"
+msgstr "Неверная глобальная кодировка «%s»"
 
 #: lib/option.tcl:19
 #, tcl-format
 msgid "Invalid repo encoding '%s'"
-msgstr "Неверная кодировка репозитория: '%s'"
+msgstr "Неверная кодировка репозитория «%s»"
 
 #: lib/option.tcl:117
 msgid "Restore Defaults"
@@ -2022,7 +1852,7 @@ msgstr "Адрес электронной почты"
 
 #: lib/option.tcl:141
 msgid "Summarize Merge Commits"
-msgstr "Суммарный комментарий при слиянии"
+msgstr "Суммарное сообщение при слиянии"
 
 #: lib/option.tcl:142
 msgid "Merge Verbosity"
@@ -2042,11 +1872,11 @@ msgstr "Доверять времени модификации файла"
 
 #: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
-msgstr "Чистка ветвей слежения при получении изменений"
+msgstr "Чистка отслеживаемых веток при извлечении изменений"
 
 #: lib/option.tcl:148
 msgid "Match Tracking Branches"
-msgstr "Имя новой ветви взять из имен ветвей слежения"
+msgstr "Такое же имя, как и у отслеживаемой ветки"
 
 #: lib/option.tcl:149
 msgid "Blame Copy Only On Changed Files"
@@ -2066,11 +1896,11 @@ msgstr "Число строк в контексте diff"
 
 #: lib/option.tcl:153
 msgid "Commit Message Text Width"
-msgstr "Ширина текста комментария"
+msgstr "Ширина текста сообщения коммита"
 
 #: lib/option.tcl:154
 msgid "New Branch Name Template"
-msgstr "Шаблон для имени новой ветви"
+msgstr "Шаблон для имени новой ветки"
 
 #: lib/option.tcl:155
 msgid "Default File Contents Encoding"
@@ -2093,7 +1923,6 @@ msgstr "Изменить"
 msgid "Choose %s"
 msgstr "Выберите %s"
 
-# carbon copy
 #: lib/option.tcl:264
 msgid "pt."
 msgstr "pt."
@@ -2116,7 +1945,7 @@ msgstr "Чистка"
 
 #: lib/remote.tcl:173
 msgid "Fetch from"
-msgstr "Получение из"
+msgstr "Извлечение из"
 
 #: lib/remote.tcl:215
 msgid "Push to"
@@ -2132,7 +1961,7 @@ msgstr "Добавить внешний репозиторий"
 
 #: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
 msgid "Add"
-msgstr ""
+msgstr "Добавить"
 
 #: lib/remote_add.tcl:37
 msgid "Remote Details"
@@ -2148,7 +1977,7 @@ msgstr "Следующая операция"
 
 #: lib/remote_add.tcl:65
 msgid "Fetch Immediately"
-msgstr "Скачать сразу"
+msgstr "Сразу извлечь изменения"
 
 #: lib/remote_add.tcl:71
 msgid "Initialize Remote Repository and Push"
@@ -2165,27 +1994,27 @@ msgstr "Укажите название внешнего репозитория.
 #: lib/remote_add.tcl:114
 #, tcl-format
 msgid "'%s' is not an acceptable remote name."
-msgstr "Недопустимое название внешнего репозитория '%s'."
+msgstr "«%s» не является допустимым именем внешнего репозитория."
 
 #: lib/remote_add.tcl:125
 #, tcl-format
 msgid "Failed to add remote '%s' of location '%s'."
-msgstr "Не удалось добавить '%s' из '%s'. "
+msgstr "Не удалось добавить «%s» из «%s». "
 
 #: lib/remote_add.tcl:133 lib/transport.tcl:6
 #, tcl-format
 msgid "fetch %s"
-msgstr "получение %s"
+msgstr "извлечение %s"
 
 #: lib/remote_add.tcl:134
 #, tcl-format
 msgid "Fetching the %s"
-msgstr "Получение %s"
+msgstr "Извлечение %s"
 
 #: lib/remote_add.tcl:157
 #, tcl-format
 msgid "Do not know how to initialize repository at location '%s'."
-msgstr "Невозможно инициализировать репозиторий в '%s'."
+msgstr "Невозможно инициализировать репозиторий в «%s»."
 
 #: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
 #: lib/transport.tcl:81
@@ -2200,7 +2029,7 @@ msgstr "Настройка %s (в %s)"
 
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Branch Remotely"
-msgstr "Удаление ветви во внешнем репозитории"
+msgstr "Удаление ветки во внешнем репозитории"
 
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -2216,7 +2045,7 @@ msgstr "Указанное положение:"
 
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
-msgstr "Ветви"
+msgstr "Ветки"
 
 #: lib/remote_branch_delete.tcl:109
 msgid "Delete Only If"
@@ -2228,7 +2057,7 @@ msgstr "Слияние с:"
 
 #: lib/remote_branch_delete.tcl:152
 msgid "A branch is required for 'Merged Into'."
-msgstr "Для опции 'Слияние с' требуется указать ветвь."
+msgstr "Для операции «Слияние с» требуется указать ветку."
 
 #: lib/remote_branch_delete.tcl:184
 #, tcl-format
@@ -2236,28 +2065,23 @@ msgid ""
 "The following branches are not completely merged into %s:\n"
 "\n"
 " - %s"
-msgstr ""
-"Следующие ветви могут быть объединены с %s при помощи операции слияния:\n"
-"\n"
-" - %s"
+msgstr "Следующие ветки могут быть объединены с %s при помощи операции слияния:\n\n - %s"
 
 #: lib/remote_branch_delete.tcl:189
 #, tcl-format
 msgid ""
 "One or more of the merge tests failed because you have not fetched the "
 "necessary commits.  Try fetching from %s first."
-msgstr ""
-"Некоторые тесты на слияние не прошли, потому что Вы не получили необходимые "
-"состояния. Попытайтесь получить их из %s."
+msgstr "Некоторые тесты на слияние не прошли, потому что вы не извлекли необходимые коммиты. Попытайтесь извлечь их из %s."
 
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
-msgstr "Укажите одну или несколько ветвей для удаления."
+msgstr "Укажите одну или несколько веток для удаления."
 
 #: lib/remote_branch_delete.tcl:226
 #, tcl-format
 msgid "Deleting branches from %s"
-msgstr "Удаление ветвей из %s"
+msgstr "Удаление веток из %s"
 
 #: lib/remote_branch_delete.tcl:292
 msgid "No repository selected."
@@ -2266,7 +2090,7 @@ msgstr "Не указан репозиторий."
 #: lib/remote_branch_delete.tcl:297
 #, tcl-format
 msgid "Scanning %s..."
-msgstr "Перечитывание %s... "
+msgstr "Перечитывание %s…"
 
 #: lib/search.tcl:21
 msgid "Find:"
@@ -2352,7 +2176,7 @@ msgstr "Ваш публичный ключ OpenSSH"
 
 #: lib/sshkey.tcl:78
 msgid "Generating..."
-msgstr "Создание..."
+msgstr "Создание…"
 
 #: lib/sshkey.tcl:84
 #, tcl-format
@@ -2360,10 +2184,7 @@ msgid ""
 "Could not start ssh-keygen:\n"
 "\n"
 "%s"
-msgstr ""
-"Ошибка запуска ssh-keygen:\n"
-"\n"
-"%s"
+msgstr "Ошибка запуска ssh-keygen:\n\n%s"
 
 #: lib/sshkey.tcl:111
 msgid "Generation failed."
@@ -2381,7 +2202,7 @@ msgstr "Ваш ключ находится в: %s"
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%s ... %*i из %*i %s (%3i%%)"
+msgstr "%s … %*i из %*i %s (%3i%%)"
 
 #: lib/tools.tcl:75
 #, tcl-format
@@ -2431,7 +2252,7 @@ msgstr "Описание вспомогательной операции"
 
 #: lib/tools_dlg.tcl:48
 msgid "Use '/' separators to create a submenu tree:"
-msgstr "Используйте '/' для создания подменю"
+msgstr "Используйте «/» для создания подменю"
 
 #: lib/tools_dlg.tcl:61
 msgid "Command:"
@@ -2464,16 +2285,14 @@ msgstr "Укажите название вспомогательной опер
 #: lib/tools_dlg.tcl:129
 #, tcl-format
 msgid "Tool '%s' already exists."
-msgstr "Вспомогательная операция '%s' уже существует."
+msgstr "Вспомогательная операция «%s» уже существует."
 
 #: lib/tools_dlg.tcl:151
 #, tcl-format
 msgid ""
 "Could not add tool:\n"
 "%s"
-msgstr ""
-"Ошибка добавления программы:\n"
-"%s"
+msgstr "Ошибка добавления программы:\n%s"
 
 #: lib/tools_dlg.tcl:190
 msgid "Remove Tool"
@@ -2507,9 +2326,8 @@ msgstr "OK"
 #: lib/transport.tcl:7
 #, tcl-format
 msgid "Fetching new changes from %s"
-msgstr "Получение изменений из %s "
+msgstr "Извлечение изменений из %s "
 
-# carbon copy
 #: lib/transport.tcl:18
 #, tcl-format
 msgid "remote prune %s"
@@ -2518,7 +2336,7 @@ msgstr "чистка внешнего %s"
 #: lib/transport.tcl:19
 #, tcl-format
 msgid "Pruning tracking branches deleted from %s"
-msgstr "Чистка ветвей слежения, удаленных из %s"
+msgstr "Чистка отслеживаемых веток, удалённых из %s"
 
 #: lib/transport.tcl:26
 #, tcl-format
@@ -2537,11 +2355,11 @@ msgstr "Отправка %s %s в %s"
 
 #: lib/transport.tcl:100
 msgid "Push Branches"
-msgstr "Отправить изменения в ветвях"
+msgstr "Отправить ветки"
 
 #: lib/transport.tcl:114
 msgid "Source Branches"
-msgstr "Исходные ветви"
+msgstr "Исходные ветки"
 
 #: lib/transport.tcl:131
 msgid "Destination Repository"
@@ -2553,7 +2371,7 @@ msgstr "Настройки отправки"
 
 #: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
-msgstr "Намеренно переписать существующую ветвь (возможна потеря изменений)"
+msgstr "Принудительно перезаписать существующую ветку (возможна потеря изменений)"
 
 #: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
-- 
2.9.0.windows.1

