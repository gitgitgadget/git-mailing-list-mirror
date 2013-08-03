From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: Bug: Pulling remotes into an empty repo deletes the index
Date: Sat, 3 Aug 2013 12:59:23 -0400
Message-ID: <20130803165923.GD945@analysisandsolutions.com>
References: <CAJOTJ-AVamimToPo4oQ=O_Pg+mJHQhardO+NfU8b1dvRxg1KMA@mail.gmail.com>
 <CAJOTJ-Cgdg4CQs-3t1CsBkq_feVEpkoASzQSTATiVugjs+LL7w@mail.gmail.com>
 <20130803163915.GB945@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam A <hitsthings@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 18:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5fAu-0007dD-65
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 18:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab3HCQ7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 12:59:24 -0400
Received: from analysisandsolutions.com ([50.116.58.177]:60880 "EHLO
	analysisandsolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3HCQ7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 12:59:24 -0400
Received: by analysisandsolutions.com (Postfix, from userid 1001)
	id B926E18973; Sat,  3 Aug 2013 12:59:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=analysisandsolutions.com; s=default; t=1375549163;
	bh=z/qfV58hRLqzQXEfMYD/icvYgsBwSUSDd886szHsuDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcImEY2IdvsucK9FbMVduUO6lWgxa3rgohJfwj6E8i4FyTwdp9+Kn1TF6Kk/QJfsG
	 d6I6ifjjTAR7B2OcjuixyspmD93Ly4JpgEpLu7erGVRTfpXzSYfiIjxW3OX57ph7zp
	 pHO7fdi+rFMaOCt8o7zo+t3QjxneFLGZX5wly9jo=
Content-Disposition: inline
In-Reply-To: <20130803163915.GB945@analysisandsolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231606>

Hey Again Adam:

On Sat, Aug 03, 2013 at 12:39:15PM -0400, Daniel Convissor wrote:
> 
> All is not lost.  Your local files should be stored in the repository's
> reflog.  Examine the output of "git reflog".  You can then reset your
> working directory to obtain those files by doing something _like_
> "git reset --hard HEAD@{1}".

A further thought.  The most useful thing to do would probably be along
these lines...

git reflog  # as mentioned before
git checkout -b myinitialstuff HEAD@{<desired number>}
git log
git checkout master
git cherry-pick <hash of your first local commit>

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
        4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335
