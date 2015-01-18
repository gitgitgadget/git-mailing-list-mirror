From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: support exclude in 'git p4 sync'
Date: Sun, 18 Jan 2015 09:02:55 -0500
Message-ID: <20150118140255.GA18490@padd.com>
References: <1421528198-16749-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:10:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCqZ2-00018I-EC
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 15:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbbAROKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 09:10:48 -0500
Received: from honk.padd.com ([71.19.245.7]:53438 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbbAROKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 09:10:47 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jan 2015 09:10:47 EST
Received: from arf.padd.com (unknown [50.111.111.202])
	by honk.padd.com (Postfix) with ESMTPSA id 85BAC6371;
	Sun, 18 Jan 2015 06:02:57 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B0C1520BEC; Sun, 18 Jan 2015 09:02:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1421528198-16749-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262600>

luke@diamand.org wrote on Sat, 17 Jan 2015 20:56 +0000:
> The git-p4 'clone' subcommand has long had the option to specify
> parts of the repo to be excluded, on the command line. But this has
> not been present in 'sync', which makes it less than useful: as
> soon as you do a sync, the excluded parts start being repopulated
> as those directories are changed.
> 
> (You can achieve the same effect by using a client specification to
> do the exclusion, but that's then an extra step).
> 
> The code for doing the exclusion is actually all present in the base
> 'P4Sync' class: this change turns that on by moving the definition
> of the command-line switch.
> 
> It also updates the documentation and adds a test-case.
> 
> Thanks,
> Luke
> 
> And yes, I'm back to using version control systems other than git :-(

So sorry. I on the other hand have been fortunate enough to
switch to using only git.

Nevertheless, I read through the patch and it looks good and
makes sense. You've got my ack on this for what it's worth.
Hopefully someone else starts picking up the git-p4 maintenance
work. Hint.

		-- Pete
