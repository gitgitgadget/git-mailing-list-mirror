From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.4-rc3
Date: Mon, 24 Jan 2011 14:36:16 -0800
Message-ID: <7vzkqqkjz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 24 23:36:37 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1PhV1Y-0006Zj-2p
	for glk-linux-kernel-3@lo.gmane.org; Mon, 24 Jan 2011 23:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1AXWg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 24 Jan 2011 17:36:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab1AXWg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2011 17:36:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 778122705;
	Mon, 24 Jan 2011 17:37:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=veyAN+4taPorHJ/LO+TgN4e2j
	6k=; b=sqWImu3oDf3SqzLCWgfsAJIWaCis5/ugL4OA+dLt3zwePbT75ImvGawh9
	hfb7Bl97JtfN3Px0eKS2QaRkNEPWuZOjJkLja27QGkT0Wx1eIWCffpxUT2GClxWE
	g+o6ghQDD9NQaK2dpeSxchH6G9tUW3ONJXORZLV99frAn4uU1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SuKXkvlrbQu2XYGiCBy
	Ltx4L3lVlFIuZ9dJwf4Q0yh0DS+ywurZtlql0WDHxRZ0iheB2vI71Ujr4b/3Lsem
	oUkNqCeng7VokuNXDocNwz/EWnSrluUBOUV8Yir5Gg/VXaqjrv0fXjEZnBYLDlyA
	GJ50BLI7XKJBEz7yViNxsgNM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 471462703;
	Mon, 24 Jan 2011 17:37:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC8C826FC; Mon, 24 Jan 2011
 17:37:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7C5F7DE2-280A-11E0-822C-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165460>

A release candidate Git 1.7.4-rc3 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.4.rc3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.4.rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.4.rc3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.4.rc3-1.fc13.$arch.rpm	(RPM)

Except for a regression fix to keep honoring "git --work-tree=3D/there/=
 cmd"
without specifying --git-dir (Thanks Jonathan), there isn't any excitin=
g
new thing to see here; which is exactly the way how I want an rc3 to be=
=2E

Hopefully we can tag the final by the end of the month.  Everybody, tha=
nks
in advance for testing this rc ;-).

----------------------------------------------------------------

Changes since v1.7.4-rc2 are as follows:

Alexey Shumkin (1):
      userdiff: match Pascal class methods

Bj=C3=B6rn Steinbrink (1):
      Correctly report corrupted objects

Erik Faye-Lund (1):
      exec_cmd: remove unused extern

Johannes Sixt (2):
      Fix expected values of setup tests on Windows
      t/README: hint about using $(pwd) rather than $PWD in tests

Jonathan Nieder (9):
      ll-merge: simplify opts =3D=3D NULL case
      Documentation/fast-import: capitalize beginning of sentence
      remote-ext: do not segfault for blank lines
      Documentation/fast-import: put explanation of M 040000 <dataref> =
"" in context
      tests: cosmetic improvements to the repo-setup test
      tests: compress the setup tests
      Documentation: do not treat reset --keep as a special case
      Subject: setup: officially support --work-tree without --git-dir
      t1510: fix typo in the comment of a test

Junio C Hamano (2):
      Documentation updates for 'GIT_WORK_TREE without GIT_DIR' histori=
cal usecase
      Git 1.7.4-rc3

Ramsay Allan Jones (1):
      svndump.c: Fix a printf format compiler warning
