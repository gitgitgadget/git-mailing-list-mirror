From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 22:34:42 +0100
Message-ID: <20051115213442.GA4256@steel.home>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 22:38:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec8SM-0005Rc-MK
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 22:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVKOVfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 16:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVKOVfG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 16:35:06 -0500
Received: from devrace.com ([198.63.210.113]:25362 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750888AbVKOVfF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 16:35:05 -0500
Received: from tigra.home (p54A0F755.dip.t-dialin.net [84.160.247.85])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAFLYjiZ081662;
	Tue, 15 Nov 2005 15:34:48 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Ec8Rv-0000Uu-00; Tue, 15 Nov 2005 22:34:43 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Ec8Ru-0005Kj-Of; Tue, 15 Nov 2005 22:34:42 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.7 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11945>

Alex Riesen, Tue, Nov 15, 2005 16:49:30 +0100:
> llist_sorted_difference_inplace didn't handle the match in the first
> sha1 correctly and the lists went wild everywhere.

This wasn't enough. It never (>5 min on 2.4GHz PIV) finishes on
my local mirror of git, which has 22 packs by now.
