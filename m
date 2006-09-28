From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Fri, 29 Sep 2006 00:24:02 +0200
Message-ID: <20060928222402.GC3469@stusta.de>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 00:24:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT4Ie-0004mf-WD
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbWI1WYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbWI1WYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:24:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54283 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161333AbWI1WYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 18:24:06 -0400
Received: (qmail 20437 invoked from network); 28 Sep 2006 22:24:05 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailhub.stusta.mhn.de with SMTP; 28 Sep 2006 22:24:05 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 104B211427C; Fri, 29 Sep 2006 00:24:03 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28057>

On Thu, Sep 28, 2006 at 01:54:27PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 26 Sep 2006, Junio C Hamano wrote:
> >
> > This adds two parameters to "diff --stat".
> > 
> >  . --stat-width=72 tells that the page should fit on 72-column output.
> > 
> >  . --stat-name-width=30 tells that the filename part is limited
> >    to 30 columns.
> 
> Thinking some more about this, I have to say, I do hate the syntax.
> 
> It may be clear thanks to being verbose, but it's _hell_ to write.
> 
> It has the same problem the "--stat-with-patch" argument had: sure, it 
> worked, but it was really really inconvenient, and just doing a 
> combination of "--stat -p" is much nicer.
> 
> So how about just extending the existing "--stat" thing, and just making 
> it do something like
> 
> 	git diff --stat=72,30
> 
> instead (perhaps along with a config option to set the defaults to 
> something else if we want to).
> 
> What do you think?
>...

What about staying compatible with diffstat?

IOW, change --stat-width=72 to -w72, or at least allow it alternatively?

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
