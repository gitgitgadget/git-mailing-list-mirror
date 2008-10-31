From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 14:43:56 -0700
Message-ID: <20081031214356.GX14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <alpine.DEB.1.10.0810311325490.5851@asgard.lang.hm> <alpine.LFD.2.00.0810311651451.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:45:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1nr-0001rn-3i
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYJaVn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYJaVn5
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:43:57 -0400
Received: from george.spearce.org ([209.20.77.23]:45375 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYJaVn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:43:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 847343835F; Fri, 31 Oct 2008 21:43:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810311651451.13034@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99651>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 31 Oct 2008, david@lang.hm wrote:
> > On Fri, 31 Oct 2008, Nicolas Pitre wrote:
> > > On Fri, 31 Oct 2008, Pierre Habouzit wrote:
> > > 
> > > > Last but not least, I believe parts of git-core are currently easy to
> > > > just take. For example, any code *I* wrote, I hereby give permission to
> > > > relicense it in any of the following licenses: BSD-like, MIT-like,
> > > > WTFPL.
> > > 
> > > First........... is there really a need to re-license it?
> > > If so then the choice of license is IMHO rather important.

Some people want to be able to link the library into an application
that they redistribute binaries of, but not sources to.  Those folks
have also volunteered to help write the library.  If they put their
code where their mouth is, then I think they should be able to use
their code the way they want to.

That said, I think the license choice that makes the most sense
here is probably LGPL or GPL+gcc exception, like you note below.
BSD and MIT are probably not serious contenders.

> > at the very least you should go from GPLv2 to LGPLv2 for the library.
> 
> Sure.

Well, we cannot do a GPL->LGPL switch on code without author
permission for that sort of re-licensing.

That said, I think many authors of git.git code would be more
comfortable with a GPL->LGPL change, where they wouldn't be OK with
a GPL->BSD/MIT change.  There may be some folks though who still
wouldn't accept a GPL->LGPL move.

> > > My favorite license for a library is the GPL with the gcc exception,
...
> > > 
> > > For reference, here's the exception text:
> > > 
> > >   In addition to the permissions in the GNU General Public License, the
> > >   Free Software Foundation gives you unlimited permission to link the
> > >   compiled version of this file into combinations with other programs,
> > >   and to distribute those combinations without any restriction coming
> > >   from the use of this file.  (The General Public License restrictions
> > >   do apply in other respects; for example, they cover modification of
> > >   the file, and distribution when not linked into a combine
> > >   executable.)
> > 
> > <shrug>, I don't see why this is needed with the LGPL, but I'm not a lawyer.
> 
> The LGPL also asks that proprietary applications provides necessary 
> object files so you can link it against an alternative implementation of 
> the LGPL library if you so wish.  With dynamic libraries this is rather 
> moot but I think that's the main difference.

I'm happy with either the LGPL or the GPL+exception above.  If I
read these correctly the GPL+exception allows one to distribute
static executables without source or object files, so long as the
library source wasn't modified.  I'd almost prefer just using the
standard LGPL then, static linking isn't very common anymore.

-- 
Shawn.
