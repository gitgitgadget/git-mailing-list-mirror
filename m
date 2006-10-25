X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] document the <tree ish> <file> blob reference syntax
Date: Wed, 25 Oct 2006 11:33:27 -0700
Message-ID: <7vwt6ob5zc.fsf@assigned-by-dhcp.cox.net>
References: <38fafea491402334df335c486270ebe9@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 18:34:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <38fafea491402334df335c486270ebe9@pinky> (Andy Whitcroft's
	message of "Wed, 25 Oct 2006 11:42:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30085>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcnZF-0005pE-3Y for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932267AbWJYSd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 14:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJYSd3
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:33:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50125 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S932267AbWJYSd2
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 14:33:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025183328.WPZJ12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 14:33:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eiZB1V00G1kojtg0000000 Wed, 25 Oct 2006
 14:33:11 -0400
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> It is possible to specify a specific file within a tree-ish
> symbolically.  For example you can find the contents of
> a specific file in a specific commit as below:
>
> 	git cat-file -p v1.2.4:git-prune.sh

Didn't we document this elsewhere recently in git-rev-parse?
How about this instead?

-- >8 --
[PATCH] Refer to git-rev-parse:Specifying Revisions from git.txt

The brief list given in "Symbolic Identifiers" section of the
main documentation is good enough for overview, but help the
reader to find a more comrehensive list as needed.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3af6fc6..b00607e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -562,6 +562,9 @@ HEAD::
 	a valid head 'name'
 	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
 
+For a more complete list of ways to spell object names, see
+"SPECIFYING REVISIONS" section in gitlink:git-rev-parse[1].
+
 
 File/Directory Structure
 ------------------------
-- 
1.4.3.2.gc1a4

