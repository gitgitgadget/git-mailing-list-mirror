From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Improve git-rev-list memory usage further
Date: Fri, 16 Sep 2005 14:42:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509161434070.26803@g5.osdl.org>
References: <Pine.LNX.4.58.0509161423400.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 16 23:44:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGNzB-0002tT-I2
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 23:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVIPVnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 17:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVIPVnG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 17:43:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751301AbVIPVnF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 17:43:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GLguBo018933
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 14:42:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GLgtBE014795;
	Fri, 16 Sep 2005 14:42:55 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509161423400.26803@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8735>



On Fri, 16 Sep 2005, Linus Torvalds wrote:
>
> Before:
> 	42934 minor pagefaults
>
> After:
> 
> 	26718 minor pagefaults

In case it wasn't clear, this is all in _addition_ to the previous fixes. 
It used to be ~48,000 pagefaults.

Still some low-hanging fruit to go after this. Object refs next, that will 
bring it down to ~18,500 pages for this load.

		Linus
