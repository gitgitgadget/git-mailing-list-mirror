X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:35:22 -0800
Message-ID: <7v7ixwgj2d.fsf@assigned-by-dhcp.cox.net>
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
	<455BBCE9.4050503@xs4all.nl> <7vhcx0gnbq.fsf@assigned-by-dhcp.cox.net>
	<455BCD2B.6060603@xs4all.nl> <7vbqn8gjeo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 03:35:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqn8gjeo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 15 Nov 2006 19:27:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31552>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkY2C-0004UP-HJ for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031079AbWKPDfY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031078AbWKPDfY
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:35:24 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21897 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1031079AbWKPDfX
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:35:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116033523.GDAS18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 22:35:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nFbU1V00t1kojtg0000000; Wed, 15 Nov 2006
 22:35:29 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

(not changing what I said but editorial)
> I myself do prefer, when learning a new tool, to use longhand
> until I understand the shorthand, but that attitude requires a
> true commitment to learn the tool, and most people do not go
> that route.  Tutorial style documents tend to give the commonly
> used shorthand first for that exact reason.

Eh, sorry, "prefer to use longhand until I understand what is
going on before using the shorthand" is what I wanted to say.

> Shorthand to give only the branch name to fetch and merge
> immediately without using a tracking branch is equivalent to
> longhand "branch:" as you found out, so if that was what was
> desired then people with the attitude "before understanding what
> longhand does I prefer using shorthand" like myself and you

"prefer not using shorthand", sorry again.

> would have liked to learn "git pull url branch:" notation from
> Tutorial.  But I think we _are_ minority.  People would not want
> to see that seemingly useless colon there.
