From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: print errors from git-update-ref
Date: Thu, 27 Jul 2006 13:04:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271302150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com>
 <7vk663h6zi.fsf@assigned-by-dhcp.cox.net> <20060727012856.GB32492@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 13:04:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G63fN-0002tg-UG
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 13:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWG0LE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 07:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWG0LE2
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 07:04:28 -0400
Received: from mail.gmx.net ([213.165.64.21]:27551 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751154AbWG0LE1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 07:04:27 -0400
Received: (qmail invoked by alias); 27 Jul 2006 11:04:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 27 Jul 2006 13:04:26 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060727012856.GB32492@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24277>

Hi,

On Wed, 26 Jul 2006, Shawn Pearce wrote:

> This change adds a test for trying to create a ref within a directory
> that is actually currently a file, and adds error printing within
> the ref locking routine should the resolve operation fail.

Why not just print an error message when the resolve operation fails, 
instead of special casing this obscure corner case? It is way shorter, 
too. The test should stay, though.

Ciao,
Dscho
