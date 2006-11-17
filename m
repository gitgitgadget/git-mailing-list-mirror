X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
Date: Fri, 17 Nov 2006 00:42:10 -0500
Message-ID: <BAYC1-PASMTP0363A52FA4E6EE87232B20AEE80@CEZ.ICE>
References: <20061117051157.27896.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 05:44:21 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061117004210.e8fd1045.seanlkml@sympatico.ca>
In-Reply-To: <20061117051157.27896.qmail@science.horizon.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Nov 2006 05:42:12.0746 (UTC) FILETIME=[2191A6A0:01C70A0B]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkwWM-000182-EB for gcvg-git@gmane.org; Fri, 17 Nov
 2006 06:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424770AbWKQFmt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 00:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424773AbWKQFmZ
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 00:42:25 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:27414 "EHLO
 BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1424770AbWKQFmN (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006
 00:42:13 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 16 Nov 2006 21:42:12 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GkvYH-00082T-VS; Thu, 16 Nov 2006 23:42:10 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

On 17 Nov 2006 00:11:57 -0500
linux@horizon.com wrote:

> "The only intuitive user interface is the nipple; all else is learned."

The thing is that other SCM's like hg look a lot more like a nipple than
Git.  And they have the same conceptual models, more or less, to deal with
as Git.

So why is it so many people think Git has a UI problem where the same
complaint isn't levelled at Mercurial?  The thing is, the focus of
Git has been different, it's been about creating great plumbing.  It's
had great success at doing that, and anyone who warms up to Git is well
rewarded with a tool that gives them a lot of power and flexibility.

But Junio and others that have done most of the work have gone so far
as to say Git is basically now feature complete.. the plumbing is more
or less done.

So now it's time to make that plumbing more accessible and less
intimidating to the uninitiated.  And blaming them for having the wrong
mental model is just fundamentally the wrong approach.  No amount of
documentation is going to replace having tools that are the least
surprising they can be and Just Work more often than not.  Other
modern SCM's have managed to do a better job of this than Git, and
there's no reason Git can't do better than it has.

As long as no damage is done to the underlying architecture and
principles of Git there really shouldn't be _any harm_ in trying
to do a better job of the porcelain layer.

