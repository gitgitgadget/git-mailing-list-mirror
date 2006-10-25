X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: (unknown)
Date: Wed, 25 Oct 2006 15:16:52 -0700
Message-ID: <7v1wowm46j.fsf@assigned-by-dhcp.cox.net>
References: <E1Gck2K-0003H4-00@dvr.360vision.com>
	<200610251610.02446.andyparkins@gmail.com>
	<7vods0b5rk.fsf@assigned-by-dhcp.cox.net>
	<200610252303.07900.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:17:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610252303.07900.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 25 Oct 2006 23:03:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30108>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcr3R-0004s6-LP for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964836AbWJYWQy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWJYWQy
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:16:54 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:13494 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S964836AbWJYWQx
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:16:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025221653.XXMK12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 18:16:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id emGb1V00a1kojtg0000000 Wed, 25 Oct 2006
 18:16:36 -0400
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006, October 25 19:38, Junio C Hamano wrote:
>
>> > I did try that, but then the branches don't appear in git branch.  I
>> > still like that they exist.
>>
>> "git branch -r" perhaps.
>
> That's pretty good.  It makes things like
>
>   git-log remotes/origin/master..master
>
> A bit long winded, but it's certainly what I asked for.

"git log remotes/origin..master" perhaps?

The point being, remotes/origin when origin is a directory that
has HEAD that points at something, it stands for
remotes/origin/HEAD.
