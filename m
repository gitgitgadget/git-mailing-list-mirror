From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: change remote to track new branch
Date: Fri, 2 Aug 2013 22:40:32 -0400
Message-ID: <20130803024032.GA28666@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 03 04:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Ru6-0000w3-Pu
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 04:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab3HCCtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 22:49:10 -0400
Received: from analysisandsolutions.com ([50.116.58.177]:60501 "EHLO
	analysisandsolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab3HCCtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 22:49:09 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2013 22:49:09 EDT
Received: by analysisandsolutions.com (Postfix, from userid 1001)
	id EB6EAAFB64; Fri,  2 Aug 2013 22:40:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=analysisandsolutions.com; s=default; t=1375497632;
	bh=LJzMBTOTPW3T8MSQw8zinZN1gIwPFpRkZdpfthAz8r0=;
	h=Date:From:To:Subject:From;
	b=ELL4xd+86U48fCUwqfwV5T0Tj8enDODBe3wxYgDzcjT6RTJs/8rzgRM9IJ7YaTyHD
	 1OsLkBRZnfW+1gQpDRmcLhEXjFuFZKMVWuSL2oVkg0ubaUn6X15uOtSBYAuAmBklGU
	 YXfA04QusEQ2IzsjmhkoNV6rke+XXSAyp23/G1KY=
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231556>

Hi:

Long ago I added a remote to my repo.  It is set to track what was then
WordPress' main release branch (3.4-branch) and created a local branch
to use it.  Well, time marches on.  I want to update my remote and
branch to track the new main release branch (3.6-branch).

Here's how I set things up at the time:

git remote add -t 3.4-branch -f wp https://github.com/WordPress/WordPress
git checkout -b wp wp/3.4-branch

I've tried various fetch, remote and branch commands to effectuate this
change, to no avail.  I get messages like "Not a valid ref."

I know a major part of this is that my repo only knows of one remote
branch (of the many that exist).  What I don't know are the commands
needed to fetch the right remote branch, set my remote and local branch
to track it.  Your help will be appreciated, please.

Here's some information on the current state of things:

vvvvvvvvvvvvvvvvvvvv
^^^^^^^^^^^^^^^^^^^^
git branch -av
  dev                                 a18677e [ahead 153] backup of 3.4 db
  master                              0d6f9b5 Merge branch 'dev'

* wp                                  42abc67 [ahead 5] Merge branch
'3.4-branch' of https://github.com/WordPress/WordPress into wp

  remotes/git_push_deployer/wordpress c8a5d69 Make my branch names generic.
  remotes/prod/HEAD                   -> prod/master
  remotes/prod/master                 0d6f9b5 Merge branch 'dev'
  remotes/wp/3.4-branch               b535358 POT, generated from r24100
  remotes/wpconfig/master             3e45a81 LSS 0.27.0.
^^^^^^^^^^^^^^^^^^^^

vvvvvvvvvvvvvvvvvvvv
git remote show wp
* remote wp
  Fetch URL: https://github.com/WordPress/WordPress
  Push  URL: https://github.com/WordPress/WordPress
  HEAD branch: master
  Remote branch:
    3.4-branch tracked
  Local branch configured for 'git pull':
    wp merges with remote 3.4-branch
  Local ref configured for 'git push':
    master pushes to master (local out of date)
^^^^^^^^^^^^^^^^^^^^

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
        4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335
