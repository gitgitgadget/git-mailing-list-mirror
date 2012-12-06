From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Stitching histories of several repositories
Date: Thu, 6 Dec 2012 01:00:15 +0100 (CET)
Message-ID: <1887785531.19321537.1354752015863.JavaMail.root@dewire.com>
References: <CALkWK0kCQQioCeuwWAAWfKodvOR+w+hB=11MYs5mGviN6Zy5qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 01:00:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgOtH-000648-4s
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 01:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab2LFAAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 19:00:17 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:39185 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2LFAAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 19:00:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 39E12825DB;
	Thu,  6 Dec 2012 01:00:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2F84V5+GiKqD; Thu,  6 Dec 2012 01:00:15 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id DAC80824FA;
	Thu,  6 Dec 2012 01:00:15 +0100 (CET)
In-Reply-To: <CALkWK0kCQQioCeuwWAAWfKodvOR+w+hB=11MYs5mGviN6Zy5qA@mail.gmail.com>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211149>



----- Ursprungligt meddelande -----
> Hi,
> 
> I've written a tool to stitch the first-parent histories of several
> git repositories.  To illustrate, consider that we have a toplevel
> git
> repository inside which the other repositories reside.
> 
[...]
> 
> I'd like to know whether the tool would be useful to a wider
> audience,
> before I polish it and consider submitting it for inclusion in
> contrib/.  I think the tool is especially useful for running bisect
> and tracking bugs that occur in large projects that consist of many
> git repositories.  Will a unified log showing commits in different
> submodules be useful?

I think it is useful. I did something like that creating a super-repo
for performing a bisect over EGit and JGit over a period over a year.
I don't think I restricted myself to the first parent, which was probably
a mistake.

The solution isn't perfect, but provided that is well-known you can
live with that. A problem I found was that many stiches versions weren't
even compilable so one might want to have the option of matching commits
using a window of some sort to identify compilable combinations and have
the ability to use only those for bisect. I'm not sure it's practical though.

-- robin
