From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.3.1
Date: Mon, 10 Jun 2013 14:03:49 -0700
Message-ID: <7vy5ahekzu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Jun 10 23:04:03 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Um9Fy-0005BM-9T
	for glk-linux-kernel-3@plane.gmane.org; Mon, 10 Jun 2013 23:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab3FJVDy (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 10 Jun 2013 17:03:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185Ab3FJVDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jun 2013 17:03:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CF5A27528;
	Mon, 10 Jun 2013 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	VgJmqfIebx5QfTTl9kb6s9h5sg=; b=OCQPTjonnpa99hQOkGO0A2l584hDgAzzI
	s93PnLFqcDhZhki2yqwbDLtYrKnb7x95cY6YE7efA/jLJBD7eklS84XQHCo0fGR/
	aizrxcm7yQtGt2pwdV2epzGrqObfu7qLlVXOI45qDOTS6E0GVHN3sxGEyDEisJzg
	0iTLga9DT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=p5aOioz+r/Lbkqg6bLrTsdVOw4dvhsZUT4QUcvCF+r02QZT2028pvEHk
	p00ak8CaWGE1TvJdMyot3Dch3rh8rQPpmwfdlytZfOJW8XNxtrsIZLHuzbIvQj6G
	G++u6BxjLMaMgUzAmwUiWm+nIWnlM3HcmaOsSNC0vhBwhcsm524=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 121EA27527;
	Mon, 10 Jun 2013 21:03:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A6D027524;
	Mon, 10 Jun 2013 21:03:51 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 408D77CA-D211-11E2-9334-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227381>

The latest maintenance release Git v1.8.3.1 is now available at the
usual places.

This is primarily to push out fixes to two regressions that seem to
affect many people, namely, the ".gitignore !directory" bug and the
"daemon cannot read from $HOME owned by root" bug.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

32562a231fe4422bc033bf872fffa61f41ee2669  git-1.8.3.1.tar.gz
94d48f6f8684aec851124e7d0b835b338a9187ad  git-htmldocs-1.8.3.1.tar.gz
0cd759579d4bd75f1cf1ba073b1ab96c49390426  git-manpages-1.8.3.1.tar.gz

The following public repositories all have a copy of the v1.8.3.1
tag and the maint branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.3.1 Release Notes
========================

Fixes since v1.8.3
------------------

 * When $HOME is misconfigured to point at an unreadable directory, we
   used to complain and die. The check has been loosened.

 * Handling of negative exclude pattern for directories "!dir" was
   broken in the update to v1.8.3.

Also contains a handful of trivial code clean-ups, documentation
updates, updates to the test suite, etc.
