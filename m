From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.0.6
Date: Fri, 23 Apr 2010 18:24:18 -0700
Message-ID: <7v4oj1ve0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Apr 24 03:24:37 2010
connect(): No such file or directory
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1O5U6n-0001VK-EX
	for glk-linux-kernel-3@lo.gmane.org; Sat, 24 Apr 2010 03:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593Ab0DXBYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 23 Apr 2010 21:24:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab0DXBY2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2010 21:24:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93BD8AD5DE;
	Fri, 23 Apr 2010 21:24:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=yUPFS/nd74HWRTAmpNW61IMZ2
	gg=; b=I09y71+65nF9D2XnBGv0S94Jtm4jTYsgnEllWNXb4Rn22iBOfk9O6IfQh
	dAde2m+TSR8jp73ohqKXZJDULGIpl64NJVMfIBeUGhC//WA8ZIk20h+VKzfYgB7w
	ZN84XHG99QqxGkPXLp0lIGM+fNPBZu4QZopXKWLhR609MXq9WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=QbTKryZGTIh8hUuT2XS
	YRpcYHT8zfx7m60npgYZ9yL+ny4eD8gcy4EHuStCHzgpx/+qObdVwstRArlZOueu
	IQXg3pcTmJxZV3muW9qYrA4ts2bYo+1vL3Ru6KAbOua4+JQDAKzyrAngEb5LlQb4
	IYMB7kX2wcSnwp3ck6buXsSc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F6EAAD5DD;
	Fri, 23 Apr 2010 21:24:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 857D4AD5DC; Fri, 23 Apr
 2010 21:24:19 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D5E118A-4F40-11DF-9F1B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145652>

 Git 1.7.0.6 is available at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.0.6.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.0.6.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.0.6.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.0.6-1.fc11.$arch.rpm	(RPM)

----------------------------------------------------------------

Git v1.7.0.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.0.5
--------------------

 * "git diff --stat" used "int" to count the size of differences,
   which could result in overflowing.

 * "git rev-list --abbrev-commit" defaulted to 40-byte abbreviations, u=
nlike
   newer tools in the git toolset.

And other minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.0.5 are as follows:

Charles Bailey (1):
      Documentation: Describe other situations where -z affects git dif=
f

David Aguilar (1):
      Makefile: Remove usage of deprecated Python "has_key" method

Jay Soffian (1):
      Documentation/config.txt: default gc.aggressiveWindow is 250, not=
 10

Jeff King (1):
      diff: use large integers for diffstat calculations

Johannes Sixt (1):
      MSVC: Fix build by adding missing termios.h dummy

Jonathan Nieder (2):
      Document new "already-merged" rule for branch -d
      Documentation/Makefile: fix interrupted builds of user-manual.xml

Junio C Hamano (1):
      Git 1.7.0.6

Marc Branchaud (1):
      Docs: Add -X option to git-merge's synopsis.

Michael J Gruber (3):
      rev-list: use default abbrev length when abbrev-commit is in effe=
ct
      t1010-mktree: Adjust expected result to code and documentation
      t7012: Mark missing tests as TODO

SZEDER G=C3=A1bor (1):
      reflog: remove 'show' from 'expire's usage string

Thomas Rast (1):
      combined diff: correctly handle truncated file

Will Palmer (1):
      documentation: clarify direction of core.autocrlf
