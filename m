From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Some curl versions lack curl_easy_duphandle()
Date: Sun, 16 Oct 2005 23:58:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510162355480.26678@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510150038550.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzlbpbwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510151348080.12307@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051016215018.GG5509@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 23:58:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERGWh-0000pP-8q
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 23:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVJPV61 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 17:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVJPV61
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 17:58:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32390 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751289AbVJPV61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 17:58:27 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 248DA13EB7F; Sun, 16 Oct 2005 23:58:26 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 05B7BB4D67; Sun, 16 Oct 2005 23:58:26 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DF6555987A; Sun, 16 Oct 2005 23:58:25 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4B46D13EB7F; Sun, 16 Oct 2005 23:58:25 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051016215018.GG5509@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10173>

Hi,

On Sun, 16 Oct 2005, Nick Hengeveld wrote:

> On Sat, Oct 15, 2005 at 01:50:16PM +0200, Johannes Schindelin wrote:
> 
> > +#if LIBCURL_VERSION_NUM < 0x070c04
> > +#define NO_CURL_EASY_DUPHANDLE
> > +#endif
> 
> Is that the correct version number?  I've been using 7.10.6 and 
> curl_easy_duphandle() has been working fine.

I looked into CVS to find when curl_easy_duphandle() was introduced, and 
it was Nov 9, 2004. So I looked for the corresponding curl.h and found it 
says 0x070c04. I will look again...

Ciao,
Dscho
