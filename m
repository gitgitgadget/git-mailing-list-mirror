From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: git-rev-list: add "--dense" flag
Date: Tue, 25 Oct 2005 20:07:07 +0200
Message-ID: <20051025180707.GA7463@diku.dk>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 20:10:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUTCg-00048b-GI
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 20:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVJYSHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 14:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVJYSHK
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 14:07:10 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:50163 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932276AbVJYSHJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 14:07:09 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 937C56DFFBF; Tue, 25 Oct 2005 20:07:02 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 58D976DFF9E; Tue, 25 Oct 2005 20:07:02 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A208E61140; Tue, 25 Oct 2005 20:07:07 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10605>

Linus Torvalds <torvalds@osdl.org> wrote Fri, Oct 21, 2005:
> To see this in action, try something like
> 
> 	gitk --dense -- gitk
> 
> to see just the history that affects gitk.

Is the initial commit supposed to be listed when the file has been added
later? I would expect it to only list until (and including) the commit
where the file was introduced.

	prompt > git-rev-list --dense HEAD -- compat/mmap.c
	f48000fcbe1009c18f1cc46e56cde2cb632071fa
	730d48a2ef88a7fb7aa4409d40b1e6964a93267f
	e83c5163316f89bfbde7d9ab23ca2e25604af290
	prompt > git-cat-file commit e83c
	tree 2b5bfdf7798569e0b59b16eb9602d5fa572d6038
	author Linus Torvalds <torvalds@ppc970.osdl.org> 1112911993 -0700
	committer Linus Torvalds <torvalds@ppc970.osdl.org> 1112911993 -0700

	Initial revision of "git", the information manager from hell

Interestingly, for the special gitk, the correct commit is the last rev
listed.

-- 
Jonas Fonseca
