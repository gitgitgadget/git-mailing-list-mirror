From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere: Fix removal of already resolved path.
Date: Thu, 4 Jan 2007 10:03:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701041003040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkkjmcwr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 10:03:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2OVe-0003dy-Kn
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 10:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbXADJD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 04:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbXADJD2
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 04:03:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:51038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932334AbXADJD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 04:03:26 -0500
Received: (qmail invoked by alias); 04 Jan 2007 09:03:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 04 Jan 2007 10:03:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkkjmcwr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35925>

Hi,

On Thu, 4 Jan 2007, Junio C Hamano wrote:

> There was an obvious thinko in memmove() to remove an entry that
> was resolved from the in-core data structure.

I keep making the same errors, don't I?

Sorry,
Dscho
