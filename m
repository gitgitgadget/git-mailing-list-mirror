X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull and merging.
Date: Thu, 07 Dec 2006 15:06:44 -0800
Message-ID: <7vac1zqpa3.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	<200612061744.31213.Josef.Weidendorfer@gmx.de>
	<4577B8C0.3060200@gmail.com>
	<200612071227.46194.Josef.Weidendorfer@gmx.de>
	<7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 23:07:36 +0000 (UTC)
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 07 Dec 2006 11:06:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33647>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsSKw-0005E0-D0 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 00:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163926AbWLGXHY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 18:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163816AbWLGXHX
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 18:07:23 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:34766 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163926AbWLGXHV (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 18:07:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207230720.MKJM29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 18:07:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vz6v1V00r1kojtg0000000; Thu, 07 Dec 2006
 18:06:56 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Once you place something like "branch.*.merge" in configuration
> file (either $GIT_DIR/config, or a $GIT_DIR/remotes/* file), you
> are talking about other repositories you regularly interact
> with, so it might be probably Ok to require the user to use a
> tracking branch if he wants the convenience of "branch.*.merge",
> and make its value name the local tracking branch instead of the
> remote branch.

In other words, I am all for fixing this.

Although it may not hurt too much if we just redefine the
meaning of it to name the local tracking branch, using a
different name "branch.*.defaultmerge" is safer and would not
break existing repositories.
