From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 02:47:14 -0500
Message-ID: <20071121074714.GW14735@spearce.org>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <4743E1D6.4010308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IukJ6-0001gO-OJ
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbXKUHrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755307AbXKUHrT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:47:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56780 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbXKUHrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:47:18 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IukIl-0007aa-Cb; Wed, 21 Nov 2007 02:47:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A015D20FBAE; Wed, 21 Nov 2007 02:47:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4743E1D6.4010308@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65615>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Johannes Schindelin schrieb:
> >	Oh, and it relies on "int" being castable to void * and vice 
> >	versa.  Is anybody aware of a platform where this can lead to
> >	problems?
> 
> Win64?

Does anyone even use that?  I thought that was dead.  Like Vista.

Seriously though, we include stdint.h.  If you want to cast a void*
to an integer type and back use ptrint_t.  That's what it exists for.

-- 
Shawn.
