From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: [PATCH] bisect view: check for MinGW32 and MacOSX in addition to
 X11
Date: Thu, 13 Mar 2008 20:19:46 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.1.00.0803132018410.23484@perkele.intern.softwolves.pp.se>
References: <alpine.LSU.1.00.0802141228300.30505@racer.site>
 <Pine.LNX.4.64.0802151038520.18292@ds9.cixit.se>
 <alpine.LSU.1.00.0802151050340.30505@racer.site>
 <Pine.LNX.4.64.0802151346000.18292@ds9.cixit.se>
 <alpine.LSU.1.00.0803101919060.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 21:21:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZtuy-00033Q-SS
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 21:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbYCMUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYCMUUH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 16:20:07 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64428 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462AbYCMUUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 16:20:05 -0400
X-Greylist: delayed 3612 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Mar 2008 16:20:05 EDT
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JXO00L0ZOD4IN00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 13 Mar 2008 20:19:52 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXO00999OCZ1T90@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 13 Mar 2008 20:19:47 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXO00IFWOCYX2E0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 13 Mar 2008 20:19:47 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id D447E2FC2D; Thu,
 13 Mar 2008 20:19:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id D11D02FC2C; Thu, 13 Mar 2008 20:19:46 +0100 (CET)
In-reply-to: <alpine.LSU.1.00.0803101919060.3975@racer.site>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77134>

Johannes Schindelin:

> Can you please test this patch (both from interactive and ssh'ed
> sessions)?

It does indeed seem to work. I get gitk when running from a local Cygwin 
shell and from a local cmd.exe shell, and git log when logging in over ssh.

Thank you.

-- 
\\// Peter - http://www.softwolves.pp.se/
