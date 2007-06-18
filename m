From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] GIT 1.5.2.2
Date: Mon, 18 Jun 2007 02:29:02 -0400
Message-ID: <20070618062902.GL18491@spearce.org>
References: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com> <200706171230.37659.arekm@maven.pl> <20070618034322.GI18491@spearce.org> <200706180821.59582.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Arkadiusz Miskiewicz <arekm@maven.pl>
X-From: git-owner@vger.kernel.org Mon Jun 18 08:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Aji-00057V-6E
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 08:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbXFRG3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 02:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbXFRG3K
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 02:29:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55437 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbXFRG3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 02:29:09 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I0AjX-0006Xi-AG; Mon, 18 Jun 2007 02:29:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3355320FBAE; Mon, 18 Jun 2007 02:29:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200706180821.59582.arekm@maven.pl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50383>

Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> On Monday 18 of June 2007, Shawn O. Pearce wrote:
> > Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> > > * FAIL 16: corrupt a pack and see if verify catches
> > >         cat test-1-${packname_1}.idx >test-3.idx &&
> > >              cat test-2-${packname_2}.pack >test-3.pack &&
> >
> > Hmm.  That is t5300-pack-objects.sh.
> 
> If anyone is interested in debugging that problem then I can give ssh access 
> to this machine.

How about we start with the output of:

  cd t && ./t5300-pack-objects.sh -v

?  That should be a lot more verbose, as it will include the
commands we are running and their stdout/stderr.  Sometimes fun
details about broken tools can be easily obtained from that output.

-- 
Shawn.
