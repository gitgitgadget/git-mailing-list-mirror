X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch fails with error code 128
Date: Fri, 15 Dec 2006 13:55:06 -0800
Message-ID: <7vy7p8omdh.fsf@assigned-by-dhcp.cox.net>
References: <200612142308.45376.andyparkins@gmail.com>
	<7vfybiyqk0.fsf@assigned-by-dhcp.cox.net>
	<200612150946.14439.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:55:17 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34557>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL1O-0006Ut-3o for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965198AbWLOVzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWLOVzJ
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:09 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36776 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965198AbWLOVzI (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215507.QDE22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vJ1V00r1kojtg0000000; Fri, 15 Dec 2006
 16:55:19 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> I hadn't realised it was quite a serious as these responses
> are making it sound.  I'll gather more precise data upon my
> return home.
> ...
> Clearly it is version-specific.  I'll do a bit of bisection
> later and see if I can nail the problem down.

Thanks --- very much appreciated.  When it comes to
inter-repository object transfer, we take compatibility very
seriously.
