From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.8.5
Date: Sun, 26 Feb 2012 18:51:12 -0800
Message-ID: <7v399xc7kv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 03:51:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1qgd-0003AE-Nx
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 03:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab2B0CvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Feb 2012 21:51:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab2B0CvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2012 21:51:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502CE78FB;
	Sun, 26 Feb 2012 21:51:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=vXBLo7Xs8EV48pyj+5uFVvnd0
	OM=; b=KQv4VyhNcYkf9Wh7nL5mRzswmTO0jmz7w9l38i88whbNHpwqy1XdMYzAU
	+C+8oeRNIPXva/m5MYJnLAj8bToXz1+z77BlrrpoVQaaoS1jgPTB3OUzyluC+XKs
	zUatbFD3oOY/h1RkEvYPLxOlSfL/A/BHkOamNQiD7Zn+75Pi+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=TnS8oE3+c/FVPE19yfw
	gv4i0MPYbTgYIBcV0n0LGPltAIwOg4LPu64BzsZLUCEJcjgxogLD37zGrOTp5Xba
	aY9LxEoWX1L1v2BKb4KjH+MihibKmXk6QiinY90hAxatfJS+XvyqipGLjtElCb2j
	5U1f14Ta71FMI4M0MVCVAeak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48D1C78FA;
	Sun, 26 Feb 2012 21:51:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB4A878F9; Sun, 26 Feb 2012
 21:51:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E96FFDAE-60ED-11E1-8408-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191599>

A maintenance release Git 1.7.8.5 is now available at the usual
places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

bb3d715437a4751f7de0c89156bf97dae7c6049a  git-1.7.8.5.tar.gz
71cf25158ae3499e33327fa9469279771429f9f7  git-htmldocs-1.7.8.5.tar.gz
ce327331973b6e100b6a69ab8f9c526690260e92  git-manpages-1.7.8.5.tar.gz

Also the following public repositories all have a copy of the v1.7.8.5
tag and the maint-1.7.8 branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v1.7.8.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.7.8.4
--------------------

 * Dependency on our thread-utils.h header file was missing for
   objects that depend on it in the Makefile.

 * "git am" when fed an empty file did not correctly finish reading it
   when it attempts to guess the input format.

 * "git grep -P" (when PCRE is enabled in the build) did not match the
   beginning and the end of the line correctly with ^ and $.

 * "git rebase -m" tried to run "git notes copy" needlessly when
   nothing was rewritten.

Also contains minor fixes and documentation updates.

----------------------------------------------------------------

Changes since v1.7.8.4 are as follows:

Andrew Wong (1):
      rebase -m: only call "notes copy" when rewritten exists and is no=
n-empty

Dmitry V. Levin (1):
      Makefile: add thread-utils.h to LIB_H

Jeff King (1):
      imap-send: remove dead code

Jim Meyering (1):
      am: don't infloop for an empty input file

Junio C Hamano (2):
      Git 1.7.6.6
      Git 1.7.8.5

Micha=C5=82 Kiedrowicz (1):
      grep -P: Fix matching ^ and $
