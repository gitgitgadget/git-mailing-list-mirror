From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Thu, 11 Jan 2007 09:15:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701110914300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
 <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 09:16:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4v6U-0004KS-Be
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 09:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbXAKIQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 03:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbXAKIQD
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 03:16:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:44294 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030215AbXAKIQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 03:16:01 -0500
Received: (qmail invoked by alias); 11 Jan 2007 08:15:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 11 Jan 2007 09:15:59 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36554>

Hi,

On Wed, 10 Jan 2007, Junio C Hamano wrote:

> Subject: [PATCH] merge-recursive: do not use on-file index when not needed.
> 
> This revamps the merge-recursive implementation following the
> outline in:
> 
> 	Message-ID: <7v8xgileza.fsf@assigned-by-dhcp.cox.net>

Thank you very much! I know, it was my task and I punted, but my time is 
really scarce these days.

Ciao,
Dscho
