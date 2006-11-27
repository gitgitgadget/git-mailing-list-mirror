X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 9/10] Allow completion of --committer and --author arguments to git log.
Date: Mon, 27 Nov 2006 11:46:55 -0500
Message-ID: <20061127164655.GA6616@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org> <20061127084228.GI19745@spearce.org> <20061127102831.GA5428@fry.bender.fht>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 16:47:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061127102831.GA5428@fry.bender.fht>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32427>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GojdN-0003an-RQ for gcvg-git@gmane.org; Mon, 27 Nov
 2006 17:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758379AbWK0QrG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 11:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbWK0QrG
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 11:47:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57827 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758379AbWK0QrD
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 11:47:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gojd7-00037L-Cr; Mon, 27 Nov 2006 11:46:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B387120FB7F; Mon, 27 Nov 2006 11:46:55 -0500 (EST)
To: Nicolas Vilz <niv@iaglans.de>
Sender: git-owner@vger.kernel.org

Nicolas Vilz <niv@iaglans.de> wrote:
> On Mon, Nov 27, 2006 at 03:42:28AM -0500, Shawn O. Pearce wrote:
> > This is just a cute hack, but we can (easily) complete the parameter
> > to --author or --committer in bash by asking for all possible authors
> > or committers in this project from git log and offering them up as
> > valid choices.
> > 
> > We replace spaces with dots as this prevents names with spaces from
> > appearing as two parameters rather than one, yet it still matches the
> > space in the field.
>
> is it hard to train bash-completion to use "" and spaces instead of 
> replacing spaces by dots? Besides, great feature, thank you for that... 
> that's very handy.

I tried.  Bash did not listen.  :-)

I tried "", '', \<sp>.  None of them carried into the completion.
Obviously I was doing something wrong, but right now I don't know
what that was.  I spent 22 minutes on it and just caved in with
dots when it worked and nothing else did.

-- 
