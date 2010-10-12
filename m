From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Mon, 11 Oct 2010 21:36:40 -0700
Message-ID: <7vr5fwni1z.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
 <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
 <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com>
 <7vfwwetih8.fsf@alter.siamese.dyndns.org>
 <AANLkTi=nCOeD3u0fst11xujFHuhhj0OU1g_dZ8gTOAMT@mail.gmail.com>
 <7vwrponjsk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Akira Kitada <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 06:37:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Wbi-0003mF-J1
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 06:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab0JLEgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 00:36:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab0JLEgu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 00:36:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2471DE2BD;
	Tue, 12 Oct 2010 00:36:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PShpWAmEY03GE4PxKRVI04pJeKI=; b=h0pnXM
	zNvHSFzmygJBjomeqXioghZ7UM/HM2rlmWOujDgHaNW5GSYN5cbPWcKX6XxPE0M4
	x2TQb36UL3er5IeKxV23VM630MJrJv6lj9Ru2K/OOJTAxF0QESVeSnaX74w89jen
	M+hNR8M0BHYPVdVtnrd2juKXxbrTdSBfHd3Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nd7hzy2gJlwmbJ/Lw93fqV28V+S+53OI
	aO15YynBDC6WP5BEe31cTDSXEWIakS+7y6xXOX+LDXMNBGtTpOYqrmd9cs4TMjr1
	dKVwhmAO1RxwAjPECEwKGx4rxNtSAZbNj4UecSphZtNOBdLSG7YxEtB85peKciyH
	oX2X/AAftaQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F418DE2BC;
	Tue, 12 Oct 2010 00:36:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E64A9DE2B9; Tue, 12 Oct
 2010 00:36:41 -0400 (EDT)
In-Reply-To: <7vwrponjsk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 11 Oct 2010 20\:59\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52359CA6-D5BA-11DF-ABE6-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158823>

--=-=-=

Junio C Hamano <gitster@pobox.com> writes:

> Akira Kitada <akitada@gmail.com> writes:
>
>>> One difference is that I never use ./configure, as that is somewhat
>>> foreign afterthought in our build infrastructure, though.
>>
>> Could you run './configure && gmake' and see if it builds on your environment?
>
> No, thanks.  I do not think I have autoconf set up on that box.  Perhaps
> sometime later, but not tonight.

Well, it turns out that I did have autoconf already.


--=-=-=
Content-Disposition: attachment; filename=fbsd.script
Content-Description: \"autoconf && ./configure && gmake\" script
Content-Transfer-Encoding: quoted-printable

