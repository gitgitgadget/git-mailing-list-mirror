From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Rewrite convert_to_{git,working_tree} to use strbuf's.
Date: Sun, 16 Sep 2007 11:27:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709161126020.16478@woody.linux-foundation.org>
References: <20070916172134.GA26457@artemis.corp>
 <20070916172233.90C9E1835B@madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 20:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWyr7-00017E-IL
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 20:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbXIPS2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 14:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbXIPS2H
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 14:28:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43144 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391AbXIPS2F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 14:28:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8GIRQ54029085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Sep 2007 11:27:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8GIRPkD027308;
	Sun, 16 Sep 2007 11:27:25 -0700
In-Reply-To: <20070916172233.90C9E1835B@madism.org>
X-Spam-Status: No, hits=-4.739 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.34__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 16 Sep 2007, Pierre Habouzit wrote:
..
>  7 files changed, 240 insertions(+), 317 deletions(-)

I like how all these patches seem to be removing more lines than 
they add.

The end result looks good from a visual standpoint too.

So:

	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

for the whole series.

		Linus
