X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] git-svn: let libsvn_ls_fullurl return properties too
Date: Mon, 04 Dec 2006 17:10:50 -0800
Message-ID: <7vhcwbkuzp.fsf@assigned-by-dhcp.cox.net>
References: <20061204235724.46FD7139B0C@magnus.utsl.gen.nz>
	<7v3b7vnqtv.fsf@assigned-by-dhcp.cox.net>
	<20061205010428.GA26687@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 01:10:58 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061205010428.GA26687@soma> (Eric Wong's message of "Mon, 4 Dec
	2006 17:04:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33279>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOpk-0005PD-53 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967952AbWLEBKx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967954AbWLEBKx
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:10:53 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:61610 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S967952AbWLEBKw (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:10:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205011052.WBOT27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 20:10:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id upB11V00h1kojtg0000000; Mon, 04 Dec 2006
 20:11:02 -0500
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> 
>> Please CC people who are primarily working on the part of the
>> system you are improving.  In the case of git-svn that would be
>> Eric Wong.
>
> Yes, CCs regarding git-svn would be much appreciated, thanks.
> ...
> Please fix the coding style so that it's consistent with the rest of
> git-svn:

Thanks Eric for your quick response.

> a) indentation is done with hard tabs
> b) no spaces around parentheses: "if ($foo) {" vs "if ( $foo ) {"
>
> Also, adding tests would be helpful in helping me maintain it (I'm not
> a regular svk user, so I don't want to break anything you've done down
> the line).

Another request from the maintainer is to Sign-off the patches.
