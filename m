From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: msysGit: "git filter-branch --subdirectory-filter" doesn't work at
 all
Date: Mon, 26 May 2008 21:31:04 +0200
Message-ID: <483B0FF8.6070700@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 21:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0iQP-0004p2-7D
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 21:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960AbYEZTbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbYEZTbK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 15:31:10 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:38535 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbYEZTbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 15:31:09 -0400
Received: from [84.176.90.138] (helo=[192.168.2.100])
	by smtprelay06.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1K0iPS-0004nu-Pt
	for git@vger.kernel.org; Mon, 26 May 2008 21:31:06 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82948>

I'm using msysGit 1.5.5.1015.g9d258 (the latest). When I try

$ git filter-branch --subdirectory-filter perl

in my git.git repo it only says

Usage: C:/Programme/Git/bin/git-filter-branch ... [--subdirectory-filter 
<directory>] ...

I.e. git-filter-branch doesn't work at all under msysGit. No matter
what other switches I give. The answer is always only the usage
information. Is this a known issue or am I doing sth. wrong?

Not that I currently have any application for git-filter-branch,
I'm just curious.

    Dirk
