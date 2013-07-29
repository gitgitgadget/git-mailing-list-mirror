From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 10:52:01 -0700
Message-ID: <7vk3k91cfy.fsf@alter.siamese.dyndns.org>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
	<51F6826D.2010606@xiplink.com>
	<7vob9l1d2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:52:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rcE-0004Uf-1U
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab3G2RwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 13:52:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab3G2RwF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 13:52:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CDDF345E9;
	Mon, 29 Jul 2013 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U1kP6Kr0jXNh
	fgRgbkgeEuc9Nto=; b=HZnqF88na7ZoSxGYREpncHAHjd69EYk2GSwLEwrQg+e/
	pex3XOBJZKxN/o161ZfghRFDwCOPKPT+4nkUIKENuJtc5De6z6ojlpjyNT+eGabA
	ggbF15sy62RBr7Uv01AvoxPUW7ldNPYMlnRmTnAjihX3e5jxtP3+exnyRfvEM5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yf/5qC
	OdNrkWCNDb1iIAmOADfE1c63ilPT7PkAsO9HgcWEJNiVerLx3OkwQa+xE9D3PUtK
	eiO0EAByp9SEZ3u971V26EyQvW1RCetYB4LeeB2G8Cjabzgn/1j7G09FvzVL9tA6
	usWgd0HzBWP3yGfL/6FJDmfBBx/IM19xdfhVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3E8D345E8;
	Mon, 29 Jul 2013 17:52:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 955A0345E6;
	Mon, 29 Jul 2013 17:52:03 +0000 (UTC)
In-Reply-To: <7vob9l1d2s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 29 Jul 2013 10:38:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93A23C3E-F877-11E2-9526-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231307>

Junio C Hamano <gitster@pobox.com> writes:

> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> Unfortunately no automated system is perfect (see some of my comment=
s below).
>>  I'm all for an automated system that identifies potential misspelli=
ngs, but
>> I'm wary of anything that attempts to automatically correct perceive=
d errors,
>> or that can't be overruled.  In the end a human must make the final =
decision.
>
> I'd actually prefer to see no patch that says "this was done with an
> automatic tool".  You can use automation on your end all you want,
> but the final result needs to be eyeballed before sending it out,
> and at that point both the credit and the blame lies on you, not any
> automated tool.
>
>>>  core.sharedRepository::
>>> -	When 'group' (or 'true'), the repository is made shareable betwee=
n
>>> +	When 'group' (or 'true'), the repository is made sharable between
>>>  	several users in a group (making sure all the files and objects a=
re
>>>  	group-writable). When 'all' (or 'world' or 'everybody'), the
>>>  	repository will be readable by all users, additionally to being
>>> -	group-shareable. When 'umask' (or 'false'), Git will use permissi=
ons
>>> +	group-sharable. When 'umask' (or 'false'), Git will use permissio=
ns
>>
>> "Sharable" is the North American spelling.  AFAIK git doesn't specif=
y what
>> kind of English the documentation source files should use.  Perhaps =
one day
>> there'll be en_UK and en_US translations, and all the sources will b=
e written
>> in Klingon...
>
> ;-)
>
> It often is a good idea to ask your search engine "What is X", and I
> seem to get a positive result for "what is shareable" just fine.

Here is what I salvaged for 'maint'.  Eyeballing by others is very
much appreciated.

-- >8 --
=46rom: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
Subject: [PATCH] many small typofixes
Date: Mon, 29 Jul 2013 10:18:21 +0200

Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/howto/new-command.txt              | 2 +-
 Documentation/technical/api-revision-walking.txt | 2 +-
 builtin/fast-export.c                            | 2 +-
 builtin/push.c                                   | 2 +-
 cache.h                                          | 2 +-
 combine-diff.c                                   | 2 +-
 contrib/ciabot/ciabot.py                         | 2 +-
 contrib/ciabot/ciabot.sh                         | 4 ++--
 contrib/subtree/git-subtree.txt                  | 2 +-
 git-mergetool--lib.sh                            | 2 +-
 git-p4.py                                        | 2 +-
 notes.h                                          | 2 +-
 read-cache.c                                     | 4 ++--
 t/gitweb-lib.sh                                  | 2 +-
 t/lib-t6000.sh                                   | 2 +-
 t/t7601-merge-pull-config.sh                     | 2 +-
 t/t9020-remote-svn.sh                            | 2 +-
 t/t9112-git-svn-md5less-file.sh                  | 2 +-
 t/t9802-git-p4-filetype.sh                       | 2 +-
 transport-helper.c                               | 4 ++--
 20 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/=
new-command.txt
index 2abc3a0..d7de5a3 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -94,7 +94,7 @@ your language, document it in the INSTALL file.
 6. There is a file command-list.txt in the distribution main directory
 that categorizes commands by type, so they can be listed in appropriat=
e
 subsections in the documentation's summary command list.  Add an entry
