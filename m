X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Can't fetch 2.6.20-rc1 tag...
Date: Mon, 18 Dec 2006 07:29:45 -0500
Message-ID: <BAYC1-PASMTP1091AB27E446DFAD251A6DAEC90@CEZ.ICE>
References: <38b2ab8a0612180356t5c04f5bn29d7be3d0aa40764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 23:56:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1147 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 07:48:55 EST
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061218072945.53eda885.seanlkml@sympatico.ca>
In-Reply-To: <38b2ab8a0612180356t5c04f5bn29d7be3d0aa40764@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Dec 2006 12:34:08.0296 (UTC) FILETIME=[CFFD8A80:01C722A0]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwHvd-0001q6-Jv for gcvg-git@gmane.org; Mon, 18 Dec
 2006 13:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753947AbWLRMs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 07:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbWLRMs4
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 07:48:56 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:6028 "EHLO
 BAYC1-PASMTP10.bayc1.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1753947AbWLRMsz (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18
 Dec 2006 07:48:55 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 18 Dec 2006 04:34:08 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GwGgi-00070I-7n; Mon, 18 Dec 2006 06:29:44 -0500
To: "Francis Moreau" <francis.moro@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, 18 Dec 2006 12:56:09 +0100
"Francis Moreau" <francis.moro@gmail.com> wrote:

>     fatal: unexpected EOF
>     Fetch failure:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> My git version is '1.4.4.2'
> 
> Can anybody tell me what I'm doing wrong ?

You're not doing anything wrong.  There is a problem on one of the
kernel.org mirrors, it seems to have been that way for a few days.
If you use "204.152.191.37" instead of git.kernel.org it should work.

