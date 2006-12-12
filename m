X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: index manipulation quickref
Date: Tue, 12 Dec 2006 10:18:36 -0800
Message-ID: <7vac1tvuyr.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0612120257p35dc9483ob65eea9ae21b5f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 18:18:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <fcaeb9bf0612120257p35dc9483ob65eea9ae21b5f7b@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Tue, 12 Dec 2006 17:57:17 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34118>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCDB-0007c3-7h for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932263AbWLLSSi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWLLSSi
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:18:38 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59959 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932318AbWLLSSh (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 13:18:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212181837.PYTP9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Tue, 12
 Dec 2006 13:18:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xuHy1V00M1kojtg0000000; Tue, 12 Dec 2006
 13:17:59 -0500
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> I'm trying to collect all operations related to index from user
> perspective and corresponding commands. The list may be put to git
> wiki if people think it can help newbies:

I think this goes in the wrong direction.  For "newbies" the
Porcelain-ish set is supposed to be enough and if there is
something missing that they need to do update-index command
itself or a pipeline that involves update-index to achieve
common tasks, we should enhance Porcelain-ish that captures the
pattern.

I think quick-ref for Porcelain writers would not hurt, but they
have manuals.
