From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge: record merge strategy in the log message on
 auto resolved merges
Date: Mon, 25 Jun 2007 08:53:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706250852470.4059@racer.site>
References: <20070625071624.7919.qmail@82fa8ed4561cac.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:53:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jOX-0005RP-CF
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXFYHx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbXFYHx4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:53:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:50824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751094AbXFYHxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:53:55 -0400
Received: (qmail invoked by alias); 25 Jun 2007 07:53:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 25 Jun 2007 09:53:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GmFpLGcsGBIIuYAFSCzoBXJrbVLqzfF88zX25DX
	CLM17pSd5XPhJv
X-X-Sender: gene099@racer.site
In-Reply-To: <20070625071624.7919.qmail@82fa8ed4561cac.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50879>

Hi,

On Mon, 25 Jun 2007, Gerrit Pape wrote:

> If a strategy module auto resolved the merge cleanly, record the used
> strategy in the log message

Why only when it merged cleanly? If that information is useful, it is 
_especially_ useful when you had conflicts, so that you know how to 
recreate the merge?

Ciao,
Dscho
