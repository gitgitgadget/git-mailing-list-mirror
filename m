X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Mon, 06 Nov 2006 18:03:46 -0800
Message-ID: <7vd5809fnh.fsf@assigned-by-dhcp.cox.net>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de>
	<7vd580azbb.fsf@assigned-by-dhcp.cox.net>
	<200611070225.24956.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 02:04:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611070225.24956.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 7 Nov 2006 02:25:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31038>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhGJz-0000DV-PB for gcvg-git@gmane.org; Tue, 07 Nov
 2006 03:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753945AbWKGCDs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 21:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbWKGCDs
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 21:03:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37283 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1753945AbWKGCDr
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 21:03:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107020347.ZTJO22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 21:03:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id je3r1V00p1kojtg0000000; Mon, 06 Nov 2006
 21:03:52 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> What do you think about the setup of the default for "git-pull"?

I personally feel that is loading "checkout" with too many
different things.

It might be easier to maintain in the long term to have a helper
command 'git-fork' to handle the gory details of forking off
from an existing branch (merge default setting, branch creation,
what else will we have next month? ;-) and perhaps automatically
call it from git-checkout as a short-hand.
