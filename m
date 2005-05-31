From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [gitweb PATCH] Configure encoding
Date: Tue, 31 May 2005 12:44:25 +0200
Message-ID: <20050531104425.GA23755@vrfy.org>
References: <1839.1117526111@www5.gmx.net> <20050531091955.GA22706@vrfy.org> <20050531101217.GA25555@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Kolejka <Thomas.Kolejka@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 12:43:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd4CW-0003Ru-L8
	for gcvg-git@gmane.org; Tue, 31 May 2005 12:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVEaKoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 06:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVEaKoy
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 06:44:54 -0400
Received: from soundwarez.org ([217.160.171.123]:19851 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261760AbVEaKoa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 06:44:30 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id B2E693B02A; Tue, 31 May 2005 12:44:25 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050531101217.GA25555@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 31, 2005 at 12:12:17PM +0200, Petr Baudis wrote:
> Dear diary, on Tue, May 31, 2005 at 11:19:55AM CEST, I got a letter
> where Kay Sievers <kay.sievers@vrfy.org> told me that...
> > On Tue, May 31, 2005 at 09:55:11AM +0200, Thomas Kolejka wrote:
> > > The following patch makes it easy to change the encoding:
> > > 
> > > 
> > > --- gitweb.cgi.177      2005-05-31 09:43:17.000000000 +0200
> > > +++ gitweb.cgi.p        2005-05-31 09:48:46.000000000 +0200
> > > @@ -20,6 +20,9 @@
> > >  my $my_uri =           $cgi->url(-absolute => 1);
> > >  my $rss_link = "";
> > >  
> > > +my $encoding = "utf-8";
> > > +$encoding = "iso-8859-1";
> > 
> > The upstream version will not support anything but the one and only
> > sane encoding which is utf-8. It will not provide options to switch
> > back to the 80's, sorry. :)
> 
> This matters mainly for commits, right?

Yes. Also the content of the files, but fortunately they are just plain
ascii most of the time. :)

> Perhaps I should recode from current locale to utf8 in cg-commit?

Everthing else than utf-8 is just a complete mess with data shared
across multiple machines. All modern distributions defaulting to utf-8
anyway, so I think it is sane to recode that utf-8.

Kay
