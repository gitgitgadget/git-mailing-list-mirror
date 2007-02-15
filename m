From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: OT: data destruction classics (was: Re: Error converting from 1.4.4.1 to 1.5.0?)
Date: Wed, 14 Feb 2007 21:13:45 -0500
Message-ID: <20070215021345.GB29732@spearce.org>
References: <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com> <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com> <17875.30687.661794.512124@lisa.zopyra.com> <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org> <17875.33204.413186.355557@lisa.zopyra.com> <Pine.LNX.4.64.0702141722410.1757@xanadu.home> <17875.36879.872210.264473@lisa.zopyra.com> <45D3B4E7.8050408@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 03:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHW8C-00081x-F8
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 03:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbXBOCNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 21:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbXBOCNu
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 21:13:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56902 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838AbXBOCNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 21:13:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHW7s-0002gJ-1F; Wed, 14 Feb 2007 21:13:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B8B5A20FBAE; Wed, 14 Feb 2007 21:13:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45D3B4E7.8050408@fs.ei.tum.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39789>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Bill Lear wrote:
> >I'm still muttering to myself that I could be that dumb...
> 
> Still better than trying to backup with
> 
> tar czvf data* destfile.tar.gz
> 
> automatic tape backup is a real helper then :)

or manual backup to "tape", where the tape device supplied was
the only disk...  SunOS 4 did not take too kindly to its kernel,
swap space, root fs being overwritten...

Oddly enough, that system never booted again.  Ever.  We couldn't
even get it to see external (CD-ROM) based media.  SCSI controller
also failed during the "tape" backup.

-- 
Shawn.
