X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Change "refs/" references to symbolic constants
Date: Sat, 16 Dec 2006 13:44:31 -0800
Message-ID: <7vslffcy80.fsf@assigned-by-dhcp.cox.net>
References: <200612141644.06167.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 21:44:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612141644.06167.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 14 Dec 2006 16:44:05 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34644>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvhKn-0000I5-SR for gcvg-git@gmane.org; Sat, 16 Dec
 2006 22:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753819AbWLPVog (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 16:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbWLPVog
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 16:44:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38939 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753819AbWLPVof (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 16:44:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216214432.JRQT9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 16:44:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zZkk1V0051kojtg0000000; Sat, 16 Dec 2006
 16:44:44 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Changed repeated use of the same constants for the ref paths to be
> symbolic constants.

This is not rejected nor forgotten but has not been applied yet,
and may not be immediately.

I would love to have this; it would reduce mistakes (spelling
"refs/head/" would silently compile fine and result in a broken
command, while spelling PATH_REFS_HEAD would be caught by the
compiler).

A sad thing is this needs to be done when things are relatively
quiescent.

So I would apply this before v1.5.0 (or a replacement, if you
have updates), but it might have to wait a bit until I I can say
"ok, no big patches to C part is pending right now and it is a
good time to do this clean-up".

