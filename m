From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Tue, 17 Jul 2007 14:56:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707170834040.14781@racer.site>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com> 
 <dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com> 
 <f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com>
 <f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, git@vger.kernel.org
To: Bradford Smith <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 15:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAnXz-000051-OZ
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 15:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbXGQN5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXGQN5A
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 09:57:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:33995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751756AbXGQN47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 09:56:59 -0400
Received: (qmail invoked by alias); 17 Jul 2007 13:56:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 17 Jul 2007 15:56:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184GXRjXI04LeGwSZ1oSls5Y4pvtbBw7f9Fhoq+xc
	vyn4Lnr5hrki5G
X-X-Sender: gene099@racer.site
In-Reply-To: <f158199e0707160626j1025ab2cp3339ca6ab91d9af0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52761>

Hi,

On Mon, 16 Jul 2007, Bradford Smith wrote:

> So, I guess I need to add a GIT_CONFIG_HOME environment variable.  If I 
> get that done, I'll send a patch to the list including doc updates.

Alternatively, you could actually not ignore my hint at readlink(2) and 
have a proper fix, instead of playing games with environment variables.

Hth,
Dscho
