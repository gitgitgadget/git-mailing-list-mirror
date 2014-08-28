From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2014, #04; Tue, 26)
Date: Wed, 27 Aug 2014 20:33:20 -0700 (PDT)
Message-ID: <1409196800770-7617655.post@n2.nabble.com>
References: <xmqqy4uagaxt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 05:33:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMqSm-000231-4b
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 05:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933950AbaH1DdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2014 23:33:21 -0400
Received: from sam.nabble.com ([216.139.236.26]:47740 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388AbaH1DdV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 23:33:21 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <yuelinho777@gmail.com>)
	id 1XMqSe-0004zJ-P5
	for git@vger.kernel.org; Wed, 27 Aug 2014 20:33:20 -0700
In-Reply-To: <xmqqy4uagaxt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256071>

Hi =E2=80=8BMichael:

2014-08-27 6:09 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>=20
=E2=80=8B[snip]
>=20
> --------------------------------------------------
> [Stalled]
>=20
[snip]
>=20
> * mh/lockfile (2014-04-15) 25 commits
>  . trim_last_path_elm(): replace last_path_elm()
>  . resolve_symlink(): take a strbuf parameter
>  . resolve_symlink(): use a strbuf for internal scratch space
>  . change lock_file::filename into a strbuf
>  . commit_lock_file(): use a strbuf to manage temporary space
>  . try_merge_strategy(): use a statically-allocated lock_file object
>  . try_merge_strategy(): remove redundant lock_file allocation
>  . struct lock_file: declare some fields volatile
>  . lockfile: avoid transitory invalid states
>  . commit_lock_file(): die() if called for unlocked lockfile object
>  . commit_lock_file(): inline temporary variable
>  . remove_lock_file(): call rollback_lock_file()
>  . lock_file(): exit early if lockfile cannot be opened
>  . write_packed_entry_fn(): convert cb_data into a (const int *)
>  . prepare_index(): declare return value to be (const char *)
>  . delete_ref_loose(): don't muck around in the lock_file's filename
>  . cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
>  . lockfile.c: document the various states of lock_file objects
>  . lock_file(): always add lock_file object to lock_file_list
>  . hold_lock_file_for_append(): release lock on errors
>  . lockfile: unlock file if lockfile permissions cannot be adjusted
>  . rollback_lock_file(): set fd to -1
>  . rollback_lock_file(): do not clear filename redundantly
>  . api-lockfile: expand the documentation
>  . unable_to_lock_die(): rename function from unable_to_lock_index_di=
e()
>=20
>  Ejected from 'pu' to unclutter.
>  Expecting a reroll.
>=20
=E2=80=8B[snip]=E2=80=8B
>=20
> --------------------------------------------------
> [Cooking]
>=20
=E2=80=8B[snip]
>=20
> * rs/strbuf-getcwd (2014-08-26) 10 commits
>   (merged to 'next' on 2014-08-26 at 11be0d6)
>  + use strbuf_add_absolute_path() to add absolute paths
>  + abspath: convert absolute_path() to strbuf
>  + use xgetcwd() to set $GIT_DIR
>  + use xgetcwd() to get the current directory or die
>  + wrapper: add xgetcwd()
>  + abspath: convert real_path_internal() to strbuf
>  + abspath: use strbuf_getcwd() to remember original working director=
y
>  + setup: convert setup_git_directory_gently_1 et al. to strbuf
>  + unix-sockets: use strbuf_getcwd()
>  + strbuf: add strbuf_getcwd()
>  (this branch is tangled with *nd/lock-paths-absolute*.)
>=20
>  Originally merged to 'next' on 2014-08-18
>=20
>  Reduce the use of fixed sized buffer passed to getcwd() calls
>  by introducing xgetcwd() helper.
>=20
>  Will merge to 'master'.
>=20
=E2=80=8B[snip=E2=80=8B]
>=20
> --------------------------------------------------
> [Discarded]
=E2=80=8B[snip=E2=80=8B]
>=20
> * nd/lock-paths-absolute (2014-08-01) 3 commits
>  . lockfile.c: store absolute path
>  . lockfile.c: remove PATH_MAX limit in resolve_symlink()
>  . lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
>=20
>  Will drop and ask =E2=80=8B=E2=80=8BMichael to possibly cooperate an=
d merge with
> *mh/lockfile*.
>=20

=E2=80=8BI am tracing the lock path issue.
(http://git.661346.n2.nabble.com/git-update-index-not-delete-lock-file-=
when-using-different-worktree-td7615300.html)
Do you have any plan on it?

Thank you.=E2=80=8B ^_^


=E2=80=8BYue Lin Ho=E2=80=8B



--
View this message in context: http://git.661346.n2.nabble.com/What-s-co=
oking-in-git-git-Aug-2014-04-Tue-26-tp7617534p7617655.html
Sent from the git mailing list archive at Nabble.com.
