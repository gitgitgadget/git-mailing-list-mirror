X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question about commit message conventions
Date: Wed, 25 Oct 2006 11:48:58 -0700
Message-ID: <7vbqo0b59h.fsf@assigned-by-dhcp.cox.net>
References: <200610241549.48238.t.toedter@gmx.net>
	<20061024140856.GH5639@harddisk-recovery.com>
	<453F8187.9060208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 18:49:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <453F8187.9060208@op5.se> (Andreas Ericsson's message of "Wed, 25
	Oct 2006 17:23:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30091>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcnoF-0008SR-7z for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030343AbWJYStA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 14:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWJYStA
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:49:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51936 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1030343AbWJYSs7
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 14:48:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025184859.NAFP12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 14:48:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eioh1V00b1kojtg0000000 Wed, 25 Oct 2006
 14:48:42 -0400
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> If you sift through the Linux kernel, you will find numerous patches
> where subsystem maintainers have acked patches sent to them. I *think*
> this usually means that they have reviewed the patch and approve of
> it, but not modified it. The Ack is then solely for Linus' benefits
> and tells him that at least one pair of eyes have already gone over
> the patch.

Correct.

> Subsys maintainers sometimes also add Signed-off-by: lines, which I
> assume means they have tweaked the patch somewhat or somehow
> collaborated with the author in producing it.
>...
> Lots of guesswork here, but in a sane world I can't be too far off the
> mark ;-)

Documentation/SubmittingPatches makes it unnecessary to make any
guesses on S-o-b lines.  Regarding subsystem maintainer
sign-offs, you are referring to DCO 1.1 (b), but the signature
could have been made under DCO 1.1 (c).

In plain terms, the signer vouches that the patch was passed
either intact or with modifications but the original and
modifications are both releasable, to the best of signer's
knowledge, under open source terms.

