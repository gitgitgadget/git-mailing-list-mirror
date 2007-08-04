From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 03:33:21 -0400
Message-ID: <20070804073321.GU20052@spearce.org>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi> <20070804065516.GS20052@spearce.org> <20070804071131.GA6557@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 09:33:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHE8f-0001d5-Ue
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 09:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbXHDHd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 03:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbXHDHd1
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 03:33:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45320 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373AbXHDHd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 03:33:26 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHE8X-0001m4-6I; Sat, 04 Aug 2007 03:33:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC0CB20FBAE; Sat,  4 Aug 2007 03:33:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070804071131.GA6557@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54809>

Jeff King <peff@peff.net> wrote:
> On Sat, Aug 04, 2007 at 02:55:16AM -0400, Shawn O. Pearce wrote:
> 
> > V??in?? J??rvel?? <v@pp.inet.fi> wrote:
> 
> Your mailer claims this message is in us-ascii, but I think it isn't...

My mutt-foo isn't very good.  I tried to tell it utf-8, but I think
its ignoring me:

  set allow_8bit=yes
  set charset=utf8

:-/
 
> I tried reproducing the encoding breakage and it ended up fine. I just
> edited the patch in the .dotest directory (looks like the leading spaces
> were all stripped) and it applied fine when I re-ran "git-am".
> 
> Are you sure it didn't get munged by your editor when you hand-edited
> the mbox file?

I just tried to reproduce it myself and I can't do whatever I did
before again now; it Just Works(tm).  *sigh*  No idea how I messed
the patch application up earlier, but I did.

It wasn't my patch editing.  My vi clone only works on bytes, so
it doesn't care about character encodings and won't mangle them
unless I edit a utf-8 multibyte sequence by hand.  Which I'm sure
I didn't do.  And the first time I messed up the apply I was fixing
up only .dotest/patch, which was most certainly just us-ascii.

I'm actually pretty good about making sure I don't munge people's
non-ASCII names, but my mutt seems to think us-ascii is the only
character encoding in the world.

-- 
Shawn.
