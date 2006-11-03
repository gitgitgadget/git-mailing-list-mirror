X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-push
Date: Thu, 02 Nov 2006 18:40:35 -0800
Message-ID: <7vbqnpl0bg.fsf@assigned-by-dhcp.cox.net>
References: <1162306098.41547.4.camel@mayday.esat.net>
	<7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk62f2l46.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611021018040.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 03:03:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30777>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfp6c-0003wO-0C for gcvg-git@gmane.org; Fri, 03 Nov
 2006 03:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752256AbWKCCkk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 21:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbWKCCkk
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 21:40:40 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12954 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1752976AbWKCCkg
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 21:40:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103024035.DTJI6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Thu, 2
 Nov 2006 21:40:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id i2gE1V00N1kojtg0000000 Thu, 02 Nov 2006
 21:40:15 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What I proposed does not break that. It only means that you only try to 
> adjust the permissions if the mkdir succeeded. If somebody else created 
> the directory in the mean time, it is not our job to adjust the 
> permissions.
> So I think that my patch is correct, but does not matter very much.

Ok.  I misread the patch.  Will apply with a one-liner log.

Thanks.

