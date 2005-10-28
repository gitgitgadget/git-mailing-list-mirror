From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Fri, 28 Oct 2005 14:08:13 +1300
Message-ID: <46a038f90510271808n36a75676y9f50109db43b5ab@mail.gmail.com>
References: <20051027203945.GC1622@pe.Belkin>
	 <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
	 <20051027234813.GA512@pe.Belkin>
	 <Pine.LNX.4.64.0510271709120.4664@g5.osdl.org>
	 <20051028005029.GA2654@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 03:09:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVIjD-0001ra-UV
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 03:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVJ1BIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 21:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVJ1BIO
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 21:08:14 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:25370 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965024AbVJ1BIO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 21:08:14 -0400
Received: by xproxy.gmail.com with SMTP id h30so98201wxd
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 18:08:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gBLNkPywOxhkRwQrjn7iXGfVnHk8rA18vupyPBTZcXnaC3Cmch1H6xcrWGHSx+Yor+0TMa00wMiAyOQkexKXp6IbkLulz/Kn+63HV2+TuSE5Hq7OzqrgedP5SwY/lfyMMzm7c1eaEodn/FpcQgrj7PPjy/1ESyh6byv25Nz1jDc=
Received: by 10.64.199.12 with SMTP id w12mr2086370qbf;
        Thu, 27 Oct 2005 18:08:13 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Thu, 27 Oct 2005 18:08:13 -0700 (PDT)
To: Chris Shoemaker <c.shoemaker@cox.net>
In-Reply-To: <20051028005029.GA2654@pe.Belkin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10733>

On 10/28/05, Chris Shoemaker <c.shoemaker@cox.net> wrote:
> So, what's the best way to detect merges?  Maybe see if
> 'git-cat-file commit $hash | grep ^parent | wc -l' is greater than 1?
>
> > That's where caching might save your *ss.
>
> Ok, but that cache would live inside GIT_DIR an be shared with gitk,
> right?

gitweb should have any caches it wants, regardless of gitk, methinks.

I very rarely run gitk and gitweb on the same repo. The repos where I
run gitk are all development repos, on my desktop machine or laptop.
gitweb runs only on the webserver where I publish those...

So it may be practical to have a common cache format, but unlikely
that both programs will use the same cached data in practice...


martin
