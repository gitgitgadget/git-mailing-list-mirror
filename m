From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 11:49:22 -0500
Message-ID: <20070228164922.GB5924@spearce.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org> <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com> <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org> <17893.43522.511785.121778@lisa.zopyra.com> <17893.44181.129918.669187@lisa.zopyra.com> <20070228163256.GD5479@spearce.org> <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:49:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRzc-0006ym-Fg
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbXB1Qt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbXB1Qt0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:49:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54824 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbXB1Qt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:49:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMRzS-00050J-CW; Wed, 28 Feb 2007 11:49:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C361E20FBAE; Wed, 28 Feb 2007 11:49:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40964>

Morten Welinder <mwelinder@gmail.com> wrote:
> >+                       die("cannot pread pack file: %s from=%lu, packfile 
> >size=%lu", strerror(errno), from, lseek(pack_fd, SEEK_END, 0));
> 
> That might give you the errno from the lseek call.

Yes, and I don't care here.  We're dead either way, that pread is
returning bunk and we don't know why.

But it is also giving me SEEK_END, not the end of the file.  I got
the arguments backwards to lseek.  Whoops.  ;-)

-- 
Shawn.
