X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git bug? + question
Date: Mon, 6 Nov 2006 12:00:08 +0100
Message-ID: <200611061200.08972.Josef.Weidendorfer@gmx.de>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <200611041852.23867.Josef.Weidendorfer@gmx.de> <454F0636.1060406@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 11:02:37 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Sean <seanlkml@sympatico.ca>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org,
	Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <454F0636.1060406@shadowen.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31007>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh2F3-0003pk-96 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 12:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751798AbWKFLCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 06:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWKFLCJ
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 06:02:09 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:53654 "EHLO
 tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1751798AbWKFLCI (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006
 06:02:08 -0500
Received: from dhcp-2s-4.lrr.in.tum.de (dhcp-2s-4.lrr.in.tum.de
 [131.159.35.4]) by mail.in.tum.de (Postfix) with ESMTP id 1B45426FA; Mon,  6
 Nov 2006 12:00:11 +0100 (MET)
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

On Monday 06 November 2006 10:53, Andy Whitcroft wrote:
> Josef Weidendorfer wrote:
> > On Saturday 04 November 2006 06:03, Shawn Pearce wrote:
> >> After reading your reply you are probably correct.  I can see there
> >> may be workflows that want every remote branch also created as a
> >> local branch.
> >>
> >> I could certainly live with a command line option to clone, e.g.:
> >>
> >> 	git clone --only vmdvt,vmtip user@host:/path...
> > 
> > Still missing here: What branch should be checked out after
> > cloning?
> 
> Does any need to be checked out?

We should not change existing behavior. IMHO, checking out a branch is
mostly the right thing to do. Of course, you often want to specify which one.
The current requirement for a master branch in the origin repository
is really bad, as it obviously requires ugly workarounds in some cases
(and totally confuse newbies in such use cases).

> Or perhap I should put it another way, 
> when we make a virgin repository we default to master checked out but
> its not joined to the DAG.

I do not understand this. By creating a local branch, the commit DAG
is never changed.

