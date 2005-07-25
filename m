From: Marco Costalba <mcostalba@yahoo.it>
Subject: Fwd: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 14:39:33 -0700 (PDT)
Message-ID: <20050725213933.34939.qmail@web26308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Jul 25 23:39:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxAfo-0007QW-Om
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 23:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVGYVji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGYVji
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 17:39:38 -0400
Received: from web26308.mail.ukl.yahoo.com ([217.146.176.19]:35244 "HELO
	web26308.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261448AbVGYVjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 17:39:37 -0400
Received: (qmail 34941 invoked by uid 60001); 25 Jul 2005 21:39:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kcwFVli9s0YM2crW4LuGQU9OdZn9L73SiT5yU+V+RNcgfle648XaAW0hIx2bpE5WcjRc+O0UF4tN+C/4nYe/IwV0xwy5J+TDywR6sZf5GTh3OV13UMWQINcy66LEMAF0HShW2koRxLSH7+lGhonaOQy/lS9kmEfApjliDslzms8=  ;
Received: from [151.42.103.53] by web26308.mail.ukl.yahoo.com via HTTP; Mon, 25 Jul 2005 14:39:33 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



--- Marco Costalba <mcostalba@yahoo.it> wrote:

> Date: Mon, 25 Jul 2005 14:34:56 -0700 (PDT)
> From: Marco Costalba <mcostalba@yahoo.it>
> Subject: Re: [RFC] extending git-ls-files --exclude.
> To: Junio C Hamano <junkio@cox.net>
> CC: Linus Torvalds <torvalds@osdl.org>, 
>     Catalin Marinas <catalin.marinas@gmail.com>, Petr Baudis <pasky@suse.cz>
> 
> Junio C Hamano wrote:
> 
> >Linus Torvalds <torvalds@osdl.org> writes:
> >
> >>On Mon, 25 Jul 2005, Junio C Hamano wrote:
> >>
> >I imagined it, but it appears to me that this is a bad example.
> >My understanding of what Catalin and the proposed patch
> >disagrees is whether the patterns in .gitignore at the top level
> >should govern files under ppc/ and mozilla-sha1/ subdirectories;
> >Catalin thinks they should not.
> >
> >What I meant by "cumulative" (now I realize I might have
> >misunderstood what Pasky wanted to mean by that word, though)
> >was not just .gitignore in subdirectory being added, but the
> >effect of patterns being added so far, either from the command
> >line or by parent directories, last while in the deeper
> >directories.
> >
> 
> This cumulative effect brakes local scoping of .gitignore files in 
> corresponding subdirectory.
> 
> As example in a directory A we can have a .gitignore file with
> 
> !foo.html
> *.html
> 
> because we want to special case 'that' foo.html 
> in 'that' directory.
> 
> If for any reason in any of part of subdirectories tree
> with base A there is (or there will be in the future) another
>  foo.html this will be automatically special cased because
>  of cumulative adding of patterns.
> 
> This can be powerful and flexible but also prone to errors. 
> 
> Peraphs can be better to use just one file with global scope
> (as example .git/exclude) and all the others .gitignore files
> with scope local to their directory.
> 
> 
> Marco
> 
> 
> 
> 
> 
> 
> 
> 		
> ____________________________________________________
> Start your day with Yahoo! - make it your home page 
> http://www.yahoo.com/r/hs 
>  
> 



		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
