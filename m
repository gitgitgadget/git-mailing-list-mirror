From: bob <kranki@mac.com>
Subject: Centralized repository
Date: Sat, 24 Feb 2007 21:14:27 -0500
Message-ID: <EF7846A2-C573-4018-B399-EBBEEE2812A4@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 03:28:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL985-00015m-St
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 03:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933632AbXBYC2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 21:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933633AbXBYC2h
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 21:28:37 -0500
Received: from smtpout.mac.com ([17.250.248.175]:57834 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933632AbXBYC2g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 21:28:36 -0500
X-Greylist: delayed 840 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Feb 2007 21:28:36 EST
Received: from mac.com (smtpin06-en2 [10.13.10.151])
	by smtpout.mac.com (Xserve/8.12.11/smtpout05/MantshX 4.0) with ESMTP id l1P2EauT022668
	for <git@vger.kernel.org>; Sat, 24 Feb 2007 18:14:36 -0800 (PST)
Received: from [192.168.2.23] (c-71-196-35-31.hsd1.fl.comcast.net [71.196.35.31])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin06/MantshX 4.0) with ESMTP id l1P2EWMi014161
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 24 Feb 2007 18:14:35 -0800 (PST)
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40533>

I know that this has been mentioned before.  So, I will only bring it  
up once (from me at least).

I have a project that is currently over 2gigs without .git and  
growing.  It is a personal website that I use to provide/remind me of  
things that I used to remember when I was younger.  When you put a  
GIT repostitory in it, you get almost 4gigs of space taken (and this  
amount is growing all the time).  Then I keep it centralized, because  
I own several machines (OK, way too many, over 20 currently,  
dedicated to Folding@Home).  So, it takes up a lot of disk space over  
all those machines.

Because it is so big, cloning no longer works.  I can't remember the  
exact errors, but I gave up and now tar up  a semi-current version  
and untar it on a new/re-installed machine.  Then I do a "pull" to  
update it and that works when the clone doesn't.  I should mention  
that I have only 2 windows machines, but run GIT on all the rest  
which are Linux and MacOSX machines.

Anyway, for this one repository, I would really like GIT to support  
the CVS/SVN central repository system.  The rest of the time, I am  
quite happy with GIT's distributed system even though all of my  
repositories are really just for me.

Last, thanks for GIT.  I really enjoy it and use it daily and have  
never had it fail on me (no matter what I did!)!

Bob White
