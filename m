From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Wed, 18 Mar 2009 17:01:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903181657180.10279@pacific.mpi-cbg.de>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> <Pine.LNX.4.64.0712061201580.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 17:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjyDG-0008Ii-3D
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 17:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbZCRP7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 11:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbZCRP7k
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 11:59:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:42599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751592AbZCRP7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 11:59:39 -0400
Received: (qmail invoked by alias); 18 Mar 2009 15:59:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 18 Mar 2009 16:59:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4CE8bZzO4gOviJgr09Gv5818Itpq2d3WJsUMOFV
	UK/zgsq9jW7ZmG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <Pine.LNX.4.64.0712061201580.27959@racer.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113623>

Hi,

On Thu, 6 Dec 2007, Johannes Schindelin wrote:

> 
> The default was not to change the window or depth at all.  As suggested
> by Jon Smirl, Linus Torvalds and others, default to
> 
> 	--window=250 --depth=250
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Guess what.  This is still unresolved, and yet somebody else had to be 
bitten by 'git gc --aggressive' being everything but aggressive.

So...  I think it is high time to resolve the issue, either by applying 
this patch with a delay of over one year, or by the pack wizards trying to 
implement that 'never fall back to a worse delta' idea mentioned in this 
thread.

Although I suggest, really, that implying --depth=250 --window=250 (unless 
overridden by the config) with --aggressive is not at all wrong.

Ciao,
Dscho
