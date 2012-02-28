From: Junio C Hamano <gitster@pobox.com>
Subject: Incremental updates to What's cooking
Date: Mon, 27 Feb 2012 22:53:16 -0800
Message-ID: <7vy5rn1mar.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 07:53:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Gw9-0000a8-Gi
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 07:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab2B1GxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 01:53:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab2B1GxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 01:53:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB1064283;
	Tue, 28 Feb 2012 01:53:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	YP83X5q/qqJI8498tJEMGGPfvw=; b=Vp2yqZbc558zMwkGrUhfiKTB44iPwFNGK
	zZDGApCY1xKAmh4qNNKCLcOQPxbmAnp4mOD6ipdKeSX2nsqMwG0uHHwwR1iRX2OH
	01mKd86jKZsLrPPTW6ioAxZtDt2PI8GcNCKPXhL+5go7j1GISddUyKWBrg+efwI9
	N0311xyUdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=PNuQfpgWHbYWhX4KzUPygNCIeEbWwCqwOjerJz/rVlQb8i+q81UughGI
	wkxREkAhW9mImUJXjbYtLPFPdoEuSGDC2BlTW8ZQEB9iAUx54rZnNEzZHUaXCZRO
	lGHYaMZW6xq4tFmvukUYKNNmcT5fTUdv5T4WLnmLjt+tCSnWFI8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1C614282;
	Tue, 28 Feb 2012 01:53:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1278B4281; Tue, 28 Feb 2012
 01:53:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E508441A-61D8-11E1-A396-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191700>

It is a bit too much to keep sending the full report every night, so I'll
send out some highlights since issue #09 of this month for tonight.

Short term plans
----------------

Will merge to "master".
 + jb/required-filter                     02-17/02-26    #1
 + ph/cherry-pick-advice-refinement       02-22/02-26    #1
 + pj/completion-remote-set-url-branches  02-22/02-26    #2

Will merge to "next"
 - cn/maint-branch-with-bad               02-27          #1
 - jk/symbolic-ref-short                  02-27          #1

Will merge to "next", perhaps?
 - jn/gitweb-hilite-regions               02-26          #4
 - th/git-diffall                         02-27          #1


Notable topics that may need more discussion
--------------------------------------------

I will not list the stalled topics here and harrass owners of them here.

* zj/diff-stat-dyncol (2012-02-27) 11 commits
 - diff --stat: add config option to limit graph width
 - diff --stat: enable limiting of the graph part
 - diff --stat: add a test for output with COLUMNS=40
 - diff --stat: use a maximum of 5/8 for the filename part
 - merge --stat: use the full terminal width
 - log --stat: use the full terminal width
 - show --stat: use the full terminal width
 - diff --stat: use the full terminal width
 - diff --stat: tests for long filenames and big change counts
 - t4014: addtional format-patch test vectors
 - Merge branches zj/decimal-width, zj/term-columns and jc/diff-stat-scaler

I resurrected the additional tests for format-patch from an earlier round,
as it illustrates the behaviour change brought by "5/8 split" very well.

* nd/columns (2012-02-26) 11 commits
 - tag: add --column
 - column: support piping stdout to external git-column process
 - status: add --column
 - branch: add --column
 - help: reuse print_columns() for help -a
 - column: add column.ui for default column output settings
 - column: support columns with different widths
 - column: add columnar layout
 - Stop starting pager recursively
 - Add git-column and column mode parsing
 - column: add API to print items in columns

Comments by Ramsay on the parsing code seemed reasonable.

* cb/fsck-squelch-dangling (2012-02-26) 1 commit
 - fsck: do not print dangling objects by default

Introduces "fsck --dangling" and removes the output for dangling objects
from the default output.

The first patch to advance this topic should add --[no-]dangling option
and update the documentation to illustrate its use.  On top of that, if we
were to change the default not to show the dangling objects, deprecation
patches that span longer timeperiod need to be built, but the follow-on
patches and the default change may not be necessary, given that the
command is "fsck".

* rs/no-no-no-parseopt (2012-02-26) 3 commits
 - parse-options: remove PARSE_OPT_NEGHELP
 - parse-options: allow positivation of options starting, with no-
 - test-parse-options: convert to OPT_BOOL()

Options that use PARSE_OPT_NEGHELP needed to word their help text in
a strange way, and this gets rid of the uses of them.

I tend to agree with Peff that REVERSE_BOOL or NEGBIT based solution may
be more readable in the longer term. As the options that used the funny
NEGHELP are limited, the difference between two approaches may not matter
too much, but then that argues against fixing the funny help messages,
so...
