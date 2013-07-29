From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 19:59:47 +0200
Message-ID: <51F6AD93.7090601@googlemail.com>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz> <51F6826D.2010606@xiplink.com> <7vob9l1d2s.fsf@alter.siamese.dyndns.org> <7vk3k91cfy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig351E9B68EC2731FB14946C61"
Cc: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:59:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rjR-00005V-RM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab3G2R7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:59:37 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:40903 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab3G2R7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:59:36 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so5103081wgh.26
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=TZpTifri0h1MrQHTCQckmCN0OtoCIEA8R6Vjakvkt0Q=;
        b=nMPNeOK+nasLVBwUehTFYZSxbOklfFP5JraDgCKXWpREc48ZkIFrb8fvnsyf88+Dxk
         cxIvi6vGkd2kr+o+FriFadPqrv3zAdeiOPDFmDdieuZiGtHpfYVyjSmjAkIe70nR1+Lb
         lapjm9FonCd3RXVgu2dYCL+jfmaoA+sLDByoLHm0l7YgL2iHR+vpnEr0zU/y+LeqNM0g
         5WvxBNbXlk+4Xd9tdmBSgKdBzXP3BeP5yjwEIKvhWL6BvnFtzcM7MK1NkBAL+inc0uo2
         nNK5bbkee4O9uMrCStx0c4KEqnKFOpzLPHuwLHH1+Nb3yAqXOqQy2qTQDJfZHIRRW8Ln
         Xh7A==
X-Received: by 10.194.249.129 with SMTP id yu1mr44567080wjc.10.1375120774159;
        Mon, 29 Jul 2013 10:59:34 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id o10sm24148732wiz.5.2013.07.29.10.59.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 10:59:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vk3k91cfy.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231310>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig351E9B68EC2731FB14946C61
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/29/2013 07:52 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>
>>> Unfortunately no automated system is perfect (see some of my comments=
 below).
>>>  I'm all for an automated system that identifies potential misspellin=
gs, but
>>> I'm wary of anything that attempts to automatically correct perceived=
 errors,
>>> or that can't be overruled.  In the end a human must make the final d=
ecision.
>>
>> I'd actually prefer to see no patch that says "this was done with an
>> automatic tool".  You can use automation on your end all you want,
>> but the final result needs to be eyeballed before sending it out,
>> and at that point both the credit and the blame lies on you, not any
>> automated tool.
>>
>>>>  core.sharedRepository::
>>>> -	When 'group' (or 'true'), the repository is made shareable between=

>>>> +	When 'group' (or 'true'), the repository is made sharable between
>>>>  	several users in a group (making sure all the files and objects ar=
e
>>>>  	group-writable). When 'all' (or 'world' or 'everybody'), the
>>>>  	repository will be readable by all users, additionally to being
>>>> -	group-shareable. When 'umask' (or 'false'), Git will use permissio=
ns
>>>> +	group-sharable. When 'umask' (or 'false'), Git will use permission=
s
>>>
>>> "Sharable" is the North American spelling.  AFAIK git doesn't specify=
 what
>>> kind of English the documentation source files should use.  Perhaps o=
ne day
>>> there'll be en_UK and en_US translations, and all the sources will be=
 written
>>> in Klingon...
>>
>> ;-)
>>
>> It often is a good idea to ask your search engine "What is X", and I
>> seem to get a positive result for "what is shareable" just fine.
>=20
> Here is what I salvaged for 'maint'.  Eyeballing by others is very
> much appreciated.
>=20
> -- >8 --
> From: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
> Subject: [PATCH] many small typofixes
> Date: Mon, 29 Jul 2013 10:18:21 +0200
>=20
> Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/howto/new-command.txt              | 2 +-
>  Documentation/technical/api-revision-walking.txt | 2 +-
>  builtin/fast-export.c                            | 2 +-
>  builtin/push.c                                   | 2 +-
>  cache.h                                          | 2 +-
>  combine-diff.c                                   | 2 +-
>  contrib/ciabot/ciabot.py                         | 2 +-
>  contrib/ciabot/ciabot.sh                         | 4 ++--
>  contrib/subtree/git-subtree.txt                  | 2 +-
>  git-mergetool--lib.sh                            | 2 +-
>  git-p4.py                                        | 2 +-
>  notes.h                                          | 2 +-
>  read-cache.c                                     | 4 ++--
>  t/gitweb-lib.sh                                  | 2 +-
>  t/lib-t6000.sh                                   | 2 +-
>  t/t7601-merge-pull-config.sh                     | 2 +-
>  t/t9020-remote-svn.sh                            | 2 +-
>  t/t9112-git-svn-md5less-file.sh                  | 2 +-
>  t/t9802-git-p4-filetype.sh                       | 2 +-
>  transport-helper.c                               | 4 ++--
>  20 files changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/=
new-command.txt
> index 2abc3a0..d7de5a3 100644
> --- a/Documentation/howto/new-command.txt
> +++ b/Documentation/howto/new-command.txt
> @@ -94,7 +94,7 @@ your language, document it in the INSTALL file.
>  6. There is a file command-list.txt in the distribution main directory=

