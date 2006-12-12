X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] no need to install manpages as executable
Date: Mon, 11 Dec 2006 17:15:50 -0800
Message-ID: <7virghzzg9.fsf@assigned-by-dhcp.cox.net>
References: <20061211073932.GA12555@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 12 Dec 2006 01:16:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34055>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtwFj-0005mZ-8w for gcvg-git@gmane.org; Tue, 12 Dec
 2006 02:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750813AbWLLBPz convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006 20:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWLLBPz
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 20:15:55 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37599 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750813AbWLLBPw convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 20:15:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212011552.OGTZ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Mon, 11
 Dec 2006 20:15:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xdG21V00f1kojtg0000000; Mon, 11 Dec 2006
 20:16:03 -0500
To: Chris Wright <chrisw@sous-sol.org>
Sender: git-owner@vger.kernel.org

Chris Wright <chrisw@sous-sol.org> writes:

> No need to install manpages as executable.  Noticed by Ville Skytt=E4=
=2E

Thanks.  I agree there is no need but I wonder why we even need
to specify that explicitly.  Well, I guess I did not know that
install(1) was that stupid.
