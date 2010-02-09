From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Feb 2010, #01; Mon, 08)
Date: Mon, 08 Feb 2010 23:42:57 -0800
Message-ID: <7vaavikg72.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 08:43:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nekka-0001sO-6T
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 08:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab0BIHnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 02:43:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0BIHnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 02:43:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFFD097CAF;
	Tue,  9 Feb 2010 02:43:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=00N8rfIerPx9g+P1CIdx7+TA+
	YU=; b=brEJM3zPo5Ttf4Wvj2432akwecfXGYF4IXFkgXVoynxWfh/tQTZ2+TZ+o
	5+Y1jWpfgefXbvOu/qQRDbnSI8FlqwBn6cgrHZgMB2QAbviQyBv8pDB5ODLDihct
	78G7OX1sDIHTQRbvWash4bRMZWUtXa1FDNVY2EQ+Y8qaMBcgh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=sPnU7gcfeSOYK9kmZZR
	14ZPx+1cH1zy8djAbBl8jb9FxIHQad/5aOsX2l9ejPybTyXRqNB1PKLWKmRGEZD6
	2xpZrxpsCVy7Kf0p+y0tW7Xl1wY+Z26mCb4nJQKmczJPWGyH0NEUzQclcAd1L4/G
	a811i8wQM6FLL5VXet+gbXR8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8DEA97CAE;
	Tue,  9 Feb 2010 02:43:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 307B397CAC; Tue,  9 Feb
 2010 02:42:59 -0500 (EST)
X-maint-at: e33cc592deae8132936eea119554799e1039bc0f
X-master-at: 8b2337a5893479ee18dfb21a1d4aa5fc1608872d
X-maint-was: 9504f3d3d2e62cb6fba9e7c61c6fe69dec9053a4
X-master-was: 8051a030617cf7d083568cca223bdaa15052c33f
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BF71D65E-154E-11DF-A6A4-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139379>

Not much is going on in 'next' and 'pu'.

* The 'master' branch has these since v1.7.0-rc2 in addition to what ar=
e
  in 'maint'.

Brian Gernhardt (1):
  t3902: Protect against OS X normalization

Nicolas Pitre (1):
  Revert "pack-objects: fix pack generation when using pack_size_limit"

* The 'maint' branch has these fixes since v1.6.6.1; they are mostly mi=
nor
  documentation fixes.  I might be issuing v1.6.6.2 before v1.7.0 final=
=2E

Christopher Beelby (1):
  git-gui: Keep repo_config(gui.recentrepos) and .gitconfig in sync

Giuseppe Bilotta (1):
  git-gui: work from the .git dir

Jay Soffian (1):
  blame: prevent a segv when -L given start > EOF

Jeff Epler (1):
  git-gui: Fix applying a line when all following lines are deletions

Jeff King (1):
  fix memcpy of overlapping area

Jens Lehmann (1):
  git-gui: Correct file_states when unstaging partly staged entry

Jonathan Nieder (1):
  git-gui: Makefile: consolidate .FORCE-* targets

Junio C Hamano (8):
  status: don't require the repository to be writable
  Fix "log" family not to be too agressive about showing notes
  Fix "log --oneline" not to show notes
  merge-recursive: do not return NULL only to cause segfault
  ignore duplicated slashes in make_relative_path()
  git-add documentation: Fix shell quoting example
  Fix parsing of imap.preformattedHTML and imap.sslverify
  git-push: document all the status flags used in the output

Pat Thoyts (1):
  git-gui: handle really long error messages in updateindex.

Peter Krefting (1):
  git-gui: Fix gitk for branch whose name matches local file

Ren=C3=A9 Scharfe (1):
  archive: simplify archive format guessing

SZEDER G=C3=A1bor (1):
  bash: don't offer remote transport helpers as subcommands

Tay Ray Chuan (1):
  retry request without query when info/refs?query fails

Vitaly _Vi Shukela (1):
  git-gui: Add hotkeys for "Unstage from commit" and "Revert changes"

Wesley J. Landaker (1):
  Update git fsck --full short description to mention packs
