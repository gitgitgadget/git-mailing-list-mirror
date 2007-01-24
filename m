From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow default core.logallrefupdates to be overridden
 with template's config
Date: Wed, 24 Jan 2007 02:49:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701240245440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
 <7v64axmcmr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 02:49:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9XGL-0003F2-Nj
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbXAXBtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933165AbXAXBtT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:49:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:52101 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933163AbXAXBtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:49:18 -0500
Received: (qmail invoked by alias); 24 Jan 2007 01:49:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 24 Jan 2007 02:49:16 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64axmcmr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37592>

Hi,

On Tue, 23 Jan 2007, Junio C Hamano wrote:

> While on the topic of config files, we should fix the config
> reader not to allow per-repository variables in ~/.gitconfig

So we finally get this central place where all possible config variables 
are listed, with options (a la struct cmd_struct) which tell more about 
where they may be used?

While I think this might make sense, I feel quite uneasy about such a 
drastic change between -rc2 and -final.

Ciao,
Dscho
