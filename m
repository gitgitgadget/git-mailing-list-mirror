From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9.4
Date: Mon, 12 Mar 2012 16:45:21 -0700
Message-ID: <7vvcm9mlim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 13 00:45:52 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7Ew3-00080M-Lq
	for glk-linux-kernel-3@plane.gmane.org; Tue, 13 Mar 2012 00:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030Ab2CLXpa (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 19:45:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932258Ab2CLXp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 19:45:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5514E7AA2;
	Mon, 12 Mar 2012 19:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=YeisRtR2sTa2HlLm1KlhAUgncTM=; b=pSRYzdKs379rUqE83ew7LlBsdp6K
	MvpxGeyeeNzk6+KpXvEuIGGhgvaBEHrmBF889/vHALUMkbx2X/EFgf1cTjK6NBtD
	1HbRgO2I8zYD8DWqVrVzsKQpojE4QNd8MIYbTBfXxlfCkTQjezMk90OVUidHxX9h
	u7GUv6p3YyVSzeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	J4XS3P0UW5OLS63d5M0ltZ/NYlnJloEV7vtGD15eu5ZXcHY7zW+56M82vexTmlQy
	jaAC4jhPFZTv1/4lgrFqJHTMlHjmjQLGldy0pBMAXQiZhVBTHJV0fPF8UAJ0Bpzd
	72khD1xGX1E2hlkIxXcPzwsRxr/liM1aDj9G7J8LCm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BCA47AA1;
	Mon, 12 Mar 2012 19:45:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C54057A9B; Mon, 12 Mar 2012
 19:45:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F251078-6C9D-11E1-8EFC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192964>

The latest maintenance release Git 1.7.9.4 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

05d2ff75ffd3356516d096f992b4fb3b8b6c0079  git-1.7.9.4.tar.gz
4d8b27a244969a707e83f6699fd00c322ff0ad5e  git-htmldocs-1.7.9.4.tar.gz
833dc143d2d296754d681c57b41a008ff433b225  git-manpages-1.7.9.4.tar.gz

Also the following public repositories all have a copy of the v1.7.9.4
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Changes since v1.7.9.3 are as follows:

Jakub Narebski (1):
      gitweb: Fix fixed string (non-regexp) project search

Junio C Hamano (6):
      am -3: allow nonstandard -p<num> option
      test: "am -3" can accept non-standard -p<num>
      t4011: modernise style
      t4011: illustrate "diff-index -p" on stat-dirty paths
      diff -p: squelch "diff --git" header for stat-dirty paths
      Git 1.7.9.4

Thomas Rast (5):
      t5510: refactor bundle->pack conversion
      t5510: ensure we stay in the toplevel test dir
      bundle: keep around names passed to add_pending_object()
      Document the --histogram diff option
      t5704: fix nonportable sed/grep usages
