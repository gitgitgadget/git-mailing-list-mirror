From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-whatchanged does not show merge result?
Date: Fri, 14 Oct 2005 10:13:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510141007290.23590@g5.osdl.org>
References: <4dd15d180510140929x2c69f61ag19a1409cfd993e7b@mail.gmail.com>
 <4dd15d180510140933j7a730c49hb9cdaa98ea0a5b07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 19:14:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQT7N-0005Ie-1C
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 19:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVJNRNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 13:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVJNRNM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 13:13:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750801AbVJNRNM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 13:13:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9EHD84s005354
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Oct 2005 10:13:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9EHD87j008687;
	Fri, 14 Oct 2005 10:13:08 -0700
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <4dd15d180510140933j7a730c49hb9cdaa98ea0a5b07@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10114>



On Fri, 14 Oct 2005, David Ho wrote:
> 
> Maybe someone can clear up a confusion I have with git-whatchanged.
> I created a new repo with just one file hello, split out a new branch "mybranch.
> When I merged back the changes from mybranch, git-whatchanged -p did
> not should the diff of the merge.

You can use the "-m" flag to show merges. HOWEVER, it's not very useful 
in general, although it _is_ useful on a file-by-file basis. 

What "-m" does is that it will show diffs against each parent, which is 
_sometimes_ what you want. Try it.

		Linus
