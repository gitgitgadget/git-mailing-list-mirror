From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-pack-objects: Automatically pack annotated tags if object was packed
Date: Mon, 3 Mar 2008 22:06:58 -0500
Message-ID: <20080304030658.GO8410@spearce.org>
References: <20080304023607.GA16152@spearce.org> <alpine.LFD.1.00.0803032144110.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNVG-0005Dm-55
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbYCDDHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYCDDHE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:07:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57361 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbYCDDHD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:07:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWNUN-0003UL-Nr; Mon, 03 Mar 2008 22:06:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2D24E20FBAE; Mon,  3 Mar 2008 22:06:58 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803032144110.2947@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76023>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 3 Mar 2008, Shawn O. Pearce wrote:
> 
> > The new option "--auto-follow-tags" allows the caller to request that
> > any annotated tag be included into the packfile if the object the tag
> > references was also included as part of the packfile.
> 
> Wouldn't "auto-include-tag" a better name for this option?

Ooooh.  Indeed it would!

I shall respin this series based around this better name.

-- 
Shawn.
