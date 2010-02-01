From: =?UTF-8?q?Alejandro=20Riveira=20Fern=C3=A1ndez?= 
	<alejandro.riveira@gmail.com> (by way of Alejandro Riveira
	=?UTF-8?B?RmVybsOhbmRleg==?= <ariveira@gmail.com>)
Subject: [PATCH]     git gui spanish translation.
Date: Mon, 1 Feb 2010 20:51:03 +0100
Message-ID: <4b69946c.0f67f10a.25e8.03e1@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Feb 03 16:21:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nch2m-0008CL-GL
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 16:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab0BCPVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 10:21:22 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-ew0-f228.google.com ([209.85.219.228]:62196 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702Ab0BCPVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 10:21:20 -0500
Received: by ewy28 with SMTP id 28so1537402ewy.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:date
         :resent-date:resent-from:subject:resent-message-id:resent-to
         :resent-cc;
        bh=KwzE4qA1r2zDAd7mH1Gr+PJOmHH93TKZT/AhXXDhKns=;
        b=N/93C/uah33bvDqFj7ruT7yMO1A2CxIdsRFRWCo32OLKwZG3ejL3BygEjtDE3WaGg1
         b1IILCMAcYJDlIchk8lQE/vEatQFyfv+2/cCDU5vi28gbxl4wpHTx/GXxpLPE1YoMdxb
         UAlOokWMOhsVioPKPvtEMIIfhV9uKfmipGoc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:resent-date:resent-from:subject
         :resent-message-id:resent-to:resent-cc;
        b=JaZOgjGNSDgsAeDeKfY9L81A/L/QRnNOZm4sFb55fXG9KTwnE94rIXNpxw68/BvImz
         zHnRXgVaZu4oNUg6XqbLni+4w2mkDD8g17T+l7g5tkshXmkp6ip9A3tGNPCmhDi/aO3G
         +4nLrrB5OlCjrlZUjwg0cV9/oEacwB3W0YFCk=
Received: by 10.213.37.206 with SMTP id y14mr7385609ebd.4.1265210477618;
        Wed, 03 Feb 2010 07:21:17 -0800 (PST)
Received: from varda (121.Red-88-24-214.staticIP.rima-tde.net [88.24.214.121])
        by mx.google.com with ESMTPS id 15sm5457461ewy.4.2010.02.03.07.21.14
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 07:21:16 -0800 (PST)
Apparently-To: <ariveira@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138836>

     It is the first try maybe we can later come up with
    better translations for some verbs and nouns that do
    not have a good short translation in spanish ...
---
 git-gui/po/es.po | 2546 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 2546 insertions(+), 0 deletions(-)
 create mode 100644 git-gui/po/es.po

diff --git a/git-gui/po/es.po b/git-gui/po/es.po
new file mode 100644
index 0000000..7e1cd34
--- /dev/null
+++ b/git-gui/po/es.po
@@ -0,0 +1,2546 @@
+# git-gui translation to spanish
+# Copyright (C) 2010 "Shawn O. Pearce" <spearce@spearce.org>
+# This file is distributed under the same license as the git-gui packa=
ge.
+# alejandro Riveira Fern=C3=A1ndez <ariveira@gmail.com>, 2010.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2008-12-08 08:31-0800\n"
+"PO-Revision-Date: 2010-02-03 15:59+0100\n"
+"Last-Translator: Alejandro Riveira Fern=C3=A1ndez <ariveira@gmail.com=
>\n"
+"Language-Team: \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
+#: git-gui.sh:866
+msgid "git-gui: fatal error"
+msgstr "git-gui: erro fatal"
+
+#: git-gui.sh:689
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "Fuente especificada no v=C3=A1lida en %s:"
+
+#: git-gui.sh:723
+msgid "Main Font"
+msgstr "Fuente Principal"
+
+#: git-gui.sh:724
+msgid "Diff/Console Font"
+msgstr "Fuente para Parches/Consola"
+
+#: git-gui.sh:738
+msgid "Cannot find git in PATH."
+msgstr "git no se encontra en PATH."
+
+#: git-gui.sh:765
+msgid "Cannot parse Git version string:"
+msgstr "No se puede analizar la cadena de version de Git:"
+
+#: git-gui.sh:783
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
+"No se puede determinar la version de Git,\n"
+"\n"
+"%s dice que es la version '%s',\n"
+"\n"
+"%s requeire al menos Git 1.5.0 o superior.\n"
+"\n"
+"Asumir que '%s' es versi=C3=B3n 1.5.0.?\n"
+
+#: git-gui.sh:1062
+msgid "Git directory not found:"
+msgstr "Directorio Git no encontrado:"
+
+#: git-gui.sh:1069
+msgid "Cannot move to top of working directory:"
+msgstr "No se ha podido cambiar al directorio de trabajo superior:"
+
+#: git-gui.sh:1076
+msgid "Cannot use funny .git directory:"
+msgstr "No se puede usar un directorio .git \"extra=C3=B1o\":"
+
+#: git-gui.sh:1081
+msgid "No working directory"
+msgstr "No hay directorio de trabajo"
+
+#: git-gui.sh:1247 lib/checkout_op.tcl:305
+msgid "Refreshing file status..."
+msgstr "Actualizando el estado del fichero..."
+
+#: git-gui.sh:1303
+msgid "Scanning for modified files ..."
+msgstr "Buscando ficheros modificados ..."
+
+#: git-gui.sh:1367
+msgid "Calling prepare-commit-msg hook..."
+msgstr "Llamando al gancho prepare-commit-hook..."
+
+#: git-gui.sh:1384
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "Revisi=C3=B3n rechazada por el gancho prepare-commit-msg."
+
+#: git-gui.sh:1542 lib/browser.tcl:246
+msgid "Ready."
+msgstr "Listo."
+
+#: git-gui.sh:1726
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr "Mostrando solo %s de %s ficheros."
+
+#: git-gui.sh:1819
+msgid "Unmodified"
+msgstr "No modificado"
+
+#: git-gui.sh:1821
+msgid "Modified, not staged"
+msgstr "Modificado, no preparado"
+
+#: git-gui.sh:1822 git-gui.sh:1830
+msgid "Staged for commit"
+msgstr "Preparado para nueva revisi=C3=B3n"
+
+#: git-gui.sh:1823 git-gui.sh:1831
+msgid "Portions staged for commit"
+msgstr "Secciones preparadas para nueva revisi=C3=B3n"
+
+#: git-gui.sh:1824 git-gui.sh:1832
+msgid "Staged for commit, missing"
+msgstr "Preparado para nueva revisi=C3=B3n, faltan"
+
+#: git-gui.sh:1826
+msgid "File type changed, not staged"
+msgstr "Tipo de fichero ha cambiado, no preparado"
+
+#: git-gui.sh:1827
+msgid "File type changed, staged"
+msgstr "Tipo de fichero ha cambiado, preparado"
+
+#: git-gui.sh:1829
+msgid "Untracked, not staged"
+msgstr "No registrado, no preparado"
+
+#: git-gui.sh:1834
+msgid "Missing"
+msgstr "Falta"
+
+#: git-gui.sh:1835
+msgid "Staged for removal"
+msgstr "Preparado para borrar"
+
+#: git-gui.sh:1836
+msgid "Staged for removal, still present"
+msgstr "Preparado para borrado, todav=C3=ADa presente"
+
+#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
+#: git-gui.sh:1842 git-gui.sh:1843
+msgid "Requires merge resolution"
+msgstr "Requiere la resoluci=C3=B3n de conflictos"
+
+#: git-gui.sh:1878
+msgid "Starting gitk... please wait..."
+msgstr "Ejecutando gitk... por favor espere..."
+
+#: git-gui.sh:1887
+msgid "Couldn't find gitk in PATH"
+msgstr "No se ha podido encontrar gitk en PATH"
+
+#: git-gui.sh:2280 lib/choose_repository.tcl:36
+msgid "Repository"
+msgstr "Repositorio"
+
+#: git-gui.sh:2281
+msgid "Edit"
+msgstr "Editar"
+
+#: git-gui.sh:2283 lib/choose_rev.tcl:561
+msgid "Branch"
+msgstr "Rama"
+
+#: git-gui.sh:2286 lib/choose_rev.tcl:548
+msgid "Commit@@noun"
+msgstr "Revisi=C3=B3n"
+
+#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+msgid "Merge"
+msgstr "Fusi=C3=B3n"
+
+#: git-gui.sh:2290 lib/choose_rev.tcl:557
+msgid "Remote"
+msgstr "Remoto"
+
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "Herramientas"
+
+#: git-gui.sh:2302
+msgid "Explore Working Copy"
+msgstr "Explorar la copia de trabajo"
+
+#: git-gui.sh:2307
+msgid "Browse Current Branch's Files"
+msgstr "Explore los ficheros de la rama actual"
+
+#: git-gui.sh:2311
+msgid "Browse Branch Files..."
+msgstr "Explora los ficheros de la rama..."
+
+#: git-gui.sh:2316
+msgid "Visualize Current Branch's History"
+msgstr "Visualiza la historia de la rama actual"
+
+#: git-gui.sh:2320
+msgid "Visualize All Branch History"
+msgstr "Visualiza la historia de todas las ramas"
+
+#: git-gui.sh:2327
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "Explora los ficheros de %s"
+
+#: git-gui.sh:2329
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "Visualiza la historia de %s"
+
+#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "Estadisticas de la Base de Datos"
+
+#: git-gui.sh:2337 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "Comprimir Base de Datos"
+
+#: git-gui.sh:2340
+msgid "Verify Database"
+msgstr "Verificar Base de Datos"
+
+#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
+#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
+msgid "Create Desktop Icon"
+msgstr "Crear icono de escritorio"
+
+#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
+msgid "Quit"
+msgstr "Salir"
+
+#: git-gui.sh:2371
+msgid "Undo"
+msgstr "Deshacer"
+
+#: git-gui.sh:2374
+msgid "Redo"
+msgstr "Rehacer"
+
+#: git-gui.sh:2378 git-gui.sh:2937
+msgid "Cut"
+msgstr "Cortar"
+
+#: git-gui.sh:2381 git-gui.sh:2940 git-gui.sh:3014 git-gui.sh:3096
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Copiar"
+
+#: git-gui.sh:2384 git-gui.sh:2943
+msgid "Paste"
+msgstr "Pegar"
+
+#: git-gui.sh:2387 git-gui.sh:2946 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "Borrar"
+
+#: git-gui.sh:2391 git-gui.sh:2950 git-gui.sh:3100 lib/console.tcl:71
+msgid "Select All"
+msgstr "Seleccionar Todo"
+
+#: git-gui.sh:2400
+msgid "Create..."
+msgstr "Crear..."
+
+#: git-gui.sh:2406
+msgid "Checkout..."
+msgstr "Activar..."
+
+#: git-gui.sh:2412
+msgid "Rename..."
+msgstr "Renombrar..."
+
+#: git-gui.sh:2417
+msgid "Delete..."
+msgstr "Borrar..."
+
+#: git-gui.sh:2422
+msgid "Reset..."
+msgstr "Reinicializar..."
+
+#: git-gui.sh:2432
+msgid "Done"
+msgstr "Hecho"
+
+#: git-gui.sh:2434
+msgid "Commit@@verb"
+msgstr "Crear Revisi=C3=B3n"
+
+#: git-gui.sh:2443 git-gui.sh:2878
+msgid "New Commit"
+msgstr "Nueva Revisi=C3=B3n"
+
+#: git-gui.sh:2451 git-gui.sh:2885
+msgid "Amend Last Commit"
+msgstr "Corregir =C3=BAltima Revisi=C3=B3n"
+
+#: git-gui.sh:2461 git-gui.sh:2839 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "Reanalizar"
+
+#: git-gui.sh:2467
+msgid "Stage To Commit"
+msgstr "Preparar para crear nueva revisi=C3=B3n"
+
+#: git-gui.sh:2473
+msgid "Stage Changed Files To Commit"
+msgstr "Preparar ficheros modificados para nueva revisi=C3=B3n"
+
+#: git-gui.sh:2479
+msgid "Unstage From Commit"
+msgstr "Anular preparaci=C3=B3n para nueva revisi=C3=B3n"
+
+#: git-gui.sh:2484 lib/index.tcl:410
+msgid "Revert Changes"
+msgstr "Anular cambios"
+
+#: git-gui.sh:2491 git-gui.sh:3083
+msgid "Show Less Context"
+msgstr "Mostrar menos contexto"
+
+#: git-gui.sh:2495 git-gui.sh:3087
+msgid "Show More Context"
+msgstr "Mostar mas contexto"
+
+#: git-gui.sh:2502 git-gui.sh:2852 git-gui.sh:2961
+msgid "Sign Off"
+msgstr "Sign Off"
+
+#: git-gui.sh:2518
+msgid "Local Merge..."
+msgstr "Fusi=C3=B3n local..."
+
+#: git-gui.sh:2523
+msgid "Abort Merge..."
+msgstr "Anular fusi=C3=B3n..."
+
+#: git-gui.sh:2535 git-gui.sh:2575
+msgid "Add..."
+msgstr "A=C3=B1adir..."
+
+#: git-gui.sh:2539
+msgid "Push..."
+msgstr "Propagar..."
+
+#: git-gui.sh:2543
+msgid "Delete Branch..."
+msgstr "Borrar rama..."
+
+#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#, tcl-format
+msgid "About %s"
+msgstr "Sobre %s"
+
+#: git-gui.sh:2557
+msgid "Preferences..."
+msgstr "Preferencias..."
+
+#: git-gui.sh:2565 git-gui.sh:3129
+msgid "Options..."
+msgstr "Opciones..."
+
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "Borrar..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
+msgid "Help"
+msgstr "Ayuda"
+
+#: git-gui.sh:2611
+msgid "Online Documentation"
+msgstr "Documentacion en linea"
+
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "Mostrar clave SSH"
+
+#: git-gui.sh:2721
+#, tcl-format
+msgid "fatal: cannot stat path %s: No such file or directory"
+msgstr "fatal: stat path %s fall=C3=B3: No hay tal fichero o directori=
o"
+
+#: git-gui.sh:2754
+msgid "Current Branch:"
+msgstr "Rama actual:"
+
+#: git-gui.sh:2775
+msgid "Staged Changes (Will Commit)"
+msgstr "Cambios Preparados (crear=C3=A1n nueva revisi=C3=B3n)"
+
+#: git-gui.sh:2795
+msgid "Unstaged Changes"
+msgstr "Cambios no preparados"
+
+#: git-gui.sh:2845
+msgid "Stage Changed"
+msgstr "Preparar Cambiados"
+
+#: git-gui.sh:2864 lib/transport.tcl:104 lib/transport.tcl:193
+msgid "Push"
+msgstr "Propagar"
+
+#: git-gui.sh:2899
+msgid "Initial Commit Message:"
+msgstr "Mensaje de la revisi=C3=B3n inicial:"
+
+#: git-gui.sh:2900
+msgid "Amended Commit Message:"
+msgstr "Corregir el mensaje de la Revisi=C3=B3n:"
+
+#: git-gui.sh:2901
+msgid "Amended Initial Commit Message:"
+msgstr "Corregir el mensaje de la revisi=C3=B3n inicial:"
+
+#: git-gui.sh:2902
+msgid "Amended Merge Commit Message:"
+msgstr "Corregir el mensaje de la revisi=C3=B3n de fusi=C3=B3n:"
+
+#: git-gui.sh:2903
+msgid "Merge Commit Message:"
+msgstr "Mensaje de la revisi=C3=B3n de Fusi=C3=B3n:"
+
+#: git-gui.sh:2904
+msgid "Commit Message:"
+msgstr "Mensaje de la revisi=C3=B3n:"
+
+#: git-gui.sh:2953 git-gui.sh:3104 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Copiar todo"
+
+#: git-gui.sh:2977 lib/blame.tcl:104
+msgid "File:"
+msgstr "Fichero:"
+
+#: git-gui.sh:3092
+msgid "Refresh"
+msgstr "Actualizar"
+
+#: git-gui.sh:3113
+msgid "Decrease Font Size"
+msgstr "Disminuir tama=C3=B1o de la fuente"
+
+#: git-gui.sh:3117
+msgid "Increase Font Size"
+msgstr "Aumentar tama=C3=B1o de la fuente"
+
+#: git-gui.sh:3125 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "Codificaci=C3=B3n"
+
+#: git-gui.sh:3136
+msgid "Apply/Reverse Hunk"
+msgstr "Aplicar/Revertir secci=C3=B3n"
+
+#: git-gui.sh:3141
+msgid "Apply/Reverse Line"
+msgstr "Aplicar/Revertir linea"
+
+#: git-gui.sh:3151
+msgid "Run Merge Tool"
+msgstr "Ejecutar herramienta de resoluci=C3=B3n de conflictos"
+
+#: git-gui.sh:3156
+msgid "Use Remote Version"
+msgstr "Usar la versi=C3=B3n remota"
+
+#: git-gui.sh:3160
+msgid "Use Local Version"
+msgstr "Usar la versi=C3=B3n local"
+
+#: git-gui.sh:3164
+msgid "Revert To Base"
+msgstr "Revertir a versi=C3=B3n Com=C3=BAn"
+
+#: git-gui.sh:3183
+msgid "Unstage Hunk From Commit"
+msgstr "Anular preparaci=C3=B3n de la secci=C3=B3n para revisi=C3=B3n"
+
+#: git-gui.sh:3184
+msgid "Unstage Line From Commit"
+msgstr "Anular preparaci=C3=B3n de la linea para revisi=C3=B3n"
+
+#: git-gui.sh:3186
+msgid "Stage Hunk For Commit"
+msgstr "Preparar la secci=C3=B3n para nueva revisi=C3=B3n"
+
+#: git-gui.sh:3187
+msgid "Stage Line For Commit"
+msgstr "Preparar la linea para nueva revisi=C3=B3n"
+
+#: git-gui.sh:3210
+msgid "Initializing..."
+msgstr "Inicializando..."
+
+#: git-gui.sh:3315
+#, tcl-format
+msgid ""
+"Possible environment issues exist.\n"
+"\n"
+"The following environment variables are probably\n"
+"going to be ignored by any Git subprocess run\n"
+"by %s:\n"
+"\n"
+msgstr ""
+"Hay probablemente problemas con las variables de entorno.\n"
+"\n"
+"Las sigientes variables de entorno ser=C3=A1n probablemente\n"
+"ignoradas por los todos subprocesos Git ejecutados por\n"
+"%s:\n"
+"\n"
+
+#: git-gui.sh:3345
+msgid ""
+"\n"
+"This is due to a known issue with the\n"
+"Tcl binary distributed by Cygwin."
+msgstr ""
+"\n"
+"Esto es debido a un conocido problema con\n"
+"el binario Tcl distribuido por Cygwin."
+
+#: git-gui.sh:3350
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
+"Una buena alternativa a %s\n"
+"es asignar valores a las variables\n"
+"user.name y user.email en su fichero\n"
+"~/.gitconfig personal.\n"
+
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - una intefaz gr=C3=A1fica de usuario para Git."
+
+#: lib/blame.tcl:72
+msgid "File Viewer"
+msgstr "Visor de ficheros"
+
+#: lib/blame.tcl:78
+msgid "Commit:"
+msgstr "Revisi=C3=B3n:"
+
+#: lib/blame.tcl:271
+msgid "Copy Commit"
+msgstr "Copiar revisi=C3=B3n"
+
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "Buscar texto..."
+
+#: lib/blame.tcl:284
+msgid "Do Full Copy Detection"
+msgstr "Hacer detecci=C3=B3n de copia completa"
+
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "Mostar el contexto historico"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr "Anotar la revisi=C3=B3n precedente"
+
+#: lib/blame.tcl:450
+#, tcl-format
+msgid "Reading %s..."
+msgstr "Leyendo %s..."
+
+#: lib/blame.tcl:557
+msgid "Loading copy/move tracking annotations..."
+msgstr "Cargando las anotaciones de copia/movimiento..."
+
+#: lib/blame.tcl:577
+msgid "lines annotated"
+msgstr "lineas anotadas"
+
+#: lib/blame.tcl:769
+msgid "Loading original location annotations..."
+msgstr "Cargando las anotaciones de la posici=C3=B3n original..."
+
+#: lib/blame.tcl:772
+msgid "Annotation complete."
+msgstr "Anotaci=C3=B3n completa."
+
+#: lib/blame.tcl:802
+msgid "Busy"
+msgstr "Ocupado"
+
+#: lib/blame.tcl:803
+msgid "Annotation process is already running."
+msgstr "El proceso de anotacion ya est=C3=A1 ejecutandose."
+
+#: lib/blame.tcl:842
+msgid "Running thorough copy detection..."
+msgstr "Ejecutando detecci=C3=B3n de copia completa..."
+
+#: lib/blame.tcl:910
+msgid "Loading annotation..."
+msgstr "Cargando anotaciones..."
+
+#: lib/blame.tcl:963
+msgid "Author:"
+msgstr "Autor:"
+
+#: lib/blame.tcl:967
+msgid "Committer:"
+msgstr "Comitter:"
+
+#: lib/blame.tcl:972
+msgid "Original File:"
+msgstr "Fichero original:"
+
+#: lib/blame.tcl:1020
+msgid "Cannot find HEAD commit:"
+msgstr "No se puede encontrar la revisi=C3=B3n HEAD:"
+
+#: lib/blame.tcl:1075
+msgid "Cannot find parent commit:"
+msgstr "No se puede encontrar la revisi=C3=B3n precedente:"
+
+#: lib/blame.tcl:1090
+msgid "Unable to display parent"
+msgstr "No se puede visualizar la revis=C3=B3n precedente"
+
+#: lib/blame.tcl:1091 lib/diff.tcl:297
+msgid "Error loading diff:"
+msgstr "Error cargando el diff:"
+
+#: lib/blame.tcl:1231
+msgid "Originally By:"
+msgstr "Originalmente por:"
+
+#: lib/blame.tcl:1237
+msgid "In File:"
+msgstr "En fichero:"
+
+#: lib/blame.tcl:1242
+msgid "Copied Or Moved Here By:"
+msgstr "Copiado o movido aqu=C3=AD por:"
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "Activar rama"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "Activar"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:108
+msgid "Cancel"
+msgstr "Cancelar"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
+msgid "Revision"
+msgstr "Revisi=C3=B3n"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
+msgid "Options"
+msgstr "Opciones"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Traer duplicado local de rama remota"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "Desvincular de rama local"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "Crear rama"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "Crear nueva rama"
+
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
+msgid "Create"
+msgstr "Crear"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "Nombre de la rama"
+
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
+msgid "Name:"
+msgstr "Nombre:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "Casar nombre del duplicado local de rama remota"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Iniciando revisi=C3=B3n"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Actualizar rama existente:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "No"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Solo Fast Forward"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
+msgid "Reset"
+msgstr "Reinicializa"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Activar despues de crear"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "Por favor escoja un duplicado local de rama remota."
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "El duplicado local de rama remota %s no es una rama en el repo=
sitorio remoto."
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "Por favor indique el nombre de rama."
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s' no es un nombre de rama v=C3=A1lido."
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "Borrar rama"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "Borrar rama local"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "Ramas locales"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr "Borrar solo si fusionada con otra rama"
+
+#: lib/branch_delete.tcl:54
+msgid "Always (Do not perform merge test.)"
+msgstr "Siempre (No hacer comprobaci=C3=B3n de fusi=C3=B3n.)"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Las ramas siguientes no han sido completamente fusionadas en %=
s:"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Se fall=C3=B3 al borrar las ramas:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "Renombrar rama"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "Renombrar"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "Rama:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "Nuevo nombre:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "Por favor seleccione la rama a renombrar."
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "La rama '%s' ya existe."
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Se fall=C3=B3 al renombrar '%s'."
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Iniciando..."
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr "Explorador de archivos"
+
+#: lib/browser.tcl:126 lib/browser.tcl:143
+#, tcl-format
+msgid "Loading %s..."
+msgstr "Cargando %s..."
+
+#: lib/browser.tcl:187
+msgid "[Up To Parent]"
+msgstr "[Directorio superior]"
+
+#: lib/browser.tcl:267 lib/browser.tcl:273
+msgid "Browse Branch Files"
+msgstr "Explora los ficheros de la rama"
+
+#: lib/browser.tcl:278 lib/choose_repository.tcl:394
+#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
+#: lib/choose_repository.tcl:995
+msgid "Browse"
+msgstr "Explora"
+
+#: lib/checkout_op.tcl:84
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Trayendo %s de %s"
+
+#: lib/checkout_op.tcl:132
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "fatal: No se pudo resolver %s"
+
+#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
+msgid "Close"
+msgstr "Cerrar"
+
+#: lib/checkout_op.tcl:174
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "La rama '%s' no existe."
+
+#: lib/checkout_op.tcl:193
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Se fall=C3=B3 al configurar el git-pull simplificado para '%s'=
=2E"
+
+#: lib/checkout_op.tcl:228
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"La rama '%s' ya existe.\n"
+"\n"
+"No se puede hacer fast-forward a %s.\n"
+"Se requiere una fusi=C3=B3n."
+
+#: lib/checkout_op.tcl:242
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "La estrategia de fusi=C3=B3n '%s' no est=C3=A1 soportada."
+
+#: lib/checkout_op.tcl:261
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Se fall=C3=B3 al actualizar '%s'."
+
+#: lib/checkout_op.tcl:273
+msgid "Staging area (index) is already locked."
+msgstr "El =C3=A1rea de preparaci=C3=B3n (index) ya est=C3=A1 bloquead=
a."
+
+#: lib/checkout_op.tcl:288
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"El =C3=BAltimo estado escaneado no casa con el estado del repositorio=
=2E\n"
+"\n"
+"Otro programa de Git a modificado este repositorio desde el =C3=BAlti=
mo escaneo.\n"
+"Un nuevo escaneo debe realizarse antes de que la rama actual pueda ca=
mbiarse.\n"
+"\n"
+"El escaneo empezar=C3=A1 automaticamente ahora.\n"
+
+#: lib/checkout_op.tcl:344
+#, tcl-format
+msgid "Updating working directory to '%s'..."
+msgstr "Actualizando el directorio de trabajo a '%s'..."
+
+#: lib/checkout_op.tcl:345
+msgid "files checked out"
+msgstr "ficheros en el directorio de trabajo"
+
+#: lib/checkout_op.tcl:375
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr "Activaci=C3=B3n de '%s' abortada (fusi=C3=B3n a nivel de fiche=
ro necesaria)."
+
+#: lib/checkout_op.tcl:376
+msgid "File level merge required."
+msgstr "Fusi=C3=B3n a nivel de fichero necesaria."
+
+#: lib/checkout_op.tcl:380
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Permaneciendo en rama '%s'."
+
+#: lib/checkout_op.tcl:451
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This D=
etached "
+"Checkout'."
+msgstr ""
+"Ya no estas en una rama local.\n"
+"\n"
+"Si lo que quer=C3=ADas era estar en una rama, crea una ahora a\n"
+"partir de 'This Detached Checkout'."
+
+#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
+#, tcl-format
+msgid "Checked out '%s'."
+msgstr "Activada '%s'."
+
+#: lib/checkout_op.tcl:500
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr "Reinicializar '%s' a '%s' har=C3=A1 que se pierdan estas revis=
iones:"
+
+#: lib/checkout_op.tcl:522
+msgid "Recovering lost commits may not be easy."
+msgstr "Recuperar las revisiones perdidas puede no ser facil."
+
+#: lib/checkout_op.tcl:527
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "=C2=BFReinicializar '%s'?"
+
+#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+msgid "Visualize"
+msgstr "Visualizar"
+
+#: lib/checkout_op.tcl:600
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully u=
pdated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"Se fall=C3=B3 al preparar la rama actual.\n"
+"\n"
+"Este directorio de trabajo est=C3=A1 solo parcialmente cambiado. Se h=
an actualizado\n"
+"tus ficheros con =C3=A9xito, pero se fall=C3=B3 al actualizar un fich=
ero interno de Git.\n"
+"\n"
+"Esto no deber=C3=ADa de haber ocurrido. %s se cerrar=C3=A1 y desistir=
=C3=A1."
+
+#: lib/choose_font.tcl:39
+msgid "Select"
+msgstr "Selecciona"
+
+#: lib/choose_font.tcl:53
+msgid "Font Family"
+msgstr "Familia de fuente"
+
+#: lib/choose_font.tcl:74
+msgid "Font Size"
+msgstr "Tama=C3=B1o de fuente"
+
+#: lib/choose_font.tcl:91
+msgid "Font Example"
+msgstr "Ejemplo de fuente"
+
+#: lib/choose_font.tcl:103
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"Esto es testo de ejemplo.\n"
+"Si te gusta este texto, esta puede ser tu fuente."
+
+#: lib/choose_repository.tcl:28
+msgid "Git Gui"
+msgstr "Git Gui"
+
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
+msgid "Create New Repository"
+msgstr "Crear nuevo repositorio"
+
+#: lib/choose_repository.tcl:93
+msgid "New..."
+msgstr "Nuevo..."
+
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
+msgid "Clone Existing Repository"
+msgstr "Clonar un repositorio existente"
+
+#: lib/choose_repository.tcl:106
+msgid "Clone..."
+msgstr "Clonar..."
+
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
+msgid "Open Existing Repository"
+msgstr "Abrir un repositorio existente"
+
+#: lib/choose_repository.tcl:119
+msgid "Open..."
+msgstr "Abrir..."
+
+#: lib/choose_repository.tcl:132
+msgid "Recent Repositories"
+msgstr "Repositorios recientes"
+
+#: lib/choose_repository.tcl:138
+msgid "Open Recent Repository:"
+msgstr "Abrir repositorio reciente:"
+
+#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:316
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Se fall=C3=B3 al crear el repositorio %s:"
+
+#: lib/choose_repository.tcl:387
+msgid "Directory:"
+msgstr "Directorio:"
+
+#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1017
+msgid "Git Repository"
+msgstr "Repositorio git"
+
+#: lib/choose_repository.tcl:442
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "El directorio %s ya existe."
+
+#: lib/choose_repository.tcl:446
+#, tcl-format
+msgid "File %s already exists."
+msgstr "El fichero %s ya existe."
+
+#: lib/choose_repository.tcl:460
+msgid "Clone"
+msgstr "Clonar"
+
+#: lib/choose_repository.tcl:473
+msgid "Source Location:"
+msgstr "Localizacion del c=C3=B3digo fuente:"
+
+#: lib/choose_repository.tcl:484
+msgid "Target Directory:"
+msgstr "Directorio objetivo:"
+
+#: lib/choose_repository.tcl:496
+msgid "Clone Type:"
+msgstr "Tipo de clonado:"
+
+#: lib/choose_repository.tcl:502
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Standar (R=C3=A1pido, semi-redundante, con hard links)"
+
+#: lib/choose_repository.tcl:508
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Copia completa (Mas lento, redundante, copia de respaldo)"
+
+#: lib/choose_repository.tcl:514
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Compartido (el m=C3=A1s r=C3=A1pido, no recomendado, no es cop=
ia de respaldo)"
+
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "No es un repositorio Git: %s"
+
+#: lib/choose_repository.tcl:586
+msgid "Standard only available for local repository."
+msgstr "Standar solo disponible para repositorios locales."
+
+#: lib/choose_repository.tcl:590
+msgid "Shared only available for local repository."
+msgstr "Compartido solo disponible para repositorios locales."
+
+#: lib/choose_repository.tcl:611
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "La localizacion %s ya existe."
+
+#: lib/choose_repository.tcl:622
+msgid "Failed to configure origin"
+msgstr "Se fall=C3=B3 al configurar origen"
+
+#: lib/choose_repository.tcl:634
+msgid "Counting objects"
+msgstr "Contando objetos"
+
+#: lib/choose_repository.tcl:635
+msgid "buckets"
+msgstr "cubos"
+
+#: lib/choose_repository.tcl:659
+#, tcl-format
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "No se pudo copiar objetos/info/alternativas: %s"
+
+#: lib/choose_repository.tcl:695
+#, tcl-format
+msgid "Nothing to clone from %s."
+msgstr "Nada que clonar desde %s."
+
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
+msgid "The 'master' branch has not been initialized."
+msgstr "La rama 'master' no ha sido inicializada."
+
+#: lib/choose_repository.tcl:710
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Hardlinks no disponibles. Se recurre a copiar."
+
+#: lib/choose_repository.tcl:722
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "Clonando desde %s"
+
+#: lib/choose_repository.tcl:753
+msgid "Copying objects"
+msgstr "Copiando objetos"
+
+#: lib/choose_repository.tcl:754
+msgid "KiB"
+msgstr "KiB"
+
+#: lib/choose_repository.tcl:778
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "No se puede copiar objeto: %s"
+
+#: lib/choose_repository.tcl:788
+msgid "Linking objects"
+msgstr "Vinculando (hardlinks) objetos"
+
+#: lib/choose_repository.tcl:789
+msgid "objects"
+msgstr "objetos"
+
+#: lib/choose_repository.tcl:797
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "No se puede vincular (hardlink) el objeto: %s"
+
+#: lib/choose_repository.tcl:852
+msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
+msgstr "Imposible traer las ramas y objetos. Para mas detalles vea la =
salida de consola"
+
+#: lib/choose_repository.tcl:863
+msgid "Cannot fetch tags.  See console output for details."
+msgstr "Imposible traer etiquetas. Para m=C3=A1s detalles vea la salid=
a de consola"
+
+#: lib/choose_repository.tcl:887
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr "No se puede determinar HEAD. Para mas detalles vea la salida d=
e consola."
+
+#: lib/choose_repository.tcl:896
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr "Imposible limpiar %s"
+
+#: lib/choose_repository.tcl:902
+msgid "Clone failed."
+msgstr "Fallo al clonar."
+
+#: lib/choose_repository.tcl:909
+msgid "No default branch obtained."
+msgstr "No se obtubo la rama por defecto."
+
+#: lib/choose_repository.tcl:920
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr "No se pudo resolver %s como revisi=C3=B3n."
+
+#: lib/choose_repository.tcl:932
+msgid "Creating working directory"
+msgstr "Creando el directorio de trabajo"
+
+#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
+#: lib/index.tcl:196
+msgid "files"
+msgstr "ficheros"
+
+#: lib/choose_repository.tcl:962
+msgid "Initial file checkout failed."
+msgstr "Fall=C3=B3 la activacion inicial de ficheros."
+
+#: lib/choose_repository.tcl:978
+msgid "Open"
+msgstr "Abrir"
+
+#: lib/choose_repository.tcl:988
+msgid "Repository:"
+msgstr "Repositorio:"
+
+#: lib/choose_repository.tcl:1037
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "Se fall=C3=B3 al abrir el repositorio %s:"
+
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr ""
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Expresion de revisi=C3=B3n:"
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr "Rama local"
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr "Duplicado local de rama remota"
+
+#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
+msgid "Tag"
+msgstr "Etiqueta"
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Revisi=C3=B3n no v=C3=A1lida: %s"
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr "No se ha seleccionado revisi=C3=B3n."
+
+#: lib/choose_rev.tcl:346
+msgid "Revision expression is empty."
+msgstr "Exprasi=C3=B3n de revisi=C3=B3n vacia."
+
+#: lib/choose_rev.tcl:531
+msgid "Updated"
+msgstr "Actualizado"
+
+#: lib/choose_rev.tcl:559
+msgid "URL"
+msgstr "URL"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit befor=
e this "
+"to amend.\n"
+msgstr ""
+"No hay nada que corregir.\n"
+"\n"
+"Va usted a crear la revis=C3=B3n inicial. No hay ninguna revisi=C3=B3=
n anterior\n"
+"que corregir.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort =
the "
+"current merge activity.\n"
+msgstr ""
+"No se puede corregir mientras durante una fusi=C3=B3n.\n"
+"\n"
+"Esta usted en el medio de un proceso de fusi=C3=B3n que no ha\n"
+"sido completado. No puede corregir la revision anterior a\n"
+"no ser que primero cancele el proceso de fusi=C3=B3n.\n"
+
+#: lib/commit.tcl:48
+msgid "Error loading commit data for amend:"
+msgstr "Error al cargar los datos de la revisi=C3=B3n para correcci=C3=
=B3n:"
+
+#: lib/commit.tcl:75
+msgid "Unable to obtain your identity:"
+msgstr "Incapaz de obtener su identidad:"
+
+#: lib/commit.tcl:80
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "GIT_COMMITTER_IDENT inv=C3=A1lido:"
+
+#: lib/commit.tcl:132
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"El =C3=BAltimo estado escaneado no casa con el estado del repositorio=
=2E\n"
+"\n"
+"Otro programa de Git a modificado este repositorio desde el =C3=BAlti=
mo escaneo.\n"
+"Un nuevo escaneo debe realizarse antes de que una nueva revisi=C3=B3n=
 pueda crearse.\n"
