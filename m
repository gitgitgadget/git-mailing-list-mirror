X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 12:29:13 -0800
Message-ID: <7vmz7e27dy.fsf@assigned-by-dhcp.cox.net>
References: <539418.62803.qm@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 20:29:28 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <539418.62803.qm@web31807.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Sun, 29 Oct 2006 11:43:14 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30453>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHHT-0005OP-0R for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965429AbWJ2U3P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965431AbWJ2U3P
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:29:15 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60915 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S965430AbWJ2U3O
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:29:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029202914.PHFZ16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 15:29:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id gLVJ1V00C1kojtg0000000 Sun, 29 Oct 2006
 15:29:18 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> For dear life, I cannot understand  *WTF*  is this argument about
> "quoted" and "unquoted".  Can this stop please?  PLEASE?
>
> Unquoted, natural, normal.

I do not think Jakub is talking about quoting normal filenames a/foo
that is not quoted by "git diff" into "a/foo" with his code.

I think when "git diff" quotes because of unusual characters
gitweb should show it quoted, i.e. as it receives from "git diff".

