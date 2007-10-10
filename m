From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] git-gui: add mingw specific startup wrapper
Date: Wed, 10 Oct 2007 04:02:56 -0400
Message-ID: <20071010080256.GR2137@spearce.org>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de> <11919995392158-git-send-email-prohaska@zib.de> <11919995392881-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWXE-00053h-13
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 10:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbXJJIDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 04:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbXJJIDD
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 04:03:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38316 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbXJJIDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 04:03:01 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IfWWv-00010P-7Y; Wed, 10 Oct 2007 04:02:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 08F2520FBAE; Wed, 10 Oct 2007 04:02:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11919995392881-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60477>

Steffen Prohaska <prohaska@zib.de> wrote:
> The wrapper adds the directory it is installed in to PATH.
> This is required for the git commands implemented in shell.
> git-gui fails to launch them if PATH is not modified.

Thanks, I have both of these applied now to master and will push
it out shortly, along with the mingw version fix you had sent
me much earlier.
 
> +if { $argc >=2 && [lindex $argv 0] == "--working-dir" } {
> +	cd [lindex $argv 1]
> +	set argv [lrange $argv 2 end]
> +	incr argc -2
> +}

Perhaps someday in the future we'll put this into git-gui.sh so
all platforms can use it.  Today, its Windows only.  ;-)

-- 
Shawn.
