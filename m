From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 01/25] Add a simple option parser.
Date: Wed, 17 Oct 2007 03:24:19 -0400
Message-ID: <20071017072419.GZ13801@spearce.org>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523721-18985-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3Gb-0007Aq-10
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858AbXJQHYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758019AbXJQHYY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:24:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60519 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957AbXJQHYX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:24:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii3GO-0006N8-7w; Wed, 17 Oct 2007 03:24:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CABED20FBAE; Wed, 17 Oct 2007 03:24:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192523721-18985-1-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61345>

Pierre Habouzit <madcoder@debian.org> wrote:
> The option parser takes argc, argv, an array of struct option
> and a usage string. ...

OK, I've chewed down some version of this series.  ;-)

To be more specific I fetched ph/parseopt (11b83dc4da) from your
tree at git://git.madism.org/git.git and split it apart somewhat.
All of the patches were rebased onto my most recent master but I
also yanked the two that impacted the builtin-fetch series out and
layered them over a merge of db/fetch-pack and my version of your
ph/parseopt series.

Why?  Well I want to keep our options open about which series
graduates to master first.  Although builtin-fetch has been cooking
for a while there's been a number of issues with that code.
There exists a (perhaps small) chance that ph/parseopt will be
ready before db/fetch-pack.

Currently ph/parseopt is in pu.  Tomorrow I'll look at the usage
strings in more depth and see if any improvements can be easily
made.  I already made one suggested by Dscho in builtin-add.

-- 
Shawn.
