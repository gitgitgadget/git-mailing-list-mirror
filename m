From: Petr Baudis <pasky@suse.cz>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3]
	add new Git::Repo API)
Date: Sun, 20 Jul 2008 14:58:41 +0200
Message-ID: <20080720125841.GD10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <200807192254.24622.jnareb@gmail.com> <alpine.DEB.1.00.0807201233010.3305@eeepc-johanness> <20080720104935.GB10151@machine.or.cz> <alpine.DEB.1.00.0807201420500.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:59:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYVu-0006np-HG
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbYGTM6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYGTM6n
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:58:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43642 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729AbYGTM6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:58:43 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3CFFF393B322; Sun, 20 Jul 2008 14:58:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807201420500.3305@eeepc-johanness>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89197>

  Hi,

On Sun, Jul 20, 2008 at 02:33:46PM +0200, Johannes Schindelin wrote:
> On Sun, 20 Jul 2008, Petr Baudis wrote:
> 
> > On Sun, Jul 20, 2008 at 12:38:07PM +0200, Johannes Schindelin wrote:
> >
> > > Pasky tried to convert all Perl scripts at once IIRC, and my numerous 
> > > problems just _making_ the Git scripts led me to rewrite a few Perl 
> > > scripts in C, so I could safely exclude the Perl scripts from my 
> > > personal fork.
> > 
> > I don't remember any concrete report of such problems ever reaching me; 
> > exactly what trouble are you hitting with the Perl scripts using Git.pm?  
> > I will be glad to try to fix it.
> 
> They reached you:
> 
> http://article.gmane.org/gmane.comp.version-control.git/23153

  running Git in-place without correctly setting the prefix is not
supported anyway; git wrapper will still be using non-builtin commands
from the prefix location instead of your fresh build.

> http://thread.gmane.org/gmane.comp.version-control.git/22764/focus=22778

  It seems I fixed this right away?

				Petr "Pasky" Baudis
