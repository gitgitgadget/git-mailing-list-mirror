From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 11:36:40 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se>
References: <1233137498146-2231416.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Wed Jan 28 11:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS7oB-0007LP-2I
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbZA1Kgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZA1Kgq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:36:46 -0500
Received: from ds9.cixit.se ([193.15.169.228]:43049 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbZA1Kgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:36:45 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0SAafac012880
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Jan 2009 11:36:41 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n0SAaf2E012874;
	Wed, 28 Jan 2009 11:36:41 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1233137498146-2231416.post@n2.nabble.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Wed, 28 Jan 2009 11:36:41 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107523>

Zabre:

> I delete one file in the new branch
> $ git rm d.txt
> $ ls
> a.txt b.txt c.txt

Here you have not yet committed the change, so the change is only in
the staging area. You need to

  git commit

to create a commit on your branch.

> Then I go back to the master branch and list the files there
> $ git checkout master

Since you have not yet made any commits to your branch, master and new
both point to the same commit, meaning that this is does nothing but
changes which branch you are committing to.

> $ls
> a.txt b.txt c.txt

You are in the same place as you were a moment ago, but you have told
Git that you want to commit the removal to master instead of new.

-- 
\\// Peter - http://www.softwolves.pp.se/
