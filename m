X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Wed, 06 Dec 2006 11:47:10 -0800
Message-ID: <7vpsaw3iyp.fsf@assigned-by-dhcp.cox.net>
References: <200612040001.13640.jnareb@gmail.com>
	<200612061351.02712.jnareb@gmail.com>
	<7vveko3km4.fsf@assigned-by-dhcp.cox.net>
	<200612062032.58706.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 19:48:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612062032.58706.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 6 Dec 2006 20:32:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33514>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2kG-0004KW-2k for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937572AbWLFTrN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937574AbWLFTrN
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:47:13 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40188 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937572AbWLFTrL (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 14:47:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206194710.RAXY2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Wed, 6
 Dec 2006 14:47:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vXnL1V00a1kojtg0000000; Wed, 06 Dec 2006
 14:47:21 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, what is the formal structure of the config file? Perhaps
> something like the notation used in RFC?

Is there an RFC for .INI format?

> Is it possible (and doesn't crash current git config parser) having
>
>   [gitweb]
>   	blame = yes
>   	pickaxe = no
>   	snapshot = bzip2
>
>   [gitweb "committags"]
>   	message-id = "http://news.gmane.org/find-root.php?message_id="
>   	mantis = "http://bugs.or.cz/view.php?id="
>   	url
>   	sha1
>
> in the config file?

If you are asking about [gitweb] stanza and (seemingly
overlapping) [gitweb "foo"] stanza, we already have prior
examples:

	[diff]
        	color = auto
        [diff "color"]
        	whitespace = blue reverse

so your example in the above would be legal (the dash in
'message-id' part might be questionable, though).




