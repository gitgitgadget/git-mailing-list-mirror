From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fatal: unable to create '.git/index': File exists
Date: Fri, 5 Jan 2007 21:16:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701052115161.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701051150.09968.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 21:16:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2vUG-0006SS-AM
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 21:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXAEUQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 15:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXAEUQV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 15:16:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:43750 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbXAEUQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 15:16:20 -0500
Received: (qmail invoked by alias); 05 Jan 2007 20:16:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 05 Jan 2007 21:16:18 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Len Brown <lenb@kernel.org>
In-Reply-To: <200701051150.09968.lenb@kernel.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36018>

Hi,

On Fri, 5 Jan 2007, Len Brown wrote:

> I kicked off a pull.
> Realized I was on the wrong branch
> and immediately did a ^C
> 
> Now I can't change branches:
> 
> # git checkout release
> fatal: unable to create '.git/index': File exists

This usually means that .git/index.lock exists. Try removing that file.

However, it _should_ be removed by the atexit() handler, methinks. I have 
no idea why it does not.

Ciao,
Dscho
