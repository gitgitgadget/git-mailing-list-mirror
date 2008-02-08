From: Mike Hommey <mh@glandium.org>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 23:27:22 +0100
Organization: glandium.org
Message-ID: <20080208222722.GA24474@glandium.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com> <alpine.LSU.1.00.0802081151170.11591@racer.site> <46a038f90802081423v13a19a65oe842b94ba7f85528@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbgv-0002Ls-Nm
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbYBHW0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbYBHW0x
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:26:53 -0500
Received: from vuizook.err.no ([85.19.215.103]:51902 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655AbYBHW0w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:26:52 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNbhB-0007mS-1v; Fri, 08 Feb 2008 23:27:51 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNbgo-0006O4-QK; Fri, 08 Feb 2008 23:27:22 +0100
Content-Disposition: inline
In-Reply-To: <46a038f90802081423v13a19a65oe842b94ba7f85528@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73164>

On Sat, Feb 09, 2008 at 11:23:30AM +1300, Martin Langhoff wrote:
> On Feb 9, 2008 12:52 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > That question comes up pretty often, I think.  But you need a working
> > directory to resolve conflicts for merges.  You only have one, though.
> 
> Once all the remote refs are fetched, it is trivial to determine that
> it is just a fast-forward, therefore _no_ merge and no chance for
> conflicts...

Even with merges, it could be helpful to have a tool that would
automagically stash, checkout the appropriate branch, merge (and deal
with conflicts if necessary), and so on.

Mike
