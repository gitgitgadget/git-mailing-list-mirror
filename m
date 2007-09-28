From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Fri, 28 Sep 2007 07:15:03 +0200
Message-ID: <20070928051503.GA19815@xp.machine.xx>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp> <46FBFDD7.1080300@gmail.com> <20070927191125.GD12427@artemis.corp> <20070927222326.GB8688@thunk.org> <20070927222825.GG12427@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Russ Brown <pickscrape@gmail.com>,
	Kelvie Wong <kelvie@ieee.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 07:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib8C4-00050A-JK
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 07:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbXI1FPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 01:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbXI1FPI
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 01:15:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:54432 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752922AbXI1FPF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 01:15:05 -0400
Received: (qmail invoked by alias); 28 Sep 2007 05:15:03 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp025) with SMTP; 28 Sep 2007 07:15:03 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+5TasA4lS5EYTIZI8jDzg2LwvHZAjb+mygE2epHg
	xgMmuHIEF9pyrx
Content-Disposition: inline
In-Reply-To: <20070927222825.GG12427@artemis.corp>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59366>

On Fri, Sep 28, 2007 at 12:28:25AM +0200, Pierre Habouzit wrote:
> On Thu, Sep 27, 2007 at 10:23:26PM +0000, Theodore Tso wrote:
> > On Thu, Sep 27, 2007 at 09:11:25PM +0200, Pierre Habouzit wrote:
> > > > >   And as none of the other merge tool that are supported are able to
> > > > > either do 3way merges, or have a decent UI (that definitely seems to be
> > > > > exclusive features) I've given up on git-mergetool (and to be fair, it
> > > > > sucks, because it could be _sooo_ useful sometimes).
> > > > > 
> > > > 
> > > > What about meld? That does 3-way merge, and the UI is fine.
> > > 
> > >   Indeed, it seems that since the last time I tested it, it now does
> > > diff3 merging. I should reevaluate it :)
> > 
> > Pierre,
> > 
> > FYI, kdiff3, meld, xxdiff, opendiff (on MacOSX), and emerge all
> > support 3-way merge.
> 
>   I know, but:
>   * kdiff3 often take decisions behind your back, and results in broken
>     merges, so it's a no-go ;
>   * xxdiff has (IMHO) a very bad and non-intuitive UI, I never get to
>     make it work ;
>   * I don't use macos (opendiff) ;
>   * emerge is emacs right ? :)
> 
>   Though I gave meld another chance, and it works really better than it
> used to, so I may give it a try :) Let's hope I won't be disappointed by
> meld :)
> 

FWIW, xxdiff has support to handle halfway merged files, so that if git
could merge some hunks already for you (e.g. rerere kicked in), you
don't have to redo the _whole_ merge by hand, just call

	xxdiff -U file/with/mergemarkers/inside

and it will do the right thing. Not sure if the other tools could handle
it, but any pointers appreciated, because it often happens to me that
only one hunk out of several wasn't merged automatically by git. And
mergetool wants to always redo the whole merge, which isn't the best it
can do.

-Peter
