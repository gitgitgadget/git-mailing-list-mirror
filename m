From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: how to hide some branches
Date: Mon, 1 Dec 2008 09:01:06 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0812010857360.5440@ds9.cixit.se>
References: <493261C9.4040608@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 09:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L73kB-0007hz-Id
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 09:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbYLAIBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 03:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYLAIBN
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 03:01:13 -0500
Received: from ds9.cixit.se ([193.15.169.228]:36883 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbYLAIBM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 03:01:12 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mB1818ac007785
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 1 Dec 2008 09:01:08 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mB1816iX007780;
	Mon, 1 Dec 2008 09:01:06 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <493261C9.4040608@obry.net>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 01 Dec 2008 09:01:08 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102000>

Pascal Obry:

> I'd like to hide some (not removing them).
> Is there a solution for this?

git branch --no-merged

shows only the branches that has not been merged into your current
working branch. That might be one solution.

I don't know if it is possible to set it as a default option, but I
would also appreciate such a feature.


I use the "git branch --merged" to move away merged branches into a
different "namespace" (branch "a" becomes "merged/a"):

  for branch in $(git branch --merged master | egrep -v 'merged|master');
  do
    git branch -m "$branch" "merged/$branch"
  done

-- 
\\// Peter - http://www.softwolves.pp.se/
