From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk layout bug
Date: Mon, 21 Jan 2008 20:08:54 +0100
Message-ID: <20080121190854.GA5263@steel.home>
References: <alpine.LFD.1.00.0801191740020.2957@woody.linux-foundation.org> <18324.27370.96611.769276@cargo.ozlabs.ibm.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:10:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH221-0002Sv-RQ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbYAUTI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbYAUTI6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:08:58 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:29416 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYAUTI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:08:57 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll+fw==
Received: from tigra.home (Fad5f.f.strato-dslnet.de [195.4.173.95])
	by post.webmailer.de (fruni mo15) (RZmta 15.4)
	with ESMTP id U03fa6k0LF0KRY ; Mon, 21 Jan 2008 20:08:54 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CA0DA277AE;
	Mon, 21 Jan 2008 20:08:54 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B0A5956D22; Mon, 21 Jan 2008 20:08:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18324.27370.96611.769276@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71310>

Paul Mackerras, Mon, Jan 21, 2008 10:50:34 +0100:
> I'd be interested to know if you can trigger it with the "dev" branch
> of gitk, too.  The dev branch doesn't use --topo-order or
> --date-order, but instead does the topological sort itself, so the
> cold-cache case is a lot faster (and the hot-cache case goes just as
> fast as before).  And because I can now reorder the commits, I can put
> each open-circle commit just after the last merge that has it as a
> parent, which ends up looking much nicer too.

It is better, but sometimes the layout seem to be a bit too
"aggressively cleaned up": there are just merges and arrows pointing
in all directions but very few of real information.
