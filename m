From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.3.5
Date: Wed, 05 Jan 2011 16:52:46 -0800
Message-ID: <7vy66yc0pt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jan 06 01:53:39 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Pae6k-0004TV-Ve
	for glk-linux-kernel-3@lo.gmane.org; Thu, 06 Jan 2011 01:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583Ab1AFAw7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 5 Jan 2011 19:52:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210Ab1AFAw5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2011 19:52:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 140CA38A8;
	Wed,  5 Jan 2011 19:53:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=kVAtpqYir9DL60oYrphh6IZOA
	bw=; b=YEtJchr7D+TgNtOYmU2gF3Hxvo9tfMSWFJzv+XkTwXHTD1Js32haEGhFf
	2728j2yQXlMZhHkTDTXqYYH+n3jfm90rBcZniPlQFFIpkDUC8YVE+hqrqNEEDYfh
	1XmdkZjbLVNHOcbRTSZ+bzMg0Y2j88oro1BCCMClfeE2LZ/qDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Cm3qE0pJEI2QVJvLgsx
	A0gejU+kLqEx6OaVSNhLGEvPIHM0rs5C/Ms4PV7jGPiXTZ4ud2Cu1UGtxGXbs6rh
	shFhsNHRCpBzcj0OLmrfVkvFOWkS0dlRrbtOSRU03RnlI64sNjSqZ5oA75yrpVbP
	7bOVdTcCk3mA/vqEbvZeqceM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D43FB38A7;
	Wed,  5 Jan 2011 19:53:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 798A638A6; Wed,  5 Jan 2011
 19:53:25 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60BD7740-192F-11E0-A09F-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164616>

The latest maintenance release Git 1.7.3.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.3.5.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.3.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.3.5.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.3.5-1.fc11.$arch.rpm	(RPM)

Just a handful of small fixes here and there, nothing spectacular, exce=
pt
perhaps for a fix to the "am --abort" safety issue Linus noticed the ot=
her
day.

----------------------------------------------------------------

Changes since v1.7.3.4 are as follows:

Brandon Casey (1):
      test-lib.sh/test_decode_color(): use octal not hex in awk script

Jakub Narebski (1):
      gitweb: Include links to feeds in HTML header only for '200 OK' r=
esponse

Jeff King (1):
      ident: die on bogus date format

Jiang Xin (1):
      Fix typo in git-gc document.

Jonathan Nieder (2):
      t0050: fix printf format strings for portability
      gitweb: skip logo in atom feed when there is none

Junio C Hamano (5):
      commit: die before asking to edit the log message
      am --abort: keep unrelated commits since the last failure and war=
n
      rebase --skip: correctly wrap-up when skipping the last patch
      Prepare for 1.7.3.5
      Git 1.7.3.5

Kevin Ballard (1):
      status: Quote paths with spaces in short format

Kirill Smelkov (2):
      t/t8006: Demonstrate blame is broken when cachetextconv is on
      fill_textconv(): Don't get/put cache if sha1 is not valid

Mark Lodato (1):
      fsck docs: remove outdated and useless diagnostic

Michael J Gruber (2):
      git-difftool.txt: correct the description of $BASE and describe $=
MERGED
      difftool: provide basename to external tools

Ramsay Allan Jones (1):
      t3419-*.sh: Fix arithmetic expansion syntax error

Ren=C3=A9 Scharfe (1):
      close file on error in read_mmfile()

Robin H. Johnson (2):
      Fix false positives in t3404 due to SHELL=3D/bin/false
      t9001: Fix test prerequisites

Thomas Rast (1):
      userdiff: fix typo in ruby and python word regexes

Vasyl' Vavrychuk (1):
      trace.c: mark file-local function static
