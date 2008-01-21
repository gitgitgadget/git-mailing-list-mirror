From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui and commit-msg hook
Date: Sun, 20 Jan 2008 23:08:19 -0500
Message-ID: <20080121040819.GE24004@spearce.org>
References: <054F21930D24A0428E5B4588462C7AEDC5F8DB@ednex512.dsto.defence.gov.au> <054F21930D24A0428E5B4588462C7AEDC5F8DC@ednex512.dsto.defence.gov.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au>
X-From: git-owner@vger.kernel.org Mon Jan 21 05:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGnxx-0004Bc-Qp
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 05:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795AbYAUEIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 23:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756573AbYAUEIX
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 23:08:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55137 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbYAUEIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 23:08:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JGnxB-0005Gl-2s; Sun, 20 Jan 2008 23:08:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3796E20FBAE; Sun, 20 Jan 2008 23:08:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <054F21930D24A0428E5B4588462C7AEDC5F8DC@ednex512.dsto.defence.gov.au>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71212>

"Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au> wrote:
> I've just setup a commit-msg hook in my local repository.  It works as
> advertised from the command-line when using git commit, but if I use git
> gui to do the commit, then the hook is ignored.

Fixed in my latest git-gui master, which will be gitgui-0.9.2 or .3.

I apparently missed git 1.5.4-rc4, but will have to ask Junio nicely
if this can be included into 1.5.4 final.

-- 
Shawn.
