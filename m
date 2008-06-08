From: Tzafrir Cohen <tzafrir.cohen@xorcom.com>
Subject: Re: git-svn: multiple branches directories
Date: Sun, 8 Jun 2008 21:37:42 +0300
Organization: Xorcom*
Message-ID: <20080608183742.GF23243@xorcom.com>
References: <20080608002349.GB23243@xorcom.com> <e06498070806080900x4ecd730byefedf88aa4feee5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 20:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Pms-0005fF-1k
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 20:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbYFHShs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 14:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbYFHShs
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 14:37:48 -0400
Received: from local.xorcom.com ([62.90.10.53]:37487 "EHLO local.xorcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbYFHShs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 14:37:48 -0400
Received: by local.xorcom.com (Postfix, from userid 1000)
	id 961CB1B5850; Sun,  8 Jun 2008 21:37:42 +0300 (IDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e06498070806080900x4ecd730byefedf88aa4feee5e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84306>

On Sun, Jun 08, 2008 at 12:00:58PM -0400, Steven Walter wrote:
> On Sat, Jun 7, 2008 at 8:23 PM, Tzafrir Cohen <tzafrir.cohen@xorcom.com> wrote:
> > Hi
> >
> > Does git-svn support a repository layout where branches may reside under
> > more than one root?
> >
> > /trunk
> > /branches
> >  branch1
> >  branch2
> >  branch3
> > /somedir
> >  branch4
> >  branch5
> >  branch6
> > /tags
> >  ...
> 
> git-svn does support it.  The way that I interact with repositories
> like this is to have the main git-svn remote track only the trunk
> (fetch = /trunk:...), and then to add addititonal remotes for each
> branch that I want to track.  There may be a nicer way to do it, but
> git-svn certainly supports the method just described.

Thanks for your answer,

I'm afraid I don't follow you. Where do I have to write that and where?

-- 
               Tzafrir Cohen
icq#16849755              jabber:tzafrir.cohen@xorcom.com
+972-50-7952406           mailto:tzafrir.cohen@xorcom.com
http://www.xorcom.com  iax:guest@local.xorcom.com/tzafrir
