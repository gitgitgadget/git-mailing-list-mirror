From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.0.4
Date: Wed, 30 Jul 2014 15:40:48 -0700
Message-ID: <xmqqfvhixyfj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jul 31 00:41:13 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XCcYa-0003dz-4q
	for glk-linux-kernel-3@plane.gmane.org; Thu, 31 Jul 2014 00:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbaG3Wk7 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 30 Jul 2014 18:40:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60228 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbaG3Wk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2014 18:40:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 766FB2CE1D;
	Wed, 30 Jul 2014 18:40:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	cHViPi4tMCJDQ/lQ6UwHkkinZ8=; b=CWnOKkVdwakBEMDKOpkemQL4P3T/kLwBv
	KbYGDgKUbv3go7+Ens3Ww1pO9RMeOk5YjzqdJ55vNPQlL5OcFhSYUjjjad1h+F2S
	7LR/RfcqC7ClZ3+nxDfzhrfqITSfCM37T93Ai+1R5XYEqXeGldDwdwLnf0KSt5bO
	CmwCUsAfbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=LP4+P9rz0RtTmBNBgTVt3vzstwaVnPFLhrUfIMI/zE2dr/otObJmgkkg
	6va2k12TBqy7MddLDTP573SOue1+3tefCyG6MetZwrwfugCeA/q4yA3ugNR6i4w3
	PlVMgsolYp4rPIJL18k4XaXax9P3CIP/1wbF8t4l9Qck9eYDptQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BFF22CE1C;
	Wed, 30 Jul 2014 18:40:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 04D7A2CE15;
	Wed, 30 Jul 2014 18:40:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8E2B2B7E-183A-11E4-8BDF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254530>

The latest maintenance release Git v2.0.4 is now available at
the usual places.

This is primarily to fix a regression of "git diff-tree" in v2.0.2.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.0.4'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v2.0.4 Release Notes
========================

 * An earlier update to v2.0.2 broken output from "git diff-tree",
   which is fixed in this release.

----------------------------------------------------------------

Changes since v2.0.3 are as follows:

Fabian Ruch (1):
      commit --amend: test specifies authorship but forgets to check

Jeff King (8):
      alloc: write out allocator definitions
      move setting of object->type to alloc_* functions
      parse_object_buffer: do not set object type
      add object_as_type helper for casting objects
      alloc: factor out commit index
      object_as_type: set commit index
      diff-tree: avoid lookup_unknown_object
      t4013: test diff-tree's --stdin commit formatting

Junio C Hamano (1):
      Git 2.0.4

Ramsay Allan Jones (1):
      alloc.c: remove the alloc_raw_commit_node() function
