From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stgit: cleaning up after using git branch delete commands
Date: Wed, 07 Nov 2007 14:57:34 +0000
Message-ID: <tnxwssuyug1.fsf@pc1117.cambridge.arm.com>
References: <9e4733910711070606t2c558ac9ob4c729d5baca8fb9@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:58:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmLu-0007id-Nl
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213AbXKGO5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758195AbXKGO5o
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:57:44 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:34073 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758138AbXKGO5n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 09:57:43 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id lA7EvahX016509;
	Wed, 7 Nov 2007 14:57:36 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Nov 2007 14:57:35 +0000
In-Reply-To: <9e4733910711070606t2c558ac9ob4c729d5baca8fb9@mail.gmail.com> (Jon Smirl's message of "Wed\, 7 Nov 2007 09\:06\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-OriginalArrivalTime: 07 Nov 2007 14:57:35.0534 (UTC) FILETIME=[8824D4E0:01C8214E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63814>

"Jon Smirl" <jonsmirl@gmail.com> wrote:
> I've used git commands to delete several branches that had stgit
> active on it.  Doing that has left a bunch of clutter in the .git
> directory. Is there a stgit command to remove all the clutter from
> branches that no longer exist? I'd like to use the branch names again
> but the clutter is interfering.

You can create the branch back with GIT and run "stg branch --delete
--force", though I don't guarantee it will work (BTW, I only recently
relaxed the branch deletion rules in StGIT so that it doesn't complain
of missing files and completes the operation, so you should use the
latest HEAD).

-- 
Catalin
