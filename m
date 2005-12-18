From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Remove misguided branch disambiguation.
Date: Sun, 18 Dec 2005 01:06:36 +0100
Message-ID: <20051218000636.GA20874@steel.home>
References: <7virto12u5.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 01:08:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Enm4l-0002Qy-3L
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 01:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVLRAGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 19:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVLRAGu
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 19:06:50 -0500
Received: from devrace.com ([198.63.210.113]:15366 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964944AbVLRAGt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Dec 2005 19:06:49 -0500
Received: from tigra.home (p54A0E6BC.dip.t-dialin.net [84.160.230.188])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jBI06cPp053057;
	Sat, 17 Dec 2005 18:06:39 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Enm4S-00061O-00; Sun, 18 Dec 2005 01:06:36 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Enm4S-0005Qo-Cc; Sun, 18 Dec 2005 01:06:36 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virto12u5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13780>

Junio C Hamano, Sat, Dec 17, 2005 10:37:38 +0100:
> This removes the misguided attempt to refuse processing a branch
> name xyzzy and insist it to be given as either heads/xyzzy or
> tags/xyzzy when a tag xyzzy exists.  There was no reason to do
> so --- the search order was predictable and well defined, so if
> the user says xyzzy we should have taken the tag xyzzy in such a
> case without complaining.

Right. The test 'Ambiguous' in t0000-basic is redundant now, btw
