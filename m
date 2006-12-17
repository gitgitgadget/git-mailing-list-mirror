X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add file addition/deletion indicator in diffstat
Date: Sat, 16 Dec 2006 16:15:20 -0800
Message-ID: <7vhcvv8jjb.fsf@assigned-by-dhcp.cox.net>
References: <20061111123331.GA23829@localhost>
	<fcaeb9bf0612161612r36470c2fm3c0f19e56f6a16a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 00:15:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <fcaeb9bf0612161612r36470c2fm3c0f19e56f6a16a@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Sun, 17 Dec 2006 07:12:58 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34666>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvjga-0005P5-VX for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422919AbWLQAPW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbWLQAPW
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:15:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:38608 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422919AbWLQAPW (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 19:15:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217001521.ZTCM4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 19:15:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zcFZ1V00K1kojtg0000000; Sat, 16 Dec 2006
 19:15:33 -0500
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> I have used this patch for a while and found it actually useful,
> especially while inspecting "git-log --stat". And if you prefer "git
> diff --stat" over "git status", it may tell you which file you added
> or deleted. So my only guess is that you missed it somehow. If it is
> refused, may I know the reason? I can improve it on request :-)

Doesn't seem to add much value over existing --summary.
