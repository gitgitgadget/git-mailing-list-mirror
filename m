X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Sun, 26 Nov 2006 17:55:41 -0800
Message-ID: <7vac2dr6ua.fsf@assigned-by-dhcp.cox.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 01:55:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 26 Nov 2006 17:06:08 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32380>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoVin-00062f-Et for gcvg-git@gmane.org; Mon, 27 Nov
 2006 02:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756047AbWK0Bzn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 20:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756049AbWK0Bzn
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 20:55:43 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39329 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1756047AbWK0Bzm
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 20:55:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127015542.XQGX5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 20:55:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rdvp1V00m1kojtg0000000; Sun, 26 Nov 2006
 20:55:50 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 26 Nov 2006, Junio C Hamano wrote:
>>
>> This implements an experimental "git log-fpc" command that shows
>> short-log style output sorted by topics.
>> 
>> A "topic" is identified by going through the first-parent
>> chains; this ignores the fast-forward case, but for a top-level
>> integrator it often is good enough.

After sending out a response, I re-read your message because I
did not quite get where bayesian would come into the picture.

I think I should have used the word "topic branch" instead of
"topic".  In other words, I was not interested in sifting the
various totally unrelated linear commits into groups that deal
with distinct problems.

But again you are showing your superiour intelligence by setting
the problem in a much grander scheme ;-), where there is no such
developer discipline that would help the shortlogger (like use
of topic branches).  In such a case, you would need a set of
heuristics that you described.
