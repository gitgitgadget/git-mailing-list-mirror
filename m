X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Topic descriptions
Date: Wed, 06 Dec 2006 14:31:28 -0800
Message-ID: <7v4ps8y7un.fsf@assigned-by-dhcp.cox.net>
References: <200612062153.30639.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 22:31:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612062153.30639.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 6 Dec 2006 21:53:28 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33532>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs5Ib-0003mp-JK for gcvg-git@gmane.org; Wed, 06 Dec
 2006 23:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937744AbWLFWba (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 17:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937748AbWLFWba
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 17:31:30 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61273 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937744AbWLFWba (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 17:31:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206223129.YFKL15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 17:31:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vaXf1V00E1kojtg0000000; Wed, 06 Dec 2006
 17:31:39 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> -----
> <sha1>
> <anything at all>
> -----
>
> I don't know where the UI would go; but it would let Junio generate his what's 
> cooking emails with cat .git/refs/*/*

I think the right place to store that <anything at all>
information is per-branch configuration item.  Perhaps:

	[branch "ap/clone-origin"]
        description = we talk about what this thing does and \
        what the current status of it is.

I am unlikely to use such a thing for the "What's in" message,
though.  The part that talks about "what the current status is"
is much easier to write when I need to talk about "the current";
otherwise I'd be forced to remember to think if I need to update
the information, every time I touch topic branches.

But that description thing would be useful in gitweb, for
example.
