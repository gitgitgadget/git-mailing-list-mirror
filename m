From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 18:08:48 +0200
Message-ID: <20051115180848.561a6da5.tihirvon@gmail.com>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, lukass@etek.chalmers.se, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 17:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec3Mx-000801-Ja
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 17:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVKOQJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 11:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVKOQJA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 11:09:00 -0500
Received: from marski.suomi.net ([212.50.131.142]:56052 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S932533AbVKOQI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 11:08:59 -0500
Received: from prolisok.suomi.net (prolisok.suomi.net [212.50.140.226])
 by marski.suomi.net (Sun Java System Messaging Server 6.2 (built Dec  2 2004))
 with ESMTP id <0IQ000JRJ7IS3000@marski.suomi.net> for git@vger.kernel.org;
 Tue, 15 Nov 2005 18:08:53 +0200 (EET)
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTP id <0IQ0004XJ7PSFH40@mailstore.suomi.net>; Tue,
 15 Nov 2005 18:13:05 +0200 (EET)
Received: from garlic.home.net (addr-82-128-203-211.suomi.net [82.128.203.211])
	by spam1.suomi.net (Postfix) with SMTP id 886C31ABDB6; Tue,
 15 Nov 2005 18:08:47 +0200 (EET)
In-reply-to: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.6; i686-pc-linux-gnu)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.075,	required 5,
 autolearn=not spam, AWL 0.52, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11913>

On Tue, 15 Nov 2005 16:49:30 +0100
Alex Riesen <raa.lkml@gmail.com> wrote:

> llist_sorted_difference_inplace didn't handle the match in the first
> sha1 correctly and the lists went wild everywhere.
> 
> ---
> 
> I noticed it on a very big repository (more than 100k files), trying
> to prune it.
> The code could profit from double-linked lists greatly, IMHO.

I use list.h from Linux when I need double-linked lists.  It is very
easy to use, efficient and fast.

-- 
http://onion.dynserv.net/~timo/
