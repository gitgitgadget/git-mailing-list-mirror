From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 4/7] use 'commit-ish' instead of 'committish'
Date: Wed,  4 Sep 2013 15:04:31 -0400
Message-ID: <1378321474-7125-5-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
 <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:05:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIOA-0002LG-T4
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760076Ab3IDTFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Sep 2013 15:05:07 -0400
Received: from smtp.bbn.com ([128.33.1.81]:26107 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760053Ab3IDTFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Sep 2013 15:05:05 -0400
Received: from socket.bbn.com ([192.1.120.102]:59579)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHINv-00033b-T7; Wed, 04 Sep 2013 15:04:59 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id B6FD84004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233860>

Replace 'committish' in documentation and comments with 'commit-ish'
to match gitglossary(7) and to be consistent with 'tree-ish'.

The only remaining instances of 'committish' are:
  * variable, function, and macro names
  * "(also committish)" in the definition of commit-ish in
    gitglossary[7]

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/config.txt                     |  4 ++--
 Documentation/git-describe.txt               | 14 +++++++-------
 Documentation/git-fast-import.txt            | 26 +++++++++++++-------=
------
 Documentation/git-name-rev.txt               |  2 +-
 Documentation/git-push.txt                   |  2 +-
 Documentation/gitcli.txt                     |  2 +-
 Documentation/howto/revert-branch-rebase.txt |  2 +-
 builtin/describe.c                           |  4 ++--
 builtin/merge.c                              |  2 +-
 contrib/examples/git-merge.sh                |  2 +-
 fast-import.c                                | 16 ++++++++--------
 po/da.po                                     |  2 +-
 po/de.po                                     |  6 +++---
 po/fr.po                                     |  4 ++--
 po/git.pot                                   |  4 ++--
 po/it.po                                     |  2 +-
 po/nl.po                                     |  2 +-
 po/pt_PT.po                                  |  2 +-
 po/sv.po                                     |  6 +++---
 po/vi.po                                     |  6 +++---
 po/zh_CN.po                                  |  4 ++--
 sha1_name.c                                  |  6 +++---
 t/t9300-fast-import.sh                       |  6 +++---
 23 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..1ccec22 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -170,8 +170,8 @@ advice.*::
 	pushNeedsForce::
 		Shown when linkgit:git-push[1] rejects an update that
 		tries to overwrite a remote ref that points at an
-		object that is not a committish, or make the remote
-		ref point at an object that is not a committish.
+		object that is not a commit-ish, or make the remote
+		ref point at an object that is not a commit-ish.
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1], in
diff --git a/Documentation/git-describe.txt b/Documentation/git-describ=
e.txt
index 9439cd6..d20ca40 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -9,7 +9,7 @@ git-describe - Show the most recent tag that is reachab=
le from a commit
 SYNOPSIS
 --------
 [verse]
-'git describe' [--all] [--tags] [--contains] [--abbrev=3D<n>] <committ=
ish>...
+'git describe' [--all] [--tags] [--contains] [--abbrev=3D<n>] <commit-=
ish>...
 'git describe' [--all] [--tags] [--contains] [--abbrev=3D<n>] --dirty[=
=3D<mark>]
=20
 DESCRIPTION
@@ -26,8 +26,8 @@ see the -a and -s options to linkgit:git-tag[1].
=20
 OPTIONS
 -------
-<committish>...::
-	Committish object names to describe.
+<commit-ish>...::
+	Commit-ish object names to describe.
=20
 --dirty[=3D<mark>]::
 	Describe the working tree.
@@ -57,7 +57,7 @@ OPTIONS
=20
 --candidates=3D<n>::
 	Instead of considering only the 10 most recent tags as
-	candidates to describe the input committish consider
+	candidates to describe the input commit-ish consider
 	up to <n> candidates.  Increasing <n> above 10 will take
 	slightly longer but may produce a more accurate result.
 	An <n> of 0 will cause only exact matches to be output.
