From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/3] FindToolbar port to the new history page.
Date: Mon, 7 Apr 2008 01:19:08 -0400
Message-ID: <20080407051908.GS10274@spearce.org>
References: <1207518109-4174-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Mon Apr 07 07:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jijlw-0002s2-T6
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 07:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbYDGFTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 01:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYDGFTQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 01:19:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55324 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbYDGFTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 01:19:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jijl8-00054g-19; Mon, 07 Apr 2008 01:19:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DDCF320FBAE; Mon,  7 Apr 2008 01:19:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1207518109-4174-1-git-send-email-rogersoares@intelinet.com.br>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78947>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> This is a port from the find toolbar to the new history page.
> It is replacing the current highlight flag in order to have the
> find feature back but most of the code from the toolbar shall be
> replaced to make use of the new infrastructure added into jgit
> (RevFlag and RevFilter).
...
> I'm reseding the toolbar port with the fixes for the items you mentioned.
> It's on top of 009f11e2c8971b6053, don't know if it would have been better
> to rebase it, just let me know.

Well, I just rebased my entire tree, and then plopped your four
patches (these three plus 009f) on top of it.  So no need to rebase.
There was a very minor merge conflict, easily fixed, no worries.

> Patch 3/3 is something I've come up to remove the Map hit in the paint
> method. As you said you were going to revisit the jgit API soon I didn't
> want to do something too elaborated that will be dumped soon. I'm
> manipulating RevFlags directly from the find toolbar, so if you don't
> like just ignore it.

Its better.  I'd like to be able to use more of RevFilter in the
search, but as you pointed out support isn't all there yet.

I'm taking in this series as is.  We can improve on it further later.

Thanks.

-- 
Shawn.
