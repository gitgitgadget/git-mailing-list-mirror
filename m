From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 11:07:42 +0100
Message-ID: <tnx4qe49z4h.fsf@arm.com>
References: <20050416131528.GB19908@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 12:04:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNT6d-0007Bi-Uz
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVDRKHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVDRKHs
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:07:48 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:31228 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262014AbVDRKHq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 06:07:46 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j3IA7L4G024836;
	Mon, 18 Apr 2005 11:07:21 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.141])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA12070;
	Mon, 18 Apr 2005 11:07:42 +0100 (BST)
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050416131528.GB19908@elte.hu> (Ingo Molnar's message of
 "Sat, 16 Apr 2005 15:15:28 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> i've converted the Linux kernel CVS tree into 'flat patchset' format, 
> which gave a series of 28237 separate patches. (Each patch represents a 
> changeset, in the order they were applied. I've used the cvsps
> utility.)

AFAIK, cvsps uses the date/time to create the changesets. There is a
problem with the BKCVS export since some files in the same commit can
have a different time (by an hour). I posted a mail some time ago
about this - 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110026570201544&w=2

I read that the old history won't be merged into the new repository
but, if you are interested, I have a script that can do this based on
the "(Logical change ...)" string in the file commit logs and it is
quite fast at generating the patches.

-- 
Catalin

