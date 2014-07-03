From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Show containing branches in log?
Date: Thu, 3 Jul 2014 15:18:42 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1407031517100.4693@ds9.cixit.se>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 16:18:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2hqf-00071P-1k
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 16:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbaGCOSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 10:18:48 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:50187 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752078AbaGCOSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 10:18:48 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s63EIhYu023148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 3 Jul 2014 16:18:43 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s63EIgFt023145;
	Thu, 3 Jul 2014 16:18:42 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 03 Jul 2014 16:18:43 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252864>

Robert Dailey:

> Is there a way to graphically see what is the "nearest" named ref to 
> the specified commit in the logs?

git log --graph --decorate commit..

will display all the commits that happened after the commit "commit", 
with the branch names indicated, with lines indicating the ancestry. 
That's the closest I can come to think of.

-- 
\\// Peter - http://www.softwolves.pp.se/