+"\n"
+"El escaneo empezar=C3=A1 automaticamente ahora.\n"
+
+#: lib/commit.tcl:155
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the fil=
e "
+"before committing.\n"
+msgstr ""
+"Imosible crear revis=C3=B3n con ficheros sin fusionar.\n"
+"\n"
+"El fichero %s tiene conflictos de fusi=C3=B3n. Debe resolverlos y\n"
+"preparar el fichero para nueva revisi=C3=B3n antes de continuar.\n"
+
+#: lib/commit.tcl:163
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Estado de fichero desconocido %s detectado.\n"
+"\n"
+"El programa no puede hacer una revisi=C3=B3n con el fichero %s.\n"
+
+#: lib/commit.tcl:171
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"No hay cambios para una nueva revisi=C3=B3n.\n"
+"\n"
+"Debe preparar para nueva revis=C3=B3n al menos un fichero\n"
+"antes de proceder.\n"
+
+#: lib/commit.tcl:186
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Por favor facilite un mensaje de revis=C3=B3n.\n"
+"\n"
+"Un buen mensaje tiene el siguiente formato:\n"
+"\n"
+"- Primera linea: Describa en una linea lo que hizo.\n"
+"- Segunda linea: En blanco\n"
+"- Lineas siguientes: Describa porque el cambio es bueno.\n"
+
+#: lib/commit.tcl:210
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "aviso: Tcl no soporta la codificaci=C3=B3n '%s'."
+
+#: lib/commit.tcl:226
+msgid "Calling pre-commit hook..."
+msgstr "Ejecutando el hook pre-commit..."
+
+#: lib/commit.tcl:241
+msgid "Commit declined by pre-commit hook."
+msgstr "La revisi=C3=B3n ha sido rechazada por el hook pre-commit."
+
+#: lib/commit.tcl:264
+msgid "Calling commit-msg hook..."
+msgstr "Ejecutando el hook commit-msg..."
+
+#: lib/commit.tcl:279
+msgid "Commit declined by commit-msg hook."
+msgstr "La revisi=C3=B3n ha sido rechazada por el hook commit-msg."
+
+#: lib/commit.tcl:292
+msgid "Committing changes..."
+msgstr "Archivando los cambios..."
+
+#: lib/commit.tcl:308
+msgid "write-tree failed:"
+msgstr "El write-tree fall=C3=B3:"
+
+#: lib/commit.tcl:309 lib/commit.tcl:353 lib/commit.tcl:373
+msgid "Commit failed."
+msgstr "Se fall=C3=B3 al crear una nueva revisi=C3=B3n."
+
+#: lib/commit.tcl:326
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "La revis=C3=B3n %s parece estar corrupta."
+
+#: lib/commit.tcl:331
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\=
n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"No hay cambios para una nueva revisi=C3=B3n.\n"
+"\n"
+"Ning=C3=BAn fihero ha sido modificado por esta revisi=C3=B3n y no es =
una\n"
+"revis=C3=B3n de fusi=C3=B3n.\n"
+"\n"
+"Un rescaneo empezar=C3=A1 automaticamente ahora.\n"
+
+#: lib/commit.tcl:338
+msgid "No changes to commit."
+msgstr "No hay cambios para una nueva revisi=C3=B3n."
+
+#: lib/commit.tcl:352
+msgid "commit-tree failed:"
+msgstr "Fall=C3=B3 el commit-tree:"
+
+#: lib/commit.tcl:372
+msgid "update-ref failed:"
+msgstr "Fall=C3=B3 el update-ref:"
+
+#: lib/commit.tcl:460
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Creada la revisi=C3=B3n %s: %s"
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "Trabajando... por favor espere..."
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "=C3=89xito"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Error: El comando fall=C3=B3"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "N=C3=BAmero de objetos sueltos"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr "Espacio en disco usado por objetos sueltos"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "N=C3=BAmero de objetos empaquetados"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "N=C3=BAmero de paquetes"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr "Espacio en disco usado por objetos empaquetados"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr "Objetos empaquetados esperando poda"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "Ficheros basura"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Comprimiendo/Empaquetando la Base de Datos de objetos"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Verificando la Base de Datos de objetos con fsck-objects"
+
+#: lib/database.tcl:108
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you c=
ompress "
+"the database when more than %i loose objects exist.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Este repositorio cuenta actualmente con %i objetos sueltos.\n"
+"\n"
+"Para mantener un rendimento =C3=B3ptimo se recomienda encarecidamente=
\n"
+"que comprima la Base de Datos cuando hay mas de %i objetos sueltos.\n=
"
+"\n"
+"=C2=BFComprimir la Base de Datos ahora?"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Fecha invalida de Git: %s"
+
+#: lib/diff.tcl:59
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application=
, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may =
have "
+"the same state."
+msgstr ""
+"Ninguna diferencia detectada.\n"
+"\n"
+"%s no tiene cambios.\n"
+"\n"
+"La fecha de modificacion ha sido cambiada por otra aplicaci=C3=B3n,\n=
"
+"pero los contenidos del fichero no han cambiado.\n"
+"\n"
+"Un rescaneo se realizar=C3=A1 ahora para detectar otros ficheros en \=
n"
+"el mismo estado."
+
+#: lib/diff.tcl:99
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Cargando el diff de %s..."
+
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"LOCAL: borrado\n"
+"REMOTO:\n"
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"REMOTO: borrado\n"
+"LOCAL:\n"
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr "LOCAL:\n"
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr "REMOTO:\n"
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Imposible mostrar %s"
+
+#: lib/diff.tcl:198
+msgid "Error loading file:"
+msgstr "Error cargando fichero:"
+
+#: lib/diff.tcl:205
+msgid "Git Repository (subproject)"
+msgstr "Repositorio Git (subproyecto)"
+
+#: lib/diff.tcl:217
+msgid "* Binary file (not showing content)."
+msgstr "* Fichero Binario (no se muestra contenido)."
+
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* Fichero no registrado es de %d bytes.\n"
+"* Mostrando solo los primeros %d bytes.\n"
+
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Fichero no registrado cortado aqui por %s.\n"
+"* Para ver el fichero completo, use un editor externo.\n"
+
+#: lib/diff.tcl:436
+msgid "Failed to unstage selected hunk."
+msgstr "Se fall=C3=B3 al cancelar la preparacion para nueva revisi=C3=B3=
n de la secci=C3=B3n seleccionada."
+
+#: lib/diff.tcl:443
+msgid "Failed to stage selected hunk."
+msgstr "Se fall=C3=B3 al preparar para nueva revisi=C3=B3n la secci=C3=
=B3n seleccionada."
+
+#: lib/diff.tcl:509
+msgid "Failed to unstage selected line."
+msgstr "Se fall=C3=B3 al cancelar la preparaci=C3=B3n para nueva revis=
i=C3=B3n de la linea seleccionada."
+
+#: lib/diff.tcl:517
+msgid "Failed to stage selected line."
+msgstr "Se fall=C3=B3 al preparar para nueva revis=C3=B3n la linea sel=
eccionada."
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Por defecto"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Sistema (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Otro"
+
+#: lib/error.tcl:20 lib/error.tcl:114
+msgid "error"
+msgstr "error"
+
+#: lib/error.tcl:36
+msgid "warning"
+msgstr "advertencia"
+
+#: lib/error.tcl:94
+msgid "You must correct the above errors before committing."
+msgstr "Debe corregir los errores mostrados antes de crear nueva revis=
=C3=B3n."
+
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Incapaz de desbloquear el =C3=ADndice (index)."
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr "Error del =C3=8Dndice"
+
+#: lib/index.tcl:21
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr ""
+"Fall=C3=B3 la actualizaci=C3=B3n del =C3=ADndice. Un rescaneo comenza=
r=C3=A1 ahora\n"
+"para resincronizar git-gui."
+
+#: lib/index.tcl:27
+msgid "Continue"
+msgstr "Continuar"
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr "Desbloquear =C3=8Dndice"
+
+#: lib/index.tcl:287
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "Cancelando la preparacion de %s de la revis=C3=B3n."
+
+#: lib/index.tcl:326
+msgid "Ready to commit."
+msgstr "Preparado para crear nueva revisi=C3=B3n."
+
+#: lib/index.tcl:339
+#, tcl-format
+msgid "Adding %s"
+msgstr "A=C3=B1adiendo %s"
+
+#: lib/index.tcl:396
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "=C2=BFRevertir los cambios en el fichero %s?"
+
+#: lib/index.tcl:398
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "=C2=BFRevertir los cambios en estos %i ficheros?"
+
+#: lib/index.tcl:406
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr "Cualquier cambio no preparado para nueva revisi=C3=B3n se perd=
er=C3=A1 al revertir."
+
+#: lib/index.tcl:409
+msgid "Do Nothing"
+msgstr "No hacer nada"
+
+#: lib/index.tcl:427
+msgid "Reverting selected files"
+msgstr "Revertiendo los ficheros seleccionados"
+
+#: lib/index.tcl:431
+#, tcl-format
+msgid "Reverting %s"
+msgstr "Revertiendo %s"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merg=
e.\n"
+msgstr ""
+"No se puede fusionar mientras se corrige.\n"
+"\n"
+"Debe terminar de corregir la revisi=C3=B3n antes de comenzar cualquie=
r tipo de fusi=C3=B3n.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"El =C3=BAltimo estado escaneado no casa con el estado del repositorio=
=2E\n"
+"\n"
+"Otro programa de Git a modificado este repositorio desde el =C3=BAlti=
mo escaneo.\n"
+"Un nuevo escaneo debe realizarse antes de que una nueva fusi=C3=B3n p=
ueda realizarse.\n"
+"\n"
+"El escaneo empezar=C3=A1 automaticamente ahora.\n"
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the cur=
rent "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"Esta en el medio de una fusi=C3=B3n con conflictos.\n"
+"\n"
+"El fichero %s tiene conflictos.\n"
+"\n"
+"Debe resolverlos, preparar el fichero para nueva revisi=C3=B3n, y cre=
ar\n"
+"la nueva revisi=C3=B3n para completar la fusi=C3=B3n. Solo asi podr=C3=
=A1 comenzar \n"
+"una nueva fusi=C3=B3n.\n"
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doin=
g so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Esta en el medio de un cambio.\n"
+"\n"
+"El fichero %s ha sido modificado.\n"
+"\n"
+"Deber=C3=ADa completar la revisi=C3=B3n actual antes de comenzar la f=
usi=C3=B3n.\n"
+"Hacer eso le ayudar=C3=A1 a cancelar una fusi=C3=B3n fallida si surgi=
ese la \n"
+"necesidad.\n"
+
+#: lib/merge.tcl:107
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s de %s"
+
+#: lib/merge.tcl:120
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "Fusionando %s y %s..."
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr "Fusi=C3=B3n completada con =C3=A9xito."
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Fallo en la fusi=C3=B3n. Se requiere resoluci=C3=B3n de confli=
ctos."
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Fusionar a %s"
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr "Revisi=C3=B3n a Fusionar"
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"No se puede abortar durante la correcci=C3=B3n.\n"
+"\n"
+"Debe terminar de corregir la revisi=C3=B3n.\n"
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be=
 lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"=C2=BFAbortar fusi=C3=B3n?\n"
