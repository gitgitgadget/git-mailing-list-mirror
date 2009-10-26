From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.5.2
Date: Sun, 25 Oct 2009 22:19:27 -0700
Message-ID: <7vljiypw9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754710AbZJZFTg@vger.kernel.org Mon Oct 26 06:20:02 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754710AbZJZFTg@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Hzt-0005oD-N9
	for glk-linux-kernel-3@lo.gmane.org; Mon, 26 Oct 2009 06:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbZJZFTg (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Oct 2009 01:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZJZFTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Oct 2009 01:19:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbZJZFTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Oct 2009 01:19:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 946EA67AD3;
	Mon, 26 Oct 2009 01:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=V3xN
	X1Pfd+bjI4ndVNqcXAg5FKQ=; b=BK/rrVozeu47p03BrCWeK0MnbpFeBic5d7Gx
	ch4qlITUf+QPP40uBNSpC+Ba0u9MsqWD3SoSMaybmVExLB20cNcW2NZiFab6DQH8
	rkHjDDzHSpvjYiW9Kf/qRTdM29+d0Y+kQBvrHYeWnUupkFW/9RXu1xphU4XZ8a1v
	IOYGBWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=e+R
	WYs32JZUvA6ToR9Uu9FaXSGmD2EYzj8WaU17GT75hMA/l3iU1b6gma1QJCFRJois
	I1ZlD0Evz2UmAlRegZA4aWKUMHE0dUmBoZHszXyuXYfcHmntl2NVLzTcEa9W27a4
	BaxEkZM5zSTf6GsrnL+kSphudTGk4pFkHyCoPnb8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 540DA67AD0;
	Mon, 26 Oct 2009 01:19:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B59367ACE; Mon, 26 Oct
 2009 01:19:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25CB2ADA-C1EF-11DE-A55F-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131241>

The latest maintenance release GIT 1.6.5.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.2-1.fc9.$arch.rpm	(RPM)

GIT v1.6.5.2 Release Notes
==========================

Fixes since v1.6.5.1
--------------------

 * Installation of templates triggered a bug in busybox when using tar
   implementation from it.

 * "git add -i" incorrectly ignored paths that are already in the index
   if they matched .gitignore patterns.

 * "git describe --always" should have produced some output even there
   were no tags in the repository, but it didn't.

 * "git ls-files" when showing tracked files incorrectly paid attention
   to the exclude patterns.

Other minor documentation updates are included.

----------------------------------------------------------------

Changes since v1.6.5.1 are as follows:

Andreas Schwab (1):
      Work around option parsing bug in the busybox tar implementation

Carlos R. Mafra (1):
      Makefile: clean block-sha1/ directory instead of mozilla-sha1/

Jeff King (2):
      ls-files: excludes should not impact tracked files
      document push's new quiet option

Joe Perches (1):
      git-send-email.perl: fold multiple entry "Cc:" and multiple single line "RCPT TO:"s

Johannes Sixt (2):
      Remove a left-over file from t/t5100
      Mark files in t/t5100 as UTF-8

Jonathan Nieder (1):
      Documentation: describe check-ref-format --branch

Junio C Hamano (4):
      Fix incorrect error check while reading deflated pack data
      Do not fail "describe --always" in a tag-less repository
      Fix list of released versions in the toc document
      GIT 1.6.5.2

Markus Heidelberg (1):
      t7800-difftool: fix the effectless GIT_DIFFTOOL_PROMPT test

Matt Kraai (1):
      Documentation/git-gc.txt: change "references" to "reference"

Nanako Shiraishi (2):
      git push: remove incomplete options list from help text
      git push: say that --tag can't be used with --all or --mirror in help text

Nasser Grainawi (1):
      Document `delta` attribute in "git help attributes".

Pauli Virtanen (1):
      git-add--interactive: never skip files included in index
