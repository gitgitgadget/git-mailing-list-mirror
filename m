From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 05:01:41 -0500
Message-ID: <20070115100141.GA12257@spearce.org>
References: <200701150144.56793.jnareb@gmail.com> <20070115070826.GB939@localdomain> <200701151003.44498.jnareb@gmail.com> <20070115095613.GA4037@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVv-0000V7-N3
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:55 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9V-0003eK-Ul
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbXAOKBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbXAOKBr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:01:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45531 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175AbXAOKBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:01:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6Oer-0002OW-Bg; Mon, 15 Jan 2007 05:01:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4067320FBAE; Mon, 15 Jan 2007 05:01:42 -0500 (EST)
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20070115095613.GA4037@localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36835>

Eric Wong <normalperson@yhbt.net> wrote:
> If the Perl output is redirected to a file (say .git/config.perl) and
> only regenerated when .git/config changes, `do(".git/config.perl")' will
> likely be faster since all the parsing will be done by Perl itself.

So long as its automatic in gitweb.cgi and based on the stat
attributes of .git/config, OK.  But my database background tells
me two copies of the same thing is fishy...

-- 
Shawn.
