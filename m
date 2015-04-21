From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.6
Date: Tue, 21 Apr 2015 14:53:24 -0700
Message-ID: <xmqqsibtf8rv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Apr 21 23:53:38 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Ykg6o-0005eX-IN
	for glk-linux-kernel-3@plane.gmane.org; Tue, 21 Apr 2015 23:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933742AbbDUVx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 21 Apr 2015 17:53:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933282AbbDUVx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Apr 2015 17:53:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 944EE4BE4D;
	Tue, 21 Apr 2015 17:53:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=UrmDlSfpcQQXKipFnepQJZKGH
	/g=; b=Zj2BDfuDq+oAL7776X6OdL7eTB+ErhyFJEa5YY0b3EcMxZfGPVkaPoEnD
	Cw1qeI4FvZ3F5e9VFVtcSlPtaFSmPlkH+CRRUtPKmzsRNzkmSbgYiaS+7JdSAZXF
	p7edG29KtWKIdXPCoNL4wuKPcx0JGT3B+PREw6BKhoxsRWzhCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GnEVLxyXLwupE3jZPko
	xfrekA7CxXF0gMnbOA+9IXDwz1MhMGx2jkSh3NpRIh4jQHHnLIZ5hOPXWJ3RHQb9
	DOSzvH63lTSUkNh5A59TzCcyUtDAE9izXIr4+jwuuw8Lbl5FBGtyoKhJ8gRNHUwb
	VTg0Jmi4C/c/BYnDe3v7HyLk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DD314BE4C;
	Tue, 21 Apr 2015 17:53:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 157B04BE4B;
	Tue, 21 Apr 2015 17:53:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D6857D32-E870-11E4-ADFA-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267560>

The latest maintenance release Git v2.3.6 is now available at the
usual places.  It is comprised of 14 non-merge commits since v2.3.5,
contributed by 8 people, 4 of which are new faces.

There is not much to see there (the changes are mostly documentation
and test updates), except for updates to diff-highlight in contrib/.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.6'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.3.5 are as follows.
Welcome to the Git development community!

  Ivan Ukhov, J=C3=A9r=C3=B4me Zago, Julian Gindi, and Paul Tan.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Jeff King, Jonathan Nieder, Junio C Hamano, and Kyle J. McKay.

----------------------------------------------------------------

Git v2.3.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.3.5
------------------

 * "diff-highlight" (in contrib/) used to show byte-by-byte
   differences, which meant that multi-byte characters can be chopped
   in the middle.  It learned to pay attention to character boundaries
   (assuming the UTF-8 payload).

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.3.5 are as follows:

Ivan Ukhov (1):
      parse-options.h: OPTION_{BIT,SET_INT} do not store pointer to def=
val

Jeff King (7):
      t: translate SIGINT to an exit
      t: redirect stderr GIT_TRACE to descriptor 4
      t: pass GIT_TRACE through Apache
      t5541: move run_with_cmdline_limit to test-lib.sh
      t5551: make EXPENSIVE test cheaper
      cherry-pick: fix docs describing handling of empty commits
      howto: document more tools for recovery corruption

Jonathan Nieder (1):
      fast-import doc: remove suggested 16-parent limit

Julian Gindi (1):
      CodingGuidelines: update 'rough' rule count

Junio C Hamano (1):
      Git 2.3.6

J=C3=A9r=C3=B4me Zago (1):
      gitweb.conf.txt: say "build-time", not "built-time"

Kyle J. McKay (1):
      diff-highlight: do not split multibyte characters

Paul Tan (1):
      enter_repo(): fix docs to match code
