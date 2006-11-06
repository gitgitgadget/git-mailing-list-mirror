X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Documentation: Two more git-rebase --onto examples
Date: Mon, 06 Nov 2006 11:18:40 -0800
Message-ID: <7vodrkcrjj.fsf@assigned-by-dhcp.cox.net>
References: <200611042205.58212.jnareb@gmail.com>
	<7vbqnmwvib.fsf@assigned-by-dhcp.cox.net>
	<200611051122.17623.jnareb@gmail.com>
	<87zmb4v3vu.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 19:31:23 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87zmb4v3vu.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	06 Nov 2006 10:14:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31025>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh9ze-0007ZX-4p for gcvg-git@gmane.org; Mon, 06 Nov
 2006 20:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752622AbWKFTSn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 14:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWKFTSn
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 14:18:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21143 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1752622AbWKFTSm
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 14:18:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106191841.NGLQ13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 14:18:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jXJm1V00T1kojtg0000000; Mon, 06 Nov 2006
 14:18:47 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> writes:

> I think Jakub's explanations do a much better job of explaining
> something someone might actually want to do and then showing how to do
> it. So if there's redundancy I'd vote for dropping the old stuff.

I agree with that.

> Meanwhile, while we're talking about git-rebase documentation, the
> recent posts about the:
>
> 	git rebase --onto <foo> <upstream> <branch>
>
> form take advantage of the fact that this command also changes the
> current branch to <branch>. I think that's quite surprising behavior,
> (though useful in the example that was given). It's perhaps out of
> line with the scope of git-rebase but it should at least be
> documented. I think that will need some specific mention before the
> examples.

Good point.
