From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 7 Oct 2006 18:16:34 -0700 (PDT)
Message-ID: <20061008011634.844.qmail@web31814.mail.mud.yahoo.com>
References: <7vmz87pxg6.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 03:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWNHW-00011H-2x
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 03:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJHBQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 21:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWJHBQg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 21:16:36 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:29836 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750700AbWJHBQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 21:16:35 -0400
Received: (qmail 846 invoked by uid 60001); 8 Oct 2006 01:16:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=v5P2LrvTD4DhenWNagOKSQkzIr+YOsKMyLMYfkSbKyH3PElCWMTxr35t022AkWvOIiuzh14U3WmQ2mKDkiTKgL9KtgUfsaqCdNsHEJxd5SwNXdRYoAYJ7QS7UBcqBUmvzXQuH55KnRadL+Bs52FnrDIwNOIPlWJragc12uoIxGE=  ;
Received: from [71.80.233.118] by web31814.mail.mud.yahoo.com via HTTP; Sat, 07 Oct 2006 18:16:34 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz87pxg6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28519>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- Petr Baudis <pasky@suse.cz> wrote:
> >> Signed-off-by: Petr Baudis <pasky@suse.cz>
> >> ---
> >
> > First, this is a Unixism, and would confuse other OS users.
> > Second, "/" is after all _not part of the name_ of the tree/directory,
> > but part of the filesystem's path separator, let's not export it
> > to users of other OS's.
> > Third, directories/trees are already clearly 
> >   1) underlined, and
> >   2) differently colored,
> > which makes it overly obvious what it what.
> 
> I was actually hoping that we can get rid of the differences you
> cited above.
> 
> Underlines make entries harder to read, and colouring is 
> distracting; some people do not see all colours and to them it
> may not distracting but then they need another way to notice the
> differences between tree/blob.

I know, I've seen your email on that and have your patch with the
icons applied at work.  But it is black and white and I'd rather
see some nice color and shading if we're going to change that.

I don't mind using nice warm color icons in the left-most column.

   Luben
