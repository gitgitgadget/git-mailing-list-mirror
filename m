From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Generic configuration plumbing (Was: Re: [RFC 2/2] Automatically transform...)
Date: Mon, 28 Nov 2005 15:32:35 +0100
Message-ID: <200511281532.36054.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <200511281359.04741.Josef.Weidendorfer@gmx.de> <438B021F.5030204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 28 15:35:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egk3w-0001wa-HU
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 15:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVK1Ock (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 09:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVK1Ock
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 09:32:40 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:50313 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751253AbVK1Ocj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 09:32:39 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 8465326F6;
	Mon, 28 Nov 2005 15:32:38 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <438B021F.5030204@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12882>

On Monday 28 November 2005 14:11, Andreas Ericsson wrote:
> Josef Weidendorfer wrote:
> > 
> > To allow for this, git_config() should not be hardcoded to only
> > read .git/config, but perhaps a list of files in environment variable
> > GIT_CONFIG_FILES.
> > 
> 
> $HOME/.gitrc:$GIT_DIR/conf/*

Yes, perhaps with this as default...

> All files could support the freestanding "include" syntax.

Better run cpp on the config files before loading ;-)
Or provide a hook which returns the config on stdout.
The default for .git/hooks/config would be

	cat $GIT_DIR/config

Hmm... this was only meant to be a joke; but now I actually think
this is a nice idea as basic configuration mechanism of git plumbing.

Josef
