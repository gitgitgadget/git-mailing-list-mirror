From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 01:14:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609280113490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
 <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
 <20060927080652.GA8056@admingilde.org>
 <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <451AB122.9020600@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Waitz <tali@admingilde.org>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 01:14:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSiby-0001BF-MB
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 01:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031212AbWI0XOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 19:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031235AbWI0XOh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 19:14:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:24493 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031212AbWI0XOg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 19:14:36 -0400
Received: (qmail invoked by alias); 27 Sep 2006 23:14:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 28 Sep 2006 01:14:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <451AB122.9020600@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27946>

Hi,

On Wed, 27 Sep 2006, A Large Angry SCM wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Wed, 27 Sep 2006, Martin Waitz wrote:
> > 
> > > On Tue, Sep 26, 2006 at 03:33:49PM -0700, A Large Angry SCM wrote:
> > > > So, for each subproject of a parent project, you want to record branch,
> > > > version (commit ID), and directory location. Not quite as easy to do in
> > > > a makefile but do-able.
> > > I've been playing with this kind of subprojects a little bit.
> > > 
> > > My current approach is like this:
> > > 
> > >  * create a .gitmodules file which lists all the directories
> > >    which contain a submodule.
> > >  * the .git/refs/heads directory of the submodule gets stored in
> > >    .gitmodule/<modulename> inside the parent project
> > 
> > Taking this a step further, you could make subproject/.git/refs/heads a
> > symbolic link to .git/refs/heads/subproject, with the benefit that fsck Just
> > Works.
> 
> Wouldn't an fsck in the parent complain about missing objects?

... not if my original idea (which I might have forgotten to mention ;-) 
was implemented: symlinking subproject/.git/objects to .git/objects.

Ciao,
Dscho