>  that categorizes commands by type, so they can be listed in appropriat=
e
>  subsections in the documentation's summary command list.  Add an entry=

> -for yours.  To understand the categories, look at git-cmmands.txt
> +for yours.  To understand the categories, look at git-commands.txt
>  in the main directory.
> =20
>  7. Give the maintainer one paragraph to include in the RelNotes file
> diff --git a/Documentation/technical/api-revision-walking.txt b/Documen=
tation/technical/api-revision-walking.txt
> index b7d0d9a..55b878a 100644
> --- a/Documentation/technical/api-revision-walking.txt
> +++ b/Documentation/technical/api-revision-walking.txt
> @@ -59,7 +59,7 @@ function.
>  `reset_revision_walk`::
> =20
>  	Reset the flags used by the revision walking api. You can use
> -	this to do multiple sequencial revision walks.
> +	this to do multiple sequential revision walks.
> =20
>  Data structures
>  ---------------
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d60d675..0c8d250 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -379,7 +379,7 @@ static void handle_tag(const char *name, struct tag=
 *tag)
>  	int tagged_mark;
>  	struct commit *p;
> =20
> -	/* Trees have no identifer in fast-export output, thus we have no way=

> +	/* Trees have no identifier in fast-export output, thus we have no wa=
y
>  	 * to output tags of trees, tags of tags of trees, etc.  Simply omit
>  	 * such tags.
>  	 */
> diff --git a/builtin/push.c b/builtin/push.c
> index 2d84d10..795197a 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -92,7 +92,7 @@ static NORETURN int die_push_simple(struct branch *br=
anch, struct remote *remote
>  	if (!short_upstream)
>  		short_upstream =3D branch->merge[0]->src;
>  	/*
> -	 * Don't show advice for people who explicitely set
> +	 * Don't show advice for people who explicitly set
>  	 * push.default.
>  	 */
>  	if (push_default =3D=3D PUSH_DEFAULT_UNSPECIFIED)
> diff --git a/cache.h b/cache.h
> index 94ca1ac..5794479 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -483,7 +483,7 @@ extern void *read_blob_data_from_index(struct index=
_state *, const char *, unsig
>  extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
>  extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
> =20
> -#define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
> +#define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONES=
TAR */
> =20
>  struct pathspec {
>  	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
> diff --git a/combine-diff.c b/combine-diff.c
> index 6dc0609..88525b3 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -165,7 +165,7 @@ static struct lline *coalesce_lines(struct lline *b=
ase, int *lenbase,
> =20
>  	/*
>  	 * Coalesce new lines into base by finding the LCS
> -	 * - Create the table to run dynamic programing
> +	 * - Create the table to run dynamic programming
>  	 * - Compute the LCS
>  	 * - Then reverse read the direction structure:
>  	 *   - If we have MATCH, assign parent to base flag, and consume
> diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
> index 36b5665..befa0c3 100755
> --- a/contrib/ciabot/ciabot.py
> +++ b/contrib/ciabot/ciabot.py
> @@ -70,7 +70,7 @@ tinyifier =3D "http://tinyurl.com/api-create.php?url=3D=
"
> =20
>  # The template used to generate the XML messages to CIA.  You can make=

>  # visible changes to the IRC-bot notification lines by hacking this.
> -# The default will produce a notfication line that looks like this:
> +# The default will produce a notification line that looks like this:
>  #
>  # ${project}: ${author} ${repo}:${branch} * ${rev} ${files}: ${logmsg}=
 ${url}
>  #
> diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
> index 3fbbc53..dfb71a1 100755
> --- a/contrib/ciabot/ciabot.sh
> +++ b/contrib/ciabot/ciabot.sh
> @@ -39,7 +39,7 @@
>  #       done
>  #
>  # The reason for the tac call is that git rev-list emits commits from
> -# most recent to least - better to ship notifactions from oldest to ne=
west.
> +# most recent to least - better to ship notifications from oldest to n=
ewest.
>  #
>  # Configuration variables affecting this script:
>  #
> @@ -64,7 +64,7 @@
>  # down. It is unknown whether this is still an issue in 2010, but
>  # XML-RPC would be annoying to do from sh in any case. (XML-RPC does
>  # have the advantage that it guarantees notification of multiple commi=
ts
> -# shpped from an update in their actual order.)
> +# shipped from an update in their actual order.)
>  #
> =20
>  # The project as known to CIA. You can set this with a -p option,
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subt=
ree.txt
> index 7ba853e..e0957ee 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -270,7 +270,7 @@ git-extensions repository in ~/git-extensions/:
>  name
> =20
>  You can omit the --squash flag, but doing so will increase the number
> -of commits that are incldued in your local repository.
> +of commits that are included in your local repository.
> =20
>  We now have a ~/git-extensions/git-subtree directory containing code
>  from the master branch of git://github.com/apenwarr/git-subtree.git
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index e338be5..7e5c525 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -117,7 +117,7 @@ valid_tool () {
>  setup_tool () {
>  	tool=3D"$1"
> =20
> -	# Fallback definitions, to be overriden by tools.
> +	# Fallback definitions, to be overridden by tools.
>  	can_merge () {
>  		return 0
>  	}
> diff --git a/git-p4.py b/git-p4.py
> index 88fcf23..31e71ff 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1786,7 +1786,7 @@ class P4Submit(Command, P4UserMap):
>              missingGitTags =3D gitTags - p4Labels
>              self.exportGitTags(missingGitTags)
> =20
> -        # exit with error unless everything applied perfecly
> +        # exit with error unless everything applied perfectly
>          if len(commits) !=3D len(applied):
>                  sys.exit(1)
> =20
> diff --git a/notes.h b/notes.h
> index 3324c48..2a3f923 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -77,7 +77,7 @@ const char *default_notes_ref(void);
>   * variable is used, and if that is missing, the default notes ref is =
used
>   * ("refs/notes/commits").
>   *
> - * If you need to re-intialize a notes_tree structure (e.g. when switc=
hing from
> + * If you need to re-initialize a notes_tree structure (e.g. when swit=
ching from
>   * one notes ref to another), you must first de-initialize the notes_t=
ree
>   * structure by calling free_notes(struct notes_tree *).
>   *
> diff --git a/read-cache.c b/read-cache.c
> index d97e3bf..fe7da6c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -472,7 +472,7 @@ int remove_index_entry_at(struct index_state *istat=
e, int pos)
>  }
> =20
>  /*
> - * Remove all cache ententries marked for removal, that is where
> + * Remove all cache entries marked for removal, that is where
>   * CE_REMOVE is set in ce_flags.  This is much more effective than
>   * calling remove_index_entry_at() for each entry to be removed.
>   */
> @@ -1743,7 +1743,7 @@ static int has_racy_timestamp(struct index_state =
*istate)
>  }
> =20
>  /*
> - * Opportunisticly update the index but do not complain if we can't
> + * Opportunistically update the index but do not complain if we can't
>   */
>  void update_index_if_able(struct index_state *istate, struct lock_file=
 *lockfile)
>  {
> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index ae2dc46..9e381e0 100644
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -36,7 +36,7 @@ EOF
> =20
>  	# You can set the GITWEB_TEST_INSTALLED environment variable to
>  	# the gitwebdir (the directory where gitweb is installed / deployed t=
o)
> -	# of an existing gitweb instalation to test that installation,
> +	# of an existing gitweb installation to test that installation,
>  	# or simply to pathname of installed gitweb script.
>  	if test -n "$GITWEB_TEST_INSTALLED" ; then
>  		if test -d $GITWEB_TEST_INSTALLED; then
> diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
> index ea25dd8..4a397e6 100644
> --- a/t/lib-t6000.sh
> +++ b/t/lib-t6000.sh
> @@ -37,7 +37,7 @@ save_tag()
>  	mv sed.script.tmp sed.script
>  }
> =20
> -# Replace unhelpful sha1 hashses with their symbolic equivalents
> +# Replace unhelpful sha1 hashes with their symbolic equivalents
>  entag()
>  {
>  	sed -f sed.script
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.s=
h
> index 25dac79..830a4c3 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -109,7 +109,7 @@ test_expect_success 'setup conflicted merge' '
>  '
> =20
>  # First do the merge with resolve and recursive then verify that
> -# recusive is chosen.
> +# recursive is chosen.
> =20
>  test_expect_success 'merge picks up the best result' '
>  	git config --unset-all pull.twohead &&
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> index d9f6b73..4d81ba1 100755
> --- a/t/t9020-remote-svn.sh
> +++ b/t/t9020-remote-svn.sh
> @@ -24,7 +24,7 @@ init_git () {
>  	rm -fr .git &&
>  	git init &&
>  	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.=
svnrdump
> -	# let's reuse an exisiting dump file!?
> +	# let's reuse an existing dump file!?
>  	git remote add svnsim testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump
>  	git remote add svnfile testsvn::file://$TEST_DIRECTORY/t9154/svn.dump=

>  }
> diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-=
file.sh
> index a61d671..9861c71 100755
> --- a/t/t9112-git-svn-md5less-file.sh
> +++ b/t/t9112-git-svn-md5less-file.sh
> @@ -7,7 +7,7 @@ test_description=3D'test that git handles an svn reposi=
tory with missing md5sums'
>  # Loading a node from a svn dumpfile without a Text-Content-Length
>  # field causes svn to neglect to store or report an md5sum.  (it will
>  # calculate one if you had put Text-Content-Length: 0).  This showed
> -# up in a repository creted with cvs2svn.
> +# up in a repository created with cvs2svn.
> =20
>  cat > dumpfile.svn <<EOF
>  SVN-fs-dump-format-version: 1
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> index eeefa67..87f4968 100755
> --- a/t/t9802-git-p4-filetype.sh
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -28,7 +28,7 @@ test_expect_success 'p4 client newlines, unix' '
>  		test_cmp f-unix-orig f-unix &&
> =20
>  		# make sure stored in repo as unix newlines
> -		# use sed to eat python-appened newline
> +		# use sed to eat python-appended newline
>  		p4 -G print //depot/f-unix | marshal_dump data 2 |\
>  		    sed \$d >f-unix-p4-print &&
>  		test_cmp f-unix-orig f-unix-p4-print &&
> diff --git a/transport-helper.c b/transport-helper.c
> index 522d791..2ba3012 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1104,7 +1104,7 @@ static void *udt_copy_task_routine(void *udt)
>  #ifndef NO_PTHREADS
> =20
>  /*
> - * Join thread, with apporiate errors on failure. Name is name for the=

> + * Join thread, with appropriate errors on failure. Name is name for t=
he
>   * thread (for error messages). Returns 0 on success, 1 on failure.
>   */
>  static int tloop_join(pthread_t thread, const char *name)
> @@ -1170,7 +1170,7 @@ static void udt_kill_transfer(struct unidirection=
al_transfer *t)
>  }
> =20
>  /*
> - * Join process, with apporiate errors on failure. Name is name for th=
e
> + * Join process, with appropriate errors on failure. Name is name for =
the
>   * process (for error messages). Returns 0 on success, 1 on failure.
>   */
>  static int tloop_join(pid_t pid, const char *name)
> --

Eyeballed-by: Stefan Beller <stefanbeller@googlemail.com>


--------------enig351E9B68EC2731FB14946C61
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR9q2TAAoJEJQCPTzLflhq3tMP/jRu34Bqc3QGJkVUsCM7Pjex
yyrx88AByzyUt+yDgzSMoDVnw6SmM+ec6zqsacdr6cauuPLrXN9yvp2QzjH5Ljfy
bqSv1PmCDdJIKOuRWrjg7AjN9jZtlUlH0OsvBFAgCr56tv7M/3kDGK8Z+FbRiFMc
VQedGBNugBIYrPIsHbbyzzdECLdFcLEdleUrtE5upBEhFrWKEJeFu4o+43oTDRD4
aNvR647b7B+aSh9kQ6YvgQvBL0os9rm7Mo9bDiqA07ChT4dxytwWSE+j0l2gt9Rs
1KQV7MCY5sXluH6jIIfsFi1ZP0/JayJTDNJCLC8OI8SEKvuUHiXzb8mcUrEu27uL
5A6uS/1eWDal5WraPRBThr8o4HlxCMKsXdMwMaEI1i/D0S6g5UDEFkxTlHhrmysA
EpTzM66xHrkLof645spb6R41GWw0DFmmgzpuHYfzfKOgOIEZVwn+civcs0au8bkS
1w1lVnV3snr16wGFvSXrA4XHCRvE7lq+Nn08AXj+5JJ9npVKIs+Dfs1qST0UNJlf
QXUujptWBbXimegnmnAniyXP3E4cWZib2AZUyu5AixDk8sGVacGxMnmnbA8I2cXG
aGosgq95Ic3gHXFv8dmmDE1Xs+8gQzuFW8IZyyriNDxfoRVBf89Z05u7W5F/SNaq
8+pYetpgRpi0K+tcl4qB
=a0t7
-----END PGP SIGNATURE-----

--------------enig351E9B68EC2731FB14946C61--
