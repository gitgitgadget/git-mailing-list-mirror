X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Combined diff format documentation
Date: Wed, 25 Oct 2006 20:04:30 -0700
Message-ID: <7vmz7jkcap.fsf@assigned-by-dhcp.cox.net>
References: <junkio@cox.net>
	<200610260148.k9Q1mr99007511@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 03:04:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610260148.k9Q1mr99007511@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Wed, 25 Oct 2006 22:48:53 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30132>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcvY3-0008AK-8S for gcvg-git@gmane.org; Thu, 26 Oct
 2006 05:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422850AbWJZDEh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 23:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422862AbWJZDEh
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 23:04:37 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24294 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1422850AbWJZDEh
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 23:04:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026030436.WVRW6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 23:04:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id er4K1V0041kojtg0000000 Wed, 25 Oct 2006
 23:04:19 -0400
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

>> Correct.  This was done to prevent people from accidentally
>> feeding it to "patch -p1".  In other words, we wanted to make it
>> so obvious that it is _not_ a patch.
>
> It isn't, really... perhaps it should be made /more/ obvious (not use @ but
> e.g. &, ...)?

Eh, sorry, what I meant was "obvious to the tool", so "patch"
would take notice.
