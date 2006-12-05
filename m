X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-explain
Date: Tue, 05 Dec 2006 15:07:01 -0800
Message-ID: <7vslfudjsa.fsf@assigned-by-dhcp.cox.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
	<7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
	<7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
	<el3ibq$9kn$2@sea.gmane.org>
	<46a038f90612051500w44438f70y3c7d1c99998d16bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 23:07:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <46a038f90612051500w44438f70y3c7d1c99998d16bb@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 6 Dec 2006 12:00:14 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33388>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrjNV-0003vl-A6 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 00:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966586AbWLEXHF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966995AbWLEXHF
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 18:07:05 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:56398 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S966586AbWLEXHD (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 18:07:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205230702.NJVW5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 18:07:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vB7C1V00F1kojtg0000000; Tue, 05 Dec 2006
 18:07:12 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 12/5/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Junio C Hamano wrote:
>>
>> > [PATCH] git-explain
>> >
>> > This patch adds "git-explain" script that notices various clues
>> > other commands can leave the working tree and repository in and
>> > intended to guide the end user out of the confused mess.
>>
>> I like it, although I think that it explains a bit too little
>
> I like what it does too... but why not as part of git-status?

The biggest reason was that it is a demonstration of concepts,
not replacement of anything.  Maybe "git status" can be replaced
with something like that if people worked on it enough.

The current use of "git status" inside "git commit" needs to be
revamped if we pursue this further, though.  Because one of the
points the "what state is this repository in" check "explain"
does is to define what operations are sensible in each state,
and most likely in many state it would not make _any_ sense to
run "git commit" (say, in the middle of "bisect").




