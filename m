X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Thu, 02 Nov 2006 18:40:32 -0800
Message-ID: <7vslh1l0bj.fsf@assigned-by-dhcp.cox.net>
References: <200611021112.26420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 03:00:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30775>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfp33-0003wO-Tz for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752966AbWKCCki (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbWKCCkh
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:37 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37052 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1752966AbWKCCkf
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024033.THMW13632.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2gB1V00j1kojtg0000000 Thu, 02 Nov 2006
 21:40:12 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> prune_object() in show_only mode would previously just show the path to the
> object that would be deleted.  The path the object is stored in shouldn't be
> shown to users, they only know about sha1 identifiers so show that instead.
>
> Further, the sha1 alone isn't that useful for examining what is going to be
> deleted.  This patch also adds the object type to the output, which makes it
> easy to pick out, say, the commits and use git-show to display them.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

List members and git users, 

	if you are using "prune -n" output in your scripts, this
change could cause those scripts to break; so please holler.

I am inclined to take this output format change, so if you are
going to holler please do so fast.
