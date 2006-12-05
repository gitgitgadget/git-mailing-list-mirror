X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 04 Dec 2006 21:43:15 -0800
Message-ID: <7vslfukido.fsf@assigned-by-dhcp.cox.net>
References: <87odqm2ppv.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
	<4571DB40.6020800@vilain.net>
	<Pine.LNX.4.64.0612022246310.2630@xanadu.home>
	<7vd570q888.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>
	<7v8xhnm9o6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612042225220.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 05:44:01 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Carl Worth <cworth@cworth.org>, Sam Vilain <sam@vilain.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612042225220.2630@xanadu.home> (Nicolas Pitre's
	message of "Mon, 04 Dec 2006 22:29:13 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33305>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrT5y-0003gS-Gv for gcvg-git@gmane.org; Tue, 05 Dec
 2006 06:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967726AbWLEFnS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 00:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967865AbWLEFnS
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 00:43:18 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65034 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967726AbWLEFnQ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 00:43:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205054316.IOMN5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 00:43:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id utjR1V00W1kojtg0000000; Tue, 05 Dec 2006
 00:43:26 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 4 Dec 2006, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@osdl.org> writes:
>> 
>> > If it doesn't match HEAD, we can't get it back as easily, so maybe that's 
>> > the case when we want to have "git rm -f filename".
>> 
>> Hmph.  Wouldn't this lossage the same as the lossage we are
>> removing the "safety valve" for, when "commit --only" jumps the
>> index?
>
> Losing an intermediate file state is much less severe than losing the 
> latest file state I would think.

Very true indeed.
