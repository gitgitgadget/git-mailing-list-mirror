From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fast-export hg mutt (24M vs 184M)
Date: Thu, 03 May 2007 21:11:22 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705032109070.24220@xanadu.home>
References: <20070503185623.GA11817@cip.informatik.uni-erlangen.de>
 <20070503191716.GB11817@cip.informatik.uni-erlangen.de>
 <20070503210112.GE3260@artemis> <20070503211824.GB16538@spearce.org>
 <20070503222946.GH3260@artemis>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	GIT <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 04 03:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjmKp-0002gv-59
	for gcvg-git@gmane.org; Fri, 04 May 2007 03:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767496AbXEDBLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 21:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767510AbXEDBLd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 21:11:33 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39382 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767496AbXEDBLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 21:11:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHH00BPPSMY2I90@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 May 2007 21:11:23 -0400 (EDT)
In-reply-to: <20070503222946.GH3260@artemis>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46127>

On Fri, 4 May 2007, Pierre Habouzit wrote:

> On Thu, May 03, 2007 at 05:18:24PM -0400, Shawn O. Pearce wrote:
> > Pierre Habouzit <madcoder@debian.org> wrote:
> > > On Thu, May 03, 2007 at 09:17:16PM +0200, Thomas Glanzmann wrote:
> > > > Hello,
> > > > git-repack -a -d -f got it down to 19M. I missed the -f parameter
> > > > before. Sorry for the noise.
> > > 
> > >   You may want to use git gc that does that (and a bit more) for you.
> > 
> > Actually, in this case, no.
> > 
> > git-gc by default doesn't use the -f option.  -f to git-repack
> > means "no reuse deltas".  That particular feature of git-repack is
> > basically required to be used after running git-fast-import with
> > anything sizeable.
> 
>   okay, so why git fast-import does not let some note somewhere (to be
> picked by git gc later) "a fast-import has been run, use -f for next
> repack if you want best compression" ?

Nah.

The conversion script should do it itself directly after it is done with 
fast-import.


Nicolas
