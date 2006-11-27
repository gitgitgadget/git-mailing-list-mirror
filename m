X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/10] Teach git-completion.bash how to complete git-merge.
Date: Mon, 27 Nov 2006 15:12:36 -0500
Message-ID: <20061127201236.GA7331@spearce.org>
References: <20061127084047.GA19745@spearce.org> <7vlklwhffb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 20:13:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vlklwhffb.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32447>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GomqI-00017N-SX for gcvg-git@gmane.org; Mon, 27 Nov
 2006 21:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758556AbWK0UMk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 15:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758558AbWK0UMk
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 15:12:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:2976 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1758556AbWK0UMj
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 15:12:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gomq5-0006US-SF; Mon, 27 Nov 2006 15:12:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9E68F20FB7F; Mon, 27 Nov 2006 15:12:36 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +__git_merge_strategies ()
> > +{
> > +	sed -n "/^all_strategies='/{
> > +		s/^all_strategies='//
> > +		s/'//
> > +		p
> > +		q
> > +		}" "$(git --exec-path)/git-merge"
> > +}
> > +
> 
> Shouldn't we load and compute this once and keep the result in a
> variable (say $__git_merge_strategies)?

Sure.  See my latest 4 patch series.  :-)
 
-- 
