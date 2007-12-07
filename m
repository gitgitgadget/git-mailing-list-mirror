From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Fri, 07 Dec 2007 01:50:52 -0800
Message-ID: <7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 10:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Zrl-0006KZ-5k
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 10:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbXLGJvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 04:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbXLGJvF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 04:51:05 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:42669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbXLGJvD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 04:51:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D3033773;
	Fri,  7 Dec 2007 04:50:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 662E03772;
	Fri,  7 Dec 2007 04:50:55 -0500 (EST)
X-maint-at: 8e7425da782cbdff4531d84e0ef4ec7bd3ae23d7
X-master-at: 9758ecde9a0be8b9758d0a512c90f8bfc865af4f
In-Reply-To: <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 05 Dec 2007 02:57:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67404>

Heavy merges to 'master' continues.  We are almost there for -rc0.
Merged to 'master' are:

 * Colorized "add -i" (Dan Zwell)
 * Talk more about diff options in "git log" documentation (Miklos)
 * git-gui 0.9.1 preview
 * Make cvsserver act more like receive-pack (Michael Witten)
 * "git-clean <paths>" limits the damage to named paths
 * Use right Perl in Documentation/Makefile

Also people's favorite topic "squelching compilation warnings for iconv=
"
is included.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

David Symonds (1):
  Change from using email.com to example.com as example domain, as per =
RFC
    2606.

Junio C Hamano (2):
  git grep shows the same hit repeatedly for unmerged paths
  git-am -i: report rewritten title

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  Add missing inside_work_tree setting in setup_git_directory_gently
  Do check_repository_format() early
  Do check_repository_format() early (re-fix)

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Bj=C3=B6rn Steinbrink (1):
  git config: Don't rely on regexec() returning 1 on non-match

Brian M. Carlson (1):
  git-gui: Reorder msgfmt command-line arguments

Christian Stimming (2):
  Update git-gui.pot with latest (few) string additions and changes.
  Update German translation. 100% completed.

Jakub Narebski (1):
  autoconf: Add test for OLD_ICONV (squelching compiler warning)

Jeff King (1):
  t7300: add test for clean with wildcard pathspec

Johannes Sixt (2):
  git-gui: Improve the application icon on Windows.
  for-each-ref: Fix quoting style constants.

Junio C Hamano (12):
  Run the specified perl in Documentation/
  git-cvsserver runs hooks/post-update
  Revert "git-am: catch missing author date early."
  Documentation: color.* =3D true means "auto"
  git config --get-colorbool
  Color support for "git-add -i"
  git-clean: Honor pathspec.
  config --get-colorbool: diff.color is a deprecated synonym to color.d=
iff
  hg-to-git: handle an empty dir in hg.
  do not discard status in fetch_refs_via_pack()
  git-status documentation: mention subdirectory behaviour
  Update draft release notes to 1.5.4

Kristian H=C3=B8gsberg (1):
  Rewrite builtin-fetch option parsing to use parse_options().

Matthias Kestenholz (1):
  Documentation: add --patch option to synopsis of git-add

Michael Witten (1):
  git-cvsserver runs hooks/post-receive

Michele Ballabio (2):
  git-gui: fix a typo in lib/commit.tcl
  git-gui: update it.po and glossary/it.po

Miklos Vajna (2):
  Include diff options in the git-log manpage
  Update Hungarian translation. 100% completed.

Nanako Shiraishi (1):
  Update ja.po for git-gui

Robert Schiele (1):
  git-gui: install-sh from automake does not like -m755

Wincent Colaiuta (1):
  Silence iconv warnings on Leopard
