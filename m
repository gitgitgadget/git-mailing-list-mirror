From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/8] repack -A -d: use --keep-unreachable when repacking
Date: Mon, 17 Sep 2007 23:01:56 -0400
Message-ID: <20070918030156.GJ3099@spearce.org>
References: <11900186941912-git-send-email-gitster@pobox.com> <11900187002882-git-send-email-gitster@pobox.com> <Pine.LNX.4.64.0709171027400.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 05:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXTLm-0004F9-Tb
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 05:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbXIRDCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 23:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbXIRDCE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 23:02:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42597 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbXIRDCC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 23:02:02 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXTLO-0007Br-EE; Mon, 17 Sep 2007 23:01:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 527D820FBAE; Mon, 17 Sep 2007 23:01:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709171027400.28586@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58524>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 17 Sep 2007, Junio C Hamano wrote:
> 
> > -USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
> > +USAGE='[-a|-A] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
> 
> Would "[-a] [-A]" not be better?  In other usage lines, we have the "|" 
> for alternative forms of the _same_ option, like "[-m|--merge]".
> 
> > +	-A)	all_into_one=t
> > +		keep_unreachable=t ;;
> 
> Why not "keep_unreachable=--keep-unreachable" and use "$args 
> $keep_unreachable" later?

I agree.  Aside from the above and my other reply about editing
pack_name in place to test the .keep file I'm happy with this series.
I know the automatic GC thing has been a hot topic in the past with
various parties on different sides of the fence.  I think this is
a pretty reasonable implementation that actually is a fairly good
comprimise between the two sides.

Thanks Junio.

-- 
Shawn.
