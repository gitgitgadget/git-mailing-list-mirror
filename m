From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Recording merges after repo conversion
Date: Tue, 9 Oct 2007 08:09:36 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 09:10:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If9E1-0007jW-Oz
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 09:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbXJIHJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 03:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXJIHJo
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 03:09:44 -0400
Received: from ds9.cixit.se ([193.15.169.228]:51837 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbXJIHJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 03:09:44 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9979bnQ028817
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Oct 2007 09:09:37 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9979auw028812;
	Tue, 9 Oct 2007 09:09:36 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 09 Oct 2007 09:09:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60365>

Hi!

I have a couple of repositories converted from CVS to Git using
parsecvs. Some are just converted, some I've continued to develop after
the conversion (and cloned a couple of times).

Since parsecvs gave me all the CVS branches, I would like to record the
merge points in the Git history, if possible. I have commited merges
with comments like "merged <branchname>", so I can probably find them
quite easily, and I do have the imported CVS branches available. Can I
record the merge information so git knows about them?

Is it safe to do so on a repository that has already been cloned (i.e,
will a later push/pull work)?

-- 
\\// Peter - http://www.softwolves.pp.se/
