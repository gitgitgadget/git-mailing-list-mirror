From: daicoden <daicoden@copypastel.com>
Subject: Re: How to host a github?
Date: Sat, 19 Sep 2009 14:01:47 -0700 (PDT)
Message-ID: <25525401.post@talk.nabble.com>
References: <24713161.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 19 23:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mp77d-0005jU-1t
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 23:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZISVBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbZISVBo
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 17:01:44 -0400
Received: from kuber.nabble.com ([216.139.236.158]:52180 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbZISVBn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 17:01:43 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Mp73z-0003aq-AH
	for git@vger.kernel.org; Sat, 19 Sep 2009 14:01:47 -0700
In-Reply-To: <24713161.post@talk.nabble.com>
X-Nabble-From: daicoden@copypastel.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128827>




jvsrvcs wrote:
> 
> I want to share code with a few co-workers and I want to use git.
> 
> I installed git (cygwin), created a /project/ and then $cd project
> and then $git init
> 
> I have found so much documentation as to what to do next, that
> I'm confused.
> 
> Do I have to create an account on github in order to share code with
> a few local developers?
> 
> Could I run some sort of server on my laptop in order to share code?
> (we only need to share during office hours).  Basically I just
> want to share code but do not want to sign up for an account
> on github.
> 
> How do I work this?
> 
> thanks
> 
> jvsrvcs
> 

Hey,  assuming you have shell access into your laptop, create a user named
git.  You don't have to do this but you want to give everyone access to an
account on the laptop.  You could also create a usergroup and add the
project folder to that group and give all your developers access to that
group.

Either-way once everyone is able to log onto the laptop make a new directory
called project.git.  Then go into that directory and use git --bare init.

Assuming you created a user named git you can then check the code out via

git clone git@localhost:project.git

to start things off from the source you will be working on you can then use:

git init
touch 'Readme'
git add Readme
git commit -m 'Initial Comit'
git remote add origin git@ip:project.git
git push origin master

-- 
View this message in context: http://www.nabble.com/How-to-host-a-github--tp24713161p25525401.html
Sent from the git mailing list archive at Nabble.com.
