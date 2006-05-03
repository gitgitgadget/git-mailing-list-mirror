From: Shawn Pearce <spearce@spearce.org>
Subject: Re: problem with plain git clone
Date: Wed, 3 May 2006 10:31:30 -0400
Message-ID: <20060503143130.GA9172@spearce.org>
References: <7CAB7A96-2C63-4B05-B0C6-72FC5B74D960@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 16:31:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbIOD-00033Z-97
	for gcvg-git@gmane.org; Wed, 03 May 2006 16:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWECObj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 10:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWECObi
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 10:31:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:61918 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965201AbWECObi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 10:31:38 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FbINz-0005ep-GN; Wed, 03 May 2006 10:31:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18B1D2303C8; Wed,  3 May 2006 10:31:30 -0400 (EDT)
To: Kumar Gala <galak@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <7CAB7A96-2C63-4B05-B0C6-72FC5B74D960@kernel.crashing.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19486>

Kumar Gala <galak@kernel.crashing.org> wrote:
> Anyone see an issues like the following:
> 
> [kgala@kgala_lnx z]$ git clone git://git.kernel.org:/pub/scm/boot/u- 
> boot/galak/u-boot.git
> git clone git://git.kernel.org:/pub/scm/boot/u-boot/galak/u-boot.git
> fatal: unable to connect a socket (Connection timed out)

There's no GIT daemon running on the empty port.  Notice the ':'
appearing right after '.org'.

Hmm, that sounds like a bug in the protocol URL parser...

-- 
Shawn.
