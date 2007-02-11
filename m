From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 23:53:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702112351270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
 <20070211224158.GA31488@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNaA-0007M3-A0
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXBKWxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbXBKWxp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:53:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:59607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932835AbXBKWxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:53:42 -0500
Received: (qmail invoked by alias); 11 Feb 2007 22:53:40 -0000
X-Provags-ID: V01U2FsdGVkX1/Q9VJW41/Q2SEgd7uf1I2m7uBpsipzeNmH/ZHImC
	mGVg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070211224158.GA31488@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39321>

Hi,

On Sun, 11 Feb 2007, Shawn O. Pearce wrote:

> Unlike Kay, I'm not looking to merge git-gui into git.git to abandon it.

That's great!

> It may be saner for all involved if that development happens in the 
> git-gui.git repository, with drops made to git.git by way of merging the 
> "subproject" every so often.

Fully agree.

> It may make patching slightly more interesting though, as some
> users new to git-gui development may generate a patch in git.git
> (using a/git-gui/git-gui.sh as the path) which then would not apply
> as-is to the master git-gui development tree.

In this case, a "-p <n>" option to git-am would make sense, no?

Ciao,
Dscho
