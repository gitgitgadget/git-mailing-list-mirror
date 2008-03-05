From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-pack-objects: Automatically pack annotated tags if object was packed
Date: Wed, 5 Mar 2008 01:32:43 -0500
Message-ID: <20080305063243.GG8410@spearce.org>
References: <20080304023607.GA16152@spearce.org> <alpine.LFD.1.00.0803032144110.2947@xanadu.home> <20080304030658.GO8410@spearce.org> <47CCF9DA.4050304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 07:33:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWnC9-0004gj-Ld
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 07:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377AbYCEGdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 01:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbYCEGdB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 01:33:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46180 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbYCEGdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 01:33:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWnBE-0005a9-7i; Wed, 05 Mar 2008 01:32:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B399520FBAE; Wed,  5 Mar 2008 01:32:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47CCF9DA.4050304@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76178>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> > Nicolas Pitre <nico@cam.org> wrote:
> >> On Mon, 3 Mar 2008, Shawn O. Pearce wrote:
> >>
> >>> The new option "--auto-follow-tags" allows the caller to request that
> >>> any annotated tag be included into the packfile if the object the tag
> >>> references was also included as part of the packfile.
> >> Wouldn't "auto-include-tag" a better name for this option?
> > 
> > Ooooh.  Indeed it would!
> > 
> > I shall respin this series based around this better name.
> 
> More bikeshedding: Why are you calling it "auto-"? If I tell the program
> to "--include-tags", I expect it to happen automatically.

Because its more automatic than manually including tags?
I don't know.

Junio, if you haven't already merged this topic into someplace that
I can't rewrite the series for a _3rd_ time, I might be willing to
respin it without the "auto-" prefix.  We are unlikely to ever have
a reason to support "--manually-include-tags".  Stone tablet based
computing stopped being fun back in the '50s.

-- 
Shawn.
