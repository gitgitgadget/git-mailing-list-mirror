X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 14:09:26 -0800
Message-ID: <7v64dhznmx.fsf@assigned-by-dhcp.cox.net>
References: <20061114134958.5326.qmail@science.horizon.com>
	<200611141815.24236.jnareb@gmail.com>
	<20061114173657.GC5453@diana.vm.bytemark.co.uk>
	<200611141845.18930.jnareb@gmail.com>
	<20061114174939.GB4299@spearce.org>
	<Pine.LNX.4.64.0611141037120.3327@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 22:09:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611141037120.3327@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 14 Nov 2006 10:40:30 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31384>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk6TE-0002ml-JP for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966411AbWKNWJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966413AbWKNWJ2
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:09:28 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36558 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S966411AbWKNWJ2
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:09:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114220927.OJUF97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 17:09:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mm9Z1V00K1kojtg0000000; Tue, 14 Nov 2006
 17:09:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 14 Nov 2006, Shawn Pearce wrote:
>> That's not a bad idea.  Then you can checkout a tag and have
>> 'ref: refs/tags/v1.11' in HEAD, which means anyone who puts
>> $(git-symbolic-ref) calls into their PS1 will see "refs/tags/v1.11"
>> as their current branch, reminding them they are looking at the past.
>
> I agree. This would probably be a good way to do "read-only branches".
> ...
> Junio, what do you think? It wouldn't even be backwards incompatible, 
> because we're strictly allowing a superset of what we used to..

(late reply -- just came back from a clinic)

I do not see any fundamental reason not to allow HEAD to be a
commit that you cannot commit on top of because you are not on
any branch, and I agree it is the right way to go.

I am not sure how much pain we are talking about yet though.
