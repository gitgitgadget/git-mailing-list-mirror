From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Thu, 26 Apr 2007 20:59:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704262055270.9964@woody.linux-foundation.org>
References: <20070427034138.1646.15989.stgit@rover>
 <20070427034729.GU4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhHdM-0000aQ-7O
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXD0D7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 23:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbXD0D7i
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 23:59:38 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58537 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755248AbXD0D7h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2007 23:59:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3R3xUrR005159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Apr 2007 20:59:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3R3xT4e018753;
	Thu, 26 Apr 2007 20:59:30 -0700
In-Reply-To: <20070427034729.GU4489@pasky.or.cz>
X-Spam-Status: No, hits=-5.008 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45679>



On Fri, 27 Apr 2007, Petr Baudis wrote:
> 
> 	http://repo.or.cz/w?p=git.git&a=search&h=HEAD&st=grep&s=hate%5B%5Ev%5D

That looks bogus. It doesn't find

 - Documentation/git-cvsimport.txt:

	git-cvsimport - Salvage your data out of another SCM people love to hate

Why?

		Linus
