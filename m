From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 02:55:16 -0400
Message-ID: <20070804065516.GS20052@spearce.org>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?iso-8859-1?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Sat Aug 04 08:55:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHDXo-0002ay-1x
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 08:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbXHDGzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 02:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXHDGzV
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 02:55:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44448 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbXHDGzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 02:55:20 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHDXf-0000rj-Vw; Sat, 04 Aug 2007 02:55:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4694320FBAE; Sat,  4 Aug 2007 02:55:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54802>

V??in?? J??rvel?? <v@pp.inet.fi> wrote:
> OS X sends Button-2 on a "real" right click, such as with a three
> button mouse, or by using the two-finger trackpad click.

Thanks, this will be in 0.8.1.  I'm pushing it out shortly.

I had a devil of a time applying your patch though.  git-am
choked because the patch was whitespace damaged, and then after
hand-correction and resuming it horribly munged your name's encoding
in the commit.  I think there's a bug in there in git-am; I'll
have to try to track it down.  I managed to get the patch applied
correctly by editing the mbox file directly, so that git-am did
not need to stop and ask me to resolve the patch.

It seems that Apple's Mail.app just doesn't like to send patches
without destroying them.  If you do wind up sending another patch
in the future it may just be easier if you attach the mbox that
format-patch creates, instead of trying to inline it in the
message body.

-- 
Shawn.
