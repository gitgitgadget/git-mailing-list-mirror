From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] describe: Add unlisted option
Date: Mon, 23 Jul 2007 03:03:08 -0400
Message-ID: <20070723070308.GH32566@spearce.org>
References: <87sl7fmyca.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICrwt-0007fh-FP
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbXGWHDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbXGWHDO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:03:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44560 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148AbXGWHDN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:03:13 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICrwj-0004bq-Hi; Mon, 23 Jul 2007 03:03:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8502920FBAE; Mon, 23 Jul 2007 03:03:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87sl7fmyca.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53400>

Yasushi SHOJI <yashi@atmark-techno.com> wrote:
> added unlisted options, --contains, --candidates and --debug, to usage
> line.  also, prints some info when --contains and --debug are given.

That makes sense.  Especially telling the user why --debug --contains
doesn't actually print anything.  ;-)

Originally I left out --candidates and --debug when I wrote the code
for them as I thought they were a tad too internal for casual use.
But maybe it makes sense to include them in the usage string.


Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
