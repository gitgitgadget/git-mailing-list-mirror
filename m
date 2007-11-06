From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push problem - unpack unpacker exited with error code; ng
 refs/heads/rel2_branch n/a (unpacker error)
Date: Tue, 6 Nov 2007 10:51:49 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061050060.4362@racer.site>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
 <20070709173720.GS29994@genesis.frugalware.org>
 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
 <4713FA4A.5090501@bluelane.com> <Pine.LNX.4.64.0710160100510.25221@racer.site>
 <47140A5F.7000309@bluelane.com> <Pine.LNX.4.64.0710160201220.25221@racer.site>
 <4714130F.7030809@bluelane.com> <Pine.LNX.4.64.0710160231040.25221@racer.site>
 <47142AF3.1030405@bluelane.com> <Pine.LNX.4.64.0710161154340.25221@racer.site>
 <47303826.1000506@bluelane.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pete/Piet Delaney <pete@bluelane.com>, git@vger.kernel.org,
	Piet Delaney <piet.delaney@gmail.com>
To: Piet Delaney <pdelaney@bluelane.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 11:52:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpM3F-0006ET-R1
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 11:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbXKFKwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 05:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbXKFKwo
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 05:52:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:45987 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754779AbXKFKwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 05:52:43 -0500
Received: (qmail invoked by alias); 06 Nov 2007 10:52:41 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp041) with SMTP; 06 Nov 2007 11:52:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+46rhebIy41sBzH1SARN2TDHRKfb9l7bxEvyyzgA
	G6rn19+lNiPXus
X-X-Sender: gene099@racer.site
In-Reply-To: <47303826.1000506@bluelane.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63656>

Hi,

On Tue, 6 Nov 2007, Piet Delaney wrote:

> I'm getting an error when I try to push back a git repository
> that I just pulled and made a slight change to:
> -------------------------------------------------------------------------------------
> -bash-3.00$ git push
> [...]
> error: failed to push to 'git://cvs.bluelane.com/home/git/blux'

For security reasons, you cannot push to git://, by default. git:// does 
not have any form of authentication or encryption.

You need to use the ssh protocol (probably something like 
cvs.bluelane.com:/home/git/blux in your case).

Ciao,
Dscho
