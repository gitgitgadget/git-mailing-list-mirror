From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Recover from a bad push in StGit
Date: Mon, 21 Aug 2006 10:35:26 +0100
Message-ID: <tnxk652torl.fsf@arm.com>
References: <200608190030.47257.robin.rosenberg.lists@dewire.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 11:36:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF6CV-0001FD-0j
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 11:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWHUJfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWHUJfv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 05:35:51 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:5558 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751137AbWHUJfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 05:35:50 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k7L9ZVGf006232;
	Mon, 21 Aug 2006 10:35:31 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 21 Aug 2006 10:35:31 +0100
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
In-Reply-To: <200608190030.47257.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sat, 19 Aug 2006 00:30:46 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 21 Aug 2006 09:35:31.0042 (UTC) FILETIME=[24DA1C20:01C6C505]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25790>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> I recently did some reordering of patches and goofed up (not totally, but 
> anyway). I pushed a number of patches and forgot one in the middle resulting 
> in a merge  conflict. Pop won't work since I have local changes from the 
> conflict and I don't want to resolve the conflict either since I didn't mean 
> to push the patch at that point.
>
> Is there a simple way of undoing a bad push? 
>
> In this case I had a fresh export do help me out so I could just delete the 
> patches and re-import them again, but what if I didn't?

"stg push --undo" (the same option for "refresh"; maybe I should add a
separate "undo" command) resets the local changes and it restores the
original boundaries of the patch (no information is lost). You could
use the latest snapshot as it has some bug-fixes from release 0.10.

-- 
Catalin
