Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1479B2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 17:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbdCRRy3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:54:29 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:31671 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbdCRRy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:54:27 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 403192003FD;
        Sat, 18 Mar 2017 18:54:18 +0100 (CET)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH v2 2/2] l10n: Add git-add.txt to localized man pages
Date:   Sat, 18 Mar 2017 18:53:53 +0100
Message-Id: <20170318175353.24578-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170318175353.24578-1-jn.avila@free.fr>
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170318175353.24578-1-jn.avila@free.fr>
MIME-Version: 1.0
In-Reply-To: <20170312200248.3610-1-jn.avila@free.fr>
References: <20170312200248.3610-1-jn.avila@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 Documentation/po/documentation.fr.po | 1095 ++++++++++++++++++++++++++++++++++
 Documentation/po/documentation.pot   |  787 ++++++++++++++++++++++++
 2 files changed, 1882 insertions(+)
 create mode 100644 Documentation/po/documentation.fr.po
 create mode 100644 Documentation/po/documentation.pot

diff --git a/Documentation/po/documentation.fr.po b/Documentation/po/documentation.fr.po
new file mode 100644
index 000000000..3017da0c9
--- /dev/null
+++ b/Documentation/po/documentation.fr.po
@@ -0,0 +1,1095 @@
+# French translations for Git Manual Pages.
+# Copyright (C) 2017 Jean-Noël Avila <jn.avila@free.fr>
+# This file is distributed under the same license as the Git package.
+# Jean-Noël Avila <jn.avila@free.fr>, 2016.
+msgid ""
+msgstr ""
+"Project-Id-Version: git documentation\n"
+"POT-Creation-Date: 2017-03-03 21:18+0100\n"
+"PO-Revision-Date: 2017-03-15 21:42+0100\n"
+"Last-Translator: Jean-Noël Avila <jn.avila@free.fr>\n"
+"Language-Team: Jean-Noël Avila <jn.avila@free.fr>\n"
+"Language: fr\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=utf-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. type: Title =
+#: git-add.txt:2
+#, no-wrap
+msgid "git-add(1)"
+msgstr "git-add(1)"
+
+#. type: Title -
+#: git-add.txt:5
+#, no-wrap
+msgid "NAME"
+msgstr "NOM"
+
+#
+#. type: Plain text
+#: git-add.txt:7
+msgid "git-add - Add file contents to the index"
+msgstr "git-add - Ajoute le contenu de fichiers à l'index"
+
+#. type: Title -
+#: git-add.txt:9
+#, no-wrap
+msgid "SYNOPSIS"
+msgstr "SYNOPSIS"
+
+#. type: Plain text
+#: git-add.txt:15
+#, no-wrap
+msgid ""
+"'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]\n"
+"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]\n"
+"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]\n"
+"\t  [--chmod=(+|-)x] [--] [<pathspec>...]\n"
+msgstr ""
+"'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]\n"
+"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]\n"
+"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]\n"
+"\t  [--chmod=(+|-)x] [--] [<spécification de chemin>...]\n"
+
+#. type: Title -
+#: git-add.txt:17
+#, no-wrap
+msgid "DESCRIPTION"
+msgstr "DESCRIPTION"
+
+#
+#. type: Plain text
+#: git-add.txt:24
+msgid ""
+"This command updates the index using the current content found in the "
+"working tree, to prepare the content staged for the next commit.  It "
+"typically adds the current content of existing paths as a whole, but with "
+"some options it can also be used to add content with only part of the "
+"changes made to the working tree files applied, or remove paths that do not "
+"exist in the working tree anymore."
+msgstr ""
+"Cette commande met à jour l'index en utilisant le contenu actuel trouvé dans "
+"la copie de travail, pour préparer le contenu de la prochaine validation. "
+"Typiquement, elle ajoute intégralement le contenu actuel des chemins "
+"existant, mais peut aussi n'ajouter que certaines parties des modifications "
+"au moyen d'options ou soustraire certains chemins qui n'existent plus dans "
+"la copie de travail."
+
+#
+#. type: Plain text
+#: git-add.txt:30
+msgid ""
+"The \"index\" holds a snapshot of the content of the working tree, and it is "
+"this snapshot that is taken as the contents of the next commit.  Thus after "
+"making any changes to the working tree, and before running the commit "
+"command, you must use the `add` command to add any new or modified files to "
+"the index."
+msgstr ""
+"L'« index » contient un instantané du contenu de la copie de travail et "
+"c'est cet instantané qui sera utilisé comme contenu du prochain commit.  "
+"Ainsi, après avoir réalisé des modifications dans la copie de travail, et "
+"avant de lancer la commande commit, vous devez utiliser la commande `add` "
+"pour ajouter tout fichier nouveau ou modifié à l'index."
+
+#
+#. type: Plain text
+#: git-add.txt:35
+msgid ""
+"This command can be performed multiple times before a commit.  It only adds "
+"the content of the specified file(s) at the time the add command is run; if "
+"you want subsequent changes included in the next commit, then you must run "
+"`git add` again to add the new content to the index."
+msgstr ""
+"Cette commande peut être effectuée plusieurs fois avant la validation.  Elle "
+"n'ajoute que le contenu des fichiers spécifiés au moment où la commande "
+"`add` est lancée ; si vous souhaitez inclure des modifications postérieures "
+"à un `add` dans la prochaine validation, vous devez alors lancer `git add` à "
+"nouveau pour ajouter le nouveau contenu à l'index."
+
+#
+#. type: Plain text
+#: git-add.txt:38
+msgid ""
+"The `git status` command can be used to obtain a summary of which files have "
+"changes that are staged for the next commit."
+msgstr ""
+"La commande `git status` permet d'obtenir un résumé des fichiers modifiés "
+"qui sont préparés pour la prochaine validation."
+
+#
+#. type: Plain text
+#: git-add.txt:45
+msgid ""
+"The `git add` command will not add ignored files by default.  If any ignored "
+"files were explicitly specified on the command line, `git add` will fail "
+"with a list of ignored files.  Ignored files reached by directory recursion "
+"or filename globbing performed by Git (quote your globs before the shell) "
+"will be silently ignored.  The 'git add' command can be used to add ignored "
+"files with the `-f` (force) option."
+msgstr ""
+"Par défaut, la commande `git add` n'ajoute pas les fichiers ignorés.  Si des "
+"fichiers ignorés sont spécifiés explicitement en ligne de commande, `git "
+"add` échouera avec la liste des fichiers ignorés. Les fichiers ignorés "
+"atteint via la récursion de répertoires ou les patrons de fichiers gérés par "
+"Git (les patrons doivent alors être échappés du shell par des quotes)  "
+"seront ignorés silencieusement. La commande `git add` peut tout de même "
+"ajouter des fichiers ignorés avec l'option `-f` (force)."
+
+#
+#. type: Plain text
+#: git-add.txt:48
+msgid ""
+"Please see linkgit:git-commit[1] for alternative ways to add content to a "
+"commit."
+msgstr ""
+"Référez-vous linkgit:git-commit[1] pour des méthodes alternatives d'ajout de "
+"contenu à une validation."
+
+#. type: Title -
+#: git-add.txt:51
+#, no-wrap
+msgid "OPTIONS"
+msgstr "OPTIONS"
+
+#. type: Plain text
+#: git-add.txt:64
+#, no-wrap
+msgid ""
+"<pathspec>...::\n"
+"\tFiles to add content from.  Fileglobs (e.g. `*.c`) can\n"
+"\tbe given to add all matching files.  Also a\n"
+"\tleading directory name (e.g. `dir` to add `dir/file1`\n"
+"\tand `dir/file2`) can be given to update the index to\n"
+"\tmatch the current state of the directory as a whole (e.g.\n"
+"\tspecifying `dir` will record not just a file `dir/file1`\n"
+"\tmodified in the working tree, a file `dir/file2` added to\n"
+"\tthe working tree, but also a file `dir/file3` removed from\n"
+"\tthe working tree.  Note that older versions of Git used\n"
+"\tto ignore removed files; use `--no-all` option if you want\n"
+"\tto add modified or new files but ignore removed\tones.\n"
+msgstr ""
+"<chemin>...::\n"
+"\tFichiers dont le contenu doit être ajouté. Les patrons (ex : `*.c`)\n"
+"\tpermettent de restreindre à tous le fichiers correspondant. Un\n"
+"\tnom de répertoire (ex : `rep` pour ajouter `rep/fichier1` et\n"
+"\t`rep/fichier2`) permet d'ajouter récursivement tous les fichiers\n"
+"\td'un répertoire.\n"
+
+#. type: Plain text
+#: git-add.txt:69
+#, no-wrap
+msgid ""
+"-n::\n"
+"--dry-run::\n"
+"\tDon't actually add the file(s), just show if they exist and/or will\n"
+"\tbe ignored.\n"
+msgstr ""
+"-n::\n"
+"--dry-run::\n"
+"\tN'ajoute pas réellement les fichiers. Montrer juste s'ils existent\n"
+"\tou seront ignorés.\n"
+
+#. type: Plain text
+#: git-add.txt:73
+#, no-wrap
+msgid ""
+"-v::\n"
+"--verbose::\n"
+"        Be verbose.\n"
+msgstr ""
+"-v::\n"
+"--verbose::\n"
+"        Mode bavard.\n"
+
+#. type: Plain text
+#: git-add.txt:77
+#, no-wrap
+msgid ""
+"-f::\n"
+"--force::\n"
+"\tAllow adding otherwise ignored files.\n"
+msgstr ""
+"-f::\n"
+"--force::\n"
+"\tForce l'ajout de fichiers qui sont normalement ignorés.\n"
+
+#. type: Plain text
+#: git-add.txt:84
+#, no-wrap
+msgid ""
+"-i::\n"
+"--interactive::\n"
+"\tAdd modified contents in the working tree interactively to\n"
+"\tthe index. Optional path arguments may be supplied to limit\n"
+"\toperation to a subset of the working tree. See ``Interactive\n"
+"\tmode'' for details.\n"
+msgstr ""
+"-i::\n"
+"--interactive::\n"
+"\tAjoute le contenu modifié dans l'arbre de travail à l'index\n"
+"\tde manière interactive. Les arguments optionnels de chemin \n"
+"\tpermettent de limiter les opérations à un sous-ensemble de la\n"
+"\tcopie de travail. Référez-vous à « Mode interactif » pour plus\n"
+"\tde détails.\n"
+
+#. type: Plain text
+#: git-add.txt:91
+#, no-wrap
+msgid ""
+"-p::\n"
+"--patch::\n"
+"\tInteractively choose hunks of patch between the index and the\n"
+"\twork tree and add them to the index. This gives the user a chance\n"
+"\tto review the difference before adding modified contents to the\n"
+"\tindex.\n"
+msgstr ""
+"-p::\n"
+"--patch::\n"
+"\tChoisit de manière interactive les sections de patch entre l'index\n"
+"\tet la copie de travail et les ajouter à l'index. Cela permet à\n"
+"\tl'utilisateur de réviser les différences avec d'ajouter le contenu\n"
+"\tmodifié à l'index.\n"
+
+#. type: Plain text
+#: git-add.txt:95
+#, no-wrap
+msgid ""
+"This effectively runs `add --interactive`, but bypasses the\n"
+"initial command menu and directly jumps to the `patch` subcommand.\n"
+"See ``Interactive mode'' for details.\n"
+msgstr ""
+"Cela lance effectivement `add --interactive` mais court-circuite\n"
+"le menu initial et saute directement à la sous-commande `patch`.\n"
+"Référez-vous à ``Mode interactif'' pour plus de détails.\n"
+
+#. type: Plain text
+#: git-add.txt:101
+#, no-wrap
+msgid ""
+"-e::\n"
+"--edit::\n"
+"\tOpen the diff vs. the index in an editor and let the user\n"
+"\tedit it.  After the editor was closed, adjust the hunk headers\n"
+"\tand apply the patch to the index.\n"
+msgstr ""
+"-e::\n"
+"--edit::\n"
+"\tOuvre les différences avec l'index dans un éditeur et laisser\n"
+"\tl'utilisateur les éditer. Après la fermeture de l'éditeur, ajuster\n"
+"\tles entêtes de sections et appliquer le patch dans l'index.\n"
+
+#. type: Plain text
+#: git-add.txt:107
+#, no-wrap
+msgid ""
+"The intent of this option is to pick and choose lines of the patch to\n"
+"apply, or even to modify the contents of lines to be staged. This can be\n"
+"quicker and more flexible than using the interactive hunk selector.\n"
+"However, it is easy to confuse oneself and create a patch that does not\n"
+"apply to the index. See EDITING PATCHES below.\n"
+msgstr ""
+"L'objectif de cette option est de permettre de choisir et retenir les\n"
+"lignes du patch à appliquer, ou même de modifier le contenu des lignes\n"
+"à indexer. Cela peut être plus rapide et plus flexible que l'utilisation\n"
+"du sélecteur interactif. Cependant, il plus facile de se \n"
+"tromper et de créer un patch qui ne s'applique pas. Référez-vous à\n"
+"ÉDITER LES PATCHS ci-dessous.\n"
+
+#. type: Plain text
+#: git-add.txt:113
+#, no-wrap
+msgid ""
+"-u::\n"
+"--update::\n"
+"\tUpdate the index just where it already has an entry matching\n"
+"\t<pathspec>.  This removes as well as modifies index entries to\n"
+"\tmatch the working tree, but adds no new files.\n"
+msgstr ""
+"-u::\n"
+"--update::\n"
+"\tMet à jour l'index sur les seuls fichiers déjà présents et\n"
+"\tcorrespondant à <chemin>. Cela retire ou modifie les entrées\n"
+"\td'index pour correspondre à la copie de travail, mais n'ajoute\n"
+"\tpas de fichier.\n"
+
+#. type: Plain text
+#: git-add.txt:118
+#, no-wrap
+msgid ""
+"If no <pathspec> is given when `-u` option is used, all\n"
+"tracked files in the entire working tree are updated (old versions\n"
+"of Git used to limit the update to the current directory and its\n"
+"subdirectories).\n"
+msgstr ""
+"Si aucun <chemin> n'est spécifié, quand l'option `-u` est utilisée,\n"
+"tous les fichiers suivis dans la totalité de la copie de travail sont\n"
+"mis à jour (les version anciennes de Git limitaient la mise à jour au\n"
+"répertoire courant et ses sous-répertoires).\n"
+
+#. type: Plain text
+#: git-add.txt:126
+#, no-wrap
+msgid ""
+"-A::\n"
+"--all::\n"
+"--no-ignore-removal::\n"
+"\tUpdate the index not only where the working tree has a file\n"
+"\tmatching <pathspec> but also where the index already has an\n"
+"\tentry.\tThis adds, modifies, and removes index entries to\n"
+"\tmatch the working tree.\n"
+msgstr ""
+"-A::\n"
+"--all::\n"
+"--no-ignore-removal::\n"
+"\tMet à jour l'index non seulement pour tous les fichiers de\n"
+"\tla copie de travail correspondant à <chemin> mais aussi pour\n"
+"\ttoutes les entrées existant déjà dans l'index. Ceci ajoute,\n"
+"\tmodifie et retire des entrées d'index pour correspondre à\n"
+"\tla copie de travail.\n"
+
+#. type: Plain text
+#: git-add.txt:131
+#, no-wrap
+msgid ""
+"If no <pathspec> is given when `-A` option is used, all\n"
+"files in the entire working tree are updated (old versions\n"
+"of Git used to limit the update to the current directory and its\n"
+"subdirectories).\n"
+msgstr ""
+"Si aucun <chemin> n'est spécifié quand l'option `-A` est utilisée,\n"
+"tous le fichiers de l'arbre de travail sont mis à jour (les versions\n"
+"anciennes de Git utilisaient le répertoire courant et ses\n"
+"sous-répertoires).\n"
+
+#. type: Plain text
+#: git-add.txt:138
+#, no-wrap
+msgid ""
+"--no-all::\n"
+"--ignore-removal::\n"
+"\tUpdate the index by adding new files that are unknown to the\n"
+"\tindex and files modified in the working tree, but ignore\n"
+"\tfiles that have been removed from the working tree.  This\n"
+"\toption is a no-op when no <pathspec> is used.\n"
+msgstr ""
+"--no-all::\n"
+"--ignore-removal::\n"
+"\tMet à jour l'index en ajoutant dans l'index les nouveaux\n"
+"\tfichiers qui sont inconnus et les fichiers modifiés dans la\n"
+"\tcopie de travail, mais ignore les fichiers qui ont été\n"
+"\teffacés de la copie de travail. Cette option ne fait rien\n"
+"\tquand aucun <chemin> n'est utilisé.\n"
+
+#. type: Plain text
+#: git-add.txt:142
+#, no-wrap
+msgid ""
+"This option is primarily to help users who are used to older\n"
+"versions of Git, whose \"git add <pathspec>...\" was a synonym\n"
+"for \"git add --no-all <pathspec>...\", i.e. ignored removed files.\n"
+msgstr ""
+"Cette option sert principalement à aider les utilisateurs de versions\n"
+"anciennes de Git pour lesquels « git add <chemin>... » était synonyme\n"
+"de « git add --no-all <chemin>... », c'est-à-dire qui ignorait les\n"
+"fichiers effacés.\n"
+
+#. type: Plain text
+#: git-add.txt:150
+#, no-wrap
+msgid ""
+"-N::\n"
+"--intent-to-add::\n"
+"\tRecord only the fact that the path will be added later. An entry\n"
+"\tfor the path is placed in the index with no content. This is\n"
+"\tuseful for, among other things, showing the unstaged content of\n"
+"\tsuch files with `git diff` and committing them with `git commit\n"
+"\t-a`.\n"
+msgstr ""
+"-N::\n"
+"--intent-to-add::\n"
+"\tN'enregistre que le fait que le chemin sera ajouté plus tard. Une\n"
+"\tentrée pour le chemin est placée en index sans contenu. C'est\n"
+"\tparticulièrement utile pour, entre autres choses, montrer le\n"
+"\tcontenu non indexé de ces fichiers avec `git diff` et les valider\n"
+"\tavec `git commit -a`.\n"
+
+#. type: Plain text
+#: git-add.txt:154
+#, no-wrap
+msgid ""
+"--refresh::\n"
+"\tDon't add the file(s), but only refresh their stat()\n"
+"\tinformation in the index.\n"
+msgstr ""
+"--refresh::\n"
+"\tN'ajoute pas les fichiers mais rafraîchit seulement leur\n"
+"\tinformation de stat() dans l'index.\n"
+
+#. type: Plain text
+#: git-add.txt:161
+#, no-wrap
+msgid ""
+"--ignore-errors::\n"
+"\tIf some files could not be added because of errors indexing\n"
+"\tthem, do not abort the operation, but continue adding the\n"
+"\tothers. The command shall still exit with non-zero status.\n"
+"\tThe configuration variable `add.ignoreErrors` can be set to\n"
+"\ttrue to make this the default behaviour.\n"
+msgstr ""
+"--ignore-errors::\n"
+"\tSi des fichiers n'ont pu être ajoutés à cause d'erreurs lors\n"
+"\tde leur indexation, n'annule pas l'opération mais continue\n"
+"\tl'ajout des autres fichiers. La commande se terminera tout de\n"
+"\tmême avec un code d'erreur non nul. Le paramètre\n"
+"\tde configuration `add.ignoreErrors` peut être positionné à\n"
+"\ttrue pour que ce comportement soit celui par défaut.\n"
+
+#. type: Plain text
+#: git-add.txt:167
+#, no-wrap
+msgid ""
+"--ignore-missing::\n"
+"\tThis option can only be used together with --dry-run. By using\n"
+"\tthis option the user can check if any of the given files would\n"
+"\tbe ignored, no matter if they are already present in the work\n"
+"\ttree or not.\n"
+msgstr ""
+"--ignore-missing::\n"
+"\tCette option ne peut être utilisée que couplée avec --dry-run.\n"
+"\tL'utilisation de cette option permet à l'utilisateur de vérifier\n"
+"\tsi un des fichiers indiqués serait ignoré, qu'il soit présent\n"
+"\tou non dans la copie de travail.\n"
+
+#. type: Plain text
+#: git-add.txt:172
+#, no-wrap
+msgid ""
+"--chmod=(+|-)x::\n"
+"\tOverride the executable bit of the added files.  The executable\n"
+"\tbit is only changed in the index, the files on disk are left\n"
+"\tunchanged.\n"
+msgstr ""
+"--chmod=(+|-)x::\n"
+"\tForce le bit exécutable des fichiers ajoutés. Le bit\n"
+"\texécutable n'est modifié que dans l'index, les fichiers de la\n"
+"\tcopie de travail ne sont pas modifiés.\n"
+
+#. type: Plain text
+#: git-add.txt:177
+#, no-wrap
+msgid ""
+"\\--::\n"
+"\tThis option can be used to separate command-line options from\n"
+"\tthe list of files, (useful when filenames might be mistaken\n"
+"\tfor command-line options).\n"
+msgstr ""
+"\\--::\n"
+"\tCette option permet de séparer les options de la ligne de commande\n"
+"\tde la liste des fichiers (utile si certains noms de fichiers\n"
+"\tpeuvent être confondus avec des options).\n"
+
+#. type: Title -
+#: git-add.txt:180
+#, no-wrap
+msgid "Configuration"
+msgstr "Configuration"
+
+#
+#. type: Plain text
+#: git-add.txt:186
+msgid ""
+"The optional configuration variable `core.excludesFile` indicates a path to "
+"a file containing patterns of file names to exclude from git-add, similar to "
+"$GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to "
+"those in info/exclude.  See linkgit:gitignore[5]."
+msgstr ""
+"Le paramètre de configuration optionnel `core.excludesFile` indique un "
+"chemin vers un fichier contenant les patrons des noms de fichier à exclure "
+"de git-add, similaire à $GIT_DIR/info/exclude. Les patrons dans le fichier "
+"d'exclusion sont additionnés à ceux de info/exclude. Référez-vous à linkgit:"
+"gitignore[5]."
+
+#. type: Title -
+#: git-add.txt:189
+#, no-wrap
+msgid "EXAMPLES"
+msgstr "EXEMPLES"
+
+#
+#. type: Plain text
+#: git-add.txt:193
+msgid ""
+"Adds content from all `*.txt` files under `Documentation` directory and its "
+"subdirectories:"
+msgstr ""
+"Ajouter le contenu de tous le fichiers `*.txt` sous le répertoire "
+"`Documentation` et ses sous répertoires."
+
+#. type: delimited block -
+#: git-add.txt:196
+#, no-wrap
+msgid "$ git add Documentation/\\*.txt\n"
+msgstr "$ git add Documentation/\\*.txt\n"
+
+#
+#. type: Plain text
+#: git-add.txt:201
+msgid ""
+"Note that the asterisk `*` is quoted from the shell in this example; this "
+"lets the command include the files from subdirectories of `Documentation/` "
+"directory."
+msgstr ""
+"Remarquez que l'astérisque `*` est échappé du shell dans cet exemple ; cela "
+"permet d'inclure les fichiers dans les sous-répertoires du Répertoire "
+"`Documentation/`."
+
+#
+#. type: Plain text
+#: git-add.txt:203
+msgid "Considers adding content from all git-*.sh scripts:"
+msgstr "Ajouter le contenu de tous les scripts git-*.sh :"
+
+#. type: delimited block -
+#: git-add.txt:206
+#, no-wrap
+msgid "$ git add git-*.sh\n"
+msgstr "$ git add git-*.sh\n"
+
+#
+#. type: Plain text
+#: git-add.txt:211
+msgid ""
+"Because this example lets the shell expand the asterisk (i.e. you are "
+"listing the files explicitly), it does not consider `subdir/git-foo.sh`."
+msgstr ""
+"Comme cet exemple laisse le shell réaliser l'expansion de l'astérisque "
+"(c'est-à-dire que vous listez explicitement les fichiers du répertoire), il "
+"ne traite pas `subdir/git-foo.sh`."
+
+#. type: Title -
+#: git-add.txt:213
+#, no-wrap
+msgid "Interactive mode"
+msgstr "Mode interactif"
+
+#
+#. type: Plain text
+#: git-add.txt:217
+msgid ""
+"When the command enters the interactive mode, it shows the output of the "
+"'status' subcommand, and then goes into its interactive command loop."
+msgstr ""
+"Quand la commande entre en mode interactif, elle affiche le résultat de la "
+"sous-commande 'status', puis entre en boucle de commande interactive."
+
+#
+#. type: Plain text
+#: git-add.txt:222
+msgid ""
+"The command loop shows the list of subcommands available, and gives a prompt "
+"\"What now> \".  In general, when the prompt ends with a single '>', you can "
+"pick only one of the choices given and type return, like this:"
+msgstr ""
+"La boucle de commande affiche la liste des sous-commandes disponibles et "
+"affiche le prompt \"What now>\" (Que faire maintenant). En général, lorsque "
+"le prompt se termine par un '>' unique, vous ne pouvez choisir qu'une seule "
+"des propositions et appuyer Entrée, comme cela :"
+
+#. type: delimited block -
+#: git-add.txt:228
+#, no-wrap
+msgid ""
+"    *** Commands ***\n"
+"      1: status       2: update       3: revert       4: add untracked\n"
+"      5: patch        6: diff         7: quit         8: help\n"
+"    What now> 1\n"
+msgstr ""
+"    *** Commands ***\n"
+"      1: status       2: update       3: revert       4: add untracked\n"
+"      5: patch        6: diff         7: quit         8: help\n"
+"    What now> 1\n"
+
+#
+#. type: Plain text
+#: git-add.txt:232
+msgid ""
+"You also could say `s` or `sta` or `status` above as long as the choice is "
+"unique."
+msgstr ""
+"Vous pouvez indiquer `s` ou `sta` ou `status` dans le cas si dessus, à "
+"condition que le choix soit unique."
+
+#
+#. type: Plain text
+#: git-add.txt:234
+msgid "The main command loop has 6 subcommands (plus help and quit)."
+msgstr ""
+"La boucle de commande principale propose 6 sous-commandes (plus help (aide)  "
+"et quit (quitter))."
+
+#. type: Labeled list
+#: git-add.txt:235
+#, no-wrap
+msgid "status"
+msgstr "status"
+
+#
+#. type: Plain text
+#: git-add.txt:242
+msgid ""
+"This shows the change between HEAD and index (i.e. what will be committed if "
+"you say `git commit`), and between index and working tree files (i.e. what "
+"you could stage further before `git commit` using `git add`) for each path.  "
+"A sample output looks like this:"
+msgstr ""
+"Affiche les modifications entre HEAD et l'index (c-à-d ce qui serait validé "
+"si vous lanciez `git commit`), et entre l'index et les fichiers de la copie "
+"de travail (c-à-d ce que vous pourriez indexer au moyen de `git add` avant "
+"de lancer `git commit`) pour chaque chemin. Un exemple d'affichage ressemble "
+"à ceci :"
+
+#. type: delimited block -
+#: git-add.txt:247
+#, no-wrap
+msgid ""
+"              staged     unstaged path\n"
+"     1:       binary      nothing foo.png\n"
+"     2:     +403/-35        +1/-1 git-add--interactive.perl\n"
+msgstr ""
+"              staged     unstaged path\n"
+"     1:       binary      nothing foo.png\n"
+"     2:     +403/-35        +1/-1 git-add--interactive.perl\n"
+
+#
+#. type: Plain text
+#: git-add.txt:258
+msgid ""
+"It shows that foo.png has differences from HEAD (but that is binary so line "
+"count cannot be shown) and there is no difference between indexed copy and "
+"the working tree version (if the working tree version were also different, "
+"'binary' would have been shown in place of 'nothing').  The other file, git-"
+"add{litdd}interactive.perl, has 403 lines added and 35 lines deleted if you "
+"commit what is in the index, but working tree file has further modifications "
+"(one addition and one deletion)."
+msgstr ""
+"foo.png contient de différences avec HEAD (mais c'est un format binaire donc "
+"le nombre de lignes ne peut pas être affiché) et il n'y a pas différence "
+"entre la copie indexée et la copie de travail (si la copie de travail avait "
+"été aussi différente, 'binary' aurait été affiché à la place de 'nothing'). "
+"L'autre fichier, git-add{litdd}interactive.perl, a 430 lignes ajoutées et 35 "
+"effacées si vous validez ce qui est dans l'index, mais la copie de travail "
+"contient d'autres modifications (un ajout et un retrait)."
+
+#. type: Labeled list
+#: git-add.txt:259
+#, no-wrap
+msgid "update"
+msgstr "update"
+
+#
+#. type: Plain text
+#: git-add.txt:268
+msgid ""
+"This shows the status information and issues an \"Update>>\" prompt.  When "
+"the prompt ends with double '>>', you can make more than one selection, "
+"concatenated with whitespace or comma.  Also you can say ranges.  E.g. \"2-5 "
+"7,9\" to choose 2,3,4,5,7,9 from the list.  If the second number in a range "
+"is omitted, all remaining patches are taken.  E.g. \"7-\" to choose 7,8,9 "
+"from the list.  You can say '*' to choose everything."
+msgstr ""
+"Affiche l'information d'état et un prompt \"Update>>\". Quand le prompt se "
+"termine par un double '>', vous pouvez sélectionner plus d'une option, "
+"concaténées avec des espaces ou des virgules. Vous pouvez aussi indiquer des "
+"intervalles.  Par exemple \"2-5 7,9\" pour choisir 2, 3, 4, 5, 7 et 9 dans "
+"la liste. Si le second nombre d'un intervalle est absent, tous les patchs "
+"restants sont sélectionnés. Par ex. \"7-\" choisit 7, 8 et 9 dans la liste. "
+"'*' permet de tout sélectionner."
+
+#
+#. type: Plain text
+#: git-add.txt:271
+msgid "What you chose are then highlighted with '*', like this:"
+msgstr "Tout ce qui a été sélectionné est indiqué par une '*', comme ceci :"
+
+#. type: delimited block -
+#: git-add.txt:276
+#, no-wrap
+msgid ""
+"           staged     unstaged path\n"
+"  1:       binary      nothing foo.png\n"
+"* 2:     +403/-35        +1/-1 git-add--interactive.perl\n"
+msgstr ""
+"           staged     unstaged path\n"
+"  1:       binary      nothing foo.png\n"
+"* 2:     +403/-35        +1/-1 git-add--interactive.perl\n"
+
+#
+#. type: Plain text
+#: git-add.txt:280
+msgid "To remove selection, prefix the input with `-` like this:"
+msgstr "Pour retirer une sélection, préfixez-la avec `-` comme ceci :"
+
+#. type: delimited block -
+#: git-add.txt:283
+#, no-wrap
+msgid "Update>> -2\n"
+msgstr "Update>> -2\n"
+
+#
+#. type: Plain text
+#: git-add.txt:287
+msgid ""
+"After making the selection, answer with an empty line to stage the contents "
+"of working tree files for selected paths in the index."
+msgstr ""
+"Après sélection, répondez avec une ligne vide pour indexer le contenu des "
+"fichiers sélectionnés de la copie de travail."
+
+#. type: Labeled list
+#: git-add.txt:288
+#, no-wrap
+msgid "revert"
+msgstr "revert"
+
+#
+#. type: Plain text
+#: git-add.txt:293
+msgid ""
+"This has a very similar UI to 'update', and the staged information for "
+"selected paths are reverted to that of the HEAD version.  Reverting new "
+"paths makes them untracked."
+msgstr ""
+"Ceci présente une interface d'utilisation similaire à 'update', et le "
+"contenu indexé des chemins sélectionnés sont ramenés à la version HEAD. "
+"Inverser des chemins nouveau les rend non-suivis."
+
+#. type: Labeled list
+#: git-add.txt:294
+#, no-wrap
+msgid "add untracked"
+msgstr "add untracked"
+
+#
+#. type: Plain text
+#: git-add.txt:298
+msgid ""
+"This has a very similar UI to 'update' and 'revert', and lets you add "
+"untracked paths to the index."
+msgstr ""
+"Ceci présente une interface d'utilisation très similaire à 'update' et "
+"'revert' et permet d'ajouter des chemins non-suivis à l'index."
+
+#. type: Labeled list
+#: git-add.txt:299
+#, no-wrap
+msgid "patch"
+msgstr "patch"
+
+#
+#. type: Plain text
+#: git-add.txt:306
+msgid ""
+"This lets you choose one path out of a 'status' like selection.  After "
+"choosing the path, it presents the diff between the index and the working "
+"tree file and asks you if you want to stage the change of each hunk.  You "
+"can select one of the following options and type return:"
+msgstr ""
+"Ceci permet de choisir un chemin depuis une sélection similaire à 'status'. "
+"Après le choix du chemin, la différence entre l'index et le fichier dans "
+"l'arbre de travail est présenté et vous demande si vous souhaiter indexer "
+"chaque section de modification. Vous pouvez sélectionner une des options "
+"suivantes et taper entréé :"
+
+#
+#. type: Plain text
+#: git-add.txt:321
+msgid ""
+"y - stage this hunk n - do not stage this hunk q - quit; do not stage this "
+"hunk or any of the remaining ones a - stage this hunk and all later hunks in "
+"the file d - do not stage this hunk or any of the later hunks in the file g "
+"- select a hunk to go to / - search for a hunk matching the given regex j - "
+"leave this hunk undecided, see next undecided hunk J - leave this hunk "
+"undecided, see next hunk k - leave this hunk undecided, see previous "
+"undecided hunk K - leave this hunk undecided, see previous hunk s - split "
+"the current hunk into smaller hunks e - manually edit the current hunk ? - "
+"print help"
+msgstr ""
+"y - indexer cette section\n"
+"n - ne pas indexer cette section\n"
+"q - quitter ; ne pas indexer cette section ni les autres restantes\n"
+"a - indexer cette section et toutes les suivantes de ce fichier\n"
+"d - ne pas indexer cette section ni les suivantes de ce fichier\n"
+"g - selectionner une section et s'y rendre\n"
+"/ - rechercher une section correspondant à une regex donnée\n"
+"j - laisser cette section non décidée et aller à la suivante non-décidée\n"
+"J - laisser cette section non décidée et aller à la suivante\n"
+"k - laisser cette section non décidée et aller à la précédente non-décidée\n"
+"K - laisser cette section non décidée et aller à la précédente\n"
+"s - découper la section en sections plus petites\n"
+"e - éditer manuellement la section actuelle\n"
+"? - afficher l'aide\n"
+
+#
+#. type: Plain text
+#: git-add.txt:324
+msgid ""
+"After deciding the fate for all hunks, if there is any hunk that was chosen, "
+"the index is updated with the selected hunks."
+msgstr ""
+"Après avoir décidé du devenir de chaque section, l'index est mis à jour avec "
+"les sections sélectionnées."
+
+#
+#. type: Plain text
+#: git-add.txt:327
+msgid ""
+"You can omit having to type return here, by setting the configuration "
+"variable `interactive.singleKey` to `true`."
+msgstr ""
+"Vous pouvez vous éviter de taper entrée ici, en mettant la variable de "
+"configuration `interactive.singlekey` à `true`."
+
+#. type: Labeled list
+#: git-add.txt:328
+#, no-wrap
+msgid "diff"
+msgstr "diff"
+
+#
+#. type: Plain text
+#: git-add.txt:332
+msgid ""
+"This lets you review what will be committed (i.e. between HEAD and index)."
+msgstr ""
+"Ceci permet de faire une revue de ce qui sera validé (c'est une différence "
+"entre HEAD et index)."
+
+#. type: Title -
+#: git-add.txt:335
+#, no-wrap
+msgid "EDITING PATCHES"
+msgstr "EDITER LES PATCHES"
+
+#
+#. type: Plain text
+#: git-add.txt:345
+msgid ""
+"Invoking `git add -e` or selecting `e` from the interactive hunk selector "
+"will open a patch in your editor; after the editor exits, the result is "
+"applied to the index. You are free to make arbitrary changes to the patch, "
+"but note that some changes may have confusing results, or even result in a "
+"patch that cannot be applied.  If you want to abort the operation entirely "
+"(i.e., stage nothing new in the index), simply delete all lines of the "
+"patch. The list below describes some common things you may see in a patch, "
+"and which editing operations make sense on them."
+msgstr ""
+"Invoquer `git add -e` ou selectionner `e` depuis le sélecteur interactif de "
+"sections ouvre un patch dans votre éditeur ; après avoir quitté l'éditeur, "
+"le résultat est appliqué à l'index. Vous êtes libre de modifier en tout "
+"point le patch, mais notez cependant que certaines modifications provoquent "
+"des résultats inattendus ou même créent des patchs inapplicables. Si vous "
+"souhaitez abandonner complètement l'opération (c'est-à-dire ne rien ajouter "
+"à l'index), effacez toutes les lignes du patch. La liste ci-dessous décrit "
+"des formes habituelles dans les patchs et quelles opérations d'édition "
+"peuvent être réalisées."
+
+#. type: Labeled list
+#: git-add.txt:347
+#, no-wrap
+msgid "added content"
+msgstr "contenu ajouté"
+
+#
+#. type: Plain text
+#: git-add.txt:351
+msgid ""
+"Added content is represented by lines beginning with \"{plus}\". You can "
+"prevent staging any addition lines by deleting them."
+msgstr ""
+"Le contenu ajouté est représentés par des lignes commençant par un "
+"\"{plus}\". Vous pouvez empêcher l'indexation de lignes ajoutées en les "
+"supprimant."
+
+#. type: Labeled list
+#: git-add.txt:352
+#, no-wrap
+msgid "removed content"
+msgstr "contenu supprimé"
+
+#
+#. type: Plain text
+#: git-add.txt:356
+msgid ""
+"Removed content is represented by lines beginning with \"-\". You can "
+"prevent staging their removal by converting the \"-\" to a \" \" (space)."
+msgstr ""
+"Le contenu supprimé est représenté par des lignes commençant par \"-\". Vous "
+"pouvez empêcher l'indexation de ces suppression en convertissant le \"-\" en "
+"\" \" (espace)."
+
+#. type: Labeled list
+#: git-add.txt:357
+#, no-wrap
+msgid "modified content"
+msgstr "contenu modifié"
+
+#
+#. type: Plain text
+#: git-add.txt:364
+msgid ""
+"Modified content is represented by \"-\" lines (removing the old content)  "
+"followed by \"{plus}\" lines (adding the replacement content). You can "
+"prevent staging the modification by converting \"-\" lines to \" \", and "
+"removing \"{plus}\" lines. Beware that modifying only half of the pair is "
+"likely to introduce confusing changes to the index."
+msgstr ""
+"Le contenu modifié est représenté par des lignes \"-\" (supprimant l'ancien "
+"contenu) suivies de lignes \"{plus}\" (ajoutant le nouveau contenu). Vous "
+"pouvez empêcher l'indexation de ces modifications en convertissant les "
+"lignes \"_\" en ligne \" \" et en supprimant les lignes \"{plus}\". Méfiez-"
+"vous : ne modifier que la moitié de la paire de lignes a de fortes chances "
+"de créer des modifications inattendues dans l'index."
+
+#
+#. type: Plain text
+#: git-add.txt:372
+msgid ""
+"There are also more complex operations that can be performed. But beware "
+"that because the patch is applied only to the index and not the working "
+"tree, the working tree will appear to \"undo\" the change in the index.  For "
+"example, introducing a new line into the index that is in neither the HEAD "
+"nor the working tree will stage the new line for commit, but the line will "
+"appear to be reverted in the working tree."
+msgstr ""
+"Il existe aussi des opérations plus complexes. Méfiez-vous : quand le patch "
+"n'est appliqué que dans l'index et pas dans l'arbre de travail, l'arbre de "
+"travail semblera « défaire » les modifications de l'index. Par exemple, "
+"l'introduction dans l'index d'une nouvelle ligne qui n'apparait ni dans HEAD "
+"ni dans l'arbre de travail indexera la nouvelle ligne pour validation, mais "
+"cette ligne semblera être supprimée dans l'arbre de travail."
+
+#
+#. type: Plain text
+#: git-add.txt:374
+msgid "Avoid using these constructs, or do so with extreme caution."
+msgstr ""
+"Évitez d'utiliser ces constructions, ou faites le avec une extrême "
+"précaution."
+
+#. type: Labeled list
+#: git-add.txt:376
+#, no-wrap
+msgid "removing untouched content"
+msgstr "suppression de contenu intact"
+
+#
+#. type: Plain text
+#: git-add.txt:382
+msgid ""
+"Content which does not differ between the index and working tree may be "
+"shown on context lines, beginning with a \" \" (space).  You can stage "
+"context lines for removal by converting the space to a \"-\". The resulting "
+"working tree file will appear to re-add the content."
+msgstr ""
+"Le contenu qui ne diffère pas entre l'index et l'arbre de travail peut être "
+"visible dans des lignes de contexte commençant par un \" \" (espace). Vous "
+"pouvez indexer l'élimination de lignes de contexte en convertissant l'espace "
+"en \"-\". Le fichier dans l'arbre de travail semblera ré-ajouter le contenu."
+
+#. type: Labeled list
+#: git-add.txt:383
+#, no-wrap
+msgid "modifying existing content"
+msgstr "modification de contenu existant"
+
+#
+#. type: Plain text
+#: git-add.txt:390
+msgid ""
+"One can also modify context lines by staging them for removal (by converting "
+"\" \" to \"-\") and adding a \"{plus}\" line with the new content.  "
+"Similarly, one can modify \"{plus}\" lines for existing additions or "
+"modifications. In all cases, the new modification will appear reverted in "
+"the working tree."
+msgstr ""
+"On peut aussi modifier le contenu de lignes de contexte en indexant leur "
+"suppression (en convertissant \" \" en \"-\") et en ajoutant dessous une "
+"ligne \"{plus}\" avec le nouveau contenu. On peut modifier des lignes "
+"\"{plus}\" dans des ajouts ou des modifications de contenu. Dans tous les "
+"cas, la nouvelle modification indexée semblera être annulée dans l'arbre de "
+"travail."
+
+#. type: Labeled list
+#: git-add.txt:391
+#, no-wrap
+msgid "new content"
+msgstr "contenu nouveau"
+
+#
+#. type: Plain text
+#: git-add.txt:396
+msgid ""
+"You may also add new content that does not exist in the patch; simply add "
+"new lines, each starting with \"{plus}\". The addition will appear reverted "
+"in the working tree."
+msgstr ""
+"Vous pouvez aussi ajouter du contenu nouveau qui n'existe pas dans le "
+"patch ; ajoutez simplement des nouvelles lignes, chacune commençant avec "
+"\"{plus}\". L'ajout semblera annulé dans l'arbre de travail."
+
+#
+#. type: Plain text
+#: git-add.txt:400
+msgid ""
+"There are also several operations which should be avoided entirely, as they "
+"will make the patch impossible to apply:"
+msgstr ""
+"Il existe aussi quelques opération à éviter complètement car celles-ci "
+"rendent le patch inapplicable :"
+
+#
+#. type: Plain text
+#: git-add.txt:402
+msgid "adding context (\" \") or removal (\"-\") lines"
+msgstr "ajout de context (\" \") ou lignes de suppression (\"-\")"
+
+#
+#. type: Plain text
+#: git-add.txt:403
+msgid "deleting context or removal lines"
+msgstr "suppression de contexte ou de lignes supprimées"
+
+#
+#. type: Plain text
+#: git-add.txt:404
+msgid "modifying the contents of context or removal lines"
+msgstr "modification de contenu de contexte ou de lignes supprimées"
+
+#. type: Title -
+#: git-add.txt:406
+#, no-wrap
+msgid "SEE ALSO"
+msgstr "VOIR AUSSI"
+
+#
+#. type: Plain text
+#: git-add.txt:413
+msgid ""
+"linkgit:git-status[1] linkgit:git-rm[1] linkgit:git-reset[1] linkgit:git-"
+"mv[1] linkgit:git-commit[1] linkgit:git-update-index[1]"
+msgstr ""
+"linkgit:git-status[1] linkgit:git-rm[1] linkgit:git-reset[1] linkgit:git-"
+"mv[1] linkgit:git-commit[1] linkgit:git-update-index[1]"
+
+#. type: Title -
+#: git-add.txt:415
+#, no-wrap
+msgid "GIT"
+msgstr "GIT"
+
+#
+#. type: Plain text
+#: git-add.txt:416
+msgid "Part of the linkgit:git[1] suite"
+msgstr "Fait partie de la suite linkgit:git[1]"
diff --git a/Documentation/po/documentation.pot b/Documentation/po/documentation.pot
new file mode 100644
index 000000000..46c590bea
--- /dev/null
+++ b/Documentation/po/documentation.pot
@@ -0,0 +1,787 @@
+# SOME DESCRIPTIVE TITLE
+# Copyright (C) YEAR Free Software Foundation, Inc.
+# This file is distributed under the same license as the PACKAGE package.
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"POT-Creation-Date: 2017-03-03 21:18+0100\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"Language-Team: LANGUAGE <LL@li.org>\n"
+"Language: \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=CHARSET\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. type: Title =
+#: ./git-add.txt:2
+#, no-wrap
+msgid "git-add(1)"
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:5
+#, no-wrap
+msgid "NAME"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:7
+msgid "git-add - Add file contents to the index"
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:9
+#, no-wrap
+msgid "SYNOPSIS"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:15
+#, no-wrap
+msgid ""
+"'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | "
+"-i] [--patch | -p]\n"
+"\t  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]\n"
+"\t  [--intent-to-add | -N] [--refresh] [--ignore-errors] "
+"[--ignore-missing]\n"
+"\t  [--chmod=(+|-)x] [--] [<pathspec>...]\n"
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:17
+#, no-wrap
+msgid "DESCRIPTION"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:24
+msgid ""
+"This command updates the index using the current content found in the "
+"working tree, to prepare the content staged for the next commit.  It "
+"typically adds the current content of existing paths as a whole, but with "
+"some options it can also be used to add content with only part of the "
+"changes made to the working tree files applied, or remove paths that do not "
+"exist in the working tree anymore."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:30
+msgid ""
+"The \"index\" holds a snapshot of the content of the working tree, and it is "
+"this snapshot that is taken as the contents of the next commit.  Thus after "
+"making any changes to the working tree, and before running the commit "
+"command, you must use the `add` command to add any new or modified files to "
+"the index."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:35
+msgid ""
+"This command can be performed multiple times before a commit.  It only adds "
+"the content of the specified file(s) at the time the add command is run; if "
+"you want subsequent changes included in the next commit, then you must run "
+"`git add` again to add the new content to the index."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:38
+msgid ""
+"The `git status` command can be used to obtain a summary of which files have "
+"changes that are staged for the next commit."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:45
+msgid ""
+"The `git add` command will not add ignored files by default.  If any ignored "
+"files were explicitly specified on the command line, `git add` will fail "
+"with a list of ignored files.  Ignored files reached by directory recursion "
+"or filename globbing performed by Git (quote your globs before the shell) "
+"will be silently ignored.  The 'git add' command can be used to add ignored "
+"files with the `-f` (force) option."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:48
+msgid ""
+"Please see linkgit:git-commit[1] for alternative ways to add content to a "
+"commit."
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:51
+#, no-wrap
+msgid "OPTIONS"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:64
+#, no-wrap
+msgid ""
+"<pathspec>...::\n"
+"\tFiles to add content from.  Fileglobs (e.g. `*.c`) can\n"
+"\tbe given to add all matching files.  Also a\n"
+"\tleading directory name (e.g. `dir` to add `dir/file1`\n"
+"\tand `dir/file2`) can be given to update the index to\n"
+"\tmatch the current state of the directory as a whole (e.g.\n"
+"\tspecifying `dir` will record not just a file `dir/file1`\n"
+"\tmodified in the working tree, a file `dir/file2` added to\n"
+"\tthe working tree, but also a file `dir/file3` removed from\n"
+"\tthe working tree.  Note that older versions of Git used\n"
+"\tto ignore removed files; use `--no-all` option if you want\n"
+"\tto add modified or new files but ignore removed\tones.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:69
+#, no-wrap
+msgid ""
+"-n::\n"
+"--dry-run::\n"
+"\tDon't actually add the file(s), just show if they exist and/or will\n"
+"\tbe ignored.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:73
+#, no-wrap
+msgid ""
+"-v::\n"
+"--verbose::\n"
+"        Be verbose.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:77
+#, no-wrap
+msgid ""
+"-f::\n"
+"--force::\n"
+"\tAllow adding otherwise ignored files.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:84
+#, no-wrap
+msgid ""
+"-i::\n"
+"--interactive::\n"
+"\tAdd modified contents in the working tree interactively to\n"
+"\tthe index. Optional path arguments may be supplied to limit\n"
+"\toperation to a subset of the working tree. See ``Interactive\n"
+"\tmode'' for details.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:91
+#, no-wrap
+msgid ""
+"-p::\n"
+"--patch::\n"
+"\tInteractively choose hunks of patch between the index and the\n"
+"\twork tree and add them to the index. This gives the user a chance\n"
+"\tto review the difference before adding modified contents to the\n"
+"\tindex.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:95
+#, no-wrap
+msgid ""
+"This effectively runs `add --interactive`, but bypasses the\n"
+"initial command menu and directly jumps to the `patch` subcommand.\n"
+"See ``Interactive mode'' for details.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:101
+#, no-wrap
+msgid ""
+"-e::\n"
+"--edit::\n"
+"\tOpen the diff vs. the index in an editor and let the user\n"
+"\tedit it.  After the editor was closed, adjust the hunk headers\n"
+"\tand apply the patch to the index.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:107
+#, no-wrap
+msgid ""
+"The intent of this option is to pick and choose lines of the patch to\n"
+"apply, or even to modify the contents of lines to be staged. This can be\n"
+"quicker and more flexible than using the interactive hunk selector.\n"
+"However, it is easy to confuse oneself and create a patch that does not\n"
+"apply to the index. See EDITING PATCHES below.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:113
+#, no-wrap
+msgid ""
+"-u::\n"
+"--update::\n"
+"\tUpdate the index just where it already has an entry matching\n"
+"\t<pathspec>.  This removes as well as modifies index entries to\n"
+"\tmatch the working tree, but adds no new files.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:118
+#, no-wrap
+msgid ""
+"If no <pathspec> is given when `-u` option is used, all\n"
+"tracked files in the entire working tree are updated (old versions\n"
+"of Git used to limit the update to the current directory and its\n"
+"subdirectories).\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:126
+#, no-wrap
+msgid ""
+"-A::\n"
+"--all::\n"
+"--no-ignore-removal::\n"
+"\tUpdate the index not only where the working tree has a file\n"
+"\tmatching <pathspec> but also where the index already has an\n"
+"\tentry.\tThis adds, modifies, and removes index entries to\n"
+"\tmatch the working tree.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:131
+#, no-wrap
+msgid ""
+"If no <pathspec> is given when `-A` option is used, all\n"
+"files in the entire working tree are updated (old versions\n"
+"of Git used to limit the update to the current directory and its\n"
+"subdirectories).\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:138
+#, no-wrap
+msgid ""
+"--no-all::\n"
+"--ignore-removal::\n"
+"\tUpdate the index by adding new files that are unknown to the\n"
+"\tindex and files modified in the working tree, but ignore\n"
+"\tfiles that have been removed from the working tree.  This\n"
+"\toption is a no-op when no <pathspec> is used.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:142
+#, no-wrap
+msgid ""
+"This option is primarily to help users who are used to older\n"
+"versions of Git, whose \"git add <pathspec>...\" was a synonym\n"
+"for \"git add --no-all <pathspec>...\", i.e. ignored removed files.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:150
+#, no-wrap
+msgid ""
+"-N::\n"
+"--intent-to-add::\n"
+"\tRecord only the fact that the path will be added later. An entry\n"
+"\tfor the path is placed in the index with no content. This is\n"
+"\tuseful for, among other things, showing the unstaged content of\n"
+"\tsuch files with `git diff` and committing them with `git commit\n"
+"\t-a`.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:154
+#, no-wrap
+msgid ""
+"--refresh::\n"
+"\tDon't add the file(s), but only refresh their stat()\n"
+"\tinformation in the index.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:161
+#, no-wrap
+msgid ""
+"--ignore-errors::\n"
+"\tIf some files could not be added because of errors indexing\n"
+"\tthem, do not abort the operation, but continue adding the\n"
+"\tothers. The command shall still exit with non-zero status.\n"
+"\tThe configuration variable `add.ignoreErrors` can be set to\n"
+"\ttrue to make this the default behaviour.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:167
+#, no-wrap
+msgid ""
+"--ignore-missing::\n"
+"\tThis option can only be used together with --dry-run. By using\n"
+"\tthis option the user can check if any of the given files would\n"
+"\tbe ignored, no matter if they are already present in the work\n"
+"\ttree or not.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:172
+#, no-wrap
+msgid ""
+"--chmod=(+|-)x::\n"
+"\tOverride the executable bit of the added files.  The executable\n"
+"\tbit is only changed in the index, the files on disk are left\n"
+"\tunchanged.\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:177
+#, no-wrap
+msgid ""
+"\\--::\n"
+"\tThis option can be used to separate command-line options from\n"
+"\tthe list of files, (useful when filenames might be mistaken\n"
+"\tfor command-line options).\n"
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:180
+#, no-wrap
+msgid "Configuration"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:186
+msgid ""
+"The optional configuration variable `core.excludesFile` indicates a path to "
+"a file containing patterns of file names to exclude from git-add, similar to "
+"$GIT_DIR/info/exclude.  Patterns in the exclude file are used in addition to "
+"those in info/exclude.  See linkgit:gitignore[5]."
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:189
+#, no-wrap
+msgid "EXAMPLES"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:193
+msgid ""
+"Adds content from all `*.txt` files under `Documentation` directory and its "
+"subdirectories:"
+msgstr ""
+
+#. type: delimited block -
+#: ./git-add.txt:196
+#, no-wrap
+msgid "$ git add Documentation/\\*.txt\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:201
+msgid ""
+"Note that the asterisk `*` is quoted from the shell in this example; this "
+"lets the command include the files from subdirectories of `Documentation/` "
+"directory."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:203
+msgid "Considers adding content from all git-*.sh scripts:"
+msgstr ""
+
+#. type: delimited block -
+#: ./git-add.txt:206
+#, no-wrap
+msgid "$ git add git-*.sh\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:211
+msgid ""
+"Because this example lets the shell expand the asterisk (i.e. you are "
+"listing the files explicitly), it does not consider `subdir/git-foo.sh`."
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:213
+#, no-wrap
+msgid "Interactive mode"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:217
+msgid ""
+"When the command enters the interactive mode, it shows the output of the "
+"'status' subcommand, and then goes into its interactive command loop."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:222
+msgid ""
+"The command loop shows the list of subcommands available, and gives a prompt "
+"\"What now> \".  In general, when the prompt ends with a single '>', you can "
+"pick only one of the choices given and type return, like this:"
+msgstr ""
+
+#. type: delimited block -
+#: ./git-add.txt:228
+#, no-wrap
+msgid ""
+"    *** Commands ***\n"
+"      1: status       2: update       3: revert       4: add untracked\n"
+"      5: patch        6: diff         7: quit         8: help\n"
+"    What now> 1\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:232
+msgid ""
+"You also could say `s` or `sta` or `status` above as long as the choice is "
+"unique."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:234
+msgid "The main command loop has 6 subcommands (plus help and quit)."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:235
+#, no-wrap
+msgid "status"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:242
+msgid ""
+"This shows the change between HEAD and index (i.e. what will be committed if "
+"you say `git commit`), and between index and working tree files (i.e. what "
+"you could stage further before `git commit` using `git add`) for each path.  "
+"A sample output looks like this:"
+msgstr ""
+
+#. type: delimited block -
+#: ./git-add.txt:247
+#, no-wrap
+msgid ""
+"              staged     unstaged path\n"
+"     1:       binary      nothing foo.png\n"
+"     2:     +403/-35        +1/-1 git-add--interactive.perl\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:258
+msgid ""
+"It shows that foo.png has differences from HEAD (but that is binary so line "
+"count cannot be shown) and there is no difference between indexed copy and "
+"the working tree version (if the working tree version were also different, "
+"'binary' would have been shown in place of 'nothing').  The other file, "
+"git-add{litdd}interactive.perl, has 403 lines added and 35 lines deleted if "
+"you commit what is in the index, but working tree file has further "
+"modifications (one addition and one deletion)."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:259
+#, no-wrap
+msgid "update"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:268
+msgid ""
+"This shows the status information and issues an \"Update>>\" prompt.  When "
+"the prompt ends with double '>>', you can make more than one selection, "
+"concatenated with whitespace or comma.  Also you can say ranges.  E.g. \"2-5 "
+"7,9\" to choose 2,3,4,5,7,9 from the list.  If the second number in a range "
+"is omitted, all remaining patches are taken.  E.g. \"7-\" to choose 7,8,9 "
+"from the list.  You can say '*' to choose everything."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:271
+msgid "What you chose are then highlighted with '*', like this:"
+msgstr ""
+
+#. type: delimited block -
+#: ./git-add.txt:276
+#, no-wrap
+msgid ""
+"           staged     unstaged path\n"
+"  1:       binary      nothing foo.png\n"
+"* 2:     +403/-35        +1/-1 git-add--interactive.perl\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:280
+msgid "To remove selection, prefix the input with `-` like this:"
+msgstr ""
+
+#. type: delimited block -
+#: ./git-add.txt:283
+#, no-wrap
+msgid "Update>> -2\n"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:287
+msgid ""
+"After making the selection, answer with an empty line to stage the contents "
+"of working tree files for selected paths in the index."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:288
+#, no-wrap
+msgid "revert"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:293
+msgid ""
+"This has a very similar UI to 'update', and the staged information for "
+"selected paths are reverted to that of the HEAD version.  Reverting new "
+"paths makes them untracked."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:294
+#, no-wrap
+msgid "add untracked"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:298
+msgid ""
+"This has a very similar UI to 'update' and 'revert', and lets you add "
+"untracked paths to the index."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:299
+#, no-wrap
+msgid "patch"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:306
+msgid ""
+"This lets you choose one path out of a 'status' like selection.  After "
+"choosing the path, it presents the diff between the index and the working "
+"tree file and asks you if you want to stage the change of each hunk.  You "
+"can select one of the following options and type return:"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:321
+msgid ""
+"y - stage this hunk n - do not stage this hunk q - quit; do not stage this "
+"hunk or any of the remaining ones a - stage this hunk and all later hunks in "
+"the file d - do not stage this hunk or any of the later hunks in the file g "
+"- select a hunk to go to / - search for a hunk matching the given regex j - "
+"leave this hunk undecided, see next undecided hunk J - leave this hunk "
+"undecided, see next hunk k - leave this hunk undecided, see previous "
+"undecided hunk K - leave this hunk undecided, see previous hunk s - split "
+"the current hunk into smaller hunks e - manually edit the current hunk ? - "
+"print help"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:324
+msgid ""
+"After deciding the fate for all hunks, if there is any hunk that was chosen, "
+"the index is updated with the selected hunks."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:327
+msgid ""
+"You can omit having to type return here, by setting the configuration "
+"variable `interactive.singleKey` to `true`."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:328
+#, no-wrap
+msgid "diff"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:332
+msgid "This lets you review what will be committed (i.e. between HEAD and index)."
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:335
+#, no-wrap
+msgid "EDITING PATCHES"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:345
+msgid ""
+"Invoking `git add -e` or selecting `e` from the interactive hunk selector "
+"will open a patch in your editor; after the editor exits, the result is "
+"applied to the index. You are free to make arbitrary changes to the patch, "
+"but note that some changes may have confusing results, or even result in a "
+"patch that cannot be applied.  If you want to abort the operation entirely "
+"(i.e., stage nothing new in the index), simply delete all lines of the "
+"patch. The list below describes some common things you may see in a patch, "
+"and which editing operations make sense on them."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:347
+#, no-wrap
+msgid "added content"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:351
+msgid ""
+"Added content is represented by lines beginning with \"{plus}\". You can "
+"prevent staging any addition lines by deleting them."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:352
+#, no-wrap
+msgid "removed content"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:356
+msgid ""
+"Removed content is represented by lines beginning with \"-\". You can "
+"prevent staging their removal by converting the \"-\" to a \" \" (space)."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:357
+#, no-wrap
+msgid "modified content"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:364
+msgid ""
+"Modified content is represented by \"-\" lines (removing the old content)  "
+"followed by \"{plus}\" lines (adding the replacement content). You can "
+"prevent staging the modification by converting \"-\" lines to \" \", and "
+"removing \"{plus}\" lines. Beware that modifying only half of the pair is "
+"likely to introduce confusing changes to the index."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:372
+msgid ""
+"There are also more complex operations that can be performed. But beware "
+"that because the patch is applied only to the index and not the working "
+"tree, the working tree will appear to \"undo\" the change in the index.  For "
+"example, introducing a new line into the index that is in neither the HEAD "
+"nor the working tree will stage the new line for commit, but the line will "
+"appear to be reverted in the working tree."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:374
+msgid "Avoid using these constructs, or do so with extreme caution."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:376
+#, no-wrap
+msgid "removing untouched content"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:382
+msgid ""
+"Content which does not differ between the index and working tree may be "
+"shown on context lines, beginning with a \" \" (space).  You can stage "
+"context lines for removal by converting the space to a \"-\". The resulting "
+"working tree file will appear to re-add the content."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:383
+#, no-wrap
+msgid "modifying existing content"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:390
+msgid ""
+"One can also modify context lines by staging them for removal (by converting "
+"\" \" to \"-\") and adding a \"{plus}\" line with the new content.  "
+"Similarly, one can modify \"{plus}\" lines for existing additions or "
+"modifications. In all cases, the new modification will appear reverted in "
+"the working tree."
+msgstr ""
+
+#. type: Labeled list
+#: ./git-add.txt:391
+#, no-wrap
+msgid "new content"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:396
+msgid ""
+"You may also add new content that does not exist in the patch; simply add "
+"new lines, each starting with \"{plus}\". The addition will appear reverted "
+"in the working tree."
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:400
+msgid ""
+"There are also several operations which should be avoided entirely, as they "
+"will make the patch impossible to apply:"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:402
+msgid "adding context (\" \") or removal (\"-\") lines"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:403
+msgid "deleting context or removal lines"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:404
+msgid "modifying the contents of context or removal lines"
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:406
+#, no-wrap
+msgid "SEE ALSO"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:413
+msgid ""
+"linkgit:git-status[1] linkgit:git-rm[1] linkgit:git-reset[1] "
+"linkgit:git-mv[1] linkgit:git-commit[1] linkgit:git-update-index[1]"
+msgstr ""
+
+#. type: Title -
+#: ./git-add.txt:415
+#, no-wrap
+msgid "GIT"
+msgstr ""
+
+#. type: Plain text
+#: ./git-add.txt:416
+msgid "Part of the linkgit:git[1] suite"
+msgstr ""
-- 
2.12.0

