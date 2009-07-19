From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: how to start with non-master branch?
Date: Sun, 19 Jul 2009 18:13:10 +0200
Message-ID: <4A634616.9020302@dirk.my1.cc>
References: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSZ1S-0003vP-IU
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 18:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbZGSQNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 12:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbZGSQNP
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 12:13:15 -0400
Received: from smtprelay10.ispgateway.de ([80.67.29.24]:39236 "EHLO
	smtprelay10.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbZGSQNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 12:13:13 -0400
Received: from [84.176.111.111] (helo=[192.168.2.100])
	by smtprelay10.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MSZ0h-0008Hj-DS; Sun, 19 Jul 2009 18:13:11 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123554>

Am 19.07.2009 14:53 schrieb Rustom Mody:
> I want my first commit to be on a non-master branch.
> So after the git init I do
> $ git checkout -b newbranch
> 
> I get
> fatal: You are on a branch yet to be born
> 
> Of course I can get by with making the first commit on master and then
> switching.
> 
> But wondering if I am missing something basic?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

What about renaming the "initial master", i.e.:
git init
git add .
git commit -m "intial checkin"
git branch -m non-master-branch

and later adding a master just as any other branch, i.e.
git checkout -b master

Unfortunately renaming doesn't work before the first commit, I got an 
error similar to yours.

I think the name "master" is just a convention and there's nothing 
special about that branch. Could've been called "main" or sth. as well 
when Linus invented it.

Dirk
