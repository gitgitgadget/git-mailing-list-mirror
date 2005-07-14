From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 10:08:31 +0100
Message-ID: <tnxu0ixoiuo.fsf@arm.com>
References: <20050713135052.C6791@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0507131325170.17536@g5.osdl.org>
	<20050714083700.A26322@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 11:14:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsznv-0002JM-7Z
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 11:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVGNJMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 05:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVGNJJg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 05:09:36 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:11215 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262981AbVGNJJU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 05:09:20 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6E98Ms4008889;
	Thu, 14 Jul 2005 10:08:23 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA25132;
	Thu, 14 Jul 2005 10:08:58 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 14 Jul 2005 10:08:56 +0100
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050714083700.A26322@flint.arm.linux.org.uk> (Russell King's
 message of "Thu, 14 Jul 2005 08:37:00 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 14 Jul 2005 09:08:56.0924 (UTC) FILETIME=[AA35C1C0:01C58853]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
> it appears that cg-diff does a
>
> 	git-update-cache --refresh >/dev/null
>
> each time it's run, which is taking the bulk of the time.  Also note
> that curiously, it exits with status 1.

Does git-ls-files --unmerged show any files?

-- 
Catalin
