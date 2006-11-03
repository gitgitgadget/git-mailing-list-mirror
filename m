X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support to git-branch to show local and remote branches
Date: Fri, 03 Nov 2006 11:19:51 -0800
Message-ID: <7vac388hig.fsf@assigned-by-dhcp.cox.net>
References: <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
	<200611031052.16095.andyparkins@gmail.com>
	<7vhcxg91gq.fsf@assigned-by-dhcp.cox.net>
	<200611031240.34177.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 19:20:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611031240.34177.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 3 Nov 2006 13:40:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30875>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg4a5-0005FE-1Y for gcvg-git@gmane.org; Fri, 03 Nov
 2006 20:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753483AbWKCTTx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 14:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbWKCTTx
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 14:19:53 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12469 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1753483AbWKCTTw
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 14:19:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103191951.ULCM6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 14:19:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iKKW1V00D1kojtg0000000 Fri, 03 Nov 2006
 14:19:30 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Friday 2006 November 03 12:08, Junio C Hamano wrote:
>
>> > +static int tidy_ref_list( struct ref_list *ref_list )
>>
>> Style.  No spaces before or after parameter list.
>
> Bah!  It's so hard getting my fingers to remember what style goes in which 
> project :-)
>
>> I see you already parse "refs/tags" prefix. "git branch" would
>> not print tags, but that part might be useful when we want to
>> redo git-tag in C.
>
> I'm going to have a look at that soon;...

Just to make sure you do not misunderstand.  I do not see much
need for rewriting git-tag in C right now, and often it is more
convenient to leave higher layer commands in shell scripts to
allow people to try out new things and flush out UI issues.  I
was merely pointing out that part of the code would be usable if
we were to do it.

 
