From: Petr Baudis <pasky@suse.cz>
Subject: Re: Merging submodules
Date: Thu, 31 Jul 2008 15:06:26 +0200
Message-ID: <20080731130626.GQ32184@machine.or.cz>
References: <20080730230336.GA6481@Hermes> <20080731092104.1a6ce8bd@pc09.procura.nl> <20080731143955.034f0577@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 15:07:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXsR-0002HV-6d
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 15:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYGaNGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 09:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbYGaNGa
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 09:06:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43825 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbYGaNG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 09:06:29 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8A675393B303; Thu, 31 Jul 2008 15:06:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080731143955.034f0577@pc09.procura.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90945>

On Thu, Jul 31, 2008 at 02:39:55PM +0200, H.Merijn Brand wrote:
> On Thu, 31 Jul 2008 09:21:04 +0200, "H.Merijn Brand"
> <h.m.brand@xs4all.nl> wrote:
> 
> > I will now be playing with the results a bit. I have attached the
> > script, in case you might want to use it in documentation or examples.
> > For now, all the mods are hardcoded. No arguments and so on.
> > 
> > Again, Thanks!
> 
> There is a slight problem with this merging approach. The path names
> are as they are/were in the submodules. In module_a, foo.pl was without
> a leading module_a/ path, and now after integration, it still is. Is it
> possible to rethink this whole process that integrates/merges the
> several git repo's in subfolders into the current folder, as-if they
> would have been in this folder in the first place?

I would suggest re-reading Santi's suggestions:

> You have, basically, two possibilities:
> 
> 1) Add the module_# as submodules:
>   http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
>   http://git.or.cz/gitwiki/GitSubmoduleTutorial
> 2) Add the submodules as subtrees (as gitk and git-gui in git.git)
>   http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

I think the latter is specifically what you want.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
