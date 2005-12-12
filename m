From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: patches between commits
Date: Mon, 12 Dec 2005 18:33:52 +0100
Message-ID: <20051212173352.GA3007@steel.home>
References: <7ac1e90c0512120731g3eacdcf0s7e9d1226c88dce73@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 18:36:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElrYx-0001uY-3E
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 18:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVLLReF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 12:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLLReF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 12:34:05 -0500
Received: from devrace.com ([198.63.210.113]:20745 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932081AbVLLReE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 12:34:04 -0500
Received: from tigra.home (p54A0E2CD.dip.t-dialin.net [84.160.226.205])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jBCHXvM2061540;
	Mon, 12 Dec 2005 11:33:59 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1ElrYe-0006Xe-00; Mon, 12 Dec 2005 18:33:52 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1ElrYe-0003SZ-1D; Mon, 12 Dec 2005 18:33:52 +0100
To: Bahadir Balban <bahadir.balban@gmail.com>
Content-Disposition: inline
In-Reply-To: <7ac1e90c0512120731g3eacdcf0s7e9d1226c88dce73@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13527>

Bahadir Balban, Mon, Dec 12, 2005 16:31:12 +0100:
> Suppose I have a HEAD branch, which is the latest. And I want to
> generate `individual' patches for each commit I did since the
> beginning of development for this branch.

That is what I think "git format-patch <commit>" is for. It will
generate patches to bring "<commit>" to HEAD.

> Secondly, is the sha1 of a tree what appears next to each commit when
> I type git-log? Is this the only command that lets us know the sha1's
> of commits?

"git rev-list", I think
