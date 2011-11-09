From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.7.3
Date: Tue, 08 Nov 2011 17:15:31 -0800
Message-ID: <7vsjlyw0y4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Nov 09 02:15:58 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RNwlg-0007wc-0u
	for glk-linux-kernel-3@lo.gmane.org; Wed, 09 Nov 2011 02:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab1KIBPf (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 8 Nov 2011 20:15:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab1KIBPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2011 20:15:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 782FD6004;
	Tue,  8 Nov 2011 20:15:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=Tx+CQjFZr9//4NtUU7OwNy+k3DI=; b=KMYaoRFllKV1QKU9GLyvomdJ9DL2
	lhQBBW9uxT2Xl2ciJsWSYUMr9Q0DFIe1uB+6layclm8a854CLhHS3s+/umI5+/E8
	jZg87mLmULTKMZ9fL57d0rs5oieo2R0OK2MOhbpAJAHPkzE4wJAI3xUL5TwtLS9R
	JMwcJfBsO3/3CW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	eLa1p5EUyv2fsK9X/z1oVRrBHsmQoC+lWaOkT8iCf/nLB0OptWccAlkjBgSz91wt
	sNpjKABSoYqQUW0qfJfTB7Q6/+lb9RcNt4r8nI/qhU2F81Lj9aBH9nxtyPVnMaCo
	RgkccoBUrlcrRlhJlvag162CEkpxKfYEtVyouNO2oxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 702546003;
	Tue,  8 Nov 2011 20:15:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 034EE6002; Tue,  8 Nov 2011
 20:15:32 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 523E347E-0A70-11E1-9188-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185142>

The latest maintenance release Git 1.7.7.3 is available.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

382ee40da74a1b4a1875820c0f0a35c9ccd750f8  git-1.7.7.3.tar.gz
bc0f89cb04e562e4a6d3b936382dbc8f593d861f  git-htmldocs-1.7.7.3.tar.gz
cf1b0d35e2d242bc4cffce3b2bf5b3e32857b395  git-manpages-1.7.7.3.tar.gz

Also the following public repositories all have a copy of the v1.7.7.3
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.7.2 are as follows:

Dan McGee (4):
      pack-objects: mark add_to_write_order() as inline
      pack-objects: use unsigned int for counter and offset values
      pack-objects: rewrite add_descendants_to_write_order() iteratively
      pack-objects: don't traverse objects unnecessarily

Jeff King (1):
      docs: don't mention --quiet or --exit-code in git-log(1)

Julien Muchembled (1):
      gitweb: fix regression when filtering out forks

Junio C Hamano (3):
      branch -m/-M: remove undocumented RENAMED-REF
      docs: Update install-doc-quick
      Git 1.7.7.3
