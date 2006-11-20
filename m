X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 02:51:16 -0800
Message-ID: <7vd57i4cij.fsf@assigned-by-dhcp.cox.net>
References: <200611201157.23680.litvinov2004@gmail.com>
	<81b0412b0611200206q4ded162drdc450715d7f801e0@mail.gmail.com>
	<200611201023.54146.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 10:51:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611201023.54146.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 20 Nov 2006 11:23:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31901>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm6kD-0003mh-Og for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755748AbWKTKvS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbWKTKvS
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:51:18 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:13534 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1755748AbWKTKvR
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:51:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120105117.PASS7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 05:51:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oyqo1V0061kojtg0000000; Mon, 20 Nov 2006
 05:50:48 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Monday 2006 November 20 10:06, Alex Riesen wrote:
>
>> remove --pretty=oneline, it is default behavior of git log.
>
> No it's not; are you confusing it with --pretty=short?

I think Alex (Riesen) is saying "you (Alex Litvinov) were
wondering why you do not see the commit log message but only the
first line. That is because you are using --pretty=oneline.
Lose it, then you would get what you want because giving the log
message _is_ the default".
