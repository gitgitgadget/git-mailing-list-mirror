X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git: how to produce context diffs?
Date: Mon, 27 Nov 2006 12:06:15 -0500
Message-ID: <BAYC1-PASMTP11E0FF8B4ADAE232E667DDAEE60@CEZ.ICE>
References: <200611271516.30425.bruno@clisp.org>
	<ekesgt$6jq$1@sea.gmane.org>
	<BAYC1-PASMTP01B6529D1821EEBC0A6E6FAEE60@CEZ.ICE>
	<200611271705.36479.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 17:07:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127120615.570b777d.seanlkml@sympatico.ca>
In-Reply-To: <200611271705.36479.jnareb@gmail.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 17:16:06.0578 (UTC) FILETIME=[B965C120:01C71247]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gojvv-000843-S9 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 18:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758425AbWK0RGS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 12:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758427AbWK0RGS
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 12:06:18 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:45601 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1758426AbWK0RGR
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 12:06:17 -0500
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Mon, 27 Nov
 2006 09:16:06 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Goizm-0006pv-5n; Mon, 27 Nov 2006 11:06:14 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, 27 Nov 2006 17:05:35 +0100
Jakub Narebski <jnareb@gmail.com> wrote:

> > It appears the only valid options now are "-u XX" and "--unified=XX".
> 
> Which both mean the same.

Yes, I guess I should have said that.  The point was really that you
can't pass any-diff-option and expect it to work.

> Which, in convoluted way is said in documentation (the fact that
> GIT_DIFF_OPTS affect internal diff).

The idea is to make it less convoluted.  It directly says that -c should
work _because_ it use to work when the options were passed to external
diff.  It's not just -c that won't work, none of the other myriad external
diff options will work either.

> > Unless i've really missed something, the above documentation should be
> > reworked to remove mention of running diff altogether, and should mention
> > that the GIT_DIFF_OPTS only has two valid settings.
> 
> For now.

Well the documentation can be updated later if additional options
are added.

