From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Parseable commit header
Date: Sun, 17 Apr 2005 08:57:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504170856470.7211@ppc970.osdl.org>
References: <20050417062236.GA3261@scotty.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNC4G-00067I-NC
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVDQPz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDQPz5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:55:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:12220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbVDQPzw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:55:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HFtls4030872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 08:55:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HFtjXw024420;
	Sun, 17 Apr 2005 08:55:47 -0700
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
In-Reply-To: <20050417062236.GA3261@scotty.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Stefan-W. Hahn wrote:
> 
> after playing a while with git-pasky it is a crap to interpret the date of
> commit logs. Though it was a good idea to put the date in a parseable format
> (seconds since), but the format of the commit itself is not good parseable.

Actually, it is. The commit stuff removes all special characters from the 
strings, so '<' and '>' around the email do indeed act as delimiters, and 
cannot exist anywhere else.

			Linus
