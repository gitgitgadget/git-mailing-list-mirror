From: Adam Roben <aroben@apple.com>
Subject: Re: git-svn capabilities
Date: Sun, 09 Dec 2007 00:37:51 -0800
Message-ID: <475BA95F.7040403@apple.com>
References: <DB0B4F17-9E06-4C28-933E-FDEF9BAD6539@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 09:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Hfy-0007KF-VX
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 09:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXLIIhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 03:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbXLIIhy
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 03:37:54 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:61621 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbXLIIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 03:37:53 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 6A9D91A9D5F7
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 00:37:53 -0800 (PST)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id D100D28083
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 00:37:52 -0800 (PST)
X-AuditID: 11807134-a819bbb000005aa1-24-475ba9604a6d
Received: from gertie.apple.com (gertie.apple.com [17.151.62.15])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 3A14A28056
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 00:37:52 -0800 (PST)
Received: from [192.168.1.104] ([67.180.198.239])
 by ifon.apple.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JSR00J0JXB30S80@ifon.apple.com> for
 git@vger.kernel.org; Sun, 09 Dec 2007 00:37:52 -0800 (PST)
In-reply-to: <DB0B4F17-9E06-4C28-933E-FDEF9BAD6539@simplicidade.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67608>

Pedro Melo wrote:
> Hi,
>
> I've been following along the gcc/git thread with interest and I've 
> used Harvey Harrison recipe
>
> http://article.gmane.org/gmane.comp.version-control.git/67253
>
> with success on several svn repos.
>
> One thing that I'm not sure yet if it is possible to do is this:
>
> can I have a single central git repo that tracks the svn repo, allow 
> several developers to use clone to copy that repo, and each one of 
> them (after proper manual configuration) uses dcommit to push back to 
> svn?
>
> All the recipes so far assume that each developer has to go through 
> the initial git-svn fetch and have a copy of the entire SVN repo, and 
> that seems wasteful to me.

The "Basic Examples" section of the git-svn man page describe how to do 
just that (though only for a single branch).

-Adam
