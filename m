From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT push to sftp (feature request)
Date: Sun, 5 Aug 2007 14:38:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051436120.14781@racer.site>
References: <200708051105.44376.pavlix@pavlix.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: pavlix <pavlix@pavlix.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:38:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHgJm-0005U0-4a
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbXHENiq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXHENiq
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:38:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:59899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751280AbXHENiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:38:46 -0400
Received: (qmail invoked by alias); 05 Aug 2007 13:38:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 05 Aug 2007 15:38:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FUUYgE7PFJaA3KpUwF+cWDZYHOUri0FdN5/8Ooi
	40xZRC7ZxRLuJP
X-X-Sender: gene099@racer.site
In-Reply-To: <200708051105.44376.pavlix@pavlix.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55015>

Hi,

On Sun, 5 Aug 2007, pavlix wrote:

> Git would also have to be able to create a remote repository (maybe an option 
> to push?).
> 
> Did I miss something?

Yes.

First, we do not allow remote repository initialising yet.

Second, if you do not have git installed on the remote host, you probably 
want to serve via http.  This is a very suboptimal transport, as it cannot 
repack the contents.

And if you use such a suboptimal transport, people will blame _git_ for 
being slow, even if you made it slow deliberately.

Ciao,
Dscho
