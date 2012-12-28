From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.0.3
Date: Thu, 27 Dec 2012 16:48:23 -0800
Message-ID: <7v8v8jknmw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Dec 28 01:48:55 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ToO84-0000XX-Pb
	for glk-linux-kernel-3@plane.gmane.org; Fri, 28 Dec 2012 01:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab2L1As3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 27 Dec 2012 19:48:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399Ab2L1As0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Dec 2012 19:48:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6473A8E5;
	Thu, 27 Dec 2012 19:48:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7FKXDvvu3AlZDXxZoP8mmvThn
	yQ=; b=u27pNUGqNbCccJsSx98ePuc3RN18uM0bzS94HiEqq7W+J83UU/ZGjRLUW
	kRDT7w7xzV0ooQK0zafi4DBLbyz/tEqw9GbjPNUTUt+gb3hiJoVVVKRB/8uydW0x
	0/S1NPjncinESoJkKivlh7PyaT1rsjmyu4FvftVZFonbrePhcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=q7+uXjkiWmAUKhsp5jt
	wS+K6lKFj6hnkyvWdkrhygTchmjVtnXlw2+2pWQl96unDPfPnVZ2K4mTgll+K8dY
	ICIEwjQwHBs/+vNN9y6IYSRh4kISulFJSLNnWwiMKqF+bsCT7DgCi72jFBAmFJTt
	C/ojelsdZffzJQYsXCDd37KA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2D3EA8E1;
	Thu, 27 Dec 2012 19:48:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 070D6A8E0; Thu, 27 Dec 2012
 19:48:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49513960-5088-11E2-9603-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212217>

The latest maintenance release Git v1.8.0.3 is now available at
the usual places.

This is primarily to down-merge documentation updates that have been
accumulating to the 'master' front for the upcoming 1.8.1 to the
maintenance series.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

b1695f28448c00e61e110b3c7bcd66c8047ef176  git-1.8.0.3.tar.gz
83c46b62e0c3979c5ef77a407ca41507658b5726  git-htmldocs-1.8.0.3.tar.gz
63df55f90b9c6c11dd827ce1880b5b5fdf79c1c1  git-manpages-1.8.0.3.tar.gz

Also the following public repositories all have a copy of the v1.8.0.3
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.8.0.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.8.0.2
--------------------

 * "git log -p -S<string>" did not apply the textconv filter while
   looking for the <string>.

 * In the documentation, some invalid example e-mail addresses were
   formatted into mailto: links.

Also contains many documentation updates backported from the 'master'
branch that is preparing for the upcoming 1.8.1 release.

----------------------------------------------------------------

Changes since v1.8.0.2 are as follows:

Adam Spiers (2):
      SubmittingPatches: add convention of prefixing commit messages
      Documentation: move support for old compilers to CodingGuidelines

Anders Kaseorg (1):
      git-prompt: Document GIT_PS1_DESCRIBE_STYLE

Chris Rorvick (2):
      Documentation/git-checkout.txt: clarify usage
      Documentation/git-checkout.txt: document 70c9ac2 behavior

Gunnlaugur =C3=9E=C3=B3r Briem (1):
      Document git-svn fetch --log-window-size parameter

Jeff King (7):
      pickaxe: hoist empty needle check
      pickaxe: use textconv for -S counting
      .mailmap: match up some obvious names/emails
      .mailmap: fix broken entry for Martin Langhoff
      .mailmap: normalize emails for Jeff King
      .mailmap: normalize emails for Linus Torvalds
      contrib: update stats/mailmap script

John Keeping (1):
      Documentation: don't link to example mail addresses

Junio C Hamano (6):
      fetch --tags: clarify documentation
      README: it does not matter who the current maintainer is
      t7004: do not create unneeded gpghome/gpg.conf when GPG is not us=
ed
      Documentation: Describe "git diff <blob> <blob>" separately
      git(1): show link to contributor summary page
      Git 1.8.0.3

Krzysztof Mazur (1):
      doc: git-reset: make "<mode>" optional

Manlio Perillo (1):
      git.txt: add missing info about --git-dir command-line option

Matthew Daley (1):
      Fix sizeof usage in get_permutations

Max Horn (1):
      git-remote-helpers.txt: document invocation before input format

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      index-format.txt: clarify what is "invalid"

Ramkumar Ramachandra (1):
      Documentation: move diff.wordRegex from config.txt to diff-config=
=2Etxt

Sebastian Leske (4):
      git-svn: Document branches with at-sign(@).
      git-svn: Recommend use of structure options.
      git-svn: Expand documentation for --follow-parent
      git-svn: Note about tags.

Sitaram Chamarty (1):
      clarify -M without % symbol in diff-options

Stefano Lattarini (1):
      README: Git is released under the GPLv2, not just "the GPL"

Thomas Ackermann (8):
      Split over-long synopsis in git-fetch-pack.txt into several lines
      Shorten two over-long lines in git-bisect-lk2009.txt by abbreviat=
ing some sha1
      Change headline of technical/send-pack-pipeline.txt to not confus=
e its content with content from git-send-pack.txt
      Documentation/technical: convert plain text files to asciidoc
      Documentation/howto: convert plain text files to asciidoc
      Documentation: build html for all files in technical and howto
      Remove misleading date from api-index-skel.txt
      Sort howto documents in howto-index.txt

Tom Jones (1):
      Add -S, --gpg-sign option to manpage of "git commit"
