From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH] git-gui: offer a list of recent repositories
 on startup
Date: Tue, 9 Oct 2007 12:43:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091240540.4174@racer.site>
References: <11917925011987-git-send-email-prohaska@zib.de>
 <20071007233023.GE2137@spearce.org> <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 13:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfDVB-0007qo-QK
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 13:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbXJILnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 07:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbXJILno
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 07:43:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:45047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752120AbXJILnn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 07:43:43 -0400
Received: (qmail invoked by alias); 09 Oct 2007 11:43:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 09 Oct 2007 13:43:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184SvIwpXo4vl3o5Awn5XpY17NrFp/AJygdUKBtAY
	ni1KGyHgfCm5/9
X-X-Sender: gene099@racer.site
In-Reply-To: <BE872860-40AD-4BBA-BDD5-0EC8CB9AC4B5@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60387>

Hi,

On Mon, 8 Oct 2007, Steffen Prohaska wrote:

> commit a483fdd562d6c44d68a998224e0bbb17933b624a
> Author: Steffen Prohaska <prohaska@zib.de>
> Date:   Mon Oct 8 08:25:47 2007 +0200
> 
>    git-gui: offer a list of recent repositories on startup

May I suggest not putting this list into ~/.gitconfig, but rather 
~/.gitguirc?  It is not really a user-specific git configuration...

Besides, the call to "git-config --global --unset-all gui.recentrepo" 
fails, as far as I can tell because there is not yet such an entry.

Ciao,
Dscho
