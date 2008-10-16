From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 10:48:04 +0100
Message-ID: <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net> <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl> <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Pieter de Bie" <pdebie@ai.rug.nl>, "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 11:49:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqPTv-0005sb-64
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 11:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbYJPJsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 05:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbYJPJsJ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 05:48:09 -0400
Received: from speed.simplicidade.org ([81.92.204.129]:44302 "HELO
	speed.simplicidade.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752670AbYJPJsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 05:48:08 -0400
Received: (qmail 1567 invoked from network); 16 Oct 2008 09:48:13 -0000
Received: from bl4-247-138.dsl.telepac.pt (HELO [192.168.0.201]) (81.193.247.138)
  (smtp-auth username melo@simplicidade.org, mechanism cram-md5)
  by speed.simplicidade.org (qpsmtpd/0.43rc1) with (AES256-SHA encrypted) ESMTPSA; Thu, 16 Oct 2008 10:48:13 +0100
In-Reply-To: <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
X-Priority: 3 (Normal)
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98357>


On Oct 15, 2008, at 3:51 PM, Lars Hoss wrote:

>> Works for me on Leopard
>>
>> Vienna:a pieter$ git submodule add ~/projects/GitX/ gitx
>> Initialized empty Git repository in /Users/pieter/a/gitx/.git/
>> Vienna:a pieter$ git st
>> # On branch master
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>> #
>> #	new file:   .gitmodules
>> #	new file:   gitx
>> #
>> Vienna:a pieter$ git --version
>> git version 1.6.0.2.415.gf9137
>
> My git version "1.6.0.2" says:
>
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   .gitmodules
> #	new file:   lib
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #	lib/
> git --version
> git version 1.6.0.2
>
> Git was build from macports.

hmms.. Really, I know about fink and Macports and all others, but I'm  
using Mac OS X since version 10.1 (when compiling OSS software was  
near impossible due to Apple decisions) and I've always had better  
results with compiling my own than using any of those OSS repositories.

I understand the appeal, it seems easier, but I would recommend that  
you compile yourself the software packages you depend on.

Regarding git, I saw a git-build.sh script floating around. If you  
cannot find it, you might want to try my own recipe (http://tinyurl.com/4ayze6 
). I compile git master every day (cron) and thats the one I use on my  
main machine.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
