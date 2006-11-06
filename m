X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: how-to "backup" a repository
Date: Sun, 05 Nov 2006 22:21:19 -0800
Message-ID: <7vfycxf63k.fsf@assigned-by-dhcp.cox.net>
References: <454ECC23.6010503@saville.com>
	<20061106055224.GA23126@spearce.org> <454ED27F.8060106@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 06:21:29 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454ED27F.8060106@saville.com> (Wink Saville's message of "Sun,
	05 Nov 2006 22:13:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30998>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgxrI-0003as-3i for gcvg-git@gmane.org; Mon, 06 Nov
 2006 07:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932642AbWKFGVV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 01:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWKFGVV
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 01:21:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39148 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S932631AbWKFGVU
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 01:21:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106062120.QVED22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 6
 Nov 2006 01:21:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jJLx1V00M1kojtg0000000 Mon, 06 Nov 2006
 01:20:58 -0500
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> This sounds easy enough, but how-to "create a remote"?
> I looked in .git/remotes and see origin which contains:
>
> URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Pull: refs/heads/master:refs/heads/origin
>
> But where is the syntax defined?

man git-push -- where else ;-)?

http://www.kernel.org/pub/software/scm/git/docs/git-push.html

