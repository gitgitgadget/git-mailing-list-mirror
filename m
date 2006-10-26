X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make new builtin cherry match documentation for "+" and "-"
Date: Thu, 26 Oct 2006 01:22:09 -0700
Message-ID: <7vd58fqyfi.fsf@assigned-by-dhcp.cox.net>
References: <E1Gck4m-0003J1-00@dvr.360vision.com>
	<7vk62ob5mp.fsf@assigned-by-dhcp.cox.net>
	<200610260845.23850.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 08:22:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610260845.23850.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 26 Oct 2006 08:45:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30150>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0VC-0007OS-PG for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964897AbWJZIWL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 04:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbWJZIWL
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:22:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28390 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S964897AbWJZIWK
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:22:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026082210.IJBM13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 04:22:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ewMs1V00K1kojtg0000000 Thu, 26 Oct 2006
 04:21:53 -0400
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006 October 25 19:41, Junio C Hamano wrote:
>
>> > "+" and "-" don't match the documentation, where "+" means the patch /is/
>> > in upstream, "-" means it isn't
>>
>> The documentation was utterly wrong.  The comment at the
>> beginning of git-cherry.sh was better but slightly wrong.
>
> Seriously?  In git-cherry output a "-" means that a patch is in?  Seems 
> counter-intuitive to me.
>
> Or is it meant to be analogous to a diff so "+" means "in order to make this 
> branch like the comparison branch you would have to /add/ this patch"?

It's more like "This is still relevant and you need to
positively push your upstream for inclusion".
