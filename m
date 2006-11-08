X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Use character or octal escape codes (and add span.cntrl) in esc_path
Date: Wed, 08 Nov 2006 10:24:40 -0800
Message-ID: <7vmz71u787.fsf@assigned-by-dhcp.cox.net>
References: <200611081147.52952.jnareb@gmail.com>
	<200611081150.07469.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 18:25:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611081150.07469.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 8 Nov 2006 11:50:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31149>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghs6P-0000zd-RL for gcvg-git@gmane.org; Wed, 08 Nov
 2006 19:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161415AbWKHSYm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbWKHSYm
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 13:24:42 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11176 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1754636AbWKHSYl
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 13:24:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061108182441.MGCM20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 13:24:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kJQm1V00V1kojtg0000000; Wed, 08 Nov 2006
 13:24:46 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Instead of simply hiding control characters in esc_path by replacing
> them with '?', use Character Escape Codes (CEC) i.e. alphabetic
> backslash sequences like those found in C programming language and
> many other languages influenced by it, such as Java and Perl.  If
> control characted doesn't have corresponding character escape code,
> use octal char sequence to escape it.
>
> Additionally use 'span' element with 'cntrl' attribute to mark escaped
> control characters. Add style for span.cntrl in the CSS.

Would have preferred the 'span' thing to be part of [1/2]...

Didn't I ask quot to be freestanding sub, not nested?  That
would make UPR vs CEC experiments easier and more pleasant.
