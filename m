X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Show '...' links in "summary" view only if there are more items
Date: Tue, 19 Dec 2006 10:05:47 -0800
Message-ID: <7vr6uvpxqc.fsf@assigned-by-dhcp.cox.net>
References: <20061218224327.GG16029@localhost>
	<200612191214.58474.jnareb@gmail.com>
	<20061219120854.GA16429@localhost>
	<200612191328.08928.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 18:05:55 +0000 (UTC)
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34838>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwjLb-0002Y6-JA for gcvg-git@gmane.org; Tue, 19 Dec
 2006 19:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932874AbWLSSFt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 13:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbWLSSFt
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 13:05:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61799 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932874AbWLSSFs (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 13:05:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219180547.FELW97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 13:05:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0i5z1W0111kojtg0000000; Tue, 19 Dec 2006
 13:06:00 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Robert Fitzsimons wrote:
>> Show "..." links in "summary" view to shortlog, heads (if there are
>> any), and tags (if there are any) only if there are more items to show
>> than shown already.
>> 
>> This means that "..." link is shown below shortened shortlog if there
>> are more than 16 commits, "..." link below shortened heads list if
>> there are more than 16 heads refs (16 branches), "..." link below
>> shortened tags list if there are more than 16 tags.
>> 
>> Modified patch from Jakub to to apply cleanly to master, also preform
>> the same "..." link logic to the forks list.
>
> Junio usually puts such comments in brackets (I don't know if it is
> always used, i.e. if it is some 'convention'), e.g.:
>
>   Also perform the same "..." link logic to the forks list.
>
>   [rf: Modified patch from Jakub to to apply cleanly to master]

I would actually discourage this on messages that are still on
the list (i.e. not in commits).  I do [jc:] comment when I take
the proposed commit log message from the incoming e-mail
verbatim but I made modification to the patch text, because
otherwise the original submitter cannot tell from the log
message if that is meant to be identical to what was submitted.

I've only took a cursory look of the actual patch text, but what
Robert sent looked good to me.  Thanks, both.
