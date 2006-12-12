X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames with spaces and non-ascii characters.
Date: Mon, 11 Dec 2006 17:15:49 -0800
Message-ID: <7vodq9zzga.fsf@assigned-by-dhcp.cox.net>
References: <20061209232919.31863.58547.stgit@lathund.dewire.com>
	<200612101639.22397.robin.rosenberg@dewire.com>
	<7vlklf4f1s.fsf@assigned-by-dhcp.cox.net>
	<200612110048.47435.robin.rosenberg@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34054>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtwFi-0005mZ-O2 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 02:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750810AbWLLBPw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006 20:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWLLBPw
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 20:15:52 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63372 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750812AbWLLBPu convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 20:15:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212011550.YEBR20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Mon, 11
 Dec 2006 20:15:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xdG11V0021kojtg0000000; Mon, 11 Dec 2006
 20:16:01 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> s=F6ndag 10 december 2006 22:27 skrev Junio C Hamano:
>> Maybe I am missing something.  It tells you about added or
>> removed files (either binary or non-binary).
>
> no, I was missing --summary. I thought --numstat did that (man page=20
> says "similar to stat".

Ah, figures.

Your patch removes more lines than it adds, which is quite nice.
