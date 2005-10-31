From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Question on GIT usage.
Date: Mon, 31 Oct 2005 15:42:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311540300.27915@g5.osdl.org>
References: <4362C700.6020901@candelatech.com> <Pine.LNX.4.64.0510311749080.25300@iabervon.org>
 <Pine.LNX.4.64.0510311520190.27915@g5.osdl.org> <Pine.LNX.4.64.0510311821410.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Greear <greearb@candelatech.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 00:43:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWjIY-0000zt-Vl
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 00:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVJaXmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 18:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVJaXmi
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 18:42:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964854AbVJaXmh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 18:42:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VNgZW6024643
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 15:42:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VNgY34003800;
	Mon, 31 Oct 2005 15:42:34 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510311821410.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10900>



On Mon, 31 Oct 2005, Daniel Barkalow wrote:
> 
> Oh, that reminds me: is there a simple way to merge a branch with another 
> local branch or remote branch that's already up-to-date? E.g., I've 
> already fetched the latest git from kernel.org, built it, and installed 
> it. Now I want to merge my development branch with that. Last time I was 
> looking, I had to write the message for the merge myself, unlike "pull", 
> which takes care of that.

Umm.. Why don't you just use "pull"?

I _think_ you should be able to just do

	git pull <repodir> <branchname>

where <repodir> can even be just "." for the very same repository.

I've not tested it, but dammit, it should work. If it doesn't, it's a bug.

		Linus
