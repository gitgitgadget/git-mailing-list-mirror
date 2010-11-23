From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git branch workflow
Date: Tue, 23 Nov 2010 10:47:19 -0500
Message-ID: <1290527239.10892.12.camel@drew-northup.unet.maine.edu>
References: <20101122170805.8jtzkqwxpcog0kgk@dennymagicsite.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: denny@dennymagicsite.com
X-From: git-owner@vger.kernel.org Tue Nov 23 16:49:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKv7Q-0007XV-RA
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 16:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab0KWPtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 10:49:10 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:43699 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab0KWPtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 10:49:09 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oANFlNdk023444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Nov 2010 10:47:28 -0500
In-Reply-To: <20101122170805.8jtzkqwxpcog0kgk@dennymagicsite.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oANFlNdk023444
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291132078.97321@YW8+EilXdEDbeL7kCKgnuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161974>


On Mon, 2010-11-22 at 17:08 +0000, denny@dennymagicsite.com wrote:
> my website was small enough where I usually fixed everything live on  
> production server, including adding new features, doing bug fixes and  
> so on.
> 
> Now, with git I can create branches in whatever order I want, and then  
> merge them whenever I want and push things to production whenever I  
> want.
> With this, comes confusion of what a good branch workflow is.  And  
> this will be my question -- in what order and from which branches to I  
> create new branches and how do I merge them back.
> 
> Consider a specific scenario:
> I am on dev server on master branch and I want to develop a specific  
> feature F.
> I cut a Feature branch F from master and start working on the feature.  
>   Once I am done with most of the work on F and it works reasonably  
> well, I want to push it to production, but .. before I do I realize  
> that I want to make some CSS fixes to the site, unrelated to other  
> branches, and I can wait with pushing Feature branch to Production  
> until I fix up CSS reasonably well.
> Here is the question:  do I cut the CSS branch from Master or do I cut  
> it from the Feature branch?
> 
> If I want to keep close to my original before-git workflow, I say, either
> *  merge Feature with Master
> *  cut CSS branch from Master
> *  do CSS fixes
> *  merge CSS with Master
> *  push Dev Master to Prod Master
> 
> or
> *  cut CSS branch from Feature, as Feature already has latest code
> *  when I am done with CSS, merge CSS into Feature
> *  merge Feature into Master (and remove Feature)
> *  push Dev Master to Prod Master
> 
> There are tons of other variations that are possible.  Which workflow  
> is preferred for this scenario?
> 
> Supplementary questions that may help define a good workflow for my case:
> *  What if later a bug is discovered in the Feature.  If I already  
> merged Feature branch into Master and deleted Feature branch, do I  
> create a FeatureBugFix branch?  Or do I keep the original Feature  
> branch without removing it for a while?  If so, for how long do I keep  
> it?  Do I perhaps keep a general BugFix branch instead that I don't  
> remove?
> *  currently I am the only developer working on the code.  This will  
> not change in the forseeable future.
> 
> Dennis

Each may be overkill, but perhaps these will give you some ideas:
http://nvie.com/posts/a-successful-git-branching-model/

Referencing the above and other inspirations:
http://www.silverwareconsulting.com/index.cfm/2010/9/13/A-Git-Workflow-for-Open-Source-Collaboration--Part-I--Introduction

Good luck finding something that works for you!

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
