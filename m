From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: add "--dense" flag
Date: Tue, 25 Oct 2005 11:52:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251150580.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
 <20051025180707.GA7463@diku.dk> <Pine.LNX.4.64.0510251110050.10477@g5.osdl.org>
 <20051025184030.GB7463@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 20:54:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUTuS-0007n8-4R
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 20:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVJYSw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 14:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVJYSw3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 14:52:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932300AbVJYSw2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 14:52:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9PIqMFC013060
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 11:52:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9PIqHup023681;
	Tue, 25 Oct 2005 11:52:19 -0700
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20051025184030.GB7463@diku.dk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10609>



On Tue, 25 Oct 2005, Jonas Fonseca wrote:
> 
> Without the workaround below it segfaults.

Yes, but your patch only partly helps. It fixes the SIGSEGV, but it still 
needs to remove the "parents" pointer when the parent ends up NULL.

The patch I just sent out should be better. I think.

			Linus
