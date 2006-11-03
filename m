X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 18:29:36 -0500
Message-ID: <20061103232936.GC6970@coredump.intra.peff.net>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca> <20061103081232.GB15972@diana.vm.bytemark.co.uk> <20061103042540.192bbd18.seanlkml@sympatico.ca> <20061103202945.GA7585@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 23:29:52 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103202945.GA7585@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30897>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg8Tm-0003Ga-Ee for gcvg-git@gmane.org; Sat, 04 Nov
 2006 00:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932495AbWKCX3k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWKCX3k
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 18:29:40 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:8374 "HELO
 peff.net") by vger.kernel.org with SMTP id S932495AbWKCX3j (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 18:29:39 -0500
Received: (qmail 9534 invoked from network); 3 Nov 2006 18:28:41 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 3 Nov 2006 18:28:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov
 2006 18:29:36 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Fri, Nov 03, 2006 at 03:29:45PM -0500, Shawn Pearce wrote:

> Nack.  I'd rather see the entries added/removed from .git/config when
> the branch is created/deleted, just like the ref and the reflog are
> created/deleted.  It makes behavior more consistent for the user
> and it is mostly self documenting...

If we go this route, please consider updating .git/auto-branch-config or
similar, and adding the functionality to include that file into
.git/config.

I think the concept of automagically munging a user-editable config file
is problematic, especially when users might manage those files with
version control or other systems.

