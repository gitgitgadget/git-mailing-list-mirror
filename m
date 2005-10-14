From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-whatchanged does not show merge result?
Date: Fri, 14 Oct 2005 11:39:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510141138030.23590@g5.osdl.org>
References: <4dd15d180510140929x2c69f61ag19a1409cfd993e7b@mail.gmail.com> 
 <4dd15d180510140933j7a730c49hb9cdaa98ea0a5b07@mail.gmail.com> 
 <Pine.LNX.4.64.0510141007290.23590@g5.osdl.org>
 <4dd15d180510141031n531b9e0enc8e7d668b1e61b83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 20:41:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQUSw-00067J-7N
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 20:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVJNSje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 14:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVJNSje
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 14:39:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750849AbVJNSje (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 14:39:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9EIdUFC010727
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Oct 2005 11:39:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9EIdUDU012575;
	Fri, 14 Oct 2005 11:39:30 -0700
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <4dd15d180510141031n531b9e0enc8e7d668b1e61b83@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.53__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10120>



On Fri, 14 Oct 2005, David Ho wrote:
>
> I was a little worried when I did git-whatchanged on a file and there
> was a hole in the history where the merge is.  This reassured me that
> all changes to the file is accessible (I'm sure they are all stored
> safely in the repo =).

Btw, "git-whatchanged" really _can_ hide real stuff, namely when nothing 
changed.

A commit that has no changes at all (which is quite possible) will never 
be shown by git-whatchanged. 

So in many ways, "git log" is the way to see all commits. 
"git-whatchanged" is really just a way to see the _changes_, and by 
defauly it ignores merges just because the changes are "complicated".

		Linus
