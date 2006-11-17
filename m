X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 00:41:33 -0800
Message-ID: <7vu00ysbwi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	<87velgs9hx.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
	<87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org>
	<Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
	<87fycjs5yg.wl%cworth@cworth.org>
	<f2b55d220611160957s2e68059dk99bbe902e7e1f416@mail.gmail.com>
	<87r6w3b68p.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 08:42:15 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87r6w3b68p.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	16 Nov 2006 10:23:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31675>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkzI5-0005t9-O8 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 09:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755509AbWKQIlf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 03:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbWKQIlf
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 03:41:35 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:13987 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1755509AbWKQIle
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 03:41:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117084134.CKAX21630.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 03:41:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nkhg1V00P1kojtg0000000; Fri, 17 Nov 2006
 03:41:41 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> On Thu, 16 Nov 2006 09:57:00 -0800, "Michael K. Edwards" wrote:
>> What do you want all of those branches for?  They haven't been
>> published to you (that's a human interaction that doesn't go through
>> git), so for all you know they're just upstream experiments, and doing
>> things with them is probably shooting yourself in the foot.
>
> The same "what do you want them all for" question could be asked of
> git-clone which also fetches all available branches. I really just
> want to be able to easily watch what's going on in multiple
> repositories.
>
> I want to be able to just say "git update" (or whatever) and then be
> able to list and browse and explore the stuff locally.
>...

I have no objection to this if it is done in a controlled way
that does not make life more difficult for people who work with
multiple remote repositories.

And I think "git fetch" is the tool for what you want if
enhanced properly; see Linus's message that explaind that we
already have that support in "manually configurable" form but
initializing and maintaining the configuration is currently all
manual and can be improved.

