From: Thell Fowler <git@tbfowler.name>
Subject: What's a good setup for submitting patches to the list properly?
Date: Wed, 19 Aug 2009 19:09:58 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 02:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdvEe-0004UJ-Jg
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 02:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZHTAKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 20:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbZHTAKW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 20:10:22 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:41656 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbZHTAKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 20:10:21 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MdvEV-0006fQ-5g
	for git@vger.kernel.org; Wed, 19 Aug 2009 19:10:23 -0500
X-X-Sender: almostautomated@GWPortableVCS
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126597>

Sorry for once again.

I haven't been able to figure out a good setup for posting patches to the 
list correctly, perhaps someone could tell me where I'm going wrong.

Alpine is setup to access git @ tbfowler.name with the 'postpone' folder 
being the 'Drafts' folder on the remote mail host, and a local mbox folder 
~/mail/git

Locally I prepped the emails using:

git format-patch --cover-letter --full-index -n 
--in-reply-to=1249428804.2774.52.camel@GWPortableVCS --thread --signoff -6 
--stdout>>~/mail/git

http://article.gmane.org/gmane.comp.version-control.git/124834

Thinking that the cover letter would be in reply to a previous thread, and 
that the rest would show as a reply to that.  After doing the 
format-patch, I went into Alpine's git folder selected the messages and 
saved them to the Drafts folder, then did 'compose' for each one, filling 
in the information I thought was needed.

At that point, the msg list looked flat, so I opened Evolution Mail and 
looked at them there, they cascaded properly, so I sent them.  Yet, now, 
looking on gmane each of the patch msgs is a top level post and the cover 
letter correctly posted as a reply to the previous thread.

What could I have done/checked before sending to make sure that these 
would have posted properly?

-- 
Thell
