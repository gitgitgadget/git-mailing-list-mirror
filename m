From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] init-db.c: normalize env var handling.
Date: Tue, 19 Apr 2005 21:45:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504192142040.6467@ppc970.osdl.org>
References: <mailbox-1242-1113971319-971926@spoon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:39:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6zr-0008Nx-0p
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVDTEnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDTEnn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:43:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:21939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261382AbVDTEnk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 00:43:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3K4hcs4019686
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 21:43:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3K4hb7G018711;
	Tue, 19 Apr 2005 21:43:38 -0700
To: Zach Welch <zw@superlucidity.net>
In-Reply-To: <mailbox-1242-1113971319-971926@spoon>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Zach Welch wrote:
>
> This patch applies on top of:
>         [PATCH 1/3] init-db.c: cleanup comments
> 
>  init-db.c |   11 +++--------
>  1 files changed, 3 insertions(+), 8 deletions(-)
> 
> Signed-Off-By: Zach Welch <zw@superlucidity.net>
> 
> Normalize init-db environment variable handling, allowing the creation
> of object directories with something other than DEFAULT_DB_ENVIRONMENT.
> 
> --- a/init-db.c
> +++ b/init-db.c

For future reference, this is in the wrong order.

You should have "checkin comment" first, then "signed-off-by", then a line 
with three dashes, and then "administrative trivia".

Ie I'd much rather see the email look like

	Normalize init-db environment variable handling, allowing the creation
	of object directories with something other than DEFAULT_DB_ENVIRONMENT.
	
	Signed-Off-By: Zach Welch <zw@superlucidity.net>
	---
	This patch applies on top of:
	        [PATCH 1/3] init-db.c: cleanup comments
	
	 init-db.c |   11 +++--------
	 1 files changed, 3 insertions(+), 8 deletions(-)
	
	.. actual patch goes here ..

since otherwise I'll just have to edit it that way. I like seeing the 
administrative stuff (diffstat etc), but I don't want to have it in the 
commit message, and that's exactly what the "---" marker is for - my tools 
will automatically cut it off as if it was a signature (or the beginning 
of the patch).

		Linus
