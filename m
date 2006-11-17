X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: multi-project repos
Date: Fri, 17 Nov 2006 09:39:43 -0800
Message-ID: <7virhem0ps.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl>
	<Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
	<455C94FA.3050903@xs4all.nl>
	<Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
	<455CA2A8.5010700@xs4all.nl>
	<Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611161039160.3349@woody.osdl.org>
	<20061117162605.GA32597@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 17:40:01 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061117162605.GA32597@spearce.org> (Shawn Pearce's message of
	"Fri, 17 Nov 2006 11:26:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31716>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl7gr-0000cr-CQ for gcvg-git@gmane.org; Fri, 17 Nov
 2006 18:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933016AbWKQRjp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 12:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933022AbWKQRjp
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 12:39:45 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30636 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S933016AbWKQRjp
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 12:39:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117173944.KAUJ296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 12:39:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ntfq1V00j1kojtg0000000; Fri, 17 Nov 2006
 12:39:51 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Linus Torvalds <torvalds@osdl.org> wrote:
>>  - "ORIG_HEAD" is very useful indeed, and it's the head _before_ a merge 
>>    (or some other operations, like "git rebase" and "git reset": think of 
>>    it as a "original head before we did some uncontrolled operation 
>>    where we otherwise can't use HEAD^ or similar")
>> 
>>    I use "gitk ORIG_HEAD.." a lot, and if I don't like something I see 
>>    when I do it, I end up doing "git reset --hard ORIG_HEAD" to undo a 
>>    pull I've done. This is important exactly because ORIG_HEAD is _not_ 
>>    the same as the first parent of a merge, since a merge could have been 
>>    just a fast-forward.
>
> Although if you have reflog enabled on your current branch there
> is a 1 character shorter syntax:
>
> 	gitk HEAD@{1}..

Are you sure about this?  I've seen "next@{1}" to look at
history of the named branch, but never history of "HEAD".