-for yours.  To understand the categories, look at git-cmmands.txt
+for yours.  To understand the categories, look at git-commands.txt
 in the main directory.
=20
 7. Give the maintainer one paragraph to include in the RelNotes file
diff --git a/Documentation/technical/api-revision-walking.txt b/Documen=
tation/technical/api-revision-walking.txt
index b7d0d9a..55b878a 100644
--- a/Documentation/technical/api-revision-walking.txt
+++ b/Documentation/technical/api-revision-walking.txt
@@ -59,7 +59,7 @@ function.
 `reset_revision_walk`::
=20
 	Reset the flags used by the revision walking api. You can use
-	this to do multiple sequencial revision walks.
+	this to do multiple sequential revision walks.
=20
 Data structures
 ---------------
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d60d675..0c8d250 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -379,7 +379,7 @@ static void handle_tag(const char *name, struct tag=
 *tag)
 	int tagged_mark;
 	struct commit *p;
=20
-	/* Trees have no identifer in fast-export output, thus we have no way
+	/* Trees have no identifier in fast-export output, thus we have no wa=
y
 	 * to output tags of trees, tags of tags of trees, etc.  Simply omit
 	 * such tags.
 	 */
diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..795197a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -92,7 +92,7 @@ static NORETURN int die_push_simple(struct branch *br=
anch, struct remote *remote
 	if (!short_upstream)
 		short_upstream =3D branch->merge[0]->src;
 	/*
-	 * Don't show advice for people who explicitely set
+	 * Don't show advice for people who explicitly set
 	 * push.default.
 	 */
 	if (push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
diff --git a/cache.h b/cache.h
index 94ca1ac..5794479 100644
--- a/cache.h
+++ b/cache.h
@@ -483,7 +483,7 @@ extern void *read_blob_data_from_index(struct index=
_state *, const char *, unsig
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
-#define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
+#define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONES=
TAR */
=20
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
diff --git a/combine-diff.c b/combine-diff.c
index 6dc0609..88525b3 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -165,7 +165,7 @@ static struct lline *coalesce_lines(struct lline *b=
ase, int *lenbase,
=20
 	/*
 	 * Coalesce new lines into base by finding the LCS
-	 * - Create the table to run dynamic programing
+	 * - Create the table to run dynamic programming
 	 * - Compute the LCS
 	 * - Then reverse read the direction structure:
 	 *   - If we have MATCH, assign parent to base flag, and consume
diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index 36b5665..befa0c3 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -70,7 +70,7 @@ tinyifier =3D "http://tinyurl.com/api-create.php?url=3D=
"
=20
 # The template used to generate the XML messages to CIA.  You can make
 # visible changes to the IRC-bot notification lines by hacking this.
-# The default will produce a notfication line that looks like this:
+# The default will produce a notification line that looks like this:
 #
 # ${project}: ${author} ${repo}:${branch} * ${rev} ${files}: ${logmsg}=
 ${url}
 #
diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
index 3fbbc53..dfb71a1 100755
--- a/contrib/ciabot/ciabot.sh
+++ b/contrib/ciabot/ciabot.sh
@@ -39,7 +39,7 @@
 #       done
 #
 # The reason for the tac call is that git rev-list emits commits from
-# most recent to least - better to ship notifactions from oldest to ne=
west.
+# most recent to least - better to ship notifications from oldest to n=
ewest.
 #
 # Configuration variables affecting this script:
 #
@@ -64,7 +64,7 @@
 # down. It is unknown whether this is still an issue in 2010, but
 # XML-RPC would be annoying to do from sh in any case. (XML-RPC does
 # have the advantage that it guarantees notification of multiple commi=
ts
-# shpped from an update in their actual order.)
+# shipped from an update in their actual order.)
 #
=20
 # The project as known to CIA. You can set this with a -p option,
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subt=
ree.txt
index 7ba853e..e0957ee 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -270,7 +270,7 @@ git-extensions repository in ~/git-extensions/:
 name
=20
 You can omit the --squash flag, but doing so will increase the number
-of commits that are incldued in your local repository.
+of commits that are included in your local repository.
=20
 We now have a ~/git-extensions/git-subtree directory containing code
 from the master branch of git://github.com/apenwarr/git-subtree.git
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index e338be5..7e5c525 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -117,7 +117,7 @@ valid_tool () {
 setup_tool () {
 	tool=3D"$1"
=20
-	# Fallback definitions, to be overriden by tools.
+	# Fallback definitions, to be overridden by tools.
 	can_merge () {
 		return 0
 	}
diff --git a/git-p4.py b/git-p4.py
index 88fcf23..31e71ff 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1786,7 +1786,7 @@ class P4Submit(Command, P4UserMap):
             missingGitTags =3D gitTags - p4Labels
             self.exportGitTags(missingGitTags)
=20
-        # exit with error unless everything applied perfecly
+        # exit with error unless everything applied perfectly
         if len(commits) !=3D len(applied):
                 sys.exit(1)
=20
diff --git a/notes.h b/notes.h
index 3324c48..2a3f923 100644
--- a/notes.h
+++ b/notes.h
@@ -77,7 +77,7 @@ const char *default_notes_ref(void);
  * variable is used, and if that is missing, the default notes ref is =
used
  * ("refs/notes/commits").
  *
- * If you need to re-intialize a notes_tree structure (e.g. when switc=
hing from
+ * If you need to re-initialize a notes_tree structure (e.g. when swit=
ching from
  * one notes ref to another), you must first de-initialize the notes_t=
ree
  * structure by calling free_notes(struct notes_tree *).
  *
diff --git a/read-cache.c b/read-cache.c
index d97e3bf..fe7da6c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -472,7 +472,7 @@ int remove_index_entry_at(struct index_state *istat=
e, int pos)
 }
=20
 /*
- * Remove all cache ententries marked for removal, that is where
+ * Remove all cache entries marked for removal, that is where
  * CE_REMOVE is set in ce_flags.  This is much more effective than
  * calling remove_index_entry_at() for each entry to be removed.
  */
@@ -1743,7 +1743,7 @@ static int has_racy_timestamp(struct index_state =
*istate)
 }
=20
 /*
- * Opportunisticly update the index but do not complain if we can't
+ * Opportunistically update the index but do not complain if we can't
  */
 void update_index_if_able(struct index_state *istate, struct lock_file=
 *lockfile)
 {
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index ae2dc46..9e381e0 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -36,7 +36,7 @@ EOF
=20
 	# You can set the GITWEB_TEST_INSTALLED environment variable to
 	# the gitwebdir (the directory where gitweb is installed / deployed t=
o)
-	# of an existing gitweb instalation to test that installation,
+	# of an existing gitweb installation to test that installation,
 	# or simply to pathname of installed gitweb script.
 	if test -n "$GITWEB_TEST_INSTALLED" ; then
 		if test -d $GITWEB_TEST_INSTALLED; then
diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index ea25dd8..4a397e6 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -37,7 +37,7 @@ save_tag()
 	mv sed.script.tmp sed.script
 }
=20
-# Replace unhelpful sha1 hashses with their symbolic equivalents
+# Replace unhelpful sha1 hashes with their symbolic equivalents
 entag()
 {
 	sed -f sed.script
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.s=
h
index 25dac79..830a4c3 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -109,7 +109,7 @@ test_expect_success 'setup conflicted merge' '
 '
=20
 # First do the merge with resolve and recursive then verify that
-# recusive is chosen.
+# recursive is chosen.
=20
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index d9f6b73..4d81ba1 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -24,7 +24,7 @@ init_git () {
 	rm -fr .git &&
 	git init &&
 	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.=
svnrdump
-	# let's reuse an exisiting dump file!?
+	# let's reuse an existing dump file!?
 	git remote add svnsim testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump
 	git remote add svnfile testsvn::file://$TEST_DIRECTORY/t9154/svn.dump
 }
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-=
file.sh
index a61d671..9861c71 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -7,7 +7,7 @@ test_description=3D'test that git handles an svn reposi=
tory with missing md5sums'
 # Loading a node from a svn dumpfile without a Text-Content-Length
 # field causes svn to neglect to store or report an md5sum.  (it will
 # calculate one if you had put Text-Content-Length: 0).  This showed
-# up in a repository creted with cvs2svn.
+# up in a repository created with cvs2svn.
=20
 cat > dumpfile.svn <<EOF
 SVN-fs-dump-format-version: 1
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index eeefa67..87f4968 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -28,7 +28,7 @@ test_expect_success 'p4 client newlines, unix' '
 		test_cmp f-unix-orig f-unix &&
=20
 		# make sure stored in repo as unix newlines
-		# use sed to eat python-appened newline
+		# use sed to eat python-appended newline
 		p4 -G print //depot/f-unix | marshal_dump data 2 |\
 		    sed \$d >f-unix-p4-print &&
 		test_cmp f-unix-orig f-unix-p4-print &&
diff --git a/transport-helper.c b/transport-helper.c
index 522d791..2ba3012 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1104,7 +1104,7 @@ static void *udt_copy_task_routine(void *udt)
 #ifndef NO_PTHREADS
=20
 /*
- * Join thread, with apporiate errors on failure. Name is name for the
+ * Join thread, with appropriate errors on failure. Name is name for t=
he
  * thread (for error messages). Returns 0 on success, 1 on failure.
  */
 static int tloop_join(pthread_t thread, const char *name)
@@ -1170,7 +1170,7 @@ static void udt_kill_transfer(struct unidirection=
al_transfer *t)
 }
=20
 /*
- * Join process, with apporiate errors on failure. Name is name for th=
e
+ * Join process, with appropriate errors on failure. Name is name for =
the
  * process (for error messages). Returns 0 on success, 1 on failure.
  */
 static int tloop_join(pid_t pid, const char *name)
