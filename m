From: "Roman V. Shaposhnik" <rvs@sun.com>
Subject: Re: git branch diagram
Date: Thu, 17 Apr 2008 19:29:07 -0700
Message-ID: <1208485747.26863.246.camel@goose.sun.com>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Patrick.Higgins@cexp.com
X-From: git-owner@vger.kernel.org Fri Apr 18 04:19:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmgCQ-0005rW-Ad
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 04:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbYDRCSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 22:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYDRCSq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 22:18:46 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:37560 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYDRCSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 22:18:46 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3I2Ij9M025433
	for <git@vger.kernel.org>; Thu, 17 Apr 2008 19:18:45 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZI00F01102Q700@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Thu, 17 Apr 2008 19:18:45 -0700 (PDT)
Received: from [192.168.0.103] ([76.21.110.21])
 by fe-sfbay-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZI007J9139NO30@fe-sfbay-09.sun.com>; Thu,
 17 Apr 2008 19:18:45 -0700 (PDT)
In-reply-to: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
X-Mailer: Evolution 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79862>

On Thu, 2008-04-17 at 11:00 -0600, Patrick.Higgins@cexp.com wrote:
> I am trying to get my employer to start using git and have found the distributed model and git's 
> branching to be one of the hardest parts to explain and understand. I put together the attached 
> diagram (done with graphviz so some things are not in the most logical place)

Just as a usability comment: I believe that you should color-code or 
enumerate your arrows based on what part of the workflow they belong to.

> Unfortunately, I don't understand things well enough myself to know if the diagram is correct
> or not. I read in the stgit docs that developing directly in the master branch is discouraged 
> by convention, but I don't really understand why. The git tutorial shows work happening directly
> in master, so I wasn't sure if that's a convention that only makes sense for stgit or for plain
> git, too.
> 
> In my diagram, I am assuming that most developers work in master, and make branches for their own 
> long-lived projects and experimental things.

Speaking of diagram: when you say that inter-repo arrows are pulls, 
does it mean that you are not allowing developers to push their changes
back to the origin? If you're really trying to build your workflow  
around the pull-only, who does the pulling? IOW, who controls the
"Project Repo" (the big box in the middle)?

> Does my diagram make sense? Are there any suggestions or corrections?

Here are my comments (beware: they do not come from a Git guru, although
I'm trying to make my employer take Git seriously as well):
   * It looks like "Integration Repo" is really a Superproject that
     consists of submodules. Was that the intention?
   * do you really need dev[123]/master branches in the "Project Repo"?
   * I don't really understand what the smaller boxes labels "Local
     branches" are supposed to represent.

Thanks,
Roman.
