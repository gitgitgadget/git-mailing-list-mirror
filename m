X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Planned new release of git
Date: Tue, 07 Nov 2006 15:19:08 -0800
Message-ID: <7vac3226c3.fsf@assigned-by-dhcp.cox.net>
References: <454EAEDB.8020909@gmail.com>
	<7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com>
	<Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
	<45503553.3020605@gmail.com>
	<Pine.LNX.4.64.0611070729370.3667@g5.osdl.org>
	<7vhcxb2b15.fsf@assigned-by-dhcp.cox.net> <eiqvoh$ebd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 23:19:19 +0000 (UTC)
Cc: jnareb@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Original-cc: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31100>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhaDr-0004tQ-2Z for gcvg-git@gmane.org; Wed, 08 Nov
 2006 00:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753334AbWKGXTL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 18:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbWKGXTL
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 18:19:11 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40669 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1753334AbWKGXTJ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 18:19:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107231908.GVQP6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Tue, 7
 Nov 2006 18:19:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id jzJl1V00X1kojtg0000000; Tue, 07 Nov 2006
 18:18:46 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> We haven't seen a new release from 'master' for about a month.
>> I think the dust has settled already after two big topics
>> (packed-refs, delta-offset-base) were merged into 'master' since
>> v1.4.3, and it is now time to decide which topics that have been
>> cooking in 'next' are the ones I want in v1.4.4.  Perhaps by the
>> end of the week, I'll cut a v1.4.4-rc1 to start the pre-release
>> stabilization process.  No new features nor enhancements on
>> 'master' after that until v1.4.4 final.
>  
> Do I understand correctly that the work on not exploding downloaded
> pack on fetch, but making it non-thin, and related work on archival
> packs (not to be considered for repacking) is not considered ready
> (and tested)?

Perhaps I phrased it badly, but I doubt it.

In the above I am only saying that it probably is time for me to
decide which ones to further merge into 'master', without saying
which ones I think is ready right now.  That is because I
haven't started thinking about it.
