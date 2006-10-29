X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Overwriting bare repositories' master
Date: Sun, 29 Oct 2006 14:05:35 -0800
Message-ID: <7vlkmyzsk0.fsf@assigned-by-dhcp.cox.net>
References: <20061029210333.GG12285@localhost.localdomain>
	<20061029215758.GA24385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 22:05:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061029215758.GA24385@localhost.localdomain> (Sylvain Beucler's
	message of "Sun, 29 Oct 2006 22:57:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30467>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeImq-0000vI-JK for gcvg-git@gmane.org; Sun, 29 Oct
 2006 23:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030379AbWJ2WFh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 17:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWJ2WFh
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 17:05:37 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45265 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1030379AbWJ2WFg
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 17:05:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029220536.OUHG18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 17:05:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id gN5g1V0011kojtg0000000 Sun, 29 Oct 2006
 17:05:40 -0500
To: Sylvain Beucler <beuc@gnu.org>
Sender: git-owner@vger.kernel.org

Sylvain Beucler <beuc@gnu.org> writes:

> ShadeHawk at #git noticed that this does not apply for a local
> directory.

Do not top-post please.

> I reproduced the two successive push-es both to a local git
> repository, and then to a remote git-shell'd one, and indeed, it works
> locally but it is rejected remotely ("error: denying non-fast forward;
> you should pull first").
>
> So this is probably caused by git-shell restrictions.

I do not think so.  Have you checked your config to see if you
have receive.denyNonFastforwards set?

I suspect Jakub (ShadeHawk)'s test does not have it.



