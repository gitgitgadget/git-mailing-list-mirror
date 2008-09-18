From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Thu, 18 Sep 2008 15:30:35 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809181526190.19665@iabervon.org>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>  <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru> <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 21:31:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgPE9-0005gN-I8
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 21:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbYIRTah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 15:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbYIRTah
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 15:30:37 -0400
Received: from iabervon.org ([66.92.72.58]:52822 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588AbYIRTag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 15:30:36 -0400
Received: (qmail 5048 invoked by uid 1000); 18 Sep 2008 19:30:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2008 19:30:35 -0000
In-Reply-To: <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96236>

On Thu, 18 Sep 2008, Bert Wesarg wrote:

> On Thu, Sep 18, 2008 at 18:29, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
> > Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> > ---
> >  .gitignore |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/.gitignore b/.gitignore
> > index 8868f2d..aa39db4 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -18,3 +18,5 @@ tg-import.txt
> >  tg-remote
> >  tg-remote.txt
> >  tg
> > +
> > +*.swp
> can't you do this in your .git/info/excludes?

It's generally better to put a core.excludesfile entry in your 
~/.gitconfig pointing to a ignore file with editor temporaries for the 
editor(s) you personally use. This will then apply to all git projects you 
work on.

	-Daniel
*This .sig left intentionally blank*
