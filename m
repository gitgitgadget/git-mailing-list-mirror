X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 11:34:07 -0700
Message-ID: <7vk62k9tnk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
	<7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
	<20061028034206.GA14044@spearce.org>
	<Pine.LNX.4.64.0610272109500.3849@g5.osdl.org>
	<7vwt6l9etn.fsf@assigned-by-dhcp.cox.net>
	<20061028072146.GB14607@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 18:34:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061028072146.GB14607@spearce.org> (Shawn Pearce's message of
	"Sat, 28 Oct 2006 03:21:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30385>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdt0X-0006Sd-W6 for gcvg-git@gmane.org; Sat, 28 Oct
 2006 20:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751334AbWJ1SeK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWJ1SeK
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 14:34:10 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:22934 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1751334AbWJ1SeI
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 14:34:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028183408.OLOG22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 14:34:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fuaB1V0431kojtg0000000 Sat, 28 Oct 2006
 14:34:12 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> I take this above statement to mean that you answered your own
> question about how my sequence is able to resolve the race condition?

Yes.  I needed more thought after I asked that question.

>...
> Why not just use create a new flag file?
>
> Lets say that a pack X is NOT eligible to be repacked if
> "$GIT_DIR/objects/pack/pack-X.keep" exists.

I like it.
