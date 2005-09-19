From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 10:00:29 -0500
Message-ID: <d120d50005091908001e8339fd@mail.gmail.com>
References: <200509172141.31591.dtor_core@ameritech.net>
	 <Pine.LNX.4.58.0509181009160.26803@g5.osdl.org>
	 <200509181254.14646.dtor_core@ameritech.net>
	 <200509182333.58227.dtor_core@ameritech.net>
	 <Pine.LNX.4.58.0509190747210.9106@g5.osdl.org>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 17:03:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHN8H-00007V-8j
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 17:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVISPAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 11:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVISPAe
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 11:00:34 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:45479 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932450AbVISPAd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 11:00:33 -0400
Received: by qproxy.gmail.com with SMTP id v40so183143qbe
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 08:00:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G0Kbx6BetVsnuXlFvcS7nbgfU4MiLBrUxO8tYE9oZ6n9RA707/Advw8pcy23242R+LtRCUC48vGe7DRDNQphXSJAmdIls1VJQQQrvHwapYWwxSb1EdHolJUXq2vVvmJZjWdsZqaL7CFGEbFGRLqyOophHpQJCvpSBXRP8ajHRHo=
Received: by 10.64.180.14 with SMTP id c14mr46751qbf;
        Mon, 19 Sep 2005 08:00:29 -0700 (PDT)
Received: by 10.64.184.10 with HTTP; Mon, 19 Sep 2005 08:00:29 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509190747210.9106@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8874>

On 9/19/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Sun, 18 Sep 2005, Dmitry Torokhov wrote:
> >
> > Couple more points - just using rsync to get the data (without using git)
> > does not not produce that wierd directory, only got clone does.
> 
> Does a plain "git-init-db" in a newly created empty directory do the same?
> There was a bug (a long time ago)  that created garbage instead of the
> template files, I think.
> 

Will test once get home...

> Also, is there something inside of the garbage subdirectory?
> 

No, they are always empty.

-- 
Dmitry
