From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Migrating from Serena PVCS to GIT
Date: Thu, 14 Jan 2010 10:51:16 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1001141047350.15144@ds9.cixit.se>
References: <loom.20100114T095059-276@post.gmane.org> <alpine.DEB.2.00.1001141007260.15144@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Rivka Pollack <Rivka_P1@verifone.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:51:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVMMX-0006vV-VX
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 10:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab0ANJv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 04:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844Ab0ANJv3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 04:51:29 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:60264 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750753Ab0ANJv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 04:51:28 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o0E9pG3j020137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jan 2010 10:51:17 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o0E9pGCM020133;
	Thu, 14 Jan 2010 10:51:16 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.1001141007260.15144@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 14 Jan 2010 10:51:17 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136979>

Following up my own reply:

> There is a script for PVCS-to-RCS export in the CVS source archives (I 
> needed to hack the scripts a bit to get them to run properly, 
> unfortunately I do not have access to those changes).

IIRC, the changes I needed to make was to ensure that the files did not get 
their keyword expanded again by RCS (adding -ko mode; this also survives 
into Git), since the revision numbers are off-by-one in RCS compared to PVCS 
(RCS starts at 1.1, PVCS at 1.0). I also had to extend the list of binary 
file types in the PVCS-to-RCS script to cover all the binary files that were 
checked in.

-- 
\\// Peter - http://www.softwolves.pp.se/
