X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 16:27:07 -0500
Message-ID: <BAYC1-PASMTP020F825A42FB7A7DB6CD8BAEFE0@CEZ.ICE>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	<20061102224549.499610d1.seanlkml@sympatico.ca>
	<20061103081232.GB15972@diana.vm.bytemark.co.uk>
	<20061103042540.192bbd18.seanlkml@sympatico.ca>
	<20061103202945.GA7585@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 21:27:33 +0000 (UTC)
Cc: Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061103162707.cc8af608.seanlkml@sympatico.ca>
In-Reply-To: <20061103202945.GA7585@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 03 Nov 2006 21:27:09.0022 (UTC) FILETIME=[D1664FE0:01C6FF8E]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg6ZF-0006Lp-Bt for gcvg-git@gmane.org; Fri, 03 Nov
 2006 22:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932075AbWKCV1K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 16:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWKCV1K
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 16:27:10 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:53301 "EHLO
 BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP id S932075AbWKCV1J
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 16:27:09 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP02.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Fri, 3 Nov
 2006 13:27:08 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gg5d4-0005tD-Ta; Fri, 03 Nov 2006 15:27:06 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Fri, 3 Nov 2006 15:29:45 -0500
Shawn Pearce <spearce@spearce.org> wrote:

> Nack.  I'd rather see the entries added/removed from .git/config when
> the branch is created/deleted, just like the ref and the reflog are
> created/deleted.  It makes behavior more consistent for the user
> and it is mostly self documenting...
> 
> 	"why is branch FOO pulling FOO by default?  ahhh, its in
> 	.git/config after git branch FOO FOO."
> 
> Same goes for git-clone.  The branch.master.merge=origin/master
> entry should be in .git/config file after the clone is complete.

Well that's certainly an alternative implementation that achieves 
the same thing.  The essential point is that most of the time the
Git user should not have to manually create the merge entries
in the config file.  Git should be smart enough to get it right
most of the time automatically.

