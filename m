From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.9.4
Date: Fri, 30 May 2014 14:52:32 -0700
Message-ID: <xmqqmwdz6ijj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri May 30 23:52:49 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WqUjJ-0005vY-9T
	for glk-linux-kernel-3@plane.gmane.org; Fri, 30 May 2014 23:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934869AbaE3Vwl (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 May 2014 17:52:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51728 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbaE3Vwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2014 17:52:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A47CD1B63F;
	Fri, 30 May 2014 17:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	euTU7iWJPi/jZVmrvx7HdB+A0k=; b=LCTArkpmL9CDQU5OYNNUGcQkoaHAGowTx
	wfhJVIpYqo8zPpb7GU56FKAWUCbwYtw0FOg3iXCeA6LyyMirOdvVLlymAF5nzCPZ
	0pOIQhQJTybP6kO9lo84++cyZU6LXdJupjB9USVU0/OgqO4CUVFabWUCFFV3WH5J
	+Xg/fwjwBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=nZu8estDdx//d0xbp6DN7zyzRpF1TSiVIEopk8GV8N5LjsxccGXBKQ+Z
	dItuo0fMIfZhJTw1zNqSJfpJcwixE37vPv7EXcW/WBGQTzk1cUGT8gkCwjbi8pk/
	KTNyFj4LJKvyubPoMFeFHRxWRMlDvd0jEInLcIgRbVcAocZZ1Xg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 990C11B63E;
	Fri, 30 May 2014 17:52:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3453A1B63D;
	Fri, 30 May 2014 17:52:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B4EF274A-E844-11E3-8731-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250491>

A maintenance release Git v1.9.4 is now available at the usual
places.  This is expected to be the final maintenance release for
the 1.9 series, merging the remaining fixes that are relevant and
are already in 2.0.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v1.9.4'
tag and the 'maint-1.9' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.9.4 Release Notes
========================

Fixes since v1.9.3
------------------

 * Commands that take pathspecs on the command line misbehaved when
   the pathspec is given as an absolute pathname (which is a
   practice not particularly encouraged) that points at a symbolic
   link in the working tree.

 * An earlier fix to the shell prompt script (in contrib/) for using
   the PROMPT_COMMAND interface did not correctly check if the extra
   code path needs to trigger, causing the branch name not to appear
   when 'promptvars' option is disabled in bash or PROMPT_SUBST is
   unset in zsh.
