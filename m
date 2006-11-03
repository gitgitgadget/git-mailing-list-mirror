X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bug? + question
Date: Fri, 03 Nov 2006 11:28:59 -0800
Message-ID: <7vvelw72is.fsf@assigned-by-dhcp.cox.net>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<20061103074857.GA15972@diana.vm.bytemark.co.uk>
	<7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
	<200611030909.02564.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 19:29:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611030909.02564.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 3 Nov 2006 10:09:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30877>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg4iw-0006w8-TE for gcvg-git@gmane.org; Fri, 03 Nov
 2006 20:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753469AbWKCT3D (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 14:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbWKCT3D
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 14:29:03 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12188 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1753469AbWKCT3B
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 14:29:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103192900.JAEO18816.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 14:29:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iKUf1V0041kojtg0000000 Fri, 03 Nov 2006
 14:28:39 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Friday 2006 November 03 08:51, Junio C Hamano wrote:
>
>> time, switch between them only to compile, test and install but
>> never develop on them" workflow is rather specific to top-level
>> maintainer's workflow and that is why I said defaulting to
>> separate-remote would be an inconvenience to a minority.
>
> This is only a question of the default; why couldn't you (when
> it exists) use?
>
>   git clone --dont-use-separate-remote URL

Because I do not need it ;-).  If we switch the default to
separate-remote, I'd just let clone to lay it out that way and
then update the ref layout myself to suit my needs.  So it is
really just the matter of deciding which is more appropriate
default for the majority.
