From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-mv submodule failure
Date: Sun, 21 Oct 2007 11:02:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710211102230.25221@racer.site>
References: <46dff0320710192301p3e1d88d5l3b662b72b051d920@mail.gmail.com> 
 <Pine.LNX.4.64.0710202223590.25221@racer.site>
 <46dff0320710202248v56af5cb0gcf7dacb32848eca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Yin Ping <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 12:03:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjXeY-0001cT-60
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 12:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXJUKDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 06:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXJUKDO
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 06:03:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:54206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751434AbXJUKDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 06:03:13 -0400
Received: (qmail invoked by alias); 21 Oct 2007 10:03:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 21 Oct 2007 12:03:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vv2oPikhv34zygi+ry/nSHNXHlUKT36xokGxJlu
	tB0cUJZtso/ZWK
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320710202248v56af5cb0gcf7dacb32848eca3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61894>

Hi,

On Sun, 21 Oct 2007, Yin Ping wrote:

> > But of course .gitmodules is unaffected.  But it should be changed, too.
> 
> IMHO, changing .gitmodules is what the 'git-submodule mv' should do, and 
> 'git-mv' should only rename the module directory

No.  If you "git mv" a submodule, it makes absolutely no sense to leave 
.gitmodules as is.

Ciao,
Dscho
