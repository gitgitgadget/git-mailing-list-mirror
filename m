From: Nicolas Pitre <nico@cam.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:56:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810311651451.13034@xanadu.home>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
 <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
 <alpine.DEB.1.10.0810311325490.5851@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Oct 31 21:57:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw13i-0001n2-2t
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYJaU4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbYJaU4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:56:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18435 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYJaU4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:56:15 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M003W2FGH0IO0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 16:55:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.10.0810311325490.5851@asgard.lang.hm>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99642>

On Fri, 31 Oct 2008, david@lang.hm wrote:

> On Fri, 31 Oct 2008, Nicolas Pitre wrote:
> 
> > On Fri, 31 Oct 2008, Pierre Habouzit wrote:
> > 
> > > Last but not least, I believe parts of git-core are currently easy to
> > > just take. For example, any code *I* wrote, I hereby give permission to
> > > relicense it in any of the following licenses: BSD-like, MIT-like,
> > > WTFPL.
> > 
> > First........... is there really a need to re-license it?
> > If so then the choice of license is IMHO rather important.
> 
> at the very least you should go from GPLv2 to LGPLv2 for the library.

Sure.

> while it can be argued that this really shouldn't be nessasary, the water is
> muddy enough that it would be a very good thing to do this.
> 
> I don't see any need to switch to a BSD/MIT/etc license for a library, the
> LGPL lets it get linked with those licenses anyway.

Right.

> > My favorite license for a library is the GPL with the gcc exception,
> > i.e. what libraries coming with gcc are using.  They're GPL but with an
> > exception allowing them to be linked with anything.  And because
> > everything on a Linux system, including proprietary applications, is
> > likely linked against those gcc libs, then there is nothing that would
> > prevent libgit to be linked against anything as well.  But the library
> > code itself has GPL protection.
> > 
> > For reference, here's the exception text:
> > 
> >   In addition to the permissions in the GNU General Public License, the
> >   Free Software Foundation gives you unlimited permission to link the
> >   compiled version of this file into combinations with other programs,
> >   and to distribute those combinations without any restriction coming
> >   from the use of this file.  (The General Public License restrictions
> >   do apply in other respects; for example, they cover modification of
> >   the file, and distribution when not linked into a combine
> >   executable.)
> 
> <shrug>, I don't see why this is needed with the LGPL, but I'm not a lawyer.

The LGPL also asks that proprietary applications provides necessary 
object files so you can link it against an alternative implementation of 
the LGPL library if you so wish.  With dynamic libraries this is rather 
moot but I think that's the main difference.


Nicolas
