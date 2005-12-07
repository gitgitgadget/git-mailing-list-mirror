From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: dotfile support
Date: Wed, 7 Dec 2005 08:11:30 -0800
Message-ID: <20051207161130.GA10924@tumblerings.org>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org> <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org> <42628D1B.3000207@dwheeler.com> <20051207145646.GA9207@tumblerings.org> <4396FFB0.4040203@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 17:16:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek1tI-000577-9W
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 17:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVLGQLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 11:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVLGQLc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 11:11:32 -0500
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:36051 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1751171AbVLGQLb
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 11:11:31 -0500
Received: from zbrown by tumblerings.org with local (Exim 4.54)
	id 1Ek1tD-000573-0y; Wed, 07 Dec 2005 08:11:31 -0800
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4396FFB0.4040203@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13329>

OK, I see my mistake.

I should have tested better. I started off with a non-versioned directory
containing dotfiles and regular files. I did a cg-init, only to discover
that the dotfiles were not included in the repository at that time. So I
just assumed they couldn't be added either.

But I just tested, and yes indeed, it is possible to cg-add a dotfile.

So my question is, why does cg-init ignore dotfiles within the directory when it
first initializes the repository?

Be well,
Zack

On Wed, Dec 07, 2005 at 04:28:48PM +0100, Andreas Ericsson wrote:
> Zack Brown wrote:
> >Hi,
> >
> >What's the status of dotfile support? I can only find one thread that 
> >really
> >discusses the issue:
> >
> 
> What sort of "dotfile support" are you hinting at? git being able to 
> handle them, or git being able to ignore them? Both are implemented. The 
> former by default and the latter through .gitignore.
> 
> Files you want to version-control ofcourse has to be added with "git 
> add", but that's not just dotfiles and it's really the only sane behaviour.
> 
> -- 
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
