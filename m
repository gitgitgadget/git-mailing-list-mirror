X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdiff: Match GNU diff behaviour when deciding hunk comment worthiness of lines
Date: Tue, 24 Oct 2006 19:18:38 -0700
Message-ID: <7vejsxf88x.fsf@assigned-by-dhcp.cox.net>
References: <200610250133.k9P1XSVf006467@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 02:18:48 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610250133.k9P1XSVf006467@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Tue, 24 Oct 2006 22:33:28 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30026>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcYLr-0005iz-DB for gcvg-git@gmane.org; Wed, 25 Oct
 2006 04:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422776AbWJYCSk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 22:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422877AbWJYCSk
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 22:18:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:30459 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1422776AbWJYCSk
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 22:18:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025021839.DOZC22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Tue, 24
 Oct 2006 22:18:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eSJN1V00a1kojtg0000000 Tue, 24 Oct 2006
 22:18:23 -0400
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Petr Baudis <pasky@suse.cz> wrote:
>> This removes the '#' and '(' tests and adds a '$' test instead although I
>> have no idea what it is actually good for - but hey, if that's what GNU
>> diff does...
>
> $ starts a shell (or Perl) variable...
>
>> Pasky only went and did as Junio sayeth.
>
> Horst adds a guesse...

If I have to guess, I think that is from VMS.
