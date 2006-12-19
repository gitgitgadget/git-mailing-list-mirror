X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Only warn about missing branch.<n>.merge in pull.
Date: Mon, 18 Dec 2006 17:14:26 -0800
Message-ID: <7v7iwovg99.fsf@assigned-by-dhcp.cox.net>
References: <20061218091206.GA11284@spearce.org>
	<7virg9xcvw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612182135360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612190159.58658.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 01:15:27 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612190159.58658.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 19 Dec 2006 01:59:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34779>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwTYy-0007sk-Hb for gcvg-git@gmane.org; Tue, 19 Dec
 2006 02:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932596AbWLSBO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 20:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWLSBO3
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 20:14:29 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41471 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932596AbWLSBO2 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 20:14:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219011426.CTOQ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Mon, 18
 Dec 2006 20:14:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0RDl1W00h1kojtg0000000; Mon, 18 Dec 2006
 20:13:46 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Monday 18 December 2006 21:43, Johannes Schindelin wrote:
>> 
>> However, I would actually reuse our versatile (often hated?) config  
>> handling:
>> 
>> [branch "xyz"]
>> 	remote = blabla # this is the default remote
>> 	merge = master # this is the default branch for the default remote
>> 	merge = pu for remote second # merge 'pu' if pulling from second
>
> Looks a little bit confusing, but is fine with me.
> I even would remove the need for the word "remote" in the second merge line.
> Anybody using this has to look it up in the documentation, anyway.
> Because these options are not really self-describing.

I actually am in favor of Johannes's one, except that it does
look like you are always making a pentapus merge of pu, for,
remote and second branches into xyz ;-).

