From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tags and patches
Date: Thu, 14 Jun 2007 03:31:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706140326350.4059@racer.site>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com> 
 <Pine.LNX.4.64.0706131313550.4059@racer.site> 
 <93c3eada0706131715oa84eff7kc0b477a3b80e9d66@mail.gmail.com> 
 <Pine.LNX.4.64.0706140201400.4059@racer.site>
 <93c3eada0706131905i1cd43fd2xcc44ce47dca8ce00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 04:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyfBA-0000ZL-FE
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 04:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXFNCfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 22:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbXFNCfS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 22:35:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:49496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbXFNCfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 22:35:17 -0400
Received: (qmail invoked by alias); 14 Jun 2007 02:35:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 14 Jun 2007 04:35:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p6QdWKeLp5Q8yL+uws4rg28ETpQxw9M2HL4w9uG
	ZEheNjW5Urzhus
X-X-Sender: gene099@racer.site
In-Reply-To: <93c3eada0706131905i1cd43fd2xcc44ce47dca8ce00@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50160>

Hi,

On Thu, 14 Jun 2007, Geoff Russell wrote:

> On 6/14/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > AFAIK patches are not supposed to _contain_ patches.
> 
> Is this a typo? I expected patches to contain tags, not other patches.

Actually, two typos. Sorry. "AFAIK" -> "AFAICT", and the rest should 
actually have been written as "formatted patches are not supposed to 
contain tags."

> > What you want is probably a bundle. You don't want a collection of 
> > diffs with comments on them, but you want a collection to reacreate 
> > the history the other side has.
> 
> I didn't know about bundles but do now.  However "git bundle --help" 
> tells me "No manual entry for git-bundle" despite git-bundle.html being 
> in the Documentation directory.

... which probably means that your man pages, and therefore your Git 
installation, is not up-to-date.

> I'm trying to work out if I want to use git to manage a software 
> distribution problem. I distribute release v1.0 to people then later I 
> want to email them a patch to take them from v1.0 to v1.1.  I can 
> probably live without the tags, but am just surprised that patches don't 
> send them.

Patches are just files of the format that "diff" outputs, and "patch" 
accepts. There was never any possibility to change anything but files.

But then, usually people put the version _into_ files. So I suspect you 
really don't need tags, if you _have_ to send patches. Because if you 
_have_ to send patches, your recipients probably don't use Git, and could 
not use those tags anyway.

Ciao,
Dscho
