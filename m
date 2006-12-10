X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Sat, 09 Dec 2006 16:54:35 -0800
Message-ID: <7vd56s8t9w.fsf@assigned-by-dhcp.cox.net>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
	<m2d56taoqu.fsf@ziti.local> <7vfybpg9yx.fsf@assigned-by-dhcp.cox.net>
	<200612100146.09175.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 00:54:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612100146.09175.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 10 Dec 2006 01:46:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33859>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtCxk-0006CN-Fk for gcvg-git@gmane.org; Sun, 10 Dec
 2006 01:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754278AbWLJAyh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 19:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757216AbWLJAyh
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 19:54:37 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42470 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754278AbWLJAyh (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 19:54:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210005436.LNUQ4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sat, 9
 Dec 2006 19:54:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id woun1V0051kojtg0000000; Sat, 09 Dec 2006
 19:54:47 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Saturday 09 December 2006 01:59, Junio C Hamano wrote:
>> Maybe the "git add --interactive" would give you a transcript
>> like this:
> ...
> Something like this really would be good.

I think I already had the code in jit --- I need to dig it out.

But the above is trivial for anybody who knows how to use
git-diff-index and "git-apply --cached", so...
