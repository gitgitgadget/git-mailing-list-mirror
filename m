From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] clone: create intermediate directories of destination
 repo
Date: Wed, 25 Jun 2008 02:11:35 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806250211000.19665@iabervon.org>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com> <alpine.LNX.1.00.0806231554380.19665@iabervon.org> <20080623203835.GA8105@sigill.intra.peff.net> <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil>
 <20080624055022.GC19224@sigill.intra.peff.net> <7v3an3e0xv.fsf@gitster.siamese.dyndns.org> <20080624080437.GA2581@sigill.intra.peff.net> <alpine.LNX.1.00.0806241113360.19665@iabervon.org> <20080625054134.GB2209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, zuh@iki.fi,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 08:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBOFH-0005Mg-K7
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 08:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbYFYGLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 02:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYFYGLh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 02:11:37 -0400
Received: from iabervon.org ([66.92.72.58]:44115 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbYFYGLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 02:11:36 -0400
Received: (qmail 20532 invoked by uid 1000); 25 Jun 2008 06:11:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jun 2008 06:11:35 -0000
In-Reply-To: <20080625054134.GB2209@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86241>

On Wed, 25 Jun 2008, Jeff King wrote:

> On Tue, Jun 24, 2008 at 11:20:07AM -0400, Daniel Barkalow wrote:
> 
> > > I am worried that it is too clever. I didn't see an obvious way for
> > > work_tree and git_dir to not have that property, but I think it is still
> > > worth somebody double-checking.
> > 
> > I think you can specify git_dir and work_tree on the command line, and set 
> > them to whatever you want, although I now don't remember whether they're 
> > actually both followed for clone (I tried to match the shell version, 
> > whose behavior didn't make too much sense to me).
> 
> The git_dir variable is always set from the directory provided on the
> command line. However, the work_tree can be overridden by the
> environment. For some reason I missed the giant 'work_tree =
> getenv("GIT_WORK_TREE")' when I looked before. But that means that they
> are not necessarily related.
> 
> So my original patch was too clever. Here is the less clever patch, with
> an extra test that would break with the clever version.

Looks good, thanks.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
