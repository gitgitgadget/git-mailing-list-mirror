From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Paper bag fix git-describe on packed tags
Date: Mon, 3 Mar 2008 18:26:17 -0500
Message-ID: <20080303232617.GI8410@spearce.org>
References: <20080303232136.GA15312@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWK3e-0007lZ-PX
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 00:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbYCCX0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 18:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbYCCX0U
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 18:26:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44099 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbYCCX0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 18:26:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWK2q-0006qD-N3; Mon, 03 Mar 2008 18:26:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A47020FBAE; Mon,  3 Mar 2008 18:26:17 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080303232136.GA15312@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75997>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> In 212945d ("Teach git-describe to verify annotated tag names")
> we tried to access a possibly unparsed tag structure.  We must
> make sure it was parsed before we try to read its tag name.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  As 212945d is already in master this probably should be
>  fast-tracked there.  Whoops.  :-)

Hmmph, looks like you already fixed this with
c374b91cf295f437d438a103bfd2cf3fffcce580 ("git-describe: use tags
found in packed-refs correctly").

-- 
Shawn.
