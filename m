X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [git failure] failure pulling latest Linus tree
Date: Wed, 25 Oct 2006 10:35:03 -0700
Message-ID: <7v3b9ce1tk.fsf@assigned-by-dhcp.cox.net>
References: <yq0d58g92u0.fsf@jaguar.mkp.net>
	<Pine.LNX.4.64.0610250746000.3962@g5.osdl.org>
	<453F8630.2000608@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 17:35:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30082>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcmek-00049E-LP for gcvg-git@gmane.org; Wed, 25 Oct
 2006 19:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161115AbWJYRfG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 13:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWJYRfG
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 13:35:06 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30916 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1161223AbWJYRfE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 13:35:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025173503.VRVR13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 13:35:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eham1V00K1kojtg0000000 Wed, 25 Oct 2006
 13:34:46 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> For some reason which we haven't been able to track down yet, the
> recent load imposed by FC6 caused zeus1's load to skyrocket, but not
> zeus2's... it's largely a mystery.

Would kernel.org prefer RPM cut on a FC6 box now?

> HOWEVER, git 1.4.3 seems to have been bad chicken.  When we ran it we
> got a neverending stream of segfaults in the logs.

If that is git-daemon dying when talking to older clients, that
has been fixed in 1.4.3.2 (it's virtual hosting support had an
off-by-one wrong check to tell older clients from newer one).

Sorry about that -- we heard about the incompatibility this
Monday.

