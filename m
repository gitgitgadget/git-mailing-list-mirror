X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 19:58:49 -0800
Message-ID: <7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org> <20061126033433.GD29394@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:59:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061126033433.GD29394@spearce.org> (Shawn Pearce's message of
	"Sat, 25 Nov 2006 22:34:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32325>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoBAR-00047O-S3 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967289AbWKZD6v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967288AbWKZD6v
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:58:51 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24195 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S967289AbWKZD6v
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:58:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126035850.UFVM18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 22:58:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rFyK1V0051kojtg0000000; Sat, 25 Nov 2006
 22:58:19 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Needing to put + in front of a refspec (or needing to fetch it with
> --force) is the user agreeing that something _evil_ is going on with
> the upstream and that they acknowledge this may cause problems for
> them locally.
>
> I would prefer to see the upstream be able to publish a short
> description of each branch, where the repository owner can describe
> the policy of that branch, as well as have a machine readable
> setting on each branch indicating if that branch will be rewound
> from time to time, or never rewound.
>
> git-clone should skip rewinding branches by default, unless the user
> adds an option (e.g. --include-rewinding-branches).  This way new
> users to git.git don't get the `pu` branch unless they really mean
> to get it, at which point they have hopefully also read the upstream's
> description of the `pu` branch and its rewinding policy, and can
> at least start to grasp what is going to happen if they start to
> work with the branch.

I like this approach very much.



