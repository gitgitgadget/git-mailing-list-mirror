From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: RCS keyword expansion
Date: Thu, 11 Oct 2007 19:55:05 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Oct 11 20:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig3C9-0007a1-17
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 20:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027AbXJKSzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbXJKSzb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 14:55:31 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54592 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbXJKSz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 14:55:29 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2007 14:55:29 EDT
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JPR00F5ADS1E800@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 11 Oct 2007 19:55:13 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPR006ZHDRT7D80@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 11 Oct 2007 19:55:05 +0200 (CEST)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPR0020VDRS6F00@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 11 Oct 2007 19:55:05 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)	id 04A2A2FC18; Thu,
 11 Oct 2007 19:55:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 02A652FC0C	for <git@vger.kernel.org>; Thu,
 11 Oct 2007 19:55:06 +0200 (CEST)
In-reply-to: <86fy0hvgbh.fsf@blue.stonehenge.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60623>

Randal L. Schwartz:

> That's not a job for a source code manager to do.  It's a job for your 
> build/install tool.

Since there is no build step involved (my web site is just a CVS checkout at 
the moment), it's a job for the checkout step. I'd really want to avoid 
having a separate copy of the web site just so that I can do a "make 
install". That would sort of negate the savings in disk space I hope seeing 
by moving from CVS to Git.

-- 
\\// Peter - http://www.softwolves.pp.se/
