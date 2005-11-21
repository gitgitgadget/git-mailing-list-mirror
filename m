From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Diffs "from" working directory
Date: Mon, 21 Nov 2005 21:28:53 +0000
Message-ID: <b0943d9e0511211328j7c062c07s@mail.gmail.com>
References: <200511201817.15780.blaisorblade@yahoo.it>
	 <20051120174359.GA24177@fieldses.org>
	 <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>
	 <20051120205855.GA30346@fieldses.org>
	 <4381287F.5080402@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Blaisorblade <blaisorblade@yahoo.it>,
	Chuck Lever <cel@netapp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:31:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJDe-0005Cm-Vi
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVKUV2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKUV2z
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:28:55 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:11034 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbVKUV2y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:28:54 -0500
Received: by xproxy.gmail.com with SMTP id i30so733389wxd
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 13:28:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gWgvcD6mJgXS/BwC11Rw4bQBJ/tY30RyDxJItBkrr80XwV6T2RVNORBqZXmItKbowyYzba3FsS4orElqxtj80+2y7x3VC6FQIa5yynBOWSVVum/aHIjkMlFiTb0cjMlRXQMCY0qT+3222tdAQPCarPgo5nC0OwMTTQ7HDNAmIPc=
Received: by 10.70.128.4 with SMTP id a4mr2674914wxd;
        Mon, 21 Nov 2005 13:28:53 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Mon, 21 Nov 2005 13:28:53 -0800 (PST)
To: cel@citi.umich.edu
In-Reply-To: <4381287F.5080402@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12484>

On 21/11/05, Chuck Lever <cel@citi.umich.edu> wrote:
> J. Bruce Fields wrote:
> > A "-R" option to "stg diff" would be convenient, sure.--b.
>
> that might be an even more intuitive way to dig out what is wanted.

I also like the idea of having a -R option (--reverse the long
version). This would mean reversing the commit that changed the diff
-r option.

> btw, catalin, this was bruce's patch.  i'm not sure why i was listed as
> the author (probably a mistake of mine when i imported his patch into my
> repository).  ah well.

My import command sets the author to the e-mail sender, which was you.
Maybe this should be changed but I don't know which option is better.
In the meantime, you can change the default e-mail template to set the
From: line with to the author of the patch and maybe add a Reply-to:
with your address.

--
Catalin
