X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Mon, 06 Nov 2006 14:47:11 -0800
Message-ID: <7v8xiochw0.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<7virhw5hoi.fsf@assigned-by-dhcp.cox.net>
	<200611032333.49794.jnareb@gmail.com>
	<200611062258.08320.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 22:47:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611062258.08320.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 6 Nov 2006 22:58:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31028>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhDFM-0003kl-IG for gcvg-git@gmane.org; Mon, 06 Nov
 2006 23:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753893AbWKFWrN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbWKFWrN
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 17:47:13 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10938 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1753893AbWKFWrM
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 17:47:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061106224711.HEIE6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 17:47:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id janG1V00p1kojtg0000000; Mon, 06 Nov 2006
 17:47:17 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Here is example code for this:

Ok.  The issues I raised in the previous round seem to have been
addressed.  Maybe you would want not to use nested 'sub' and it
is good to go, I think.
