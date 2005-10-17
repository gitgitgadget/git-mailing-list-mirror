From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Mon, 17 Oct 2005 16:19:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510171617460.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
 <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org>
 <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
 <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net> <20051016213341.GF5509@reactrix.com>
 <7vwtkd6rik.fsf@assigned-by-dhcp.cox.net> <20051017060659.GH5509@reactrix.com>
 <7voe5o366d.fsf@assigned-by-dhcp.cox.net> <20051017174123.GI5509@reactrix.com>
 <7v3bmzzz30.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510171830030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 01:21:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EReH4-0003am-K1
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 01:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVJQXUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 19:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVJQXUF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 19:20:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932327AbVJQXUC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 19:20:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9HNJrFC024127
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Oct 2005 16:19:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9HNJquP016933;
	Mon, 17 Oct 2005 16:19:53 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510171830030.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10198>



On Mon, 17 Oct 2005, Daniel Barkalow wrote:
> 
> Wouldn't "git fetch http://.../foo.git/ master^{tree}" do the right thing?

The pack pullers have trouble with anything that isn't commit-based, 
because they do all the "figure out what we have in common" logic based on 
the commit history.

So if you fetch a tree, it by definition doesn't _have_ any history, and 
the pack pullers will always pack the whole tree. I think.

		Linus
