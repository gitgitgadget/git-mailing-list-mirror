From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 16:01:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131559210.4059@racer.site>
References: <18031.64456.948230.375333@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUPT-0007NU-GZ
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbXFMPFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbXFMPFU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:05:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:52473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755433AbXFMPFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:05:18 -0400
Received: (qmail invoked by alias); 13 Jun 2007 15:05:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 13 Jun 2007 17:05:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VnYdNMKFV+Rxz9i2EOp7vIAYj13161D572gXPtz
	9Q07WZYc5mm6w8
X-X-Sender: gene099@racer.site
In-Reply-To: <18031.64456.948230.375333@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50073>

Hi,

On Wed, 13 Jun 2007, Bill Lear wrote:

> We have some CVS users who complain that they cannot do a pull
> into a dirty working tree, as they could under CVS.

Two things you can do. First thing is: teach them to commit first. If they 
decide later that they did not want that change, they still can go back 
with "git reset HEAD@{2}".

The other thing, if you have to, is to put all dirty changes into the 
index before pull. Something like "git add $(git ls-files --modified)". 
You can even make that a global alias for your users. Although IIRC it 
does not work if the merge changes the same files as your dirty work tree 
touches, but I could very well be wrong there.

Hth,
Dscho
