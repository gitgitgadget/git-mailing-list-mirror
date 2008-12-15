From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Followup: management of OO files - warning about "rezip" approach
Date: Mon, 15 Dec 2008 15:41:13 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0812151535410.21677@ds9.cixit.se>
References: <loom.20081214T123442-862@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 15:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCEea-0000eL-Mj
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 15:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYLOOlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 09:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbYLOOlT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 09:41:19 -0500
Received: from ds9.cixit.se ([193.15.169.228]:60320 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbYLOOlS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 09:41:18 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mBFEfEac007661
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Dec 2008 15:41:14 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mBFEfDmo007655;
	Mon, 15 Dec 2008 15:41:13 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <loom.20081214T123442-862@post.gmane.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 15 Dec 2008 15:41:14 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103169>

Sergio Callegari:

> E.g. patch the rezip script so that
> 
> PROFILE_UNZIP_ODF_UNCOMPRESS='-b -qq'
> PROFILE_ZIP_ODF_UNCOMPRESS='-q -r -D -0 -X'
> PROFILE_UNZIP_ODF_COMPRESS='-b -qq'
> PROFILE_ZIP_ODF_COMPRESS='-q -r -D -6 -X'

Yeah, that is exactly what I ended up doing.

I've been running the rezip script for quite a long time now,
versioning a spreadsheet that I update by adding stuff to up to several
times a week. Using this approach has shrunk the compressed .git
directory by about 90 % (before I started using rezip, it was about 9
megabytes, with rezip and 30 % more commits, it is now 1 megabyte).

-- 
\\// Peter - http://www.softwolves.pp.se/
