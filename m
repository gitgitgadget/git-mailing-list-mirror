From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 03:11:31 -0400
Message-ID: <20070804071131.GA6557@coredump.intra.peff.net>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi> <20070804065516.GS20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 09:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHDnU-0005YK-IP
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 09:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbXHDHLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 03:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbXHDHLd
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 03:11:33 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2384 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbXHDHLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 03:11:33 -0400
Received: (qmail 26603 invoked from network); 4 Aug 2007 07:11:36 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 4 Aug 2007 07:11:36 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2007 03:11:31 -0400
Content-Disposition: inline
In-Reply-To: <20070804065516.GS20052@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54805>

On Sat, Aug 04, 2007 at 02:55:16AM -0400, Shawn O. Pearce wrote:

> V??in?? J??rvel?? <v@pp.inet.fi> wrote:

Your mailer claims this message is in us-ascii, but I think it isn't...

> I had a devil of a time applying your patch though.  git-am
> choked because the patch was whitespace damaged, and then after
> hand-correction and resuming it horribly munged your name's encoding
> in the commit.  I think there's a bug in there in git-am; I'll
> have to try to track it down.  I managed to get the patch applied
> correctly by editing the mbox file directly, so that git-am did
> not need to stop and ask me to resolve the patch.

I tried reproducing the encoding breakage and it ended up fine. I just
edited the patch in the .dotest directory (looks like the leading spaces
were all stripped) and it applied fine when I re-ran "git-am".

Are you sure it didn't get munged by your editor when you hand-edited
the mbox file?

-Peff
