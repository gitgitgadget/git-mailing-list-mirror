X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-push
Date: Wed, 01 Nov 2006 14:11:27 -0800
Message-ID: <7virhy24xc.fsf@assigned-by-dhcp.cox.net>
References: <1162306098.41547.4.camel@mayday.esat.net>
	<7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4ptj5ghj.fsf@assigned-by-dhcp.cox.net>
	<7v8xiu3ksl.fsf@assigned-by-dhcp.cox.net>
	<1162421693.93716.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 22:11:50 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <1162421693.93716.22.camel@localhost> (Florent Thoumie's message
	of "Wed, 01 Nov 2006 22:54:53 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30669>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOJ2-0006RA-In for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752498AbWKAWL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWKAWL3
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:11:29 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:44250 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1752498AbWKAWL3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:11:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101221128.JNVK18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 17:11:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id haBY1V00R1kojtg0000000 Wed, 01 Nov 2006
 17:11:33 -0500
To: Florent Thoumie <flz@xbsd.org>
Sender: git-owner@vger.kernel.org

Florent Thoumie <flz@xbsd.org> writes:

> On Wed, 2006-11-01 at 13:43 -0800, Junio C Hamano wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>> 
>> Actually, Florent's said the directory permission was screwed up
>> to begin with, so after following the code a bit more I can see
>> why it said "is a directory".
>
> I screwed the perms. I have a cron job that does automatic imports and
> it's running as root. I've been lured by the fact that it uses my name
> and email address to do those imports, so I thought it was running under
> my unprivileged account.

Thanks for a honest clarification.  I was starting to worry if
this is a BSD vs Linux filesystem gotcha that is harder to debug
without having an actual box.


