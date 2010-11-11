From: "Dennis" <denny@dennymagicsite.com>
Subject: Looking for a way to set up Git correctly
Date: Wed, 10 Nov 2010 22:25:31 -0500
Message-ID: <BD94CB4FDD0C4462804E316F814A3CCA@denny>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 04:26:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGNnc-0006zt-1a
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 04:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301Ab0KKDZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 22:25:51 -0500
Received: from fmailhost06.isp.att.net ([204.127.217.106]:40980 "EHLO
	fmailhost06.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab0KKDZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 22:25:50 -0500
DKIM-Signature: v=1; q=dns/txt; d=ameritech.net; s=dkim01;
      i=dennismv@ameritech.net; a=rsa-sha256; c=relaxed/relaxed;
      t=1289445950; h=Content-Transfer-Encoding:Content-Type:
     MIME-Version:Date:Subject:To:From:Message-ID; bh=6mMFBifc8El9n/arGm
     UMguWjhPvuLBY1oXFLLFRp1lU=; b=S433Y5N5IYipILIfSwH+ZnnWz82w2exedN4zT
     nV6OAGh7KJI+b0rF06l+BQSAYf6qH5d26rehNbdAeAah21Ryg==
Received: from denny (d118-75-134-244.clv.wideopenwest.com[75.118.244.134])
          by isp.att.net (frfwmhc06) with SMTP
          id <20101111032536H0600lqclme>; Thu, 11 Nov 2010 03:25:37 +0000
X-Originating-IP: [75.118.244.134]
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161205>

I have a situation.

I have started a web project (call it branch1), and have maintained it 
without a version control system for quite some time.
Then, I copied it to another folder (branch2) and while the project remained 
essentially the same, I have changed a few of internal paths and some 
variable names inside the files.
Then, a few months later on, I copied branch2 to a folder called branch3 and 
also modified some of the variable names and some of the internal structure 
of the files.

Thus I ended up with 3 folders on my local HDD with pretty much the same 
file names and folder structure and everything, and most of the file 
content, except those small deltas that made those files different for each 
branch.

I guess it's never too late, and now I want to put these 3 projects into a 
version control system, and I chose git.

Now, this can be either really simple or really complicated.  My first 
question is:  how do I set the repository up in the proper way where I could 
work on all 3 projects separately, with additional possibility of working on 
branch1 only and later committing my changes to branch2 and branch3.  (Since 
projects are virtually identical, a fix in one branch usually needs to be 
propagated to other branches)
First, I assume I will use a single repository for this.  Then, do I simply 
set up 3 branches and start using them, or is there a way to set git up to 
capitalize on the projects being nearly identical?

My second question is that each branch has a huge folder with image data. 
By huge I mean 1 to 4Gb, depending on the branch.  Since images are not 
directly relevant to the development work, is there a way to not include 
those folders in git?  To be honest though, I probably should include them, 
but I wanted to ask about this separately as git repository may be get 
large, since all 3 branches may grow to 9Gb or so.

Thus I am looking for a git way to handle my situation.  Is this simple or 
is is hard?
Are there any recommendations before I jump in?
Dennis 
