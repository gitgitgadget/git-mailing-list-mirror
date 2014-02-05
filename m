From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.5.4
Date: Wed, 05 Feb 2014 15:01:02 -0800
Message-ID: <xmqqeh3h17wx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Feb 06 00:01:38 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WBBTI-0008SS-4X
	for glk-linux-kernel-3@plane.gmane.org; Thu, 06 Feb 2014 00:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbaBEXBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 5 Feb 2014 18:01:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbaBEXBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Feb 2014 18:01:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2515867F87;
	Wed,  5 Feb 2014 18:01:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=/flobzeUF0JbZxBRfwB2GjYAo
	cM=; b=hrxQ0MNOkYsXOxprw3N+BvveRaG+3HD2yYTDQrEziDp4VuhlOsDtm0LNm
	Vk/F+tusVf0WtJpyw95DyT5onRP76cHGFitNRZ/KOkdcAJCozOi9hJtam5YFZhmg
	4YhoMzMRGp0xgOLazSpAJwlmcn95MYvBeL6KTH8SzpjUSkjpQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=vetlL4ovlEyxWoa+OmV
	k1bbB/LJHTQqTCHaaBWonQ/r0oltzFXzl5YUNHY/wTQvVfUCYmp6PGDFklEDlAV9
	gt35yDKe1CPxZulKbJeh0/+R8v7Fb80wiuqYERCgRWheMGmCw4dl9F18b+xVrivV
	gQ6dpOM+4HdkPiibLdWSAZP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB8CD67F86;
	Wed,  5 Feb 2014 18:01:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DD4B67F80;
	Wed,  5 Feb 2014 18:01:04 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 639FD9FA-8EB9-11E3-9B72-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241673>

The latest maintenance release Git v1.8.5.4 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

cbf14318ee9652232489982bb2da15d2e5ebb580  git-1.8.5.4.tar.gz
6cfb7f23d2a3493d5b7657cc4558ff791294beb0  git-htmldocs-1.8.5.4.tar.gz
4ee26cf0d2db87b0be21192c4433359b6f38b217  git-manpages-1.8.5.4.tar.gz

The following public repositories all have a copy of the v1.8.5.4
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.5.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.8.5.4
--------------------

 * "git fetch --depth=3D0" was a no-op, and was silently ignored.
   Diagnose it as an error.

 * Remote repository URL expressed in scp-style host:path notation are
   parsed more carefully (e.g. "foo/bar:baz" is local, "[::1]:/~user" a=
sks
   to connect to user's home directory on host at address ::1.

 * SSL-related options were not passed correctly to underlying socket
   layer in "git send-email".

 * "git commit -v" appends the patch to the log message before
   editing, and then removes the patch when the editor returned
   control. However, the patch was not stripped correctly when the
   first modified path was a submodule.

 * "git mv A B/", when B does not exist as a directory, should error
   out, but it didn't.

 * When we figure out how many file descriptors to allocate for
   keeping packfiles open, a system with non-working getrlimit() could
   cause us to die(), but because we make this call only to get a
   rough estimate of how many is available and we do not even attempt
   to use up all file descriptors available ourselves, it is nicer to
   fall back to a reasonable low value rather than dying.

 * "git log --decorate" did not handle a tag pointed by another tag
   nicely.

 * "git add -A" (no other arguments) in a totally empty working tree
   used to emit an error.

 * There is no reason to have a hardcoded upper limit of the number of
   parents for an octopus merge, created via the graft mechanism, but
   there was.

 * The implementation of 'git stash $cmd "stash@{...}"' did not quote
   the stash argument properly and left it split at IFS whitespace.

 * The documentation to "git pull" hinted there is an "-m" option
   because it incorrectly shared the documentation with "git merge".

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v1.8.5.3 are as follows:

Jens Lehmann (1):
      commit -v: strip diffs and submodule shortlogs from the commit me=
ssage

Johannes Schindelin (1):
      Remove the line length limit for graft files

Johannes Sixt (2):
      git_connect: remove artificial limit of a remote command
      git_connect: factor out discovery of the protocol and its parts

Junio C Hamano (4):
      get_max_fd_limit(): fall back to OPEN_MAX upon getrlimit/sysconf =
failure
      Documentation: exclude irrelevant options from "git pull"
      Documentation: "git pull" does not have the "-m" option
      Git 1.8.5.4

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      clone,fetch: catch non positive --depth option value
      add: don't complain when adding empty project root

Roman Kagan (1):
      git-svn: workaround for a bug in svn serf backend

Thomas Rast (3):
      send-email: pass Debug to Net::SMTP::SSL::new
      send-email: --smtp-ssl-cert-path takes an argument
      send-email: set SSL options through IO::Socket::SSL::set_client_d=
efaults

Torsten B=C3=B6gershausen (8):
      t5601: remove clear_ssh, refactor setup_ssh_wrapper
      t5601: add tests for ssh
      git fetch-pack: add --diag-url
      t5500: add test cases for diag-url
      git fetch: support host:/~repo
      git_connect(): refactor the port handling for ssh
      connect.c: refactor url parsing
      git_connect(): use common return point

brian m. carlson (1):
      log: properly handle decorations with chained tags

=C3=98ystein Walle (1):
      stash: handle specifying stashes with $IFS
