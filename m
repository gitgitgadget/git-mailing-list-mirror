From: Johan Herland <johan@herland.net>
Subject: Re: Attributes for commits
Date: Sat, 09 Jun 2007 15:49:39 +0200
Message-ID: <200706091549.39383.johan@herland.net>
References: <466AA714.4050500@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Paul Franz <thefranz@comcast.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 15:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx1K4-0004Lw-Gt
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 15:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbXFINtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 09:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbXFINtn
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 09:49:43 -0400
Received: from smtp.getmail.no ([84.208.20.33]:53099 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbXFINtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 09:49:42 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00101FQTSI00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 15:49:41 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00GS0FQRHX30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 15:49:40 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00008FQRUX20@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 15:49:39 +0200 (CEST)
In-reply-to: <466AA714.4050500@comcast.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49572>

On Saturday 09 June 2007, Paul Franz wrote:
>     I am a ClearCase administrator and one of the things that I love 
> about it is the ability to assign attributes to versions of files. Is 
> there anybody thinking of adding the ability to assign attributes to a 
> commit? I ask because I was thinking about how I would move from 
> ClearCase to git and part of our process is to assign the BugNum 
> attribute to every checkin so that we can see what bugs have been fixed. 
> We also track the files checked in the bug tracking software to. Thus 
> giving us a two way linkage between repository and the bug tracking 
> system. This is VERY useful. And I was wondering if there are any 
> thought to this for commits.
> 
> Now, I will be honest it is possible that this has already been done (I 
> have not read all the documentation yet) and I am justing wasting 
> bandwidth. In which, please excuse my ignorance and tell me to just RTFM.

Well, we're sort of in the process of getting there. I posted an initial
proof-of-concept implementation of git 'notes' a while back. Git notes is
a general mechanism for providing free-form annotations on git objects
after they've been created. My initial posting sparked a discussion [1],
and I'm currently in the process of reimplementing the notes concept
based on the outcome of that discussion.

So the thing you want will hopefully be in a future release.


Have fun!

...Johan

[1]: http://thread.gmane.org/gmane.comp.version-control.git/46770/focus=48540

-- 
Johan Herland, <johan@herland.net>
www.herland.net
