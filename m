X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: filemode=false somewhat broken
Date: Wed, 22 Nov 2006 14:39:18 -0800
Message-ID: <7vodqzp0mh.fsf@assigned-by-dhcp.cox.net>
References: <17764.44236.473000.729015@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 22:39:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <17764.44236.473000.729015@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Wed, 22 Nov 2006 21:02:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32107>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn0kW-0002xG-8u for gcvg-git@gmane.org; Wed, 22 Nov
 2006 23:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757013AbWKVWjV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757004AbWKVWjU
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 17:39:20 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55263 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1756915AbWKVWjU
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 17:39:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122223919.YXLY4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Wed, 22
 Nov 2006 17:39:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id pyeo1V01B1kojtg0000000; Wed, 22 Nov 2006
 17:38:49 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
Sender: git-owner@vger.kernel.org

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> Commit fd28b34afd9bbd58297a25edced3f504c9a5487a tried to ignore the
> executable bit if filemode=false, but instead forced all files to be
> regular with 644 permission bits nuking symlink support.

Thanks for noticing.  Yes, that change is _seriously_ broken.  I
should really raise the bar for patch acceptance.


