X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 10:27:58 -0800
Message-ID: <7vlkmb9rgx.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl>
	<Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
	<455C94FA.3050903@xs4all.nl>
	<Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611160932340.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 18:28:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611160932340.3349@woody.osdl.org> (Linus
	Torvalds's message of "Thu, 16 Nov 2006 09:57:29 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31612>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkly1-0005N0-G6 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 19:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162103AbWKPS2B (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 13:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162115AbWKPS2A
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 13:28:00 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:1255 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1162103AbWKPS2A
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 13:28:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116182759.KCVA5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 13:27:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nWU51V00S1kojtg0000000; Thu, 16 Nov 2006
 13:28:06 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 16 Nov 2006, Linus Torvalds wrote:
>> 
>> (And the real reason for that is simple: "git pull" simply wants to have 
>> something to _start_ with. It's not hugely fundamental, it's just how it 
>> was written).
>
> Here's a very lightly tested patch that allows you to use "git pull" to 
> populate an empty repository.
>
> I'm not at all sure this is necessarily the nicest way to do it, but it's 
> fairly straightforward.
>
> Junio, what do you think?

Yeah, I talked about making "merge" treat missing HEAD as a
special case of fast forward, but I like yours better.  It is a
lot cleaner and to the point.
