From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [gitweb PATCH] Configure encoding
Date: Tue, 31 May 2005 12:12:17 +0200
Message-ID: <20050531101217.GA25555@pasky.ji.cz>
References: <1839.1117526111@www5.gmx.net> <20050531091955.GA22706@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Kolejka <Thomas.Kolejka@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 12:10:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd3hA-0008MZ-8Z
	for gcvg-git@gmane.org; Tue, 31 May 2005 12:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVEaKMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 06:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVEaKMZ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 06:12:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42401 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261611AbVEaKMT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 06:12:19 -0400
Received: (qmail 25755 invoked by uid 2001); 31 May 2005 10:12:17 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050531091955.GA22706@vrfy.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 31, 2005 at 11:19:55AM CEST, I got a letter
where Kay Sievers <kay.sievers@vrfy.org> told me that...
> On Tue, May 31, 2005 at 09:55:11AM +0200, Thomas Kolejka wrote:
> > The following patch makes it easy to change the encoding:
> > 
> > 
> > --- gitweb.cgi.177      2005-05-31 09:43:17.000000000 +0200
> > +++ gitweb.cgi.p        2005-05-31 09:48:46.000000000 +0200
> > @@ -20,6 +20,9 @@
> >  my $my_uri =           $cgi->url(-absolute => 1);
> >  my $rss_link = "";
> >  
> > +my $encoding = "utf-8";
> > +$encoding = "iso-8859-1";
> 
> The upstream version will not support anything but the one and only
> sane encoding which is utf-8. It will not provide options to switch
> back to the 80's, sorry. :)

This matters mainly for commits, right?

Perhaps I should recode from current locale to utf8 in cg-commit?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
