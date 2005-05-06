From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Tweak git-diff-tree -v output further.
Date: Fri, 6 May 2005 14:54:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505061451530.2233@ppc970.osdl.org>
References: <7vd5s4cfzq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 23:46:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUAdi-0000y2-Fw
	for gcvg-git@gmane.org; Fri, 06 May 2005 23:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVEFVwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 17:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVEFVwb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 17:52:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:36534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261288AbVEFVw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 17:52:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j46LqMU3004762
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 14:52:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j46LqL16000521;
	Fri, 6 May 2005 14:52:21 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5s4cfzq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 6 May 2005, Junio C Hamano wrote:
> 
> This adds the full header information to git-diff-tree -v output
> in addition to the log message it already produces.

I don't actually like the git internal commit format, it's not very 
readable. It's designed to be nicely readable by machines, not humans.

If you want machine-readable output, you shouldn't use "-v" (or probably
-p either) anyway, you'd be better off with the raw file changes.

> Maybe we want to stop indenting so that it matches what
> git-export produces better.

Again, it's indented so that it's human-readable, and I was planning on
adding _some_ human-readable output from the headers (author and a
human-readable date or something).

		Linus
