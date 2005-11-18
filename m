From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 21:02:17 +0100
Message-ID: <20051118200217.GA2831@vrfy.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511181926.10357.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 23:45:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCRM-0003YC-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbVKRUC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbVKRUC3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:02:29 -0500
Received: from soundwarez.org ([217.160.171.123]:40578 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1161151AbVKRUC2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 15:02:28 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id AA3A26847A; Fri, 18 Nov 2005 21:02:17 +0100 (CET)
To: Ismail Donmez <ismail@uludag.org.tr>
Content-Disposition: inline
In-Reply-To: <200511182127.06958.ismail@uludag.org.tr>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12278>

On Fri, Nov 18, 2005 at 09:27:06PM +0200, Ismail Donmez wrote:
> On Friday 18 November 2005 19:26, you wrote:
> > On Friday 18 November 2005 18:33, you wrote:
> > > Hi all,
> > >
> > > I am trying to parse git's rss feed and now xml parsers seems to choke on
> > > it because of an error in the produced feed. Looking at
> > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=rs
> > >s
> > >
> > > line 781 says :
> > >
> > > On Thu, 17 Nov 2005, David G\363mez wrote:<br/>
> > >
> > > which is part of the commit :
> > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=co
> > >mm it;h=05b8b0fafd4cac75d205ecd5ad40992e2cc5934d
> >
> > Ok looks like this text is latin-1 encoded although xml is served as utf-8.
> 
> Any comments on this?

Yes, convince the git maintainers, that it's incredibly stupid not to
enforce utf8 in commit messages. It makes absolutely zero sense in a
SCM, which merges forth and back between people around the world to
allow random encodings from the last century.

I still can't believe that this is a subject for discussion, in a
software developed in the year 2005.

With the next round of gitweb, I will substitute these caracters with
valid utf8, which will show up as invalid chars.

And git guys, please start to think again about your insane options,
that cause more harm than anything good.

Thanks,
Kay
