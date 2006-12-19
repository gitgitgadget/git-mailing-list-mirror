X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Only warn about missing branch.<n>.merge in pull.
Date: Tue, 19 Dec 2006 02:37:00 -0800
Message-ID: <7vy7p4qiib.fsf@assigned-by-dhcp.cox.net>
References: <20061218091206.GA11284@spearce.org>
	<7virg9xcvw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612182135360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612190159.58658.Josef.Weidendorfer@gmx.de>
	<7v7iwovg99.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612191127540.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 10:37:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612191127540.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 19 Dec 2006 11:28:45 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34817>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcLM-0002dq-Mb for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932765AbWLSKhE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWLSKhE
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:37:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64248 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932765AbWLSKhD (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:37:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219103701.QTBW9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 05:37:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0adD1W0051kojtg0000000; Tue, 19 Dec 2006
 05:37:13 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >> 	merge = pu for remote second # merge 'pu' if pulling from second
>>
>> I actually am in favor of Johannes's one, except that it does
>> look like you are always making a pentapus merge of pu, for,
>> remote and second branches into xyz ;-).
>
>
> Would
>
> 	merge = pu, when pulling second
>
> be better? ;-)

The users can work it around by writing:

	merge pu remote second for

Just document it clearly and say "if you are going to make an
pentapus (or more) with remote branches that include ones named
'for' and 'remote', do not place them as third and second
(respectively) word from the end on the line" ;-).

Your "noise word" remote is actually useful.

