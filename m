X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 16:24:22 -0500
Message-ID: <BAYC1-PASMTP01F45766D9195AAFD81789AEFE0@CEZ.ICE>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	<7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	<20061102224549.499610d1.seanlkml@sympatico.ca>
	<20061103203610.GB7585@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 21:25:12 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org,
	Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061103162422.b0bf105e.seanlkml@sympatico.ca>
In-Reply-To: <20061103203610.GB7585@spearce.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 03 Nov 2006 21:24:24.0856 (UTC) FILETIME=[6F8C9180:01C6FF8E]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg6Wb-0005iP-GE for gcvg-git@gmane.org; Fri, 03 Nov
 2006 22:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753547AbWKCVY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 16:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWKCVYZ
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 16:24:25 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:33034 "EHLO
 bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1753547AbWKCVYZ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 16:24:25 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 3 Nov 2006 13:24:24 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gg5aQ-0005sm-QF; Fri, 03 Nov 2006 15:24:22 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Fri, 3 Nov 2006 15:36:10 -0500
Shawn Pearce <spearce@spearce.org> wrote:

> > Maybe even going as far as automatically creating a local branch
> > for each remote branch on clone is worth considering.
> 
> Nack.
> 
> I work with a workflow where our central repository has 2 important
> branches (vmtip and vmvt), and a bunch of transient developer
> topic branches (e.g. sp/foo).  We only have a master branch in this
> repository so that git-clone will clone it without choking during
> the clone.  Users tend to do immediately after a clone:
> 
> 	git branch -D master
> 	git branch -D origin
> 	git branch -D ... other topic branches not interested in ...
> 	edit .git/remotes/origin ... delete topic branches ...

I think your Nack was a little rash here.  The feature would be quite
useful to work flows other than yours.  It sounds like what _you_ want
is a feature to select branches when cloning rather than the current
default of cloning all.  That would stop your developers having to 
delete branches and editing .git/remotes/origin immediately
after cloning.

