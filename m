From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Wed, 13 Oct 2010 17:48:43 -0400
Message-ID: <1287006523.13553.4.camel@drew-northup.unet.maine.edu>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:49:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69CP-00058P-0t
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab0JMVsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:48:55 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:44645 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0JMVsz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:48:55 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9DLmocc015723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Oct 2010 17:48:50 -0400
In-Reply-To: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9DLmocc015723
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1287611330.93532@KcCRfMozmJPZ/pwbmq28uA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158983>


On Wed, 2010-10-13 at 14:37 -0700, Kevin Ballard wrote:
> I've been having a rather strange problem using manual hunk edit mode (`git add -p`, e) and emacs together. It seems every time I hit ^G inside of emacs in this one circumstance, the entire process instantly shuts down, both emacs and `git add`, and it doesn't even give emacs a chance to clean up the terminal, so I'm left with garbage across my display (the remains of the emacs window) and the terminal settings are screwed up enough that I have to close and reopen it (even `reset` doesn't fix everything). Has anybody else seen this, and if so, do you know what's going on? I cannot reproduce this with emacs outside of `git add -p`, and I cannot reproduce this with vim even inside of `git add -p`.

Is there some way to get a dump of the environment that emacs is seeing?
If we have that it will be easier to tell if this is an emacs problem or
a git problem.
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
