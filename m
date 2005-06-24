From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Patch (apply) vs. Pull
Date: Fri, 24 Jun 2005 14:41:46 +0100
Message-ID: <tnxvf4350th.fsf@arm.com>
References: <Pine.LNX.4.21.0506231245560.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 15:37:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DloMo-0004x8-VA
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 15:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVFXNnY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 09:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVFXNnH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 09:43:07 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:44482 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262559AbVFXNmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 09:42:50 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5ODfv6i001270;
	Fri, 24 Jun 2005 14:41:57 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id OAA20185;
	Fri, 24 Jun 2005 14:42:24 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 24 Jun 2005 14:42:01 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506231245560.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Thu, 23 Jun 2005 13:05:03 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 24 Jun 2005 13:42:01.0695 (UTC) FILETIME=[800866F0:01C578C2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> wrote:
> I think that it's important to avoid having the array of "rebased the
> patch" commits be reachable from the final series if that series is going
> to be merged into the mainline at the end.

True. I will remove that. Any commit will have the new base of the
patch as a parent.

> If you want to keep the history of a patch, you should be able to do it by
> rebasing that history as well as the latest patch, so you'd get a
> two-parent commit with two rebased parents when you rebased a two-parent
> commit.

I can have two commits, one of them accessible via HEAD and the other
stored somewhere under .git/patches. The latter is just a normal
commit where the parent is the current HEAD. This will not be
generated when the patch is re-based, but only when a patch is
modified.

-- 
Catalin

