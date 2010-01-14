From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Migrating from Serena PVCS to GIT
Date: Thu, 14 Jan 2010 10:10:18 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1001141007260.15144@ds9.cixit.se>
References: <loom.20100114T095059-276@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Rivka Pollack <Rivka_P1@verifone.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:10:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLix-0000Ok-22
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 10:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593Ab0ANJKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 04:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559Ab0ANJKd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 04:10:33 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:38576 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756550Ab0ANJKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 04:10:30 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o0E9AJrT017961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jan 2010 10:10:19 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o0E9AIVi017957;
	Thu, 14 Jan 2010 10:10:19 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <loom.20100114T095059-276@post.gmane.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 14 Jan 2010 10:10:19 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136975>

Rivka Pollack:

> Is there a simple way to migrate from Serena PVCS, with all of our older, 
> versioned, documentation, into GIT repositories?

The only more-or-less reliable export from PVCS that I have found is to RCS. 
There is a script for PVCS-to-RCS export in the CVS source archives (I 
needed to hack the scripts a bit to get them to run properly, unfortunately 
I do not have access to those changes). It needs to be run on a machine 
that has both PVCS and RCS binaries installed, and it needs to check out 
every revision for every file, so it does take some time to run.

After doing that, I moved the RCS files to a CVS-like directory layout and 
imported them into Git using one of the CVS-to-Git migration tools.

A tedious process, but it can be done.

-- 
\\// Peter - http://www.softwolves.pp.se/
