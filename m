From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.5.rc2
Date: Wed, 13 Apr 2011 15:45:37 -0700
Message-ID: <7vvcyhkbxq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 00:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA8oq-0004M2-LD
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 00:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363Ab1DMWpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 18:45:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab1DMWpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 18:45:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A16D344CB;
	Wed, 13 Apr 2011 18:47:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=vT9bwpIpwAEKiF4sLf08UNRT1
	4A=; b=vF2v/tibxyeJtksNoswaN7z9yk9X3KODvNz5xTM83DIoZJdbg4zTiPFhe
	ERdfLs0mLgS+ISX9diFbXPaDX3dH29GoV3iGhIQxy4arg41hpgw9+gAfgWEkGF7b
	0+3VXISpl/OWvQ5mxly7KsRlCkXFkYJbjNMznizfq2wlHkj9D0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=v8u+oJVkwQTaa2leXY1
	oyQXa4nsyUL9SLy4geJvs+sRK/tKzyGlMYq8Y+OzC3ISNB3g4LuNAuAYijGahoTD
	ugnXueSRmzTk1KCe/otIt2j3iBnlOJGPSOPgG1RpXJFtj+Q/pf7M/7+b9wutsUyX
	pNF+LPs2Yv2B2FGq21AJbow8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9143244C9;
	Wed, 13 Apr 2011 18:47:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9609F44C8; Wed, 13 Apr 2011
 18:47:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 096F1FA0-6620-11E0-9AF6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171497>

A release candidate Git 1.7.5.rc2 is available at the usual places for
testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.5.rc2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.5.rc2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.5.rc2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.5.rc2-1.fc13.$arch.rpm	(RPM)

It has been a quiet week on the 'master' front.  Hopefully we can concl=
ude
this cycle early next week with the 1.7.5 final.

Knock wood...

----------------------------------------------------------------

Changes since v1.7.5-rc1 are as follows:

Alejandro R. Sede=C3=B1o (1):
      git-svn: Add a svn-remote.<name>.pushurl config key

Anders Kaseorg (2):
      gitk: Take only numeric version components when computing $git_ve=
rsion
      gitk: Update cherry-pick error message parsing

Andrew Garber (1):
      git-p4: replace each tab with 8 spaces for consistency

James Y Knight (1):
      git-svn: Cache results of running the executable "git config"

Jim Meyering (1):
      remove doubled words, e.g., s/to to/to/, and fix related typos

Johannes Sixt (2):
      t0001: guard a new test with SYMLINKS prerequisite
      t2021: mark a test as fixed

Junio C Hamano (1):
      Git 1.7.5-rc2

Pat Thoyts (1):
      gitk: Quote tag names in event bindings to avoid problems with % =
chars

Paul Mackerras (1):
      gitk: Allow user to control how much of the SHA1 ID gets auto-sel=
ected

Ramkumar Ramachandra (1):
      revert: Hide '-r' option in default usage

Ramsay Allan Jones (1):
      i18n: avoid parenthesized string as array initializer

Skip (1):
      gitk: spelling fixes in Russian translation

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
      Makefile: extract Q_() source strings as ngettext()
