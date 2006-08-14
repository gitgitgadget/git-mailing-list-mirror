From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 21:38:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608142133150.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> 
 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com> 
 <Pine.LNX.4.63.0608141641330.28360@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910608140915i728004c1p216bf3d74fcc6ab7@mail.gmail.com> 
 <Pine.LNX.4.63.0608140930380.14796@qynat.qvtvafvgr.pbz>
 <9e4733910608141148t636f9874wfcf66b56161352c3@mail.gmail.com>
 <Pine.LNX.4.63.0608141206260.14796@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 21:38:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCiGk-0006Sq-DD
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 21:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWHNTie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWHNTie
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 15:38:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:1199 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932681AbWHNTid (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 15:38:33 -0400
Received: (qmail invoked by alias); 14 Aug 2006 19:38:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 14 Aug 2006 21:38:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0608141206260.14796@qynat.qvtvafvgr.pbz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25379>

Hi,

On Mon, 14 Aug 2006, David Lang wrote:

> On Mon, 14 Aug 2006, Jon Smirl wrote:
> 
> > Bit errors can mess the pack up in lots of ways. If it hits a commit 
> > you won't be able to follow the tree back in time. Packs were never 
> > designed to be error tolerant.
> 
> I'm not claiming that this is a problem, I'm reponding to other people's 
> claim that useing a global dictionary for a pack is a problem becouse if 
> something happens to that dictionary the whole pack is worthless by 
> pointing out that, if this is viewed as a real problem, it's easy to 
> solve.

Let's not solve problems we do not have. I refuse to think about this 
problem further, before there are actually some hard numbers showing an 
improvement there. If the numbers do not show an improvement, we do not 
have that problem at all!

Make a _global_ dictionary, optimize the heck out of it, _use_ that 
dictionary to repack a sizeable repository (I think linux-2.6.git should 
be enough for first tests), and tell the world about the size of the 
dictionary, the original pack, and the new pack.

You would not need to implement this cleanly, just a hack to prove that 
this idea is worth following up. 

Ciao,
Dscho
