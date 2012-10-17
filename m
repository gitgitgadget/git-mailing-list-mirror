From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.12.4
Date: Wed, 17 Oct 2012 13:33:00 -0700
Message-ID: <7v6268on43.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Oct 17 22:33:25 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TOaIq-0000vQ-JJ
	for glk-linux-kernel-3@plane.gmane.org; Wed, 17 Oct 2012 22:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857Ab2JQUdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 17 Oct 2012 16:33:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab2JQUdD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Oct 2012 16:33:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3A638718;
	Wed, 17 Oct 2012 16:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=q1Eu8NtKmqRCBJp5dhqHq056x
	mU=; b=uqKaY9f7GVJ6KIzaj+Ps1goVrf7hE3MkraQwbCW3gWoo7FFajBw35A92r
	56g3xHJm6pIzOoC8t3rFIOBPjbPyWRMSH2BKiWz98PxZmLjrmnys6HwfUSgDIgrD
	HzcTS11aBu87ZXPJermeOBDG5rCfj8X8jpOcX0h0AXbzy0wGlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=v0svSkxQfcjar3O9uT3
	QVtWd/IOT4CMLS/bfSNQehvNdC8nbHoxhFiFJ8ZJ6+9s3I5o0eIlt9PPbpWLtCZO
	OrNnRz7S1LXH+8oyJKf0iUuY4O9wig6IP6UrguKOWIlDlZnjip+/YVgx2A3xT6GO
	U8xqbjb1RmrFNN8estC6WKTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1C848717;
	Wed, 17 Oct 2012 16:33:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D54578716; Wed, 17 Oct 2012
 16:33:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8ACFAA8-1899-11E2-A633-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207940>

The latest maintenance release Git v1.7.12.4 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

e7eb697fc12887138e44ae100165c620a1210e81  git-1.7.12.4.tar.gz
1d4ce5c8fabbf576d611effcce2f87089da1bb89  git-htmldocs-1.7.12.4.tar.gz
1f853aa40c4518a4fad829f255c96d6e21659e93  git-manpages-1.7.12.4.tar.gz

Also the following public repositories all have a copy of the v1.7.12.4
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git 1.7.12.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.12.3
---------------------

 * "git fetch" over the dumb-http revision walker could segfault when
   curl's multi interface was used.

 * It was possible to give specific paths for "asciidoc" and other
   tools in the documentation toolchain, but not for "xmlto".

 * "gitweb" did not give the correct committer timezone in its feed
   output due to a typo.

 * The "-Xours" (and similarly -Xtheirs) backend option to "git
   merge -s recursive" was ignored for binary files.  Now it is
   honored.

 * The "binary" synthetic attribute made "diff" to treat the path as
   binary, but not "merge".

Also contains many documentation updates.

----------------------------------------------------------------

Changes since v1.7.12.3 are as follows:

Ben Walton (1):
      tests: "cp -a" is a GNUism

Dave Borowitz (1):
      Documentation/Makefile: Allow custom XMLTO binary

Dylan Alex Simon (1):
      gitweb.cgi: fix "comitter_tz" typo in feed

Jeff King (1):
      http: fix segfault in handle_curl_result

Junio C Hamano (6):
      merge: teach -Xours/-Xtheirs to binary ll-merge driver
      attr: "binary" attribute should choose built-in "binary" merge dr=
iver
      ll-merge: warn about inability to merge binary files only when we=
 can't
      t1450: the order the objects are checked is undefined
      gitcli: parse-options lets you omit tail of long options
      Git 1.7.12.4

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      gitignore.txt: suggestions how to get literal # or ! at the begin=
ning
      attr: a note about the order of .gitattributes lookup

Philip Oakley (5):
      Doc: shallow clone deepens _to_ new depth
      Doc: separate gitignore pattern sources
      Doc add: link gitignore
      Doc clean: add See Also link
      Doc branch: show -vv option and alternative

Ramkumar Ramachandra (3):
      t/test-lib: make sure Git has already been built
      test-lib: use $SHELL_PATH, not $SHELL
      Git url doc: mark ftp/ftps as read-only and deprecate them

Richard Fearn (1):
      Fix spelling error in post-receive-email hook

Simon Ruderich (1):
      l10n: de.po: fix a few minor typos
