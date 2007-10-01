From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to re-use setups in multiple tests?
Date: Mon, 1 Oct 2007 13:39:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011336530.28395@racer.site>
References: <550f9510710010327l3e729ff1tbbb9b6c674c1cb11@mail.gmail.com> 
 <Pine.LNX.4.64.0710011243230.28395@racer.site>
 <550f9510710010516s305c843br53da294f65318862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 14:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcKZW-00046u-Cg
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 14:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbXJAMkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 08:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbXJAMkS
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 08:40:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:60307 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751678AbXJAMkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 08:40:16 -0400
Received: (qmail invoked by alias); 01 Oct 2007 12:40:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 01 Oct 2007 14:40:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3FZo35dz3HRxh9lrx5CIbV6QEGQizWfViHSS8Ik
	9OZotov28a2Q/4
X-X-Sender: gene099@racer.site
In-Reply-To: <550f9510710010516s305c843br53da294f65318862@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59609>

Hi,

On Mon, 1 Oct 2007, Tom Clarke wrote:

> In this case the first test rebases the branch created in setup (it's 
> testing the rebase merge strategy), the second test should do the same 
> thing, except check there is a warning if a --message option is passed.
> 
> I suppose I could find the old pre-rebase head and work with that, but 
> that doesn't seem that clean to me.

You can use "git reset --hard master@{1}", and it really escapes me why 
this should not be clean, and why you want to jump through hoops instead 
using a much more complicated technique.

Ciao,
Dscho
