From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Re: Using different protocols for "pull" and "push".
Date: Fri, 05 Jun 2009 10:03:16 -0500
Message-ID: <4A2933B4.1060209@gmail.com>
References: <h09kk8$rb4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jun 05 17:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCb4D-0007I7-PZ
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 17:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbZFEPJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 11:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbZFEPJd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 11:09:33 -0400
Received: from pp0.asolutions.com ([66.236.120.143]:43392 "EHLO
	pp0.asolutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbZFEPJd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 11:09:33 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2009 11:09:33 EDT
Received: from acews2.asolutions.com (acews2.asolutions.com [192.168.3.88])
	by pp0.asolutions.com (8.14.1/8.14.1) with ESMTP id n55F38fs000813
	for <git@vger.kernel.org>; Fri, 5 Jun 2009 10:03:09 -0500
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <h09kk8$rb4$1@ger.gmane.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-06-05_08:2009-06-01,2009-06-05,2009-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0811170000 definitions=main-0906050095
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120778>

I typically set up a "push" remote when I need to do things like this. 
I've got a few projects where I get confused of which one is origin so I 
protect myself from pushing accidentally (I have to think for a second 
when pushing).

-Mike

Nikos Chantziaras wrote:
> Hi.
>
> I wonder if it's possible to setup Git (probably in .git/config) to 
> use SSH only for "git push" and use the git protocol for "git pull".  
> My current configuration is:
>
> [remote "origin"]
>         url = ssh://user@project.someserver.net/gitroot/project
>         fetch = +refs/heads/*:refs/remotes/origin/*
>
> Issuing a "git pull" command results in pulling using SSH (along with 
> asking for a password).  Is there a way to alter the configuration so 
> that a "pull" will use git:// instead of ssh:// ?
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
