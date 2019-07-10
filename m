Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09EED1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGJNkA (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 09:40:00 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46644 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJNj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 09:39:59 -0400
Received: by mail-qk1-f176.google.com with SMTP id r4so1839270qkm.13
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZltTLf29TDlYWL/F/Wt9BWr/uUBageMprjH7a8Vobo=;
        b=gpzSC/fx11xXP0TWlEhja8+P0NUiv+ghZiaWk8ql+NdHXe8yd6H/h768Cm1xivEehc
         L59Qb65+Tg46XbJ7y64/Bw+hB670aIKcOGKkzjO3mJ0oLbGkITpOdT0lzDTD8VRcBoLe
         yPMsE/62i9fgX+SDAsep3vuQX9nixFNlqEElNcqQkyV+ES1BgsSm8owb4/FWIVYzWUcY
         O7d0MZIl5nRCVCXbi3yqN6QCFnWuTfNgfDkCS3957wxZC4uCsH6+L2oMsxVKxs5YQmfH
         KUkH7WwclAz9r/eO9mP+3JXHNvUbsE9zxWU4gxs/8RoS/uhEHece9YzX7RSxVT8BQ9nE
         SRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZltTLf29TDlYWL/F/Wt9BWr/uUBageMprjH7a8Vobo=;
        b=tLy1Y018JDvCJwEHRh1OfnijcdQmvJdpS75GqpPS5MeFcpT7nkSYOvUOvyE48m76U4
         Lb/WJyPg81dVAPG0+1q2GdeEWo7XQ57WFy8vxpfM29+oiu4dNcLmnayjn9IlR79oCIDa
         vTN26La3aPMm82ie9yCLNnZ3tJD+T1SotUB2PChTEFC4Euv21ycx9vTH0mg/MIk0fexf
         AaqlRbBm1krV/69+Ky73ST+/t+sHEx9K2gPSBR65WA4Hm+wFl3eOdB2tt9WQQTGsKkeI
         XaoptbHtMzF3xDZQGKvOwjvsXM6wHIrOthIFiHhSNkPIr+WGbM2QK4y2BrmSbSE9wnsW
         UcEA==
X-Gm-Message-State: APjAAAUGRPTkR6bVGrn6ocXs6KVX3Xa2jKOMSsxkBRS4BMk6ivcOJFmm
        WIZ8mnTmWI/+3bBtMV4DXQs=
X-Google-Smtp-Source: APXvYqyAli9+V8YPmL9HKlFHTZmaqfEfkq2zoZWxqyFniWQ94LT8TFSA5zZ2UES79KrUNpjrlxG5TA==
X-Received: by 2002:a05:620a:16a6:: with SMTP id s6mr23123133qkj.39.1562765998328;
        Wed, 10 Jul 2019 06:39:58 -0700 (PDT)
Received: from localhost.localdomain ([186.158.9.226])
        by smtp.gmail.com with ESMTPSA id u19sm1221019qka.35.2019.07.10.06.39.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 06:39:57 -0700 (PDT)
From:   claudiojpaz <claudiojpaz@gmail.com>
To:     christopher.diaz.riv@gmail.com, worldhello.net@gmail.com,
        git@vger.kernel.org
Cc:     claudiojpaz <claudiojpaz@gmail.com>
Subject: [PATCH] l10n: es: Fix accent mark in several words
Date:   Wed, 10 Jul 2019 10:39:03 -0300
Message-Id: <20190710133903.15415-1-claudiojpaz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: claudiojpaz <claudiojpaz@gmail.com>
---
 po/es.po | 78 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/po/es.po b/po/es.po
index 0a3e456d6..1e172caf0 100644
--- a/po/es.po
+++ b/po/es.po
@@ -845,7 +845,7 @@ msgstr "solo guardar"
 
 #: archive.c:464
 msgid "compress faster"
-msgstr "comprimir mas rápido"
+msgstr "comprimir más rápido"
 
 #: archive.c:472
 msgid "compress better"
@@ -947,7 +947,7 @@ msgstr "timestamp muy largo para este sistema: %<PRIuMAX>"
 #: attr.c:211
 #, c-format
 msgid "%.*s is not a valid attribute name"
-msgstr "%.*s no es un nombre de atributo valido"
+msgstr "%.*s no es un nombre de atributo válido"
 
 #: attr.c:368
 #, c-format
@@ -975,7 +975,7 @@ msgstr "¡No podemos biseccionar más!\n"
 #: bisect.c:733
 #, c-format
 msgid "Not a valid commit name %s"
-msgstr "No es un nombre de commit valido %s"
+msgstr "No es un nombre de commit válido %s"
 
 #: bisect.c:758
 #, c-format
@@ -1199,7 +1199,7 @@ msgstr "No rastreando: información ambigua para la referencia %s"
 #: branch.c:189
 #, c-format
 msgid "'%s' is not a valid branch name."
-msgstr "'%s' no es un nombre valido de rama."
+msgstr "'%s' no es un nombre válido de rama."
 
 #: branch.c:208
 #, c-format
@@ -1246,7 +1246,7 @@ msgstr ""
 #: branch.c:281
 #, c-format
 msgid "Not a valid object name: '%s'."
-msgstr "Nombre de objeto no valido: '%s'."
+msgstr "Nombre de objeto no válido: '%s'."
 
 #: branch.c:301
 #, c-format
@@ -1256,7 +1256,7 @@ msgstr "Nombre de objeto ambiguo: '%s'."
 #: branch.c:306
 #, c-format
 msgid "Not a valid branch point: '%s'."
-msgstr "Punto de rama no valido: '%s'."
+msgstr "Punto de rama no válido: '%s'."
 
 #: branch.c:359
 #, c-format
@@ -3215,7 +3215,7 @@ msgstr "se esperaba '%s', se recibió '%s'"
 #: fetch-pack.c:1234
 #, c-format
 msgid "unexpected acknowledgment line: '%s'"
-msgstr "linea de confirmación inesperada: '%s'"
+msgstr "línea de confirmación inesperada: '%s'"
 
 #: fetch-pack.c:1239
 #, c-format
@@ -3430,10 +3430,10 @@ msgid_plural ""
 "The most similar commands are"
 msgstr[0] ""
 "\n"
-"El comando mas similar es"
+"El comando más similar es"
 msgstr[1] ""
 "\n"
-"Los comandos mas similares son"
+"Los comandos más similares son"
 
 #: help.c:714
 msgid "git version [<options>]"
@@ -4298,7 +4298,7 @@ msgstr "switch desconocido `%c'"
 #: parse-options.c:737
 #, c-format
 msgid "unknown non-ascii option in string: `%s'"
-msgstr "opcion desconocida en string no ascii: `%s'"
+msgstr "opción desconocida en string no ascii: `%s'"
 
 #: parse-options.c:759
 msgid "..."
@@ -4829,7 +4829,7 @@ msgid ""
 "Dropped commits (newer to older):\n"
 msgstr ""
 "Peligro: algunos commits pueden haber sido botados de forma accidental.\n"
-"Commits botados (empezando con el mas nuevo):\n"
+"Commits botados (empezando con el más nuevo):\n"
 
 #: rebase-interactive.c:180
 #, c-format
@@ -5119,7 +5119,7 @@ msgstr "formato: átomo %%(then) usado sin átomo %%(if)"
 #: ref-filter.c:751
 #, c-format
 msgid "format: %%(then) atom used more than once"
-msgstr "formato: átomo %%(then) usado mas de una vez"
+msgstr "formato: átomo %%(then) usado más de una vez"
 
 #: ref-filter.c:753
 #, c-format
@@ -5139,7 +5139,7 @@ msgstr "formato: átomo %%(else) usado sin un átomo %%(then)"
 #: ref-filter.c:785
 #, c-format
 msgid "format: %%(else) atom used more than once"
-msgstr "formato: átomo %%(else) usado mas de una vez"
+msgstr "formato: átomo %%(else) usado más de una vez"
 
 #: ref-filter.c:800
 #, c-format
@@ -7013,7 +7013,7 @@ msgstr "entrada de submódulo '%s' (%s) es un %s, no un commit"
 
 #: submodule.c:1147 builtin/branch.c:672 builtin/submodule--helper.c:1988
 msgid "Failed to resolve HEAD as a valid ref."
-msgstr "Falló al resolver HEAD como un ref valido."
+msgstr "Falló al resolver HEAD como un ref válido."
 
 #: submodule.c:1481
 #, c-format
@@ -7927,11 +7927,11 @@ msgstr[1] "Tu stash actualmente tiene %d entradas"
 
 #: wt-status.c:928
 msgid "Submodules changed but not updated:"
-msgstr "Submodulos cambiados pero no actualizados:"
+msgstr "Submódulos cambiados pero no actualizados:"
 
 #: wt-status.c:930
 msgid "Submodule changes to be committed:"
-msgstr "Submodulos cambiados listos para realizar commit:"
+msgstr "Submódulos cambiados listos para realizar commit:"
 
 #: wt-status.c:1012
 msgid ""
@@ -7999,11 +7999,11 @@ msgstr[1] "Los últimos comandos realizados (%d comandos realizados):"
 #: wt-status.c:1298
 #, c-format
 msgid "  (see more in file %s)"
-msgstr "  (ver mas en el archivo %s)"
+msgstr "  (ver más en el archivo %s)"
 
 #: wt-status.c:1303
 msgid "No commands remaining."
-msgstr "No quedan mas comandos."
+msgstr "No quedan más comandos."
 
 #: wt-status.c:1306
 #, c-format
@@ -8444,7 +8444,7 @@ msgstr ""
 "\n"
 "\tgit rm --cached %s\n"
 "\n"
-"Vea \"git help submodule\" para mas información."
+"Vea \"git help submodule\" para más información."
 
 #: builtin/add.c:354
 #, c-format
@@ -8662,7 +8662,7 @@ msgid ""
 "already introduced the same changes; you might want to skip this patch."
 msgstr ""
 "Sin cambios - olvidaste usar 'git add'?\n"
-"Si no hay nada en el área de stage, las posibilidad es que algo mas\n"
+"Si no hay nada en el área de stage, las posibilidad es que algo más\n"
 "ya haya introducido el mismo cambio; tal vez quieras omitir este parche."
 
 #: builtin/am.c:1830
@@ -9261,11 +9261,11 @@ msgstr "Ignorar diferencias de espacios en blanco"
 
 #: builtin/blame.c:810
 msgid "color redundant metadata from previous line differently"
-msgstr "colorear metadata redundante de lineas previas de manera diferente"
+msgstr "colorear metadata redundante de líneas previas de manera diferente"
 
 #: builtin/blame.c:811
 msgid "color lines by age"
-msgstr "colorear lineas por edad"
+msgstr "colorear líneas por edad"
 
 #: builtin/blame.c:818
 msgid "Use an experimental heuristic to improve diffs"
@@ -10497,7 +10497,7 @@ msgstr[1] "Se eliminarán los siguientes objetos:"
 
 #: builtin/clean.c:845
 msgid "No more files to clean, exiting."
-msgstr "No hay mas archivos para limpiar, saliendo."
+msgstr "No hay más archivos para limpiar, saliendo."
 
 #: builtin/clean.c:907
 msgid "do not print names of files removed"
@@ -11005,7 +11005,7 @@ msgid ""
 "it empty. You can repeat your command with --allow-empty, or you can\n"
 "remove the commit entirely with \"git reset HEAD^\".\n"
 msgstr ""
-"Has solicitado un amend en tu commit mas reciente, pero hacerlo lo \n"
+"Has solicitado un amend en tu commit más reciente, pero hacerlo lo \n"
 "vaciaría. Puedes repetir el comando con --alow-empty, o puedes eliminar\n"
 "el commit completamente con \"git reset HEAD^\".\n"
 
@@ -16295,7 +16295,7 @@ msgstr ""
 "Actualizaciones fueron rechazadas porque la punta de tu rama actual está\n"
 "detrás de su contraparte remota. Integra los cambios remotos (es decir\n"
 "'git pull ...') antes de hacer push de nuevo.\n"
-"Mira 'Note about fast-forwards' en 'git push --help' para mas detalles."
+"Mira 'Note about fast-forwards' en 'git push --help' para más detalles."
 
 #: builtin/push.c:282
 msgid ""
@@ -19335,7 +19335,7 @@ msgstr "Submódulo '%s' (%s) no registrado para ruta '%s'\n"
 #: builtin/submodule--helper.c:1186
 msgid "Remove submodule working trees even if they contain local changes"
 msgstr ""
-"Remover arboles de trabajo de submódulos incluso si contienen cambios locales"
+"Remover árboles de trabajo de submódulos incluso si contienen cambios locales"
 
 #: builtin/submodule--helper.c:1187
 msgid "Unregister all submodules"
@@ -19408,13 +19408,13 @@ msgstr "no se pudo obtener el directorio de submódulo para '%s'"
 #: builtin/submodule--helper.c:1473
 #, c-format
 msgid "Invalid update mode '%s' for submodule path '%s'"
-msgstr "Modo de actualización inválido '%s' para ruta de submodulo '%s'"
+msgstr "Modo de actualización inválido '%s' para ruta de submódulo '%s'"
 
 #: builtin/submodule--helper.c:1477
 #, c-format
 msgid "Invalid update mode '%s' configured for submodule path '%s'"
 msgstr ""
-"Modo de actualización inválido '%s' configurado para ruta de submodulo '%s'"
+"Modo de actualización inválido '%s' configurado para ruta de submódulo '%s'"
 
 #: builtin/submodule--helper.c:1570
 #, c-format
@@ -19488,7 +19488,7 @@ msgid ""
 "Submodule (%s) branch configured to inherit branch from superproject, but "
 "the superproject is not on any branch"
 msgstr ""
-"Rama de submódulo (%s)  configurada para heredar rama del superproyecto, "
+"Rama de submódulo (%s) configurada para heredar rama del superproyecto, "
 "pero el superproyecto no está en ninguna rama"
 
 #: builtin/submodule--helper.c:2060
@@ -19510,7 +19510,7 @@ msgstr "revisar is es seguro escribir el archivo .gitmodules"
 
 #: builtin/submodule--helper.c:2159
 msgid "unset the config in the .gitmodules file"
-msgstr "desconfigura la opcion en elarchivo .gitmodules"
+msgstr "desconfigura la opción en el archivo .gitmodules"
 
 #: builtin/submodule--helper.c:2164
 msgid "git submodule--helper config <name> [<value>]"
@@ -19538,7 +19538,7 @@ msgstr "%s no soporta --super-prefix"
 #: builtin/submodule--helper.c:2241
 #, c-format
 msgid "'%s' is not a valid submodule--helper subcommand"
-msgstr "'%s' no es un comando submodule--helper valido"
+msgstr "'%s' no es un comando submodule--helper válido"
 
 #: builtin/symbolic-ref.c:8
 msgid "git symbolic-ref [<options>] <name> [<ref>]"
@@ -19923,7 +19923,7 @@ msgstr ""
 
 #: builtin/update-index.c:1021
 msgid "with --stdin: input lines are terminated by null bytes"
-msgstr "con --stdin: las lineas de entrada son terminadas con bytes nulos"
+msgstr "con --stdin: las líneas de entrada son terminadas con bytes nulos"
 
 #: builtin/update-index.c:1023
 msgid "read list of paths to be updated from standard input"
@@ -20789,11 +20789,11 @@ msgstr "no-op (compatibilidad con versiones anteriores)"
 
 #: parse-options.h:296
 msgid "be more verbose"
-msgstr "ser mas verboso"
+msgstr "ser más verboso"
 
 #: parse-options.h:298
 msgid "be more quiet"
-msgstr "ser mas discreto"
+msgstr "ser más discreto"
 
 #: parse-options.h:304
 msgid "use <n> digits to display SHA-1s"
@@ -21110,7 +21110,7 @@ msgstr "Programa divisor de mbox simple de UNIX"
 
 #: command-list.h:121
 msgid "Join two or more development histories together"
-msgstr "Junta dos o mas historiales de desarrollo juntos"
+msgstr "Junta dos o más historiales de desarrollo juntos"
 
 #: command-list.h:122
 msgid "Find as good common ancestors as possible for a merge"
@@ -22541,7 +22541,7 @@ msgstr ""
 "J - dejar este hunk por definir, ver siguiente hunk\n"
 "k - dejar este hunk por definir, ver hunk previo por definir\n"
 "K - dejar este hunk por definir, ver hunk previo\n"
-"s - dividir el  hunk actual en hunks mas pequeños\n"
+"s - dividir el  hunk actual en hunks más pequeños\n"
 "e - editar manualmente el hunk actual\n"
 "? - imprimir ayuda\n"
 
@@ -22687,7 +22687,7 @@ msgstr "No hay más pedazos para el ir\n"
 
 #: git-add--interactive.perl:1529
 msgid "go to which hunk (<ret> to see more)? "
-msgstr "a que hunk ir (<enter> para ver mas)? "
+msgstr "a que hunk ir (<enter> para ver más)? "
 
 #: git-add--interactive.perl:1531
 msgid "go to which hunk? "
@@ -23017,7 +23017,7 @@ msgstr ""
 "    Este comportamiento is controlado por el valor de configuración "
 "sendemail.confirm.\n"
 "\n"
-"    Para mas información, ejecuta 'git send-email --help'.\n"
+"    Para más información, ejecuta 'git send-email --help'.\n"
 "    Para mantener el comportamiento actual, pero evitar este mensaje,\n"
 "    ejecuta 'git config --global sendemail.confirm auto'.\n"
 "\n"
@@ -23140,7 +23140,7 @@ msgstr "no es posible abrir %s: %s\n"
 #: git-send-email.perl:1930
 #, perl-format
 msgid "%s: patch contains a line longer than 998 characters"
-msgstr "%s: el parche contiene una línea con mas de 998 caracteres"
+msgstr "%s: el parche contiene una línea con más de 998 caracteres"
 
 #: git-send-email.perl:1947
 #, perl-format
-- 
2.20.1