@@ -145,7 +145,7 @@ be sufficient to disambiguate these commits.
 SEARCH STRATEGY
 ---------------
=20
-For each committish supplied, 'git describe' will first look for
+For each commit-ish supplied, 'git describe' will first look for
 a tag which tags exactly that commit.  Annotated tags will always
 be preferred over lightweight tags, and tags with newer dates will
 always be preferred over tags with older dates.  If an exact match
@@ -154,12 +154,12 @@ is found, its name will be output and searching w=
ill stop.
 If an exact match was not found, 'git describe' will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
-abbreviation of the input committish's SHA-1. If '--first-parent' was
+abbreviation of the input commit-ish's SHA-1. If '--first-parent' was
 specified then the walk will only consider the first parent of each
 commit.
=20
 If multiple tags were found during the walk then the tag which
-has the fewest commits different from the input committish will be
+has the fewest commits different from the input commit-ish will be
 selected and output.  Here fewest commits different is defined as
 the number of commits which would be shown by `git log tag..input`
 will be the smallest number of commits possible.
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index bf1a02a..bba3ec9 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -380,8 +380,8 @@ change to the project.
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
-	('from' SP <committish> LF)?
-	('merge' SP <committish> LF)?
+	('from' SP <commit-ish> LF)?
+	('merge' SP <commit-ish> LF)?
 	(filemodify | filedelete | filecopy | filerename | filedeleteall | no=
temodify)*
 	LF?
 ....
@@ -460,9 +460,9 @@ as the current commit on that branch is automatical=
ly assumed to
 be the first ancestor of the new commit.
=20
 As `LF` is not valid in a Git refname or SHA-1 expression, no
-quoting or escaping syntax is supported within `<committish>`.
+quoting or escaping syntax is supported within `<commit-ish>`.
=20
-Here `<committish>` is any of the following:
+Here `<commit-ish>` is any of the following:
=20
 * The name of an existing branch already in fast-import's internal bra=
nch
   table.  If fast-import doesn't know the name, it's treated as a SHA-=
1
@@ -509,7 +509,7 @@ additional ancestors (forming a 16-way merge).  For=
 this reason
 it is suggested that frontends do not use more than 15 `merge`
 commands per commit; 16, if starting a new, empty branch.
=20
-Here `<committish>` is any of the commit specification expressions
+Here `<commit-ish>` is any of the commit specification expressions
 also accepted by `from` (see above).
=20
 `filemodify`
@@ -677,8 +677,8 @@ paths for a commit are encouraged to do so.
 `notemodify`
 ^^^^^^^^^^^^
 Included in a `commit` `<notes_ref>` command to add a new note
-annotating a `<committish>` or change this annotation contents.
-Internally it is similar to filemodify 100644 on `<committish>`
+annotating a `<commit-ish>` or change this annotation contents.
+Internally it is similar to filemodify 100644 on `<commit-ish>`
 path (maybe split into subdirectories). It's not advised to
 use any other commands to write to the `<notes_ref>` tree except
 `filedeleteall` to delete all existing notes in this tree.
@@ -691,7 +691,7 @@ External data format::
 	commit that is to be annotated.
 +
 ....
-	'N' SP <dataref> SP <committish> LF
+	'N' SP <dataref> SP <commit-ish> LF
 ....
 +
 Here `<dataref>` can be either a mark reference (`:<idnum>`)
@@ -704,13 +704,13 @@ Inline data format::
 	command.
 +
 ....
-	'N' SP 'inline' SP <committish> LF
+	'N' SP 'inline' SP <commit-ish> LF
 	data
 ....
 +
 See below for a detailed description of the `data` command.
=20
-In both formats `<committish>` is any of the commit specification
+In both formats `<commit-ish>` is any of the commit specification
 expressions also accepted by `from` (see above).
=20
 `mark`
@@ -741,7 +741,7 @@ lightweight (non-annotated) tags see the `reset` co=
mmand below.
=20
 ....
 	'tag' SP <name> LF
