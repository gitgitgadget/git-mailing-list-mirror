From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui hangs on read
Date: Wed, 23 Apr 2008 21:00:15 -0400
Message-ID: <20080424010015.GS29771@spearce.org>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com> <20080422001311.GS29771@spearce.org> <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com> <20080422232530.GK29771@spearce.org> <480EF84A.4020308@isy.liu.se> <b3889dff0804230716n1b5dde1ctb7b0c1dd83f2d1ff@mail.gmail.com> <480F4C6E.9070400@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Collins <ben.collins@acm.org>, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu Apr 24 03:01:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joppl-0001I1-Na
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 03:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbYDXBAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 21:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbYDXBAV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 21:00:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58499 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYDXBAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 21:00:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jopok-0002qF-L6; Wed, 23 Apr 2008 21:00:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D4A4E20FBAE; Wed, 23 Apr 2008 21:00:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <480F4C6E.9070400@isy.liu.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80278>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> On 04/23/2008 04:16 PM, Benjamin Collins wrote:
> >What I have done for now is to comment out the line in gui-gui that
> >does the lappend on spell_cmd, near the end.

Here's another work around that doesn't require editing the code.
Just turn the d**n spell checker off:

	git config --global gui.spellingdictionary none

That will keep us from evening trying to launch aspell, and since
its global (in your ~/.gitconfig) it should default into every
repository you have, or create.

Apparently aspell 0.50 does not like git-gui.  I'll have to look at
the version header and abort trying to use aspell if it is pre 0.60.

git-gui 0.10.2 here we come.

-- 
Shawn.
