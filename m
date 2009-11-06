From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
 import
Date: Thu, 5 Nov 2009 19:37:18 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911051929340.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>  <1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org>  <fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com> 
 <alpine.LNX.2.00.0911041624401.14365@iabervon.org> <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com>  <alpine.LNX.2.00.0911050016360.14365@iabervon.org> <alpine.LNX.2.00.0911050145010.14365@iabervon.org>  <fabb9a1e0911051551r2e13cfb9me0e668adb962f6bd@mail.gmail.com>
  <alpine.LNX.2.00.0911051917100.14365@iabervon.org> <fabb9a1e0911051628v2ba15be2s9c3fb06879607cc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6CpZ-0005aH-Uk
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759112AbZKFAhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 19:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbZKFAhP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:37:15 -0500
Received: from iabervon.org ([66.92.72.58]:43836 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757867AbZKFAhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:37:14 -0500
Received: (qmail 11703 invoked by uid 1000); 6 Nov 2009 00:37:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Nov 2009 00:37:18 -0000
In-Reply-To: <fabb9a1e0911051628v2ba15be2s9c3fb06879607cc0@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132261>

On Fri, 6 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Fri, Nov 6, 2009 at 01:19, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > I didn't understand the version of my patch that contains your changes,
> > and I didn't know what was in it.
> 
> Either way, I managed to apply your patch, will send a new version of
> the series tomorrow.

Does it make sense now in what it's trying to do? (And does it turn out to 
work?) I'm fairly certain it's the easiest way to make the remote appear 
most natural to the rest of git, but I don't actually have code that wants 
to use it, so I wouldn't know if this just wouldn't work for hg or 
something.

> > I don't know why Junio squashed your
> > changes into my patch, particularly when I disagreed with those changes.
> 
> Junio didn't squash anything, it's just that pu still contains v4 of
> the series, in which I had squashed my changes in.

Oh, okay. You probably shouldn't squash un-acked changes into other 
people's patches when taking over their series.

	-Daniel
*This .sig left intentionally blank*
