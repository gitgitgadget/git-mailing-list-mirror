From: Peter Krefting <peter@softwolves.pp.se>
Subject: Using grafts file to rewrite history
Date: Wed, 25 Feb 2009 06:29:46 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0902250626300.9572@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 06:31:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcCMY-00067w-VV
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 06:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbZBYF3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 00:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbZBYF3v
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 00:29:51 -0500
Received: from ds9.cixit.se ([193.15.169.228]:56929 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbZBYF3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 00:29:50 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n1P5Tl0i009881
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 Feb 2009 06:29:47 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id n1P5TkaJ009874;
	Wed, 25 Feb 2009 06:29:46 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Wed, 25 Feb 2009 06:29:47 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111371>

Hi!

My googling powers have yet eluded to find me an answer to this:

Given an (unpublished) Git repository and a "grafts" file that slightly
re-orders commits, how do I reprocess this repository (using
git-filter-branch, probably) to have a true history according to the
"grafts" file?

I am trying to use git-import-tars to import non-linear development
history, and then use a grafts file to find the "proper" history. I
would like to re-order the history before i publish it in a public Git
repository.

-- 
\\// Peter - http://www.softwolves.pp.se/
