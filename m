X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: SEGV when lookup_* returns NULL
Date: Mon, 27 Nov 2006 16:13:51 -0800
Message-ID: <7v3b84e8cg.fsf@assigned-by-dhcp.cox.net>
References: <20061127211315.GC18810@admingilde.org>
	<7vu00kftbq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611280032300.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 00:14:16 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611280032300.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 28 Nov 2006 00:33:24 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32468>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goqbl-0000sW-3Q for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933600AbWK1ANy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 19:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933601AbWK1ANy
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 19:13:54 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55773 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S933600AbWK1ANx
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 19:13:53 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128001353.YJMN4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 19:13:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id s0DL1V00c1kojtg0000000; Mon, 27 Nov 2006
 19:13:21 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And it would totally clobber the long term goal of libifying git.

Why?  You would certainly install your own die() handler by that
time I presume?
