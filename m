From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 21:19:55 +0200
Message-ID: <200908152119.56606.trast@student.ethz.ch>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 15 21:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McOo0-0003oa-84
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 21:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbZHOTUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 15:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbZHOTUf
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 15:20:35 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:26201 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbZHOTUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 15:20:35 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 21:20:32 +0200
Received: from thomas.localnet (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 21:20:11 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126020>

Linus Torvalds wrote:
> 
> I keep on thinking that I can write
> 
> 	git log --format:'%aN: %s'
> 
> instead of using the long-form "--pretty=format:xyz' thing. And each time, 
> I curse myself for being stupid for forgetting the proper format.
> 
> And I'm tired of being stupid. So this patch makes me smart and 
> forward-thinking instead.

But we already have --format="%aN: %s" since these two commits:

commit 36407548a2825462a91b456755412a65fd611fc0
Author: Nanako Shiraishi <nanako3@lavabit.com>
Date:   Tue Feb 24 18:59:15 2009 +0900

    Give short-hands to --pretty=tformat:%formatstring

    Allow --pretty="%h %s" (and --format="%h %s") as shorthand for an often
    used option --pretty=tformat:"%h %s".

    Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

commit 3a4c1a5e212357c3df030b6713c75466694c2e77
Author: Nanako Shiraishi <nanako3@lavabit.com>
Date:   Tue Feb 24 18:59:14 2009 +0900

    Add --format that is a synonym to --pretty

    Some people prefer to call the pretty-print styles "format", and get
    annoyed to see "git log --format=short" fail.  Introduce it as a synonym
    to --pretty so that both can be used.

    Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


Granted, it makes it equivalent to --pretty=tformat:foo, but isn't
tformat the better choice in many cases?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
