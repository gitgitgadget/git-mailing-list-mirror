From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive
 description
Date: Tue, 13 May 2008 12:53:25 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805131252310.30431@racer>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl> <20080513105728.GA3088@mithlond.arda.local> <20080513110842.GB3088@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue May 13 13:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvt5G-0005Zk-Dw
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 13:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbYEMLx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 07:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbYEMLx3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 07:53:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:49322 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753154AbYEMLx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 07:53:28 -0400
Received: (qmail invoked by alias); 13 May 2008 11:53:26 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp053) with SMTP; 13 May 2008 13:53:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eIuNMDSuePiq4DySYpr2Axb6bfY92LTIt+BL6eY
	yuCjTiTzXX+0v9
X-X-Sender: gene099@racer
In-Reply-To: <20080513110842.GB3088@mithlond.arda.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82022>

Hi,

On Tue, 13 May 2008, Teemu Likonen wrote:

> Teemu Likonen wrote (2008-05-13 13:57 +0300):
> 
> > But from ordinary user's point of view this raises questions: if gc 
> > --aggressive really is not that aggressive then the option itself is 
> > misleading. Why not change gc --aggressive to be really effective? 
> > Using high --window/--depth value etc.
> 
> I mean, what I'm seeing many places is suggestions to run
> 
>   git repack -a -d -f --window=100 --depth=100

I posted a patch to use 250, not just 100, with --aggressive.  See the 
mailing list archives for the discussion.

Ciao,
Dscho
