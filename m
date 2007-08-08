From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodules
Date: Wed, 8 Aug 2007 22:12:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708082211100.21857@racer.site>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
 <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
 <200708082147.57822.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	skimo@liacs.nl, Dmitry Kakurin <dmitry.kakurin@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:13:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsqc-0000cN-On
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764276AbXHHVNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763241AbXHHVNj
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:13:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:55550 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760752AbXHHVNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:13:38 -0400
Received: (qmail invoked by alias); 08 Aug 2007 21:13:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 08 Aug 2007 23:13:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fx5tklD7fTx7Kf4I6TjfBUocdWfOcx+ZdRzIr7o
	VtB6asSfDPYWVA
X-X-Sender: gene099@racer.site
In-Reply-To: <200708082147.57822.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55368>

Hi,

On Wed, 8 Aug 2007, Andy Parkins wrote:

> On Wednesday 2007, August 08, Johannes Schindelin wrote:
> 
> > Also, I realised that git is not really happy unless you install
> > alternates pointing to the object stores of the submodules.  Shouldn't we
> > make this my default (for example in "init")?
> 
> I use submodules on a daily basis and haven't experienced this at all.  
> Would you mind saying a little more about this problem?

Not at all!

This is what I did.  I cloned msysgit.git, which contains one submodule.  
To initialise that, I did "git submodule init" and "git submodule update".  
It went and cloned the submodule.  Fine.

Then I committed in the submodule, a well-needed fix.

If I now go to the superproject again, and say "git submodule status", it 
will not find the newest commit, and complain that it cannot access that 
object.

Ciao,
Dscho