Script started on Mon Oct 11 19:38:32 2010
$ autoconf
$ git clean -n -x
Would not remove autom4te.cache/
Would remove configure
$ ./configure
configure: Setting lib to 'lib' (the default)
configure: Will try -pthread then -lpthread to enable POSIX Threads.
configure: CHECKS for site configuration
configure: CHECKS for programs
checking for cc... cc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...=20
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether cc accepts -g... yes
checking for cc option to accept ISO C89... none needed
checking for inline... inline
checking if linker supports -R... yes
checking for gar... no
checking for ar... ar
checking for gtar... no
checking for tar... tar
checking for gnudiff... no
checking for gdiff... no
checking for diff... diff
checking for asciidoc... asciidoc
checking for asciidoc version... asciidoc 8.4.5 > 7
configure: CHECKS for libraries
checking for SHA1_Init in -lcrypto... yes
checking for curl_global_init in -lcurl... no
checking for XML_ParserCreate in -lexpat... no
checking for iconv in -lc... no
checking for iconv in -liconv... no
checking for deflateBound in -lz... yes
checking for socket in -lc... yes
checking for inet_ntop... yes
checking for inet_pton... yes
checking for hstrerror... yes
checking for basename in -lc... yes
configure: CHECKS for header files
checking how to run the C preprocessor... cc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking sys/select.h usability... yes
checking sys/select.h presence... yes
checking for sys/select.h... yes
checking for old iconv()... yes
configure: CHECKS for typedefs, structures, and compiler characteristics
checking for socklen_t... yes
checking for struct dirent.d_ino... yes
checking for struct dirent.d_type... yes
checking for struct sockaddr_storage... yes
checking for struct addrinfo... yes
checking for getaddrinfo... yes
checking for library containing getaddrinfo... none required
checking whether formatted IO functions support C99 size specifiers... ye=
s
checking whether the platform regex can handle null bytes... yes
checking whether system succeeds to read fopen'ed directory... yes
checking whether snprintf() and/or vsnprintf() return bogus value... no
configure: CHECKS for library functions
checking libgen.h usability... yes
checking libgen.h presence... yes
checking for libgen.h... yes
checking paths.h usability... yes
checking paths.h presence... yes
checking for paths.h... yes
checking for strcasestr... yes
checking for library containing strcasestr... none required
checking for strtok_r... yes
checking for library containing strtok_r... none required
checking for memmem... yes
checking for library containing memmem... none required
checking for strlcpy... yes
checking for library containing strlcpy... none required
checking for uintmax_t... yes
checking for strtoumax... yes
checking for library containing strtoumax... none required
checking for setenv... yes
checking for library containing setenv... none required
checking for unsetenv... yes
checking for library containing unsetenv... none required
checking for mkdtemp... yes
checking for library containing mkdtemp... none required
checking for mkstemps... yes
checking for library containing mkstemps... none required
checking Checking for POSIX Threads with '-mt'... no
checking Checking for POSIX Threads with '-pthread'... yes
configure: creating ./config.status
config.status: creating config.mak.autogen
$ gmake
GIT_VERSION =3D 1.7.3.1.106.gc7278
    * new build flags or prefix
    CC fast-import.o
    CC abspath.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC archive.o
    CC archive-tar.o
    CC archive-zip.o
    CC attr.o
    CC base85.o
    CC bisect.o
    CC blob.o
    CC branch.o
    CC bundle.o
    CC cache-tree.o
    CC color.o
    CC combine-diff.o
    CC commit.o
    CC config.o
    CC connect.o
    CC convert.o
    CC copy.o
    CC csum-file.o
    CC ctype.o
    CC date.o
    CC decorate.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diff-delta.o
    CC diff-lib.o
    CC diff-no-index.o
    CC diff.o
    CC dir.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC exec_cmd.o
    CC fsck.o
    CC graph.o
    CC grep.o
    CC hash.o
    CC help.o
    CC hex.o
    CC ident.o
    CC levenshtein.o
    CC list-objects.o
    CC ll-merge.o
    CC lockfile.o
    CC log-tree.o
    CC mailmap.o
    CC match-trees.o
    CC merge-file.o
    CC merge-recursive.o
    CC name-hash.o
    CC notes.o
    CC notes-cache.o
    CC object.o
    CC pack-check.o
    CC pack-refs.o
    CC pack-revindex.o
    CC pack-write.o
    CC pager.o
    CC parse-options.o
    CC patch-delta.o
    CC patch-ids.o
    CC path.o
    CC pkt-line.o
    CC preload-index.o
    CC pretty.o
    CC progress.o
    CC quote.o
    CC reachable.o
    CC read-cache.o
    CC reflog-walk.o
    CC refs.o
    CC remote.o
    CC replace_object.o
    CC rerere.o
    CC resolve-undo.o
    CC revision.o
    CC run-command.o
    CC server-info.o
    CC setup.o
    CC sha1-lookup.o
    CC sha1_file.o
    CC sha1_name.o
    CC shallow.o
    CC sideband.o
    CC sigchain.o
    CC strbuf.o
    CC string-list.o
    CC submodule.o
    CC symlinks.o
    CC tag.o
    CC trace.o
    CC transport.o
    CC transport-helper.o
    CC tree-diff.o
    CC tree.o
    CC tree-walk.o
    CC unpack-trees.o
    CC url.o
    CC usage.o
    CC userdiff.o
    CC utf8.o
    CC walker.o
    CC wrapper.o
    CC write_or_die.o
    CC ws.o
    CC wt-status.o
    CC xdiff-interface.o
    CC thread-utils.o
    CC compat/fopen.o
    AR libgit.a
    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC xdiff/xemit.o
    CC xdiff/xmerge.o
    CC xdiff/xpatience.o
    AR xdiff/lib.a
    LINK git-fast-import
    CC imap-send.o
    LINK git-imap-send
    CC shell.o
    LINK git-shell
    CC show-index.o
    LINK git-show-index
    CC upload-pack.o
    LINK git-upload-pack
    CC http-backend.o
    LINK git-http-backend
    CC daemon.o
    LINK git-daemon
    GEN git-am
    GEN git-bisect
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-lost-found
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-pull
    GEN git-quiltimport
    GEN git-rebase--interactive
    GEN git-rebase
    GEN git-repack
    GEN git-request-pull
    GEN git-stash
    GEN git-submodule
    GEN git-web--browse
    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX=3D'/usr/local' INSTALL_BASE=3D''
