From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [bug] gitk can not read history if diff color is enabled
Date: Sat, 13 Oct 2007 15:43:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710131541330.25221@racer.site>
References: <4710D3AA.8000502@softhome.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: msharov@users.sourceforge.net
X-From: git-owner@vger.kernel.org Sat Oct 13 16:44:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgiDb-0001jX-T4
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762111AbXJMOnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 10:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762107AbXJMOnO
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:43:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:60918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761960AbXJMOnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 10:43:12 -0400
Received: (qmail invoked by alias); 13 Oct 2007 14:43:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 13 Oct 2007 16:43:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sXFke9XUseJvTuPzHJ64b/mWduqWHds7g0DhOTj
	DvFDfzaQp+Gxri
X-X-Sender: gene099@racer.site
In-Reply-To: <4710D3AA.8000502@softhome.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 13 Oct 2007, Mike Sharov wrote:

> Reproduced in git version 1.5.3.4.217.gbfc1, although it's been this way
> for a while. To see the bug, enable color diff with
> 
> [diff]
> color
> 
> and launch gitk on any repository (like the Linux kernel tree).

Thanks for the bug report.

This is fixed in http://hjemli.net/git/git/log/?h=q/mb/gitk/log--no-color
(which will be applied without any doubt once our king penguin comes 
back).

Ciao,
Dscho
