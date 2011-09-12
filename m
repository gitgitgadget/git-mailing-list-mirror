From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.6.3
Date: Mon, 12 Sep 2011 13:17:13 -0700
Message-ID: <7v39g17bxy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Sep 12 22:17:35 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1R3Cwg-0000Ck-GJ
	for glk-linux-kernel-3@lo.gmane.org; Mon, 12 Sep 2011 22:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab1ILURR (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Sep 2011 16:17:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754300Ab1ILURP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2011 16:17:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CF2D5881;
	Mon, 12 Sep 2011 16:17:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=hcS5CVS5tqwGt5WZrTijPMEn8NU=; b=D4IrUwyiy61Omg/9b18NExcZ+O0k
	nAj302SanaXJdrBZg+b7zSeqgI3eNyi95IOg/avLHQD+gQmFxYcJrQFlgiQuQBmd
	/BiA4BrPXi8SZjWbYRZ1YHDLEd4mnuDVXalR7fPYt09hBIftCJCUKV6dE3OD6lM1
	EMQjFY85YylL0B4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	xXBrGVPHMAjZoiTmr3HRlHnB1ZiSgRs2exegoOUf9GDjTIJYfm779ZRBtX+nuD2+
	gIJvoa4J9uFYhkcoxPmmsfOcumlrIpHSCWBlaiXGlP3Y8Rc6oQaDqaohYwz18LVc
	62dvgpr3bao5QR8MBD5JVj2hH9wPHupk1tGxlwc8c3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 449C55880;
	Mon, 12 Sep 2011 16:17:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5403587F; Mon, 12 Sep 2011
 16:17:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3488D77A-DD7C-11E0-A9A8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181237>

The latest maintenance release Git 1.7.6.3 is available but unfortunately
not at the usual places.

The release tarball is found at:

    http://code.google.com/p/git-core/downloads/list
  
and its SHA-1 checksum is:

7264c0b0d97cb6a70447ba3b4b6fa488810d8115  git-1.7.6.3.tar.gz

Also the following public repositories all have a copy of the v1.7.6.3
tag and the maint branch that the tag points at:

        url = git://repo.or.cz/alt-git.git
        url = https://code.google.com/p/git-core/
        url = git://git.sourceforge.jp/gitroot/git-core/git.git
        url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
        url = https://github.com/gitster/git

Git v1.7.6.3 Release Notes
==========================

Fixes since v1.7.6.2
--------------------

 * "git -c var=value subcmd" misparsed the custom configuration when
   value contained an equal sign.

 * "git fetch" had a major performance regression, wasting many
   needless cycles in a repository where there is no submodules
   present. This was especially bad, when there were many refs.

 * "git reflog $refname" did not default to the "show" subcommand as
   the documentation advertised the command to do.

 * "git reset" did not leave meaningful log message in the reflog.

 * "git status --ignored" did not show ignored items when there is no
   untracked items.

 * "git tag --contains $commit" was unnecessarily inefficient.

Also contains minor fixes and documentation updates.
