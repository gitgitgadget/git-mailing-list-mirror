From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tags and patches
Date: Thu, 14 Jun 2007 02:03:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706140201400.4059@racer.site>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com> 
 <Pine.LNX.4.64.0706131313550.4059@racer.site>
 <93c3eada0706131715oa84eff7kc0b477a3b80e9d66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 03:06:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HydnK-0004ty-Qk
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 03:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbXFNBGb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 21:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757227AbXFNBGb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 21:06:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:49316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757214AbXFNBGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 21:06:30 -0400
Received: (qmail invoked by alias); 14 Jun 2007 01:06:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 14 Jun 2007 03:06:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1970iY3OKF7Lqb0h+wgugKPwCmARfvd0r96W4tFWW
	RjTkr1tpRwPY4b
X-X-Sender: gene099@racer.site
In-Reply-To: <93c3eada0706131715oa84eff7kc0b477a3b80e9d66@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50152>

Hi,

On Thu, 14 Jun 2007, Geoff Russell wrote:

> On 6/13/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Wed, 13 Jun 2007, Geoff Russell wrote:
> > 
> > > Dear gits,
> > 
> > ;-)
> > 
> > > [...]
> > >
> > >        git tag v1.1
> > >        git format-patch v1.0
> > >        cd /tmp/newmyrepo
> > >        git am ~/myrepo/THEPATCHNAME
> > >
> > > Where is tag v1.1 ?
> > 
> > Tags are not propagated with patches. Sorry.
> 
> Is this considered to be a bug to be eventually fixed or a feature?

AFAIK patches are not supposed to _contain_ patches.

What you want is probably a bundle. You don't want a collection of diffs 
with comments on them, but you want a collection to reacreate the history 
the other side has.

Ciao,
Dscho
