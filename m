X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Fri, 03 Nov 2006 14:44:48 -0800
Message-ID: <7vwt6c40bj.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200611031719.13073.jnareb@gmail.com>
	<7virhw5hoi.fsf@assigned-by-dhcp.cox.net>
	<200611032333.49794.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 22:45:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611032333.49794.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 3 Nov 2006 23:33:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30892>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg7mR-0000v8-1H for gcvg-git@gmane.org; Fri, 03 Nov
 2006 23:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752549AbWKCWou (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbWKCWou
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 17:44:50 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33023 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1752549AbWKCWot
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 17:44:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103224449.HVCY2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 17:44:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iNkT1V00Q1kojtg0000000 Fri, 03 Nov 2006
 17:44:28 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Well, control characters (at least some of them) are not correct
> characters in UTF-8 HTML output; Mozilla in strict XHTML mode complains.
> Currently...

I said you quote controls (and only controls) as unsafe, so you
are not disagreeing with me here.  However "controls are unsafe"
does not necessarily mean "unsafe characters are all controls",
does it?  That was what my comments abuot the comment before the
function was.

> Which solution do you think it's best?

Sorry, if it was not clear in my message, I wanted to say that I
kinda liked those "control pictures" in U+2400 range.
