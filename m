From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add --patchdepth parameter to git-am.sh
Date: Mon, 5 Feb 2007 14:37:00 -0500
Message-ID: <20070205193700.GB8409@spearce.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <200702051924.39205.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 20:37:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE9eJ-0001Nq-0D
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 20:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbXBEThH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 14:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933423AbXBEThG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 14:37:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33140 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933347AbXBEThF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 14:37:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HE9e2-0002so-Ll; Mon, 05 Feb 2007 14:36:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC9DA20FBAE; Mon,  5 Feb 2007 14:37:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702051924.39205.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38772>

Andy Parkins <andyparkins@gmail.com> wrote:
> If the series of patches you are applying via git-am was based in a
> different directory there was no way to strip the directory (as you
> would with git-apply).
> 
> This patch adds a --patchdepth option to git-am.sh whose argument is
> passed as a "-p" option to git-apply.

Is there something wrong with -p<n>?  Looking at git-am, -p is not
currently accepted as an option.  Its universally considered the
depth parameter to standard `patch`, which is why git-apply also
accepts it over --patchdepth.

I'd rather see git-am use the same arguments (when possible)
as git-apply.

-- 
Shawn.
