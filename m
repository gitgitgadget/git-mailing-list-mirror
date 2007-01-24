From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 01:07:04 -0500
Message-ID: <20070124060703.GA25759@spearce.org>
References: <17846.53626.895660.762096@lisa.zopyra.com> <Pine.LNX.4.64.0701240019250.20138@iabervon.org> <17846.63082.935311.947093@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 07:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9bHv-0004r1-By
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 07:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbXAXGHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 01:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXAXGHK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 01:07:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38476 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030234AbXAXGHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 01:07:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H9bHm-0000w4-G2; Wed, 24 Jan 2007 01:07:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7362120FBAE; Wed, 24 Jan 2007 01:07:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17846.63082.935311.947093@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37606>

Bill Lear <rael@zopyra.com> wrote:
> I probably should have thought ahead and made this fix on a branch,
> merged it into my master branch and then into my topic branch ... I
> think.

Yes.  That is standard "good practice" with Git.  Unfortunately it
does require a little planning ahead if the base to start on isn't
immediately obvious (you need to think "I want this here, and here,
and here.. and compute the merge base").

-- 
Shawn.
