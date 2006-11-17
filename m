X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 10:57:48 -0500
Message-ID: <BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE>
References: <20061116221701.4499.qmail@science.horizon.com>
	<20061117153246.GA20065@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 15:58:28 +0000 (UTC)
Cc: linux@horizon.com, git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061117105748.b77c5799.seanlkml@sympatico.ca>
In-Reply-To: <20061117153246.GA20065@thunk.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Nov 2006 16:04:10.0375 (UTC) FILETIME=[049BF170:01C70A62]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl66I-0002ZJ-1q for gcvg-git@gmane.org; Fri, 17 Nov
 2006 16:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932934AbWKQP5y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 10:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWKQP5y
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 10:57:54 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:14560 "EHLO
 BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP id S932934AbWKQP5x
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 10:57:53 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Fri, 17 Nov
 2006 08:04:10 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gl5A4-0000ms-8m; Fri, 17 Nov 2006 09:57:48 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

On Fri, 17 Nov 2006 10:32:46 -0500
Theodore Tso <tytso@mit.edu> wrote:

> It would be nice if there was an easy way to direct users through the
> documentation in a way which makes good pedagogical sense.  Right now,
> one of the reasons why life gets hard for new users is that the
> current tutorials aren't enough for them to really undersatnd what's
> going on at a conceptual level.  And if users start using "everyday
> git" as a crutch, without the right background concepts, the human
> brain naturally tries to intuit what's happening in the background,
> but without reading the background docs, git is different enough that
> they will probably get it wrong, which means more stuff that they have
> to unlearn later.  

It would be nice to post this information on the Git website and not
have it overshadowed by Cogito examples with paragraphs explaining how
Cogito makes things easier.  The current website distracts users away
from learning Git or ever reading about this kind of information.
Maybe we can pass a hat around for some funds for a separate Cogito
website. ;o)

> Maybe we should change git so that a "Fetch: " line in the remotes
> file works the same way as "Pull: ", and then recommend that people
> use "Fetch: " in order to reduce confusion, as opposed to simply
> explaining it away as "yet another example of the histororical
> fetch/pull confusion"?
 
That's quite a good idea.  The name was fixed when the option to move
this info into the config file was added (remote.<name>.fetch).  So
another option would be to show new users the config file method and
just damn the remotes file to a historical footnote.

