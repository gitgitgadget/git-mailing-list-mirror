From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.0.4
Date: Wed, 31 Mar 2010 21:50:43 -0700
Message-ID: <7vljd7srmk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 01 06:51:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxCN6-0003Ne-LK
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 06:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab0DAEu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 00:50:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0DAEuy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 00:50:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 022AFA7085;
	Thu,  1 Apr 2010 00:50:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=29JMwqW24WuPupHneiFpe6CNT
	xs=; b=hD/6LIbY+4t+4gsCgn/oXImYfQa3XfSAe2TiI4mI870o0LBh2AfgSyAXD
	hf1C9cQUHpBjNcBrh65W0wKq14hO5go4WKNXHU5ebPs9kv76CuNAQdjJLd6LwUd4
	vWsUR6mvQkqtqDSMzrWPjUoaF6EHqAP5k16OfYnLiILnRQabG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=vpr25Src2lzvmSocmnD
	JnXSA1EkakEG3pa8OtAIQu7plI4Qr9INGGIpWnrdX5Iz476cOQzcgc51PagpeRPu
	IbEdXrBPS3YQERKJR5Ync2qCENVYGpjQn0iZ2Sx+YeoL96aFjxPZ7JsH5cgBfUDx
	YdbukGfPmmzzqHaebRTw0D1w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2EDBA7083;
	Thu,  1 Apr 2010 00:50:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDFD7A7082; Thu,  1 Apr
 2010 00:50:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2424AE96-3D4A-11DF-A05A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143706>

The latest maintenance release Git 1.7.0.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.0.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.0.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.0.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.0.4-1.fc11.$arch.rpm	(RPM)

Git v1.7.0.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.0.3
--------------------

 * Optimized ntohl/htonl on big-endian machines were broken.

 * Color values given to "color.<cmd>.<slot>" configuration can now hav=
e
   more than one attributes (e.g. "bold ul").

 * "git add -u nonexistent-path" did not complain.

 * "git apply --whitespace=3Dfix" didn't work well when an early patch =
in
   a patch series adds trailing blank lines and a later one depended on
   such a block of blank lines at the end.

 * "git fast-export" didn't check error status and stop when marks file
   cannot be opened.

 * "git format-patch --ignore-if-in-upstream" gave unwarranted errors
   when the range was empty, instead of silently finishing.

 * "git remote prune" did not detect remote tracking refs that became
   dangling correctly.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.0.3 are as follows:

Bj=C3=B6rn Gustavsson (5):
      apply: Don't unnecessarily update line lengths in the preimage
      apply: Remove the quick rejection test
      apply: Allow blank context lines to match beyond EOF
      t4124: Add additional tests of --whitespace=3Dfix
      t3417: Add test cases for "rebase --whitespace=3Dfix"

Chris Packham (1):
      test for add with non-existent pathspec

David Aguilar (1):
      difftool: Fix '--gui' when diff.guitool is unconfigured

Greg Bacon (1):
      Documentation: Clarify support for smart HTTP backend

Holger Wei=C3=9F (3):
      Don't redefine htonl and ntohl on big-endian
      Link against libiconv on IRIX
      Documentation: show-ref <pattern>s are optional

Jakub Narebski (1):
      gitweb: git_get_project_config requires only $git_dir, not also $=
project

Jan St=C4=99pie=C5=84 (1):
      Updated the usage string of git reset

Jeff King (1):
      dir: fix COLLECT_IGNORED on excluded prefixes

Johannes Sixt (2):
      diff: fix textconv error zombies
      Windows: fix utime() for read-only files

Junio C Hamano (8):
      git add -u: die on unmatched pathspec
      color: allow multiple attributes
      t0050: mark non-working test as such
      tests for "git add ignored-dir/file" without -f
      refs: ref entry with NULL sha1 is can be a dangling symref
      t9350: fix careless use of "cd"
      Prepare for 1.7.0.4
      Git 1.7.0.4

Kevin Ballard (1):
      format-patch: Squelch 'fatal: Not a range." error

Markus Heidelberg (1):
      Documentation: explain the meaning of "-g" in git-describe output

Sverre Rabbelier (1):
      fast-export: don't segfault when marks file cannot be opened
