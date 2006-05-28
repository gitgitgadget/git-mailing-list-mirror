From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Remote git-cat-file?
Date: Sat, 27 May 2006 17:29:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271727110.5623@g5.osdl.org>
References: <loom.20060528T002420-957@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 02:30:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk9B4-0003vD-7G
	for gcvg-git@gmane.org; Sun, 28 May 2006 02:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWE1Aaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 20:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWE1Aaj
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 20:30:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965016AbWE1Aai (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 20:30:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4S0TR2g001288
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 May 2006 17:29:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4S0TQtb021373;
	Sat, 27 May 2006 17:29:26 -0700
To: Elrond <elrond+kernel.org@samba-tng.org>
In-Reply-To: <loom.20060528T002420-957@post.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20873>



On Sat, 27 May 2006, Elrond wrote:
> 
> Is it possible via the git: protocol to do a git-cat-file?
> 
> To download just one object by its ID?

Nope. 

Well, depending on just how much you know about the object, you can fake 
it. For example, if you already know it's a commit, and you know the 
parents, then yes, you can download it by basically saying that you want 
that particular object and you already have the parents.

But in the general case, the answer is no. Set up a gitweb thing, and look 
up the objects that way. Or just pull the repo, and look at it locally.

Just out of interest, why would you ever want to just look at a single 
object?

		Linus
