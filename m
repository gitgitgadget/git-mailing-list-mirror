From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: if a background colour is set, set foreground colour as well
Date: Wed, 5 Mar 2008 23:49:48 -0500
Message-ID: <20080306044948.GM8410@spearce.org>
References: <1204736062-11659-1-git-send-email-ph@sorgh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Philipp A. Hartmann" <ph@sorgh.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 05:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX841-0006Y5-4U
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757947AbYCFEtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbYCFEtw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:49:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34684 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757931AbYCFEtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 23:49:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JX82z-0005bm-Ai; Wed, 05 Mar 2008 23:49:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E4A7320FBAE; Wed,  5 Mar 2008 23:49:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1204736062-11659-1-git-send-email-ph@sorgh.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76326>

"Philipp A. Hartmann" <ph@sorgh.de> wrote:
> In several places, only the background colour is set to an explicit
> value, sometimes even "white".  This does not work well with dark
> colour themes.
> 
> This patch tries to set the foreground colour to "black" in those
> situations, where an explicit background colour is set without defining
> any foreground colour.

Thanks.  Applied to `master`.
 
>    This patch is against f15b75855fe15ac54adc4908f65e8a7572d47c9f
>    from git://repo.or.cz/git-gui.git - I could of course provide
>    one against git.git itself, if required.

Totally unnecessary.  Patches against git-gui.git are preferred
over patches made against git.git.

-- 
Shawn.
