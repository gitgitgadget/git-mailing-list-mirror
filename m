From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.0-rc2
Date: Thu, 11 Oct 2012 13:09:56 -0700
Message-ID: <7vy5jc6a97.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 22:10:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMP5C-0005HR-60
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 22:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab2JKUKB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 16:10:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab2JKUJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 16:09:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B09E966B;
	Thu, 11 Oct 2012 16:09:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=YTP+9I17I+5hPPjMeJjON1+zv
	cw=; b=iQdyCJtTsZ1p5k6pwRbHqOGcnkAsuAOFcqIqnk7l/UrBZKRBfMz5HPxrj
	5IS3Pf4i2JsCQq57cNks+DpBmA0DFB5Aa7U9uuYXKvvNsd5DW70mjvAVuHfsqakb
	ZFD1h7DmQ5DZaAfhR6Ws4RLPayK3W7o1R5pqNtUfRRr0P63/0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=js9JCSsQZqpPq/6TMd0
	YHquzxc6pHZjMOHZQvx2IAJyRbPmPaSdVntLJYRmYfA9LBoPJbBgQ3dEdPpxKYxD
	nLn0ZLTZplvfpL/WneuBOfVXVTx0wMCB7vQgPSruKSDRPeDIjfNf/98nQDGZ38Dj
	mK+FGrimlTz/ChpjMhUBKFlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47FC2966A;
	Thu, 11 Oct 2012 16:09:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACEAB9669; Thu, 11 Oct 2012
 16:09:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A12BB0D8-13DF-11E2-B1A9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207509>

A release candidate Git v1.8.0-rc2 is now available for testing
at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

6c8076b3bcf08ffc53a64bbfb0fa69f82096f711  git-1.8.0.rc2.tar.gz
86aca88717928d9d3a38c47a315d2c57402747ca  git-htmldocs-1.8.0.rc2.tar.gz
f4023824ee6b3ad561dba5dbdfe6e07532904a27  git-manpages-1.8.0.rc2.tar.gz

Also the following public repositories all have a copy of the v1.8.0-rc=
2
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Things seem to have calmed down and hopefully we can have the final
1.8.0 without regression soon.

----------------------------------------------------------------

Changes since v1.8.0-rc1 are as follows:

Ben Walton (1):
      tests: "cp -a" is a GNUism

Jonathan Nieder (2):
      git svn: work around SVN 1.7 mishandling of svn:special changes
      svn test: escape peg revision separator using empty peg rev

Junio C Hamano (2):
      gitcli: parse-options lets you omit tail of long options
      Git 1.8.0-rc2

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      gitignore.txt: suggestions how to get literal # or ! at the begin=
ning
      attr: a note about the order of .gitattributes lookup

Ramkumar Ramachandra (1):
      Git url doc: mark ftp/ftps as read-only and deprecate them

Ramsay Allan Jones (1):
      MALLOC_CHECK: Allow checking to be disabled from config.mak

Simon Ruderich (1):
      l10n: de.po: fix a few minor typos

=C3=98yvind A. Holm (1):
      configure.ac: Add missing comma to CC_LD_DYNPATH
