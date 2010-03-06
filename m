From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: a few beginner git questions
Date: Sat, 6 Mar 2010 02:01:50 -0500
Message-ID: <20100306070150.GB14424@lifeintegrity.com>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 08:11:41 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnoAm-0005ws-UL
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 08:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996Ab0CFHLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 02:11:35 -0500
Received: from static-173-48-39-13.bstnma.fios.verizon.net ([173.48.39.13]:33731
	"EHLO lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0CFHLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 02:11:34 -0500
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Mar 2010 02:11:34 EST
Received: from vent.lifeintegrity.com (Wireless_Broadband_Router [173.48.39.13])
	by submission.lifeintegrity.com (Postfix) with ESMTPS id E05B3586
	for <git@vger.kernel.org>; Sat,  6 Mar 2010 07:01:50 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id A4B263040BA; Sat,  6 Mar 2010 07:01:50 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141605>

On 2010-03-06T00:42:40, Thomas Anderson wrote:
> 1. When do you commit changes and when do you stage changes?  Or maybe
> more to the point, what's the difference between doing "stage, commit,
> stage, commit" and "stage, stage, commit"?

The former gives you one commit and the latter two comments.  
Staging (git add) is local while commits can shared with others 
(git push).

> 2. What's the difference between merging and pushing?  In CVS, you
> merge code by manually adding changes.  ie. the CVS client doesn't do
> the merging - you do.  Yet in Git Gui, there's a Merge menu button, as
> if it's now supposed to be somehow automated?

pushing is how you copy the data to another repository while 
merging is integrating multiple versions in into a single new 
version.

> 3. Creating branches in Git Gui is easy enough but it's unclear to me
> how to switch back to the trunk once you've created a branch.

git checkout master (which is the default name for "trunk")

<http://git.wiki.kernel.org/index.php/GitFaq#How_do_I_access_other_branches_in_a_repository.3F>

> 4. I clone git://github.com/symfony/symfony.git to c:\git\test\root
> and clone that to c:\git\test\clone.  I then blank
> c:\git\test\clone\README, stage it, commit it and push it and the
> change does not appear in c:\git\test\root\README.  I then reopen Git
> Gui and open root and there I see the blanked README as an uncommited
> state change.  I commit it and the change still does not appear in
> c:\git\test\root\README.  Is this what Git should be doing?

<http://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F>


/allan
-- 
Allan Wind
Life Integrity, LLC
<http://lifeintegrity.com>
