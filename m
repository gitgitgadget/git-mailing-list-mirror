From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.5
Date: Tue, 31 Mar 2015 15:40:17 -0700
Message-ID: <xmqqvbhgokoe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Apr 01 00:40:37 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Yd4pg-0002mR-Mi
	for glk-linux-kernel-3@plane.gmane.org; Wed, 01 Apr 2015 00:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbbCaWkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 31 Mar 2015 18:40:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751457AbbCaWkU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Mar 2015 18:40:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60E8645DD2;
	Tue, 31 Mar 2015 18:40:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=SBU8+tj4+4WfciQqzM0RpogeT
	ZU=; b=jSobjxOdegaHPZgPhZrBh77hrDWL/SF0g9QKY5vcrW6CMNDUzJP+BvRHC
	QJbdPaq3Ru9FFH9oPHkZ3EhoWK+eflVsnavq0XU2ms4LqRy5eHn8BiP8xlUsRUCS
	N6A4yo6UYhnCkzQNhNJG/Bt+/25y26KOkEg5Mw8tdGSVKQVAYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SXPTlO9ux+IqU+Ma42U
	c7ke3RsRp7vFxup7tiTTAVK8/v2yt8Cvc2GSObQnyzL+XoU/lPwwWQrF+mvPVOe5
	cdvycjdMwqBT4JolEX7h+ub93oqOoARt1JpVrK2UcCE1eV/EGb7H+yuvvNkKNgdC
	6WJ13Xjm0/Oa1GnSIlcn6OuE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A0BA45DD1;
	Tue, 31 Mar 2015 18:40:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A007645DCF;
	Tue, 31 Mar 2015 18:40:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8445352-D7F6-11E4-BE9E-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266575>

The latest maintenance release Git v2.3.5 is now available at
the usual places.  It is comprised of 31 non-merge commits since
v2.3.4, contributed by 11 people, 2 of which are new faces.

This hopefully will be the last update for v2.3.x series before the
next feature release v2.4, as we flushed all the fixes that have
been cooking on the 'master' front.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.5'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.3.4 are as follows.
Welcome to the Git development community!

  Cody A Taylor, and Wilhelm Schuermann.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Jeff King, John Szakmeister, Junio C Hamano, Nguy=E1=BB=85n Th=C3=A1i
  Ng=E1=BB=8Dc Duy, Phil Hord, Sebastian Schuberth, SZEDER G=C3=A1bor,
  Thomas Ackermann, and Thomas Gummerer.

----------------------------------------------------------------

Git v2.3.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.3.4
------------------

 * The prompt script (in contrib/) did not show the untracked sign
   when working in a subdirectory without any untracked files.

 * Even though "git grep --quiet" is run merely to ask for the exit
   status, we spawned the pager regardless.  Stop doing that.

 * Recommend format-patch and send-email for those who want to submit
   patches to this project.

 * An failure early in the "git clone" that started creating the
   working tree and repository could have resulted in some directories
   and files left without getting cleaned up.

 * "git fetch" that fetches a commit using the allow-tip-sha1-in-want
   extension could have failed to fetch all the requested refs.

 * The split-index mode introduced at v2.3.0-rc0~41 was broken in the
   codepath to protect us against a broken reimplementation of Git
   that writes an invalid index with duplicated index entries, etc.

 * "git prune" used to largely ignore broken refs when deciding which
   objects are still being used, which could spread an existing small
   damage and make it a larger one.

 * "git tag -h" used to show the "--column" and "--sort" options
   that are about listing in a wrong section.

 * The transfer.hiderefs support did not quite work for smart-http
   transport.

 * The code that reads from the ctags file in the completion script
   (in contrib/) did not spell ${param/pattern/string} substitution
   correctly, which happened to work with bash but not with zsh.

 * The explanation on "rebase --preserve-merges", "pull --rebase=3Dpres=
erve",
   and "push --force-with-lease" in the documentation was unclear.

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v2.3.4 are as follows:

Cody A Taylor (1):
      git prompt: use toplevel to find untracked files

Jeff King (15):
      tag: fix some mis-organized options in "-h" listing
      upload-pack: fix transfer.hiderefs over smart-http
      upload-pack: do not check NULL return of lookup_unknown_object
      sha1fd_check: die when we cannot open the file
      clone: initialize atexit cleanup handler earlier
      clone: drop period from end of die_errno message
      filter_ref: avoid overwriting ref->old_sha1 with garbage
      filter_ref: make a copy of extra "sought" entries
      fetch_refs_via_pack: free extra copy of refs
      fetch-pack: remove dead assignment to ref->new_sha1
      t5312: test object deletion code paths in a corrupted repository
      refs: introduce a "ref paranoia" flag
      prune: turn on ref_paranoia flag
      repack: turn on "ref paranoia" when doing a destructive repack
      refs.c: drop curate_packed_refs

John Szakmeister (1):
      contrib/completion: escape the forward slash in __git_match_ctag

Junio C Hamano (5):
      SubmittingPatches: encourage users to use format-patch and send-e=
mail
      report_path_error(): move to dir.c
      Update mailmap to spell out "Alexander Kuleshov"
      Prepare for 2.3.5
      Git 2.3.5

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      git.txt: list index versions in plain English

Phil Hord (1):
      git-push.txt: clean up force-with-lease wording

SZEDER G=C3=A1bor (1):
      completion: use __gitcomp_nl() for completing refs

Sebastian Schuberth (2):
      docs: clarify "preserve" option wording for git-pull
      docs: clarify what git-rebase's "-p" / "--preserve-merges" does

Thomas Ackermann (1):
      2.3.2 release notes: typofix

Thomas Gummerer (2):
      t1700: make test pass with index-v4
      read-cache: fix reading of split index

Wilhelm Schuermann (1):
      grep: fix "--quiet" overwriting current output
