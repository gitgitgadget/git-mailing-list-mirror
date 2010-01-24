From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/7] clarify 'git merge' documentation
Date: Sun, 24 Jan 2010 14:25:06 +0100
Message-ID: <201001241425.07027.trast@student.ethz.ch>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 14:25:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ2Sz-0000BI-DK
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 14:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883Ab0AXNZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 08:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548Ab0AXNZU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 08:25:20 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:10240 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab0AXNZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 08:25:17 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 24 Jan
 2010 14:25:15 +0100
Received: from thomas.localnet (129.132.209.202) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 24 Jan
 2010 14:25:10 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <20100123092551.GA7571@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137895>

On Saturday 23 January 2010 10:25:51 Jonathan Nieder wrote:
> Jonathan Nieder (7):
>   Documentation: merge: move configuration section to end
>   Documentation: suggest `reset --merge` in How Merge Works section
>   Documentation: merge: move merge strategy list to end
>   Documentation: merge: add an overview
>   Documentation: emphasize when git merge terminates early
>   Documentation: merge: add a section about fast-forward
>   Documentation: simplify How Merge Works
[and in the other thread]
> Jonathan Nieder (1):
>   Documentation: merge: use MERGE_HEAD to refer to the remote branch

Thanks Jonathan!  Ack on all of them.

I still had the following patches in my little documentation queue:

  Jonathan Nieder (2):
    Documentation: git gc packs refs by default now
    Documentation: tiny git config manual tweaks

  Thomas Rast (2):
    Documentation: show-files is now called git-ls-files
    Documentation: emphasise 'git shortlog' in its synopsis

I actually forgot to post the last one, which I'll do shortly, but
it's trivial so I just included it at the bottom.

Junio, I gathered all of the above patches and pushed them again to

  git://repo.or.cz/git/trast.git doc-style/for-next

If that's ok and you merge it, I'll declare this the end of this
little topic.  Admittedly it grew a bit outside the original area of
style fixes into a half-rewrite of git-merge(1).



-- 8< --
Subject: [PATCH] Documentation: emphasise 'git shortlog' in its synopsis

The accepted style in the SYNOPSIS section is for a command to be
'emphasised'.  Do so for the git-shortlog(1) manpage.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index ecf9e27..dfd4d0c 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
-git shortlog [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] [<committish>...]
+'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] [<committish>...]
 
 DESCRIPTION
 -----------
-- 
Thomas Rast
trast@{inf,student}.ethz.ch
