From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/2] Reorganize read-tree
Date: Wed, 31 Aug 2005 15:15:12 +0100
Message-ID: <tnxy86ikxan.fsf@arm.com>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 16:20:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EATRS-0007KX-Qx
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 16:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVHaOTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVHaOTt
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 10:19:49 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:59344 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932515AbVHaOTt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 10:19:49 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7VEJCQb017661;
	Wed, 31 Aug 2005 15:19:12 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id PAA15329;
	Wed, 31 Aug 2005 15:19:10 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 31 Aug 2005 15:15:12 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508302317380.23242@iabervon.org> (Daniel
 Barkalow's message of "Tue, 30 Aug 2005 23:48:27 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 31 Aug 2005 14:15:12.0964 (UTC) FILETIME=[6702F040:01C5AE36]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7976>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> I got mostly done with this before Linus mentioned the possibility of
> having multiple index entries in the same stage for a single path. I
> finished it anyway, but I'm not sure that we won't want to know which of
> the common ancestors contributed which, and, if some of them don't have a
> path, we wouldn't be able to tell.

I don't have time to look at the patch and I don't have a good
knowledge of the GIT internals, so I will just ask. Does this patch
changes the call convention for git-merge-one-file-script? I have my
own script for StGIT and I would need to know whether it is affected
or not.

Thanks.

-- 
Catalin
