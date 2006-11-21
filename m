X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support to git-branch to show local and remote branches
Date: Tue, 21 Nov 2006 13:14:29 -0800
Message-ID: <7vwt5owlhm.fsf@assigned-by-dhcp.cox.net>
References: <200611211931.24868.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 21:14:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611211931.24868.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 21 Nov 2006 19:31:24 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32039>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmcws-00074h-Qm for gcvg-git@gmane.org; Tue, 21 Nov
 2006 22:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161334AbWKUVOb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 16:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161346AbWKUVOb
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 16:14:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48037 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1161334AbWKUVOa
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 16:14:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061121211429.SIBJ20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Tue, 21
 Nov 2006 16:14:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pZEc1V0131kojtg0000000; Tue, 21 Nov 2006
 16:14:37 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Instead of storing a list of refnames in append_ref, a list of
> structures is created.  Each of these stores the refname and a
> symbolic constant representing its type.

Thanks.  I'll drop the one in 'pu' and will replace with this
patch but with style fixes and keeping the documentation updates
from there.
