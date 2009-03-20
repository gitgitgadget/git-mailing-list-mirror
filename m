From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Document and test the new % shotcut for the tracked
	branch
Date: Fri, 20 Mar 2009 12:16:56 +0100
Message-ID: <20090320111656.GA8940@machine.or.cz>
References: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <1237543471-27248-1-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0903201128380.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 12:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkcki-0000dH-AP
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 12:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924AbZCTLRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 07:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbZCTLRA
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 07:17:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58398 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbZCTLQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 07:16:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5E470204C0C6; Fri, 20 Mar 2009 12:16:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903201128380.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113941>

  Hi!

On Fri, Mar 20, 2009 at 11:31:31AM +0100, Johannes Schindelin wrote:
> I had it ready yesterday!  But the real problem is not addressed by your 
> patch, either: '%<branch>' is a legal branch name.
> 
> I briefly considered <branch>^{tracked}, but
> 
> - the ^{} codepath does not try to substitute branch _names_, so we'd have 
>   to duplicate that ^{} detection, and,
> 
> - it is really cumbersome to write.

We already have @{N} to do one branch-based substitution, so what about
following this convention? Can't we have @{t}?

				Petr "Pasky" Baudis
