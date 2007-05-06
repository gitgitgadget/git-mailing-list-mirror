From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Mon, 7 May 2007 01:09:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705070108380.4167@racer.site>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site>
 <20070505033039.GD16538@spearce.org> <20070505193214.GD30511@admingilde.org>
 <7vy7k3hvog.fsf@assigned-by-dhcp.cox.net> <20070505211857.GE30511@admingilde.org>
 <Pine.LNX.4.64.0705060259460.4015@racer.site> <20070506185259.GF30511@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 07 01:09:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkprG-00008t-M3
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbXEFXJf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXEFXJf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:09:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:55277 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752030AbXEFXJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:09:35 -0400
Received: (qmail invoked by alias); 06 May 2007 23:09:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 07 May 2007 01:09:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4Ga8asDO4lcihQecOpwkVHJW8FuUBtBYjqQ7FbP
	QkIsPzIOUYriSy
X-X-Sender: gene099@racer.site
In-Reply-To: <20070506185259.GF30511@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46394>

Hi,

On Sun, 6 May 2007, Martin Waitz wrote:

> On Sun, May 06, 2007 at 02:59:55AM +0200, Johannes Schindelin wrote:
> > > On Sat, May 05, 2007 at 01:17:35PM -0700, Junio C Hamano wrote:
> > > > > we could also introduce "<tree-ish>/<path>" for absolute path entries.
> > > > 
> > > > When you name the tree-ish with usual "branch name", where does
> > > > the branch name end and pathname start?  What happens when there
> > > > is an ambiguity, and how costly to detect such an ambiguity to
> > > > begin with?
> > > 
> > > well, if you know that it starts with a tree-ish there is no
> > > ambiguity [...]
> > 
> > Wrong. For example, mw/submodules~10 _is_ a tree-ish (if you have a branch 
> > named "mw/submodules").
> 
> so what?

So what: it proves that your case is wrong. mw/submodules~10/README would 
be _severely_ confused.

Ciao,
Dscho
