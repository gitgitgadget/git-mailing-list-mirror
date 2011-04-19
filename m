From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.4.5
Date: Tue, 19 Apr 2011 15:52:06 -0700
Message-ID: <7v39ld4zxl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:52:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCJmO-0000Tq-8e
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 00:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab1DSWwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2011 18:52:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1DSWwN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 18:52:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAC554BDC;
	Tue, 19 Apr 2011 18:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=UmktiOk6O1QsmsXHkA6PCQynl
	sY=; b=EY18oLBKrQrRWnVlKiJzUZ1pwP7ztZGxgbAYyrSkLJ/ehOTPi41n2B3Qq
	I7ms5VoM/PCHtOcLa7RcDFGSENIgcr/gV/+k52ovVuVfLJ9eCJxuqVradHRYTX/g
	BMyiYF2jzWfeNmAuasH7wOPR2BR8H40VIOgsL2HuSa7lAphnqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=RA5deQmoUpkXRkfO1gw
	7p2tJWOXA2I9jHEV3QwCtXL6+u6AHedTVYvv83bUMX5mhFez+ijQOno1OnlYhJEM
	SIU+NRwC3P2kPGYowlBtRCJzsb22m6GQ+fObi7NskP/Y4ZRvXY/YiwFCGYKjocJT
	hQ/6sTBVkcdO0kFLCZSKkyXg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A99604BDB;
	Tue, 19 Apr 2011 18:54:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D893F4BD9; Tue, 19 Apr 2011
 18:54:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0757DCA-6AD7-11E0-AD41-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171823>

The latest maintenance release Git 1.7.4.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.4.5.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.4.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.4.5.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.4.5-1.fc13.$arch.rpm	(RPM)

This contains only minor documentation fixes accumulated since 1.7.4.4.

----------------------------------------------------------------

Changes since v1.7.4.4 are as follows:

Johannes Sixt (1):
      t2021: mark a test as fixed

Junio C Hamano (2):
      "log --cherry-pick" documentation regression fix
      Git 1.7.4.5

Michael J Gruber (3):
      git.txt: fix list continuation
      t3306,t5304: avoid clock skew issues
      git-svn.txt: Document --mergeinfo

Ren=C3=A9 Scharfe (1):
      archive: document limitation of tar.umask config setting
