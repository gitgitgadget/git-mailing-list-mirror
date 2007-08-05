From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: $GIT_DIR usage
Date: Sun, 5 Aug 2007 13:33:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051332230.14781@racer.site>
References: <46B59F63.8020707@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHfJ4-0008NW-2n
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbXHEMd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbXHEMd5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:33:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:43691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754678AbXHEMd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:33:56 -0400
Received: (qmail invoked by alias); 05 Aug 2007 12:33:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 05 Aug 2007 14:33:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lp3VHbvmlLzYQWx1p+v3RuFCL+mFYoaEn/qCTtc
	6DDyi33G/MfPY7
X-X-Sender: gene099@racer.site
In-Reply-To: <46B59F63.8020707@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55010>

Hi,

On Sun, 5 Aug 2007, Dan Zwell wrote:

> $ export GIT_DIR="`pwd`/.git_public"
> $ git init
> warning: templates not found /usr/share//git-core/templates/
> Initialized empty Git repository in /home/user/temp/.git_public/

I think that you implicitly created a bare repository with that.  Just 
check if "git config core.bare" returns true.

If so, you need to change that in order to have a working tree.

Hth,
Dscho
