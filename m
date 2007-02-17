X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A new merge stragety 'subtree'.
Date: Sat, 17 Feb 2007 10:02:53 -0800
Message-ID: <7v4ppkvf02.fsf@assigned-by-dhcp.cox.net>
References: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
	<20070217071425.GD27864@spearce.org>
	<7vzm7duqzf.fsf@assigned-by-dhcp.cox.net>
	<20070217085305.GF27864@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 17 Feb 2007 18:03:24 +0000 (UTC)
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20070217085305.GF27864@spearce.org> (Shawn O. Pearce's message
	of "Sat, 17 Feb 2007 03:53:05 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1HITu1-0002g8-08 for gcvg-git@gmane.org; Sat, 17 Feb 2007
 19:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030228AbXBQSC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 17 Feb 2007
 13:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbXBQSC4
 (ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:02:56 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43639 "EHLO
 fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030228AbXBQSCz (ORCPT <rfc822;git@vger.kernel.org>); Sat, 17 Feb 2007
 13:02:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao103.cox.net
 (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP id
 <20070217180255.EDGM1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>; Sat, 17
 Feb 2007 13:02:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id Qi2t1W00V1kojtg0000000; Sat, 17 Feb 2007
 13:02:54 -0500
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Or... I/we implement -p2 in git-am.  Then I can apply it right to
> my git-gui repository.  :-)

Which is 2092a1fe (v1.5.0~23), I think.
