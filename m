From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH] git-gui: offer a list of recent repositories
 on startup
Date: Wed, 10 Oct 2007 16:43:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101643190.4174@racer.site>
References: <11917925011987-git-send-email-prohaska@zib.de>
 <20071007233023.GE2137@spearce.org> <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de>
 <Pine.LNX.4.64.0710091240540.4174@racer.site> <4A4F8FC7-E0AB-4C07-B4C8-AFE2EBD9C3DD@zib.de>
 <20071010044030.GJ2137@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfdjZ-0008Bk-1K
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbXJJPoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbXJJPoU
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:44:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:46540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755050AbXJJPoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 11:44:19 -0400
Received: (qmail invoked by alias); 10 Oct 2007 15:44:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 10 Oct 2007 17:44:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oMMdEJKxotHP8HtWiLDBzYHbNAVVK2xgv1u370Q
	xI15Lu+LIRRd5V
X-X-Sender: gene099@racer.site
In-Reply-To: <20071010044030.GJ2137@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60511>

Hi,

On Wed, 10 Oct 2007, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
> > On Oct 9, 2007, at 1:43 PM, Johannes Schindelin wrote:
> > >On Mon, 8 Oct 2007, Steffen Prohaska wrote:
> > >
> > >>commit a483fdd562d6c44d68a998224e0bbb17933b624a
> > >>Author: Steffen Prohaska <prohaska@zib.de>
> > >>Date:   Mon Oct 8 08:25:47 2007 +0200
> > >>
> > >>   git-gui: offer a list of recent repositories on startup
> > >
> > >May I suggest not putting this list into ~/.gitconfig, but rather
> > >~/.gitguirc?  It is not really a user-specific git configuration...
> > 
> > git-gui already stores other options as global variables gui.*.
> > (see git-gui/lib/option.tcl). I just added gui.recentrepo. The
> > list of recent repos should go to wherever git-gui stores its options.
> > 
> > Right now this is in ~/.gitconfig, if I understand correctly. Shawn?
> 
> Yes, that's correct.
> 
> An item on my todo list (see todo branch in git-gui.git) is to move
> this into a ~/.gitguiconfig or something like that, but I was going
> to keep it as a git-config style file so git-config can be used to
> process its contents.
> 
> Until that task is complete I'd rather keep all of the "gui" options
> in ~/.gitconfig (global) or .git/config (per-repository).  When I
> split stuff out to git-gui specific files I'll have to migrate the
> entire "gui" section at once.

FWIW I was only concerned about the recent repos, since strictly speaking, 
they are not options to git-gui...  But I do not care deeply.

Ciao,
Dscho
