From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away
 revs hidden by a graft.
Date: Thu, 18 May 2006 15:01:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605181500470.10823@g5.osdl.org>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
 <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> <7viro3nh07.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 00:01:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgqYd-0006rC-Fn
	for gcvg-git@gmane.org; Fri, 19 May 2006 00:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWERWBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 18:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWERWBV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 18:01:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932161AbWERWBU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 18:01:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IM1HtH002256
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 15:01:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IM1G7s003381;
	Thu, 18 May 2006 15:01:16 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viro3nh07.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20308>



On Thu, 18 May 2006, Junio C Hamano wrote:
> 
> I haven't looked at what the test does, but I think he is
> talking about the opposite.  fsck by design does not honor
> grafts, and if you grafted a history back to your true root
> commit, that "older" history will be lost.

Ahh. Ok. Gotcha.

		Linus
