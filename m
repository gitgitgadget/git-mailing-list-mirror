From: Jeff King <peff@peff.net>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Tue, 11 Dec 2007 07:33:12 -0500
Message-ID: <20071211123312.GA14965@sigill.intra.peff.net>
References: <20071207093439.GA21896@elte.hu> <200712080636.12982.chriscool@tuxfamily.org> <20071211092446.GA4703@elte.hu> <20071211092916.GF30948@artemis.madism.org> <m3ve75sfn3.fsf@roke.D-201> <20071211115914.GJ30948@artemis.madism.org> <20071211122539.GA13945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J24Iu-0003Ar-Ss
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXLKMdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbXLKMdP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:33:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2354 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbXLKMdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:33:15 -0500
Received: (qmail 13656 invoked by uid 111); 11 Dec 2007 12:33:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 11 Dec 2007 07:33:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2007 07:33:12 -0500
Content-Disposition: inline
In-Reply-To: <20071211122539.GA13945@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67845>

On Tue, Dec 11, 2007 at 07:25:39AM -0500, Jeff King wrote:

> $ git show 4602c17d
> commit 4602c17d8911e14d537f6f87db02faab6e3f5d69
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Fri Dec 7 17:19:31 2007 -0800
> 
>     git-shortlog -e: show e-mail address as well
> 
>     This option shows the author's email address next to the name.
> 
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

And here is a matching documentation patch. I know, it's not a v1.5.4
bugfix, but hopefully it should be easy to review. ;)

-- >8 --
shortlog: document -e option

This was added in 4602c17d.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 2220ef6..e14720b 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s]
-git-shortlog [-n|--numbered] [-s|--summary] [<committish>...]
+git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s] [-e]
+git-shortlog [-n|--numbered] [-s|--summary] [-e|--email] [<committish>...]
 
 DESCRIPTION
 -----------
@@ -32,6 +32,9 @@ OPTIONS
 -s, \--summary::
 	Suppress commit description and provide a commit count summary only.
 
+-e, \--email::
+	Show the email address of each author.
+
 FILES
 -----
 
-- 
1.5.3.7.2224.ge4a5
