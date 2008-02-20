From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: relax "dirty" version detection
Date: Tue, 19 Feb 2008 20:57:35 -0500
Message-ID: <20080220015735.GW24004@spearce.org>
References: <1203323793-18020-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JReDv-0003Yb-6C
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 02:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616AbYBTB5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 20:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756281AbYBTB5j
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 20:57:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47624 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756175AbYBTB5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 20:57:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JReD7-0008SK-QM; Tue, 19 Feb 2008 20:57:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7785320FBAE; Tue, 19 Feb 2008 20:57:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1203323793-18020-1-git-send-email-win@wincent.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74498>

Wincent Colaiuta <win@wincent.com> wrote:
> "git gui" would complain at launch if the local version of Git was
> "1.5.4.2.dirty". Loosen the regular expression to look for either
> "-dirty" or ".dirty", thus eliminating spurious warnings.
> 
> Signed-off-by: Wincent Colaiuta <win@wincent.com>

Thanks.  Its now queued in my maint branch.

-- 
Shawn.
