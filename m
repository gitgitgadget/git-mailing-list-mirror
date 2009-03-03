From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 03 Mar 2009 06:51:59 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903030649231.2012@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <200903022058.33392.robin.rosenberg.lists@dewire.com>
 <alpine.DEB.2.00.0903022146510.20047@perkele.intern.softwolves.pp.se>
 <200903022221.10254.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 06:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeNZQ-0007hz-Cx
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 06:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbZCCFwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 00:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbZCCFwH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 00:52:07 -0500
Received: from smtp.getmail.no ([84.208.20.33]:43222 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbZCCFwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 00:52:06 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFX00B031MP8800@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 06:52:01 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX0008J1MNLT40@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 06:51:59 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFX009ZC1MNPH60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 03 Mar 2009 06:51:59 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 47A3D2FC06; Tue,
 03 Mar 2009 06:51:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 43ADE2FBBE; Tue, 03 Mar 2009 06:51:59 +0100 (CET)
In-reply-to: <200903022221.10254.robin.rosenberg.lists@dewire.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112001>

Robin Rosenberg:

> Not sure what that is.

"Invariant" is defined in an old RFC as the common subset of several 
ASCII-like and ASCII-based encodings. This was back before the MIME days, 
IIANM.

> I mean that in a local nordic, setting people can use 
> iso-8859-1|15/windows-1252/UTF-8 for their needs be means of converting 
> the characters as-needed without loss, with very few practial 
> restrictions.

Indeed. The trick is to have the storage (in this case, Git and it's tree 
objects) storing the file name data in a commonly agreed-upon way. Then it 
is simple to convert at the end-points.

> Just because I use UTF-8 doesn't mean I use start using more characters in 
> practice.

Most people do not, no. But using a Unicode encoding means that they at 
least have the option. Sometimes, having to mangle stuff down to ASCII is a 
pain.

-- 
\\// Peter - http://www.softwolves.pp.se/
