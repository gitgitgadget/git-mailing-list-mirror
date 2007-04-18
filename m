From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 12:48:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704181247410.12094@racer.site>
References: <11768880622402-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He7iz-00020A-1l
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 12:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbXDRKs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 06:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422822AbXDRKs6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 06:48:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:48131 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422821AbXDRKs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 06:48:57 -0400
Received: (qmail invoked by alias); 18 Apr 2007 10:48:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 18 Apr 2007 12:48:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nQqpyV9bnBkW8/pqQJrD4BQ6JNRIbVCl7hx5LTW
	WmMQ4RvycAI7C1
X-X-Sender: gene099@racer.site
In-Reply-To: <11768880622402-git-send-email-junkio@cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44884>

Hi,

On Wed, 18 Apr 2007, Junio C Hamano wrote:

> 	[merge]
> 		driver = ancient merge %A %O %B

Why not do something like

	[merge.driver]
		ancient = merge %A %O %B

Hmm?

Ciao,
Dscho
