From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.5.3
Date: Tue, 14 Jan 2014 09:50:03 -0800
Message-ID: <xmqq1u0a5u7o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 14 18:50:29 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W388C-0004Ir-Dr
	for glk-linux-kernel-3@plane.gmane.org; Tue, 14 Jan 2014 18:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaANRuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 14 Jan 2014 12:50:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbaANRuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jan 2014 12:50:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D52461F1B;
	Tue, 14 Jan 2014 12:50:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=TjvdjX6YiC8t0wWq1wZM/9xI2
	5I=; b=OQHXNENEk5VsHuMy9hsfmAW3Och5QWTs7PtUl9z1sEVoj8gUdahQCdcwm
	foqmqGxAynePkBDCaB2jjSxfap2yWYIjRUf6CU/K/l2TUfQdgu5qBWGy8qGKSsYf
	tXKbVxNsb40v9/Zw1fyP7nS/ooKHXA2grw+dvryEMYPsNcwQqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Cf0U/DmtvFDwdbjHgwK
	ytFW8+yHro5q19WT7yyZgIZlU2G1uoIBpI2620mxIbLFfEuktSgNJ2eYxicTYE6i
	at+tKedpq46jnyGqetcqbmpCClzkJRjBagpAhHEyUc/4EoXbdydyXXB5bCuVL4Wv
	wyRgzCqUEi8gmcrcEXn5wKbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4060D61F1A;
	Tue, 14 Jan 2014 12:50:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B32761F15;
	Tue, 14 Jan 2014 12:50:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4E1F5FDC-7D44-11E3-A3A1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240403>

The latest maintenance release Git v1.8.5.3 is now available at
the usual places, backporting the fixes that happened on the
'master' front.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

767aa30c0f569f9b6e04cb215dfeec0c013c355a  git-1.8.5.3.tar.gz
47da8e2b1d23ae501ee2c03414c04f8225079037  git-htmldocs-1.8.5.3.tar.gz
e4b66ca3ab1b089af651bf742aa030718e9af978  git-manpages-1.8.5.3.tar.gz

The following public repositories all have a copy of the v1.8.5.3
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.5.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.8.5.2
--------------------

 * The "--[no-]informative-errors" options to "git daemon" were parsed
   a bit too loosely, allowing any other string after these option
   names.

 * A "gc" process running as a different user should be able to stop a
   new "gc" process from starting.

 * An earlier "clean-up" introduced an unnecessary memory leak to the
   credential subsystem.

 * "git mv A B/", when B does not exist as a directory, should error
   out, but it didn't.

 * "git rev-parse <revs> -- <paths>" did not implement the usual
   disambiguation rules the commands in the "git log" family used in
   the same way.

 * "git cat-file --batch=3D", an admittedly useless command, did not
   behave very well.

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v1.8.5.2 are as follows:

Jeff King (5):
      rev-parse: correctly diagnose revision errors before "--"
      rev-parse: be more careful with munging arguments
      cat-file: pass expand_data to print_object_or_die
      cat-file: handle --batch format with missing type/size
      Revert "prompt: clean up strbuf usage"

Johannes Sixt (1):
      mv: let 'git mv file no-such-dir/' error out on Windows, too

Junio C Hamano (1):
      Git 1.8.5.3

Kyle J. McKay (1):
      gc: notice gc processes run by other users

Matthieu Moy (1):
      mv: let 'git mv file no-such-dir/' error out

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      daemon: be strict at parsing parameters --[no-]informative-errors

Ralf Thielow (1):
      l10n: de.po: fix translation of 'prefix'

Ramkumar Ramachandra (1):
      for-each-ref: remove unused variable

Thomas Ackermann (1):
      pack-heuristics.txt: mark up the file header properly

W. Trevor King (1):
      Documentation/gitmodules: Only 'update' and 'url' are required
