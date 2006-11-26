X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sun, 26 Nov 2006 01:15:58 -0800
Message-ID: <7vvel2va9d.fsf@assigned-by-dhcp.cox.net>
References: <ekafpm@sea.gmane.org> <200611260003.31025.andyparkins@gmail.com>
	<Pine.LNX.4.63.0611260141390.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<200611260856.03057.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 09:16:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611260856.03057.andyparkins@gmail.com> (Andy Parkins's
	message of "Sun, 26 Nov 2006 08:56:01 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32336>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoG7K-0004qs-Sc for gcvg-git@gmane.org; Sun, 26 Nov
 2006 10:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935244AbWKZJQB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 04:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935247AbWKZJQA
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 04:16:00 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:45235 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S935244AbWKZJQA
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 04:16:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126091559.UWBQ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 04:15:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rMG71V00G1kojtg0000000; Sun, 26 Nov 2006
 04:16:08 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Sunday 2006, November 26 00:48, Johannes Schindelin wrote:
>
>> This hunk is wrong: "git-repo-config remote.bla.fetch b" will _overwrite_
>> remoter.bla.fetch. To avoid that, you have to use "git repo-config
>> remote.bla.fetch b ^$". (The last argument is a regular expression which
>> has to be matched by the value-to-be-oreplaced.)
>
> This is in git-clone; the config is empty.  What is there to overwrite?

The entry you wrote in the previous iteration in the same loop,
perhaps?