Writing perl.mak for Git
    GEN git-add--interactive
    GEN git-difftool
    GEN git-archimport
    GEN git-cvsexportcommit
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-relink
    GEN git-send-email
    GEN git-svn
    GEN git-remote-testgit
    SUBDIR gitweb
    SUBDIR ../
gmake[2]: `GIT-VERSION-FILE' is up to date.
    GEN gitweb.cgi
    GEN git-instaweb
    GEN git-mergetool--lib
    GEN git-parse-remote
    GEN git-sh-setup
    GEN common-cmds.h
    CC git.o
    CC builtin/add.o
    CC builtin/annotate.o
    CC builtin/apply.o
    CC builtin/archive.o
    CC builtin/bisect--helper.o
    CC builtin/blame.o
    CC builtin/branch.o
    CC builtin/bundle.o
    CC builtin/cat-file.o
    CC builtin/check-attr.o
    CC builtin/check-ref-format.o
    CC builtin/checkout-index.o
    CC builtin/checkout.o
    CC builtin/clean.o
    CC builtin/clone.o
    CC builtin/commit-tree.o
    CC builtin/commit.o
    CC builtin/config.o
    CC builtin/count-objects.o
    CC builtin/describe.o
    CC builtin/diff-files.o
    CC builtin/diff-index.o
    CC builtin/diff-tree.o
    CC builtin/diff.o
    CC builtin/fast-export.o
    CC builtin/fetch-pack.o
    CC builtin/fetch.o
    CC builtin/fmt-merge-msg.o
    CC builtin/for-each-ref.o
    CC builtin/fsck.o
    CC builtin/gc.o
    CC builtin/grep.o
    CC builtin/hash-object.o
    CC builtin/help.o
    CC builtin/index-pack.o
    CC builtin/init-db.o
    CC builtin/log.o
    CC builtin/ls-files.o
    CC builtin/ls-remote.o
    CC builtin/ls-tree.o
    CC builtin/mailinfo.o
    CC builtin/mailsplit.o
    CC builtin/merge.o
    CC builtin/merge-base.o
    CC builtin/merge-file.o
    CC builtin/merge-index.o
    CC builtin/merge-ours.o
    CC builtin/merge-recursive.o
    CC builtin/merge-tree.o
    CC builtin/mktag.o
    CC builtin/mktree.o
    CC builtin/mv.o
    CC builtin/name-rev.o
    CC builtin/notes.o
    CC builtin/pack-objects.o
    CC builtin/pack-redundant.o
    CC builtin/pack-refs.o
    CC builtin/patch-id.o
    CC builtin/prune-packed.o
    CC builtin/prune.o
    CC builtin/push.o
    CC builtin/read-tree.o
    CC builtin/receive-pack.o
    CC builtin/reflog.o
    CC builtin/remote.o
    CC builtin/replace.o
    CC builtin/rerere.o
    CC builtin/reset.o
    CC builtin/rev-list.o
    CC builtin/rev-parse.o
    CC builtin/revert.o
    CC builtin/rm.o
    CC builtin/send-pack.o
    CC builtin/shortlog.o
    CC builtin/show-branch.o
    CC builtin/show-ref.o
    CC builtin/stripspace.o
    CC builtin/symbolic-ref.o
    CC builtin/tag.o
    CC builtin/tar-tree.o
    CC builtin/unpack-file.o
    CC builtin/unpack-objects.o
    CC builtin/update-index.o
    CC builtin/update-ref.o
    CC builtin/update-server-info.o
    CC builtin/upload-archive.o
    CC builtin/var.o
    CC builtin/verify-pack.o
    CC builtin/verify-tag.o
    CC builtin/write-tree.o
    LINK git
    BUILTIN git-add
    BUILTIN git-annotate
    BUILTIN git-apply
    BUILTIN git-archive
    BUILTIN git-bisect--helper
    BUILTIN git-blame
    BUILTIN git-branch
    BUILTIN git-bundle
    BUILTIN git-cat-file
    BUILTIN git-check-attr
    BUILTIN git-check-ref-format
    BUILTIN git-checkout-index
    BUILTIN git-checkout
    BUILTIN git-clean
    BUILTIN git-clone
    BUILTIN git-commit-tree
    BUILTIN git-commit
    BUILTIN git-config
    BUILTIN git-count-objects
    BUILTIN git-describe
    BUILTIN git-diff-files
    BUILTIN git-diff-index
    BUILTIN git-diff-tree
    BUILTIN git-diff
    BUILTIN git-fast-export
    BUILTIN git-fetch-pack
    BUILTIN git-fetch
    BUILTIN git-fmt-merge-msg
    BUILTIN git-for-each-ref
    BUILTIN git-fsck
    BUILTIN git-gc
    BUILTIN git-grep
    BUILTIN git-hash-object
    BUILTIN git-help
    BUILTIN git-index-pack
    BUILTIN git-init-db
    BUILTIN git-log
    BUILTIN git-ls-files
    BUILTIN git-ls-remote
    BUILTIN git-ls-tree
    BUILTIN git-mailinfo
    BUILTIN git-mailsplit
    BUILTIN git-merge
    BUILTIN git-merge-base
    BUILTIN git-merge-file
    BUILTIN git-merge-index
    BUILTIN git-merge-ours
    BUILTIN git-merge-recursive
    BUILTIN git-merge-tree
    BUILTIN git-mktag
    BUILTIN git-mktree
    BUILTIN git-mv
    BUILTIN git-name-rev
    BUILTIN git-notes
    BUILTIN git-pack-objects
    BUILTIN git-pack-redundant
    BUILTIN git-pack-refs
    BUILTIN git-patch-id
    BUILTIN git-prune-packed
    BUILTIN git-prune
    BUILTIN git-push
    BUILTIN git-read-tree
    BUILTIN git-receive-pack
    BUILTIN git-reflog
    BUILTIN git-remote
    BUILTIN git-replace
    BUILTIN git-rerere
    BUILTIN git-reset
    BUILTIN git-rev-list
    BUILTIN git-rev-parse
    BUILTIN git-revert
    BUILTIN git-rm
    BUILTIN git-send-pack
    BUILTIN git-shortlog
    BUILTIN git-show-branch
    BUILTIN git-show-ref
    BUILTIN git-stripspace
    BUILTIN git-symbolic-ref
    BUILTIN git-tag
    BUILTIN git-tar-tree
    BUILTIN git-unpack-file
    BUILTIN git-unpack-objects
    BUILTIN git-update-index
    BUILTIN git-update-ref
    BUILTIN git-update-server-info
    BUILTIN git-upload-archive
    BUILTIN git-var
    BUILTIN git-verify-pack
    BUILTIN git-verify-tag
    BUILTIN git-write-tree
    BUILTIN git-cherry
    BUILTIN git-cherry-pick
    BUILTIN git-format-patch
    BUILTIN git-fsck-objects
    BUILTIN git-get-tar-commit-id
    BUILTIN git-init
    BUILTIN git-merge-subtree
    BUILTIN git-peek-remote
    BUILTIN git-repo-config
    BUILTIN git-show
    BUILTIN git-stage
    BUILTIN git-status
    BUILTIN git-whatchanged
    SUBDIR git-gui
GITGUI_VERSION =3D 0.13.0
    * new locations or Tcl/Tk interpreter
    GEN git-gui
    INDEX lib/
tclsh: not found
    * tclsh failed; using unoptimized loading
    MSGFMT    po/de.msg 520 translated.
    MSGFMT    po/el.msg 381 translated, 4 fuzzy, 6 untranslated.
    MSGFMT    po/fr.msg 520 translated.
    MSGFMT    po/hu.msg 514 translated.
    MSGFMT    po/it.msg 519 translated, 1 untranslated.
    MSGFMT    po/ja.msg 520 translated.
    MSGFMT    po/nb.msg 474 translated, 39 untranslated.
    MSGFMT    po/ru.msg 513 translated, 2 untranslated.
    MSGFMT    po/sv.msg 521 translated.
    MSGFMT po/zh_cn.msg 366 translated, 7 fuzzy, 17 untranslated.
    SUBDIR gitk-git
    GEN gitk-wish
Generating catalog po/de.msg
msgfmt --statistics --tcl po/de.po -l de -d po/
289 translated messages.
Generating catalog po/es.msg
msgfmt --statistics --tcl po/es.po -l es -d po/
200 translated messages, 7 untranslated messages.
Generating catalog po/fr.msg
msgfmt --statistics --tcl po/fr.po -l fr -d po/
276 translated messages, 4 fuzzy translations.
Generating catalog po/hu.msg
msgfmt --statistics --tcl po/hu.po -l hu -d po/
288 translated messages.
Generating catalog po/it.msg
msgfmt --statistics --tcl po/it.po -l it -d po/
283 translated messages, 6 untranslated messages.
Generating catalog po/ja.msg
msgfmt --statistics --tcl po/ja.po -l ja -d po/
284 translated messages.
Generating catalog po/ru.msg
msgfmt --statistics --tcl po/ru.po -l ru -d po/
245 translated messages.
Generating catalog po/sv.msg
msgfmt --statistics --tcl po/sv.po -l sv -d po/
289 translated messages.
    SUBDIR perl
cp private-Error.pm blib/lib/Error.pm
cp Git.pm blib/lib/Git.pm
Manifying blib/man3/private-Error.3
Manifying blib/man3/Git.3
    SUBDIR git_remote_helpers
    SUBDIR templates
    CC test-chmtime.o
    LINK test-chmtime
    CC test-ctype.o
    LINK test-ctype
    CC test-date.o
    LINK test-date
    CC test-delta.o
    LINK test-delta
    CC test-dump-cache-tree.o
    LINK test-dump-cache-tree
    CC test-genrandom.o
    LINK test-genrandom
    CC test-line-buffer.o
    CC vcs-svn/string_pool.o
    CC vcs-svn/line_buffer.o
    CC vcs-svn/repo_tree.o
    CC vcs-svn/fast_export.o
    CC vcs-svn/svndump.o
    AR vcs-svn/lib.a
    LINK test-line-buffer
    CC test-match-trees.o
    LINK test-match-trees
    CC test-obj-pool.o
    LINK test-obj-pool
    CC test-parse-options.o
    LINK test-parse-options
    CC test-path-utils.o
    LINK test-path-utils
    CC test-run-command.o
    LINK test-run-command
    CC test-sha1.o
    LINK test-sha1
    CC test-sigchain.o
    LINK test-sigchain
    CC test-string-pool.o
    LINK test-string-pool
    CC test-svn-fe.o
    LINK test-svn-fe
    CC test-treap.o
    LINK test-treap
    CC test-index-version.o
    LINK test-index-version
    GEN bin-wrappers/git
    GEN bin-wrappers/git-upload-pack
    GEN bin-wrappers/git-receive-pack
    GEN bin-wrappers/git-upload-archive
    GEN bin-wrappers/git-shell
    GEN bin-wrappers/git-cvsserver
    GEN bin-wrappers/test-chmtime
    GEN bin-wrappers/test-ctype
    GEN bin-wrappers/test-date
    GEN bin-wrappers/test-delta
    GEN bin-wrappers/test-dump-cache-tree
    GEN bin-wrappers/test-genrandom
    GEN bin-wrappers/test-line-buffer
    GEN bin-wrappers/test-match-trees
    GEN bin-wrappers/test-obj-pool
    GEN bin-wrappers/test-parse-options
    GEN bin-wrappers/test-path-utils
    GEN bin-wrappers/test-run-command
    GEN bin-wrappers/test-sha1
    GEN bin-wrappers/test-sigchain
    GEN bin-wrappers/test-string-pool
    GEN bin-wrappers/test-svn-fe
    GEN bin-wrappers/test-treap
    GEN bin-wrappers/test-index-version
$ exit

Script done on Mon Oct 11 19:41:04 2010

--=-=-=--