-	'from' SP <committish> LF
+	'from' SP <commit-ish> LF
 	'tagger' (SP <name>)? SP LT <email> GT SP <when> LF
 	data
 ....
@@ -786,11 +786,11 @@ branch from an existing commit without creating a=
 new commit.
=20
 ....
 	'reset' SP <ref> LF
-	('from' SP <committish> LF)?
+	('from' SP <commit-ish> LF)?
 	LF?
 ....
=20
-For a detailed description of `<ref>` and `<committish>` see above
+For a detailed description of `<ref>` and `<commit-ish>` see above
 under `commit` and `from`.
=20
 The `LF` after the command is optional (it used to be required).
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-re=
v.txt
index 15b00e0..ca28fb8 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git name-rev' [--tags] [--refs=3D<pattern>]
-	       ( --all | --stdin | <committish>... )
+	       ( --all | --stdin | <commit-ish>... )
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f7dfe48..a5c6f7d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -120,7 +120,7 @@ already exists on the remote side.
 --follow-tags::
 	Push all the refs that would be pushed without this option,
 	and also push annotated tags in `refs/tags` that are missing
-	from the remote but are pointing at committish that are
+	from the remote but are pointing at commit-ish that are
 	reachable from the refs being pushed.
=20
 --receive-pack=3D<git-receive-pack>::
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 9ac5088..7d54b77 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -106,7 +106,7 @@ couple of magic command line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git describe [options] <committish>*
+usage: git describe [options] <commit-ish>*
    or: git describe [options] --dirty
=20
     --contains            find the tag that comes after the commit
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentati=
on/howto/revert-branch-rebase.txt
index 0d5419e..85f69db 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -154,7 +154,7 @@ $ git pull . master
 Packing 0 objects
 Unpacking 0 objects
=20
-* committish: e3a693c...	refs/heads/master from .
+* commit-ish: e3a693c...	refs/heads/master from .
 Trying to merge e3a693c... into 8c1f5f0... using 10d781b...
 Committed merge 7fb9b7262a1d1e0a47bbfdcbbcf50ce0635d3f8f
  cache.h        |    8 ++++----
diff --git a/builtin/describe.c b/builtin/describe.c
index 7d73722..121a535 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -13,7 +13,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
=20
 static const char * const describe_usage[] =3D {
-	N_("git describe [options] <committish>*"),
+	N_("git describe [options] <commit-ish>*"),
 	N_("git describe [options] --dirty"),
 	NULL
 };
