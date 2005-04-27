From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make -s flag to show-diff a no-op.
Date: Wed, 27 Apr 2005 15:20:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271520150.18901@ppc970.osdl.org>
References: <7vfyxbeuwt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:43:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvFB-0006yP-Ub
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVD0WWj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVD0WUF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:20:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:3984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbVD0WSx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 18:18:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RMIks4020860
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 15:18:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RMIj49013110;
	Wed, 27 Apr 2005 15:18:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyxbeuwt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Junio C Hamano wrote:
>
> With the recent "no-patch-by-default" change, the -s flag to
> the show-diff command (and silent variable in the show-diff.c)
> became meaningless.  This patch deprecates it.

I also wonder whether "-p" should turn on recursion by default (for all 
the tools). "-p" without "-r" doesn't really seem to make much sense, does 
it?

		Linus
