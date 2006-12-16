X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Sat, 16 Dec 2006 14:04:54 -0800
Message-ID: <7vhcvvcxa1.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<em0u4k$8hs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 22:05:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <em0u4k$8hs$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	16 Dec 2006 14:59:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34647>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvheM-00026f-OD for gcvg-git@gmane.org; Sat, 16 Dec
 2006 23:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422639AbWLPWE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 17:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWLPWE4
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 17:04:56 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46452 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1422639AbWLPWEz (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 17:04:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216220455.YJZG15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 17:04:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id za561V00d1kojtg0000000; Sat, 16 Dec 2006
 17:05:06 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Things that need to be done to complete what have been merged to
>> 'master' are:
>
> What about discussed but not implemented moving restriction on non-head refs
> from git-checkout (forbidding to checkout tags, remotes, and arbitrary
> commits like HEAD~n) to git-commit (allowing commiting only to heads refs)?

Did I miss a patch? ;-)

I've taken a look at it once, and it is usually easy to decide
if we should allow or disallow manipulation of the HEAD at
individual places that tries to look at it or modify it, but
there are many places and giving reasonable error messages to
all of the places we would want to disallow would be quite a lot
of work.  In other words, it is rather a wide-and-shallow change
all over manipulators section of Porcelain.  So from my point of
view it is backburnered, but that does not mean I would object
to a patch that does it cleanly ;-).


