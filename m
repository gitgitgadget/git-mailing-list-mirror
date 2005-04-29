From: Morgan Schweers <mschweers@gmail.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 13:16:44 -0700
Message-ID: <b8464fde050429131677ae06d1@mail.gmail.com>
References: <20050429194753.GA14222@uglybox.localnet>
	 <200504291954.MAA27561@emf.net>
Reply-To: Morgan Schweers <mschweers@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tom Lord <lord@emf.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:30:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRc7G-0007Rc-7m
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVD2UUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVD2URw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:17:52 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:64123 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262948AbVD2UQy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:16:54 -0400
Received: by zproxy.gmail.com with SMTP id 13so815732nzp
        for <git@vger.kernel.org>; Fri, 29 Apr 2005 13:16:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jPE07xDWwucmtlw0fX0Ss8u4vzUIRvDLr7rJohQqOqnSXEjnaouo3AWCQ8QQwo7+g8ba7rbYqbiXqq1QIw/ivGBiPLwt6ZU6TRBNvLToYEtg1Uas6JS6ySpHcacypBg8Efgp3Ru7fQ664zL9ckO7DZCpPor6djXIga54mD0lGzE=
Received: by 10.36.72.20 with SMTP id u20mr238238nza;
        Fri, 29 Apr 2005 13:16:44 -0700 (PDT)
Received: by 10.36.9.13 with HTTP; Fri, 29 Apr 2005 13:16:44 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <200504291954.MAA27561@emf.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Greetings,

On 4/29/05, Tom Lord <lord@emf.net> wrote:
> 
> 
>   > Call me a naive git, but seems to me the "git way" is a little
>   > different. It's tree-based rather than diff-based, and doesn't involve
>   > passing diffs around, right?
> 
> Isn't that a significant part of what I said?  Go back and read more
> carefully, is my suggestion.
> 
>   > Or am I missing something?
> 
> Very much so.

It doesn't appear that he is.  You appeared to predicate your argument
on the 'auditor' believing a diff looks good, but getting a tree
instead, that might not reflect the diff.

Instead, in the git-world, the auditor actually gets a tree, and
produces the diff themselves, and then decides whether the diff looks
good enough to keep.

The argument about the high velocity of git-transfers causing the
inability to check doesn't appear to apply here, because the
distributed development environment of Linux says that the
'gatekeepers' ARE in fact validating the changes from people in their
area of expertise are good (or are relying on sub-gatekeepers), and
then Linus is trusting them completely.

This seems like the methodology that has been used up until now via bk
previously.  Git doesn't change that, and in fact supports that method
of development.

Your further suggestion that Linus could be replaced by a
patch-manager, in that case, got a chuckle from me at least, but the
more serious point is that Linus is necessary as the arbiter of who
actually receives the absolute trust of a gatekeeper.  He is, in
effect, a meta-gatekeeper.

> -t

In reading this conversation, it seems you're looking for a more
absolute standard of trust than the kernel developers are working
with.  I believe this is an example of 'good enough' process being
accepted, versus 'perfect' process.

--  Morgan Schweers
