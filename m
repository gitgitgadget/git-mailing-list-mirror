X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: check if a commit is ascendent of a specific commit
Date: Sat, 11 Nov 2006 12:12:42 -0800
Message-ID: <7v64dlkait.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com>
	<7virhlken0.fsf@assigned-by-dhcp.cox.net>
	<20061111192321.GJ4862@socrates.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 11 Nov 2006 20:13:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061111192321.GJ4862@socrates.priv> (Tom Prince's message of
	"Sat, 11 Nov 2006 12:23:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31239>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GizDq-0004X0-KR for gcvg-git@gmane.org; Sat, 11 Nov
 2006 21:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754451AbWKKUMo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 15:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbWKKUMo
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 15:12:44 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35047 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1754451AbWKKUMn
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 15:12:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061111201243.QLCW7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sat, 11
 Nov 2006 15:12:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id lYCo1V01J1kojtg0000000; Sat, 11 Nov 2006
 15:12:49 -0500
To: Tom Prince <tom.prince@ualberta.net>
Sender: git-owner@vger.kernel.org

Tom Prince <tom.prince@ualberta.net> writes:

> On Sat, Nov 11, 2006 at 10:43:47AM -0800, Junio C Hamano wrote:
>> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>> 
>> > Hi,
>> > I want to create "git-amend-commit" to be able to amend commits before
>> > HEAD. So I need to check whether the commit I'm going to amend is
>> > ascendent of HEAD. Is there any way to check that?
>> 
>> Ascendant is a word from astorology -- you mean ancestor ;-).
>
> Or antecedent.

Sorry, there is no "or" here -- check our documentation ;-).