@@ -486,7 +486,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 		}
 		describe("HEAD", 1);
 	} else if (dirty) {
-		die(_("--dirty is incompatible with committishes"));
+		die(_("--dirty is incompatible with commit-ishes"));
 	} else {
 		while (argc-- > 0) {
 			describe(*argv++, argc =3D=3D 0);
diff --git a/builtin/merge.c b/builtin/merge.c
index 34a6166..9a2c58a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1193,7 +1193,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	 * This could be traditional "merge <msg> HEAD <commit>..."  and
 	 * the way we can tell it is to see if the second token is HEAD,
 	 * but some people might have misused the interface and used a
-	 * committish that is the same as HEAD there instead.
+	 * commit-ish that is the same as HEAD there instead.
 	 * Traditional format never would have "-m" so it is an
 	 * additional safety measure to check for it.
 	 */
diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge=
=2Esh
index 7b922c3..a5e42a9 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -263,7 +263,7 @@ fi
=20
 # This could be traditional "merge <msg> HEAD <commit>..."  and the
 # way we can tell it is to see if the second token is HEAD, but some
-# people might have misused the interface and used a committish that
+# people might have misused the interface and used a commit-ish that
 # is the same as HEAD there instead.  Traditional format never would
 # have "-m" so it is an additional safety measure to check for it.
=20
diff --git a/fast-import.c b/fast-import.c
index 019be11..f5babae 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -22,8 +22,8 @@ Format of STDIN stream:
     ('author' (sp name)? sp '<' email '>' sp when lf)?
     'committer' (sp name)? sp '<' email '>' sp when lf
     commit_msg
-    ('from' sp committish lf)?
-    ('merge' sp committish lf)*
+    ('from' sp commit-ish lf)?
+    ('merge' sp commit-ish lf)*
     (file_change | ls)*
     lf?;
   commit_msg ::=3D data;
@@ -43,18 +43,18 @@ Format of STDIN stream:
   file_obm ::=3D 'M' sp mode sp (hexsha1 | idnum) sp path_str lf;
   file_inm ::=3D 'M' sp mode sp 'inline' sp path_str lf
     data;
-  note_obm ::=3D 'N' sp (hexsha1 | idnum) sp committish lf;
-  note_inm ::=3D 'N' sp 'inline' sp committish lf
+  note_obm ::=3D 'N' sp (hexsha1 | idnum) sp commit-ish lf;
+  note_inm ::=3D 'N' sp 'inline' sp commit-ish lf
     data;
=20
   new_tag ::=3D 'tag' sp tag_str lf
-    'from' sp committish lf
+    'from' sp commit-ish lf
     ('tagger' (sp name)? sp '<' email '>' sp when lf)?
     tag_msg;
   tag_msg ::=3D data;
=20
   reset_branch ::=3D 'reset' sp ref_str lf
-    ('from' sp committish lf)?
+    ('from' sp commit-ish lf)?
     lf?;
=20
   checkpoint ::=3D 'checkpoint' lf
@@ -93,7 +93,7 @@ Format of STDIN stream:
      # stream formatting is: \, " and LF.  Otherwise these values
      # are UTF8.
      #
-  committish  ::=3D (ref_str | hexsha1 | sha1exp_str | idnum);
+  commit-ish  ::=3D (ref_str | hexsha1 | sha1exp_str | idnum);
   ref_str     ::=3D ref;
   sha1exp_str ::=3D sha1exp;
   tag_str     ::=3D tag;
@@ -2478,7 +2478,7 @@ static void note_change_n(struct branch *b, unsig=
ned char *old_fanout)
 	assert(*p =3D=3D ' ');
 	p++;  /* skip space */
=20
-	/* <committish> */
+	/* <commit-ish> */
 	s =3D lookup_branch(p);
 	if (s) {
 		if (is_null_sha1(s->sha1))
diff --git a/po/da.po b/po/da.po
index 20a88ea..898b18d 100644
--- a/po/da.po
+++ b/po/da.po
@@ -1674,7 +1674,7 @@ msgid "No names found, cannot describe anything."
 msgstr ""
=20
 #: builtin/describe.c:482
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr ""
=20
 #: builtin/diff.c:77
diff --git a/po/de.po b/po/de.po
index 11dde11..da3b0f5 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4684,8 +4684,8 @@ msgid "print sizes in human readable format"
 msgstr "gibt Gr=C3=B6=C3=9Fenangaben in menschenlesbaren Format aus"
=20
 #: builtin/describe.c:16
-msgid "git describe [options] <committish>*"
-msgstr "git describe [Optionen] <committish>*"
+msgid "git describe [options] <commit-ish>*"
+msgstr "git describe [Optionen] <commit-ish>*"
=20
 #: builtin/describe.c:17
 msgid "git describe [options] --dirty"
@@ -4822,7 +4822,7 @@ msgid "No names found, cannot describe anything."
 msgstr "Keine Namen gefunden, kann nichts beschreiben."
=20
 #: builtin/describe.c:489
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
=20
 #: builtin/diff.c:79
diff --git a/po/fr.po b/po/fr.po
index 2cdb6f9..49e0ec1 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -4291,7 +4291,7 @@ msgid "print sizes in human readable format"
 msgstr ""
=20
 #: builtin/describe.c:15
-msgid "git describe [options] <committish>*"
+msgid "git describe [options] <commit-ish>*"
 msgstr ""
=20
 #: builtin/describe.c:16
@@ -4417,7 +4417,7 @@ msgid "No names found, cannot describe anything."
 msgstr ""
=20
 #: builtin/describe.c:481
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr ""
=20
 #: builtin/diff.c:79
diff --git a/po/git.pot b/po/git.pot
index cf1e446..c91e197 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -4335,7 +4335,7 @@ msgid "print sizes in human readable format"
 msgstr ""
=20
 #: builtin/describe.c:16
-msgid "git describe [options] <committish>*"
+msgid "git describe [options] <commit-ish>*"
 msgstr ""
=20
 #: builtin/describe.c:17
@@ -4465,7 +4465,7 @@ msgid "No names found, cannot describe anything."
 msgstr ""
=20
 #: builtin/describe.c:489
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr ""
=20
 #: builtin/diff.c:79
diff --git a/po/it.po b/po/it.po
index fe61f1a..9080219 100644
--- a/po/it.po
+++ b/po/it.po
@@ -2476,7 +2476,7 @@ msgid "No names found, cannot describe anything."
 msgstr ""
=20
 #: builtin/describe.c:482
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr ""
=20
 #: builtin/diff.c:77
diff --git a/po/nl.po b/po/nl.po
index e1399e2..ad31c66 100644
--- a/po/nl.po
+++ b/po/nl.po
@@ -1669,7 +1669,7 @@ msgid "No names found, cannot describe anything."
 msgstr ""
=20
 #: builtin/describe.c:482
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr ""
=20
 #: builtin/diff.c:77
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 517ec29..689ad1b 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -2312,7 +2312,7 @@ msgid "No names found, cannot describe anything."
 msgstr "Nenhum nome encontrado, n=C3=A3o descreve nada."
=20
 #: builtin/describe.c:482
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr ""
=20
 #: builtin/diff.c:77
diff --git a/po/sv.po b/po/sv.po
index 12dfca9..dcf579b 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -4560,7 +4560,7 @@ msgid "print sizes in human readable format"
 msgstr "skriv storlekar i m=C3=A4nniskol=C3=A4sbart format"
=20
 #: builtin/describe.c:16
-msgid "git describe [options] <committish>*"
+msgid "git describe [options] <commit-ish>*"
 msgstr "git describe [flaggor] <incheckning-igt>*"
=20
 #: builtin/describe.c:17
@@ -4696,8 +4696,8 @@ msgid "No names found, cannot describe anything."
 msgstr "Inga namn hittades, kan inte beskriva n=C3=A5got."
=20
 #: builtin/describe.c:489
-msgid "--dirty is incompatible with committishes"
-msgstr "--dirty =C3=A4r inkompatibelt med \"committish\"-v=C3=A4rden"
+msgid "--dirty is incompatible with commit-ishes"
+msgstr "--dirty =C3=A4r inkompatibelt med \"commit-ish\"-v=C3=A4rden"
=20
 #: builtin/diff.c:79
 #, c-format
diff --git a/po/vi.po b/po/vi.po
index dd2d2a7..11b4912 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -4663,8 +4663,8 @@ msgid "print sizes in human readable format"
 msgstr "hi=E1=BB=83n th=E1=BB=8B k=C3=ADch c=E1=BB=A1 theo =C4=91=E1=BB=
=8Bnh d=E1=BA=A1ng d=C3=A0nh cho ng=C6=B0=E1=BB=9Di =C4=91=E1=BB=8Dc"
=20
 #: builtin/describe.c:16
-msgid "git describe [options] <committish>*"
-msgstr "git describe [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <committish>*"
+msgid "git describe [options] <commit-ish>*"
+msgstr "git describe [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <commit-ish>*"
=20
 #: builtin/describe.c:17
 msgid "git describe [options] --dirty"
@@ -4799,7 +4799,7 @@ msgid "No names found, cannot describe anything."
 msgstr "Kh=C3=B4ng t=C3=ACm th=E1=BA=A5y c=C3=A1c t=C3=AAn, kh=C3=B4ng=
 th=E1=BB=83 m=C3=B4 t=E1=BA=A3 g=C3=AC c=E1=BA=A3."
=20
 #: builtin/describe.c:489
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr "--dirty l=C3=A0 xung kh=E1=BA=AFc v=E1=BB=9Bi c=C3=A1c t=C3=B9=
y ch=E1=BB=8Dn d=C3=A0nh cho chuy=E1=BB=83n giao (commit)"
=20
 #: builtin/diff.c:79
diff --git a/po/zh_CN.po b/po/zh_CN.po
index b7b46f1..1a042af 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -4562,7 +4562,7 @@ msgid "print sizes in human readable format"
 msgstr "=E4=BB=A5=E7=94=A8=E6=88=B7=E5=8F=AF=E8=AF=BB=E7=9A=84=E6=A0=BC=
=E5=BC=8F=E6=98=BE=E7=A4=BA=E5=A4=A7=E5=B0=8F"
=20
 #: builtin/describe.c:16
-msgid "git describe [options] <committish>*"
+msgid "git describe [options] <commit-ish>*"
 msgstr "git describe [=E9=80=89=E9=A1=B9] <=E6=8F=90=E4=BA=A4=E5=8F=B7=
>*"
=20
 #: builtin/describe.c:17
@@ -4698,7 +4698,7 @@ msgid "No names found, cannot describe anything."
 msgstr "=E6=B2=A1=E6=9C=89=E5=8F=91=E7=8E=B0=E5=90=8D=E7=A7=B0=EF=BC=8C=
=E6=97=A0=E6=B3=95=E6=8F=8F=E8=BF=B0=E4=BB=BB=E4=BD=95=E4=B8=9C=E8=A5=BF=
=E3=80=82"
=20
 #: builtin/describe.c:489
-msgid "--dirty is incompatible with committishes"
+msgid "--dirty is incompatible with commit-ishes"
 msgstr "--dirty =E4=B8=8D=E8=83=BD=E4=B8=8E=E6=8F=90=E4=BA=A4=E5=90=8C=
=E6=97=B6=E4=BD=BF=E7=94=A8"
=20
 #: builtin/diff.c:79
diff --git a/sha1_name.c b/sha1_name.c
index 65ad066..ad79d7b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1130,13 +1130,13 @@ int get_sha1(const char *name, unsigned char *s=
ha1)
 }
=20
 /*
- * Many callers know that the user meant to name a committish by
+ * Many callers know that the user meant to name a commit-ish by
  * syntactical positions where the object name appears.  Calling this
  * function allows the machinery to disambiguate shorter-than-unique
- * abbreviated object names between committish and others.
+ * abbreviated object names between commit-ish and others.
  *
  * Note that this does NOT error out when the named object is not a
- * committish. It is merely to give a hint to the disambiguation
+ * commit-ish. It is merely to give a hint to the disambiguation
  * machinery.
  */
 int get_sha1_committish(const char *name, unsigned char *sha1)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ac6f3b6..a74b9cf 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2815,14 +2815,14 @@ test_expect_success 'S: notemodify with garbage=
 after sha1 dataref must fail' '
 '
=20
 #
-# notemodify, mark in committish
+# notemodify, mark in commit-ish
 #
-test_expect_success 'S: notemodify with garbarge after mark committish=
 must fail' '
+test_expect_success 'S: notemodify with garbarge after mark commit-ish=
 must fail' '
 	test_must_fail git fast-import --import-marks=3Dmarks <<-EOF 2>err &&
 	commit refs/heads/Snotes
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_D=
ATE
 	data <<COMMIT
-	commit S note committish
+	commit S note commit-ish
 	COMMIT
 	N :202 :302x
 	EOF
--=20
1.8.4