+"\n"
+"Abortar la fusi=C3=B3n actual causar=C3=A1 la p=C3=A9rdida de *TODOS*=
 los cambios no\n"
+"guardados en el repositorio.\n"
+"\n"
+"=C2=BFContinuar con la cancelaci=C3=B3n de la fusi=C3=B3n actual?"
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost=
=2E\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"=C2=BFRevertir los cambios?\n"
+"\n"
+"Revertir los cambios provocar=C3=A1 la p=C3=A9rdida de *TODOS* los ca=
mbios\n"
+"no guardados en el repositorio.\n"
+"\n"
+"=C2=BFContinuar y revertir los cambios actuales?"
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr "Cancelando"
+
+#: lib/merge.tcl:239
+msgid "files reset"
+msgstr "ficheros revertidos"
+
+#: lib/merge.tcl:267
+msgid "Abort failed."
+msgstr "Fall=C3=B3 la cancelaci=C3=B3n."
+
+#: lib/merge.tcl:269
+msgid "Abort completed.  Ready."
+msgstr "Cancelaci=C3=B3n completa. Preparado."
+
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "=C2=BFForzar resoluci=C3=B3n a la version com=C3=BAn (base)?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "=C2=BFForzar resoluci=C3=B3n a la version de esta rama?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "=C2=BFForzar resoluci=C3=B3n a la version de la otra rama?"
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
+"Tenga en cuenta que el diff solo mestra los cambios conflictivos.\n"
+"\n"
+"%s ser=C3=A1 sobrescrito.\n"
+"\n"
+"Esta operacion solo se puede deshacer reiniciando la fusi=C3=B3n."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "El fichero %s parece que tiene conflictos no resueltos =C2=BFp=
reparar para nueva revisi=C3=B3n igualmente?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "A=C3=B1adiendo resoluci=C3=B3n para %s"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "No se puede resolver el borrado o los conflictos de links con =
una herramienta"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "El fichero conflictivo no existe"
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "No es una herramienta de fusi=C3=B3n gr=C3=A1fica: '%s'"
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Herramienta de fusi=C3=B3n no soportada '%s'"
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr "La herramienta de fusi=C3=B3n ya esta ejecutandose, =C2=BFcerr=
arla? "
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Error al traer las versiones:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"No se pudo ejecutar la herramienta de fusi=C3=B3n:\n"
+"\n"
+"%s "
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr "Ejecutando la herramienta de fusi=C3=B3n..."
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr "La herramienta de fusi=C3=B3n fall=C3=B3."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Codificaci=C3=B3n global inv=C3=A1lida '%s'"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Codificacion de repositorio inv=C3=A1lida '%s'"
+
+#: lib/option.tcl:117
+msgid "Restore Defaults"
+msgstr "Restaurar opciones predeterminadas."
+
+#: lib/option.tcl:121
+msgid "Save"
+msgstr "Guardar"
+
+#: lib/option.tcl:131
+#, tcl-format
+msgid "%s Repository"
+msgstr "Repositorio %s"
+
+#: lib/option.tcl:132
+msgid "Global (All Repositories)"
+msgstr "Global (Todos los Repositorios)"
+
+#: lib/option.tcl:138
+msgid "User Name"
+msgstr "Nombre de Usuario"
+
+#: lib/option.tcl:139
+msgid "Email Address"
+msgstr "Direcci=C3=B3n de e-mail."
+
+#: lib/option.tcl:141
+msgid "Summarize Merge Commits"
+msgstr "Resumir revisones de fusi=C3=B3n"
+
+#: lib/option.tcl:142
+msgid "Merge Verbosity"
+msgstr "Verbosidad de la fusi=C3=B3n"
+
+#: lib/option.tcl:143
+msgid "Show Diffstat After Merge"
+msgstr "Mostrar Diffstat tras la fusi=C3=B3n"
+
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "Usar herramienta de fusi=C3=B3n"
+
+#: lib/option.tcl:146
+msgid "Trust File Modification Timestamps"
+msgstr "Fiarse de marca de tiempo de ficheros"
+
+#: lib/option.tcl:147
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Podar las copias locales de ramas remotas al traer"
+
+#: lib/option.tcl:148
+msgid "Match Tracking Branches"
+msgstr "Casar los duplicados locales de ramas remotas"
+
+#: lib/option.tcl:149
+msgid "Blame Copy Only On Changed Files"
+msgstr "Detecci=C3=B3n de copia solo a ficheros cambiados"
+
+#: lib/option.tcl:150
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Caracteres m=C3=ADnimos para activar detecci=C3=B3n de copia"
+
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr "Contexto de Cronolog=C3=ADa de Anotaci=C3=B3n (dias)"
+
+#: lib/option.tcl:152
+msgid "Number of Diff Context Lines"
+msgstr "N=C3=BAmero lineas de contexto en diffs"
+
+#: lib/option.tcl:153
+msgid "Commit Message Text Width"
+msgstr "Ancho de texto en mensaje de revisi=C3=B3n"
+
+#: lib/option.tcl:154
+msgid "New Branch Name Template"
+msgstr "Nombre Plantilla de Nueva Rama"
+
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "Codificaci=C3=B3n por defecto de ficheros"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "Cambiar"
+
+#: lib/option.tcl:230
+msgid "Spelling Dictionary:"
+msgstr "Diccionario de correcci=C3=B3n:"
+
+#: lib/option.tcl:254
+msgid "Change Font"
+msgstr "Cambiar fuente"
+
+#: lib/option.tcl:258
+#, tcl-format
+msgid "Choose %s"
+msgstr "Elija %s"
+
+#: lib/option.tcl:264
+msgid "pt."
+msgstr "pt."
+
+#: lib/option.tcl:278
+msgid "Preferences"
+msgstr "Preferencias"
+
+#: lib/option.tcl:314
+msgid "Failed to completely save options:"
+msgstr "Fallo al guardar completamente las opciones:"
+
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "Borrar Remoto"
+
+#: lib/remote.tcl:168
+msgid "Prune from"
+msgstr "Podar de"
+
+#: lib/remote.tcl:173
+msgid "Fetch from"
+msgstr "Traer desde"
+
+#: lib/remote.tcl:215
+msgid "Push to"
+msgstr "Propagar a"
+
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "A=C3=B1adir remoto"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "A=C3=B1adir nuevo remoto"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr "A=C3=B1adir"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "Detalles del remoto"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Localizaci=C3=B3n:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "M=C3=A1s Acciones"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "Traer inmediatamente"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "Inicializar repositorio remoto y propagar"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "No hacer nada mas ahora"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "Por favor indique un nombre para el remoto"
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s' es un nombre de remoto no aceptable."
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Se fall=C3=B3 al a=C3=B1adir el remoto '%s' de la localizacion=
 '%s'."
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "traer %s"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "Trayendo el %s"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "No se sabe como inicializar el repositorio en localizaci=C3=B3=
n '%s'."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
+#, tcl-format
+msgid "push %s"
+msgstr "propagar %s"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Creando %s (en %s)"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "Borrar rama remotamente"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "Desde repositorio"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
+msgid "Remote:"
+msgstr "Remoto:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
+msgid "Arbitrary Location:"
+msgstr "Localizaci=C3=B3n arbitraria:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "Ramas"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "Borrar solo si"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "Fusionado a:"
+
+#: lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Siempre (No hacer comprobaciones de fusi=C3=B3n)"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr "Se requiere una rama para 'Fusionado a'."
+
+#: lib/remote_branch_delete.tcl:184
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr ""
+"Las siguientes ramas no estan completamente fusionadas a %s:\n"
+"\n"
+"- %s"
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched th=
e "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Una o mas de las comprobaciones de fusi=C3=B3n fallaron porque no se =
trajeron las\n"
+"revisones necesarias. Intente trayendolas de %s primero."
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr "Por favor seleccione una o mas ramas para borrar."
+
+#: lib/remote_branch_delete.tcl:216
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Recuperar ramas borradas es dif=C3=ADcil.\n"
+"\n"
+"=C2=BFBorrar las ramas seleccionadas?"
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "Borrando ramas de %s"
+
+#: lib/remote_branch_delete.tcl:286
+msgid "No repository selected."
+msgstr "No se a seleccionado un repositorio."
+
+#: lib/remote_branch_delete.tcl:291
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "Escaneando %s..."
+
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "Encontrar:"
+
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "Siguiente"
+
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "Anterior"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "Sensible a Mayusculas"
+
+#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+msgid "Cannot write shortcut:"
+msgstr "No se puede escribir el acceso directo:"
+
+#: lib/shortcut.tcl:136
+msgid "Cannot write icon:"
+msgstr "No se puede escribir el icono:"
+
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Corrector ortogr=C3=A1fico no soportado"
+
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Correcci=C3=B3n ortogr=C3=A1fica no disponible"
+
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Configuraci=C3=B3nn de correcci=C3=B3n ortogr=C3=A1fica inv=C3=
=A1lida"
+
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
+msgstr "Revertiendo diccionario a %s."
+
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "El corrector ortogr=C3=A1fico fall=C3=B3 silenciosamente al ar=
rancar"
+
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Corrector ortogr=C3=A1fico no reconocido"
+
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "No hay sugerencias"
+
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "EOF inesperado desde el corrector ortogr=C3=A1fico"
+
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Fall=C3=B3 el corrector ortogr=C3=A1fico"
+
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "No se encontraron llaves."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Encontrada llave p=C3=BAblica en: %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "Generar Llave"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "Copiar al portapapeles"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "Tu llave p=C3=BAblica OpenSSH"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "Generando..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"No se pudo ejecutar ssh-keygen:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "Fall=C3=B3 la generaci=C3=B3n."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "La generaci=C3=B3n tubo =C3=A9xito, pero no se encontraron lla=
ves."
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Tu llave se encuentra en: %s"
+
+#: lib/status_bar.tcl:83
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i de %*i %s (%3i%%)"
+
+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Ejecutar %s requiere un fichero seleccionado."
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "=C2=BFEst=C3=A1 seguro de que quiere ejecutar %s?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Herramienta: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "Ejecutando: %s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "Herramienta ejcutada con =C3=A9xito: %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Fall=C3=B3 la herramienta: %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "A=C3=B1adir Herramienta"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "A=C3=B1adir nuevo comando herramienta"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "A=C3=B1adir globalmente"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "Detalles de la herramienta"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Usar separadores '/' para crear un submen=C3=BA en =C3=A1rbol:=
"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "Comando:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "Mostrar un dialogo antes de ejecutar"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Pedir al usuario que seleccione una revisi=C3=B3n (asigna $REV=
ISION)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Pedir al usuario argumentos adicionales (asigna $ARGS)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "No mostrar la ventana de salida de comandos"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Ejecutar solo si se se ha seleccionado un diff ($FILENAME no v=
acio)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "Por favor indique un nombre para la herramienta"
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "La herramienta '%s' ya existe."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"No se pudo a=C3=B1adir la herramienta:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "Borrar herramienta"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "Borrar comandos herramienta"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "Borrar"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Azul indica herramientas del repositoro local)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Ejecutar comando: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "Argumentos"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Trayendo cambios nuevos desde %s"
+
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "poda remota %s"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Podando las copias locales de ramas remotas de %s"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Propagando cambios a %s"
+
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Haciendo Mirror en %s"
+
+#: lib/transport.tcl:82
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Propagando %s %s a %s"
+
+#: lib/transport.tcl:100
+msgid "Push Branches"
+msgstr "Propagar ramas"
+
+#: lib/transport.tcl:114
+msgid "Source Branches"
+msgstr "Ramas origen"
+
+#: lib/transport.tcl:131
+msgid "Destination Repository"
+msgstr "Repositorio de destino"
+
+#: lib/transport.tcl:169
+msgid "Transfer Options"
+msgstr "Operaciones de trasferencia"
+
+#: lib/transport.tcl:171
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "Sobrescritura forzada de ramas existentes (puede descartar cam=
bios)"
+
+#: lib/transport.tcl:175
+msgid "Use thin pack (for slow network connections)"
+msgstr "Usar paquete ligero (thin pack) (para conexiones de red lentas=
)"
+
+#: lib/transport.tcl:179
+msgid "Include tags"
+msgstr "Incluir etiquetas"
--=20
1.7.0.rc1.34.gaafa7
