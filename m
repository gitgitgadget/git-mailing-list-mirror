From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Mon, 9 Oct 2006 22:38:41 -0700 (PDT)
Message-ID: <20061010053841.42852.qmail@web31815.mail.mud.yahoo.com>
References: <7vy7ro7o3g.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 07:38:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXAKE-0008VY-0u
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 07:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWJJFin (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 01:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWJJFim
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 01:38:42 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:33366 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964994AbWJJFim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 01:38:42 -0400
Received: (qmail 42854 invoked by uid 60001); 10 Oct 2006 05:38:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NtQ3n3d1Z/6kmpVcJACGyGN+lSF81/o15WvtPgStCdUQ6ZLzMc0nYACpA9aOi8KesYxgDnSp3e5YeHMcEm9T6nzO2hQejnpI7L+f4NBQrtTKtpkYoh8eZtTFGNYCJ+5CJY4bBM/4Q4FFeVp9iymxZsZZ8Ej6OqncQl2LxSM2Yz8=  ;
Received: from [71.80.233.118] by web31815.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 22:38:41 PDT
To: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vy7ro7o3g.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28603>

--- Junio C Hamano <junkio@cox.net> wrote:
> Having said that, I agree to the point you are trying to make
> here.  It was a mistake to remove blob/tree links from the view
> that lists pathnames.
> 
> If we did not have any obviously clickable links on the right
> hand side it might have been a different story, but when given
> UNIXy permission bits, pathname and blame/history/raw links,
> nobody would think of clicking on the pathname itself to grab
> its contents.  The blame link would give you the same

I've seen the exact opposite.

BTW, what is our standard here? People with zero-computer
exposure? With some? With high?

Certainly, if I didn't know what a folder/directory/tree is,
and what a file is and I was told to "get" that file, the first
thing I'd do when I see it on the screen would be to "put my pointer
over the file and press the action button".

It is when people actually start to "think" is when they fail
to naively click on the pathname (name of the file) to get it.

The naive approach is to simply click on what you want to get.

The interesting point here is that people with zero and high
computer exposure tend to click on the file name to obtain it.
Only people with some computer exposure start to "think" and
"figure it out" and fail to intuit to naively point at the
file name to get the file. 

So this is 2/3 to 1/3.

> information (and a bit more) and people would just go there
> without much thinking.
> 
> It probably is wise to resurrect those "redundant" links.

If someone does this, can they also remove the now "other"
redundant link? (the link at the pathname itself) A simple
code analyzer would show the duplicate code in gitweb.

   Luben
