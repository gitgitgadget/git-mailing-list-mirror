From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Tue, 4 Sep 2007 01:50:48 -0400
Message-ID: <20070904055048.GW18160@spearce.org>
References: <20070831000149.GK1219@pasky.or.cz> <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, jnareb@gmail.com,
	ltuikov@yahoo.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:51:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRJW-0002dR-S6
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbXIDFuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbXIDFuy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:50:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34506 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbXIDFux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:50:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ISRJK-0003qq-1K; Tue, 04 Sep 2007 01:50:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CF3DD20FBAE; Tue,  4 Sep 2007 01:50:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57526>

Junio C Hamano <gitster@pobox.com> wrote:
> * Incremental blame
> 
>   It does not seem to break the blame, but at least from where I
>   sit accessing repo.or.cz this does not look incremental to me.
>   The entire browser session freezes until the blame page
>   displays in full.  My local installation behaves the same way.

What kind of repo are you trying that on?

I haven't myself tried the gitweb incremental blame but I do know
that one of my day-job repositories can take *ages* for git-gui's
`git blame --incremental -C -C -w` pass.  Most of the revisions
for some of the blobs are far back in history, and there's a lot of
files to look at for copy/movement.  Plus some of that history is
downright *messy* (I posted gitk screenshots of it not too long ago).

I'll try to give the gitweb incremental blame a try on that repo
tomorrow.

-- 
Shawn.
