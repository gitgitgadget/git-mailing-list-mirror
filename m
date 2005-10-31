From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Question on GIT usage.
Date: Mon, 31 Oct 2005 15:21:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311520190.27915@g5.osdl.org>
References: <4362C700.6020901@candelatech.com> <Pine.LNX.4.64.0510311749080.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Greear <greearb@candelatech.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:22:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWixr-0006WQ-BR
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 00:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVJaXVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 18:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVJaXVQ
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 18:21:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932316AbVJaXVQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 18:21:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VNLCW6023649
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 15:21:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VNLBNl002607;
	Mon, 31 Oct 2005 15:21:12 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510311749080.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10897>



On Mon, 31 Oct 2005, Daniel Barkalow wrote:
> 
> The system will be unhappy if you commit to a branch that is checked out 
> elsewhere (because the head of that branch will change out from under the 
> checked out version), like having someone push to a repository with the 
> branch checked out.

Well, the good news is that a "git checkout -f" in the other trees will do 
the right thing (and only check out the files that have changed).

The bad news is that you need to remember to do that ;)

		Linus
