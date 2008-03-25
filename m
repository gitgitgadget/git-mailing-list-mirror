From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Hand-rolling migration to Git
Date: Tue, 25 Mar 2008 11:03:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0803251056570.8472@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 11:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je60j-0004r9-HJ
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbYCYKDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYCYKDY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:03:24 -0400
Received: from ds9.cixit.se ([193.15.169.228]:46090 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbYCYKDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:03:23 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2PA3LwE020132
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Mar 2008 11:03:21 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2PA3KX7020127;
	Tue, 25 Mar 2008 11:03:20 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 25 Mar 2008 11:03:21 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78169>

Hi!

I am looking for documentation on how to hand-roll a conversion to Git,
but I keep getting lost in the maze of similar-looking man pages. Is
there a tutorial, howto, or perhaps even just a list of recommended man
pages to read on importing project changes to Git?

I have projects of two different kinds that I need to import:

1. The "make a copy of the source code directory and edit the new copy"
source management system. I need to be able to import one directory at
a time, each describing a version controlled state. The date stamp on
the commits should probably be the most recent file in each directory.

2. A piece of software using PVCS (a RCS-like version control system
with added support for parallel development (using a locking model)). I
have a complete "trail file" which lists all commits done to the
repository in chronological order since the repository was created, and
can use that as a base. Since it has no concept of an atomic commit, I
need to semi-manually join commits by walking the trail file and
comparing lock sets, time stamps, commit messages and authors.

I can probably make the output from (2) look like from (1), so I
basically just need to find a pointer to information on how to
(re-)create the history with Git.

-- 
\\// Peter - http://www.softwolves.pp.se/
