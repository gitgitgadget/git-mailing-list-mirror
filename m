From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 15:50:57 +0200
Message-ID: <20070715135057.GI2568@steel.home>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home> <20070715105450.GD7106@genesis.frugalware.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 15 15:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA4VG-0002bp-Fv
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 15:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbXGONvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 09:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbXGONvB
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 09:51:01 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:12322 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbXGONu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 09:50:59 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (klopstock mo58) (RZmta 8.3)
	with ESMTP id p01c67j6FBVcOV ; Sun, 15 Jul 2007 15:50:57 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 38037277BD;
	Sun, 15 Jul 2007 15:50:57 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 14BA9C164; Sun, 15 Jul 2007 15:50:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715105450.GD7106@genesis.frugalware.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

VMiklos, Sun, Jul 15, 2007 12:54:50 +0200:
> Na Sun, Jul 15, 2007 at 12:47:12PM +0200, Alex Riesen <raa.lkml@gmail.com> pisal(a):
> > to. Subprojects defined in such a loosely way are more flexible then
> > having git-pull fetch subprojects by default. Sometimes I even want be
> > _sure_ the subprojects are completely untouched (I have some critical
> > parts in them).
> 
> Okay, but where can you overwrite that default? It would be nice to have
> a config variable for this or something like that.

It is not a default in a sense where it control the behaviour of a git
command. git pull just does not do anything to subprojects and you use
a separate command (git-submodule update, I believe) to update them.

That said, I never used the git-submodule, nor did I have an urge to.
As I said, I find it convenient enough as it is with git-add and
git-diff, checking out the subproject as needed. Have to be careful
about "git commit -a" (which I almost never use anyway) and haven't
had conflicts yet.
