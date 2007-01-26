From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 22:15:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701262214420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vejpi63py.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 22:15:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAYPv-0004AF-Ae
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 22:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbXAZVPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 16:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXAZVPW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 16:15:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:48163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751591AbXAZVPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 16:15:22 -0500
Received: (qmail invoked by alias); 26 Jan 2007 21:15:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 26 Jan 2007 22:15:20 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejpi63py.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37883>

Hi,

On Thu, 25 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Is it possible that diff_get_color() _never_ returns NULL?
> 
> I think so, although it may often return a pointer that points
> at NUL (e.g under --no-color option).

Ah! I misread that particular part of the code. It says "if (!*ws)", not 
-- as I read it -- "if (!ws)".

Ciao,
Dscho
