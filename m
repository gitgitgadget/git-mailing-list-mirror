From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.1-rc3
Date: Mon, 15 Dec 2008 00:32:36 -0800
Message-ID: <7voczdyh23.fsf@gitster.siamese.dyndns.org>
References: <7vbpvnbcoa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 09:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC8tv-0006Na-H1
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 09:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYLOIcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 03:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYLOIcp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 03:32:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbYLOIco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 03:32:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3168C1A480;
	Mon, 15 Dec 2008 03:32:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A1F191A47B; Mon,
 15 Dec 2008 03:32:38 -0500 (EST)
In-Reply-To: <7vbpvnbcoa.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Dec 2008 18:53:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F12E7A66-CA82-11DD-9E1E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103141>

I have fixed a few more smallish (old) bugs after I tagged this, which
will be in 'master' shortly, but it seems that this cycle is stabilizing
fairly nicely.  Let's have a successful 1.6.1 tagged on 20th.  Please hunt
and fix bugs until then.

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.1-rc3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.1-rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.1-rc3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also there.

  testing/git-*-1.6.1-rc3-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------

Changes since v1.6.1-rc2 are as follows:

Alexander Gavrilov (1):
      Documentation: Describe git-gui Tools menu configuration options.

Alexander Potashev (2):
      Fix typos in documentation
      Fix typo in comment in builtin-add.c

Alexey Borzenkov (1):
      Define linkgit macro in [macros] section

Brandon Casey (1):
      git-branch: display sha1 on branch deletion

Deskin Miller (1):
      git-svn: Make following parents atomic

Jakub Narebski (1):
      gitweb: Fix bug in insert_file() subroutine

Jeff King (5):
      reorder ALLOW_TEXTCONV option setting
      diff: allow turning on textconv explicitly for plumbing
      diff: fix handling of binary rewrite diffs
      diff: respect textconv in rewrite diffs
      rebase: improve error messages about dirty state

Jim Meyering (1):
      git-config.txt: fix a typo

Johannes Schindelin (1):
      Get rid of the last remnants of GIT_CONFIG_LOCAL

Junio C Hamano (4):
      builtin-checkout.c: check error return from read_cache()
      read-cache.c: typofix in comment
      work around Python warnings from AsciiDoc
      Fix t4031

Linus Torvalds (1):
      fsck: reduce stack footprint

Markus Heidelberg (1):
      builtin-commit: remove unused message variable

Nicolas Pitre (1):
      make sure packs to be replaced are closed beforehand

Ralf Wildenhues (1):
      Improve language in git-merge.txt and related docs

Tor Arvid Lund (1):
      git-p4: Fix regression in p4Where method.

YONETANI Tomokazu (1):
      git-fast-import possible memory corruption problem
