From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Cogito 0.12.1
Date: Wed, 13 Jul 2005 12:13:52 +0100
Message-ID: <tnxzmsrc61b.fsf@arm.com>
References: <20050712010058.GE5981@pasky.ji.cz>
	<20050713081257.D19871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 13:18:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsfFE-0000Yw-05
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 13:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVGMLRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 07:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVGMLRM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 07:17:12 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:3058 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262637AbVGMLO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 07:14:56 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6DBDms4004278;
	Wed, 13 Jul 2005 12:13:48 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id MAA02943;
	Wed, 13 Jul 2005 12:14:19 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 13 Jul 2005 12:14:17 +0100
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050713081257.D19871@flint.arm.linux.org.uk> (Russell King's
 message of "Wed, 13 Jul 2005 08:12:57 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 13 Jul 2005 11:14:17.0978 (UTC) FILETIME=[02B1C5A0:01C5879C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> wrote:
> I won't bother trying to explain, I'll just paste the errors.  We've been
> here before in a previous cogito revision.
>
> rmk@dyn-67:[linux-2.6-rmk]:<1038> cg-branch-ls
> origin  ../linux-2.6
> smp     ../linux-2.6-smp

I noticed that Cogito doesn't work well with relative paths. Run
cg-branch-chg and put absolute paths, it might work (it did for me).

-- 
Catalin
