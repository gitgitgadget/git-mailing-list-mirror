From: Adam Roben <aroben@apple.com>
Subject: Re: Switching branch before commit
Date: Thu, 10 May 2007 13:02:04 -0700
Message-ID: <CAD30837-B0EB-4752-B563-DE2517CFF0A1@apple.com>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496E7@MBGMail01.mobot.org>
Mime-Version: 1.0 (Apple Message framework v884)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ron Parker <ron.parker@mobot.org>
X-From: git-owner@vger.kernel.org Thu May 10 22:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEqO-0003R6-0A
	for gcvg-git@gmane.org; Thu, 10 May 2007 22:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbXEJUCG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbXEJUCG
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 16:02:06 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:62732 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbXEJUCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 16:02:05 -0400
Received: from relay8.apple.com (relay8.apple.com [17.128.113.38])
	by mail-out4.apple.com (Postfix) with ESMTP id CFF2BE88E1;
	Thu, 10 May 2007 13:02:04 -0700 (PDT)
Received: from relay8.apple.com (unknown [127.0.0.1])
	by relay8.apple.com (Symantec Mail Security) with ESMTP id BDCDC404FD;
	Thu, 10 May 2007 13:02:04 -0700 (PDT)
X-AuditID: 11807126-a4431bb000004313-fb-46437a3ce017 
Received: from [17.203.15.208] (il0301e-dhcp208.apple.com [17.203.15.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay8.apple.com (Apple SCV relay) with ESMTP id A97614059B;
	Thu, 10 May 2007 13:02:04 -0700 (PDT)
In-Reply-To: <769697AE3E25EF4FBC0763CD91AB1B0201D496E7@MBGMail01.mobot.org>
X-Mailer: Apple Mail (2.884)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46893>

On May 10, 2007, at 12:43 PM, Ron Parker wrote:

> I know this is probably a FAQ and I thought I found it somewhere once,
> but... How do I commit changes from in my working directory to another
> (possibly non-existent) branch?
>
> All too often I am working on changes and realize I am sitting on  
> master
> or a topic branch and I need to commit my mods to different branch.  I
> really don't like:
>
>    git commit
>    git branch <other-branch>
>    git reset --hard HEAD^
>
> Is there anything like:
>    git commit -b <other-branch> [<file>...]?
>
> If not, would patches to implement such a change be accepted?

    You can do this simply by doing the following:

git checkout -b <other-branch>
git commit

    The changes in your working tree will be carried over to <other- 
branch> when you do the git-checkout command.

-Adam
