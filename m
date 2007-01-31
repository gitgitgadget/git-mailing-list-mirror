From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Qt git repository report
Date: Wed, 31 Jan 2007 10:48:05 -0500
Message-ID: <20070131154805.GC21888@spearce.org>
References: <200701310912.59102.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 16:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCHh0-0008Fj-0L
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 16:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbXAaPsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 10:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbXAaPsK
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 10:48:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52515 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932927AbXAaPsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 10:48:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCHgn-0003gY-U5; Wed, 31 Jan 2007 10:48:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D0A4F20FBAE; Wed, 31 Jan 2007 10:48:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200701310912.59102.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38263>

Andy Parkins <andyparkins@gmail.com> wrote:
> Key facts:
>  * 13 years worth of changes
>  * 94000 revisions
>  * 736774 objects
>  * Took 3 hours to convert using git-fast-import and a custom script
>  * Repository size: 500MB
>  * Checkd out tree size: 330MB
> 
> I never cease to be amazed by how good git is at its job.

Heh.  :-)

I probably shouldn't mention this until after 1.5.0 is out the door,
but I'm working on a prototype pack version 4 format that thus far
would save at least 5.6 MiB on that pack, and make revision traversal
significantly faster.  (Yes, eat your cake and have it too!)

I'm not done though. I'm sure I can do better.  I've only mucked
with part of what I'm thinking of doing.

Yes, the code stays backward compatible.  Just like OBJ_OFS_DELTA,
pack version 4 is a one-way upgrade, but can be undone by simply
repacking that repository without the option enabled.

-- 
Shawn.
