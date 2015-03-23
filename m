From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.4
Date: Mon, 23 Mar 2015 14:36:18 -0700
Message-ID: <xmqqlhin8kh9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 23 22:36:35 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YaA1Q-0003DI-8l
	for glk-linux-kernel-3@plane.gmane.org; Mon, 23 Mar 2015 22:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbbCWVgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 23 Mar 2015 17:36:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752214AbbCWVgU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Mar 2015 17:36:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C44242B9B;
	Mon, 23 Mar 2015 17:36:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ov3uBNibBkKYMefuHMlWIzwas
	/I=; b=oSzgbbmj2eXg79FHD678DVF7lFbNh6HO0wkGS3Ha1RptVFUasnqj+4AmM
	9sQFNfyTesz6SGHqdFPfFtEkRRI6vnUDxXyZP2rchnDuQ4CzrCOZqfc7IuLMKZ4T
	r7rC3JrI5a3nm3ZrRmRSyROwMmz9miq0lOQoyjPFYb+qAVK7b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=xiYxKxDUAOAiqo+mwT3
	g6wUpg4ZJl5mfTPz4A0xodiwP8CQV6yUTzqPcusEYcpkxIvLobxbEPjlypYbftGG
	55JAX5cMYNqmRzegGII/a5tzrs9GRPrngOSx4qEnK9ffiPntLY3SrvV6Fnd5DGVI
	w8sWrLhTeSYBSVYBJWjr/UA4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9528742B9A;
	Mon, 23 Mar 2015 17:36:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20B4642B99;
	Mon, 23 Mar 2015 17:36:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A46DFA46-D1A4-11E4-B1CD-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266166>

The latest maintenance release Git v2.3.4 is now available at the
usual places.  It is comprised of 22 non-merge commits since v2.3.3,
contributed by 9 people, 1 of which is a new face.  All these fixes
have already been in the 'master' branch for some time.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.3.4'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Karthik Nayak joined the Git development community as a new
contributor whose contributions weren't in v2.3.3.  Welcome.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Kuleshov, Eric Sunshine, Junio C Hamano, Kyle J. McKay,
  Michael J Gruber, Ren=C3=A9 Scharfe, SZEDER G=C3=A1bor, and Torsten
  B=C3=B6gershausen.

----------------------------------------------------------------

Git v2.3.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.3.3
------------------

 * The 'color.status.unmerged' configuration was not described.

 * "git log --decorate" did not reset colors correctly around the
   branch names.

 * "git -C '' subcmd" refused to work in the current directory, unlike
   "cd ''" which silently behaves as a no-op.

 * "git imap-send" learned to optionally talk with an IMAP server via
   libcURL; because there is no other option when Git is built with
   NO_OPENSSL option, use that codepath by default under such
   configuration.

 * A workaround for certain build of GPG that triggered false breakage
   in a test has been added.

 * "git rebase -i" recently started to include the number of
   commits in the insn sheet to be processed, but on a platform
   that prepends leading whitespaces to "wc -l" output, the numbers
   are shown with extra whitespaces that aren't necessary.

 * We did not parse username followed by literal IPv6 address in SSH
   transport URLs, e.g. ssh://user@[2001:db8::1]:22/repo.git
   correctly.

Also contains typofixes, documentation updates and trivial code clean-u=
ps.

----------------------------------------------------------------

Changes since v2.3.3 are as follows:

Alexander Kuleshov (1):
      git: make was_alias and done_help non-static

Eric Sunshine (2):
      rebase-interactive: suppress whitespace preceding item count
      rebase-interactive: re-word "item count" comment

Junio C Hamano (8):
      Documentation/config.txt: avoid unnecessary negation
      Documentation/config.txt: explain multi-valued variables once
      Documentation/config.txt: describe the structure first and then m=
eaning
      Documentation/config.txt: have a separate "Values" section
      Documentation/config.txt: describe 'color' value type in the "Val=
ues" section
      Documentation/config.txt: simplify boolean description in the syn=
tax section
      log --decorate: do not leak "commit" color into the next item
      Git 2.3.4

Karthik Nayak (1):
      git: treat "git -C '<path>'" as a no-op when <path> is empty

Kyle J. McKay (2):
      imap-send: use cURL automatically when NO_OPENSSL defined
      t7510: do not fail when gpg warns about insecure memory

Michael J Gruber (1):
      config,completion: add color.status.unmerged

Ren=C3=A9 Scharfe (2):
      zlib: initialize git_zstream in git_deflate_init{,_gzip,_raw}
      use isxdigit() for checking if a character is a hexadecimal digit

SZEDER G=C3=A1bor (2):
      completion: add a test for __git_remotes() helper function
      completion: simplify __git_remotes()

Torsten B=C3=B6gershausen (3):
      connect.c: allow ssh://user@[2001:db8::1]/repo.git
      t5601: add more test cases for IPV6
      t5500: show user name and host in diag-url
