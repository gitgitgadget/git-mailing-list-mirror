From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Wed, 7 Nov 2007 09:16:08 +0100
Organization: glandium.org
Message-ID: <20071107081608.GA19066@glandium.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <200711062106.57083.robin.rosenberg.lists@dewire.com> <20071106201324.GA30262@glandium.org> <200711062221.58475.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0711062225090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:19:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipg8J-0000z7-KD
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003AbXKGITB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757989AbXKGITB
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:19:01 -0500
Received: from vawad.err.no ([85.19.200.177]:34989 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757985AbXKGITA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:19:00 -0500
Received: from aputeaux-153-1-78-131.w81-249.abo.wanadoo.fr ([81.249.108.131] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Ipg7T-0006bY-Gt; Wed, 07 Nov 2007 09:18:43 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1Ipg52-0004z7-Df; Wed, 07 Nov 2007 09:16:08 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711062225090.4362@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63786>

On Tue, Nov 06, 2007 at 10:25:48PM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Tue, 6 Nov 2007, Robin Rosenberg wrote:
> 
> > tisdag 06 november 2007 skrev Mike Hommey:
> > > Maybe the documentation could emphasise on how to undo things when the
> > > user makes mistakes.
> > > Sometimes, saving your repo can be as simple as git reset --hard HEAD@{1}.
> > > This is not, unfortunately, a works-for-all-cases command.
> > 
> > Yea, git-undo(7). 
> 
> In related news, I know a few users who need an un-rm-rf.  Anyone?

The fact is you can do harm to your repo with things you wouldn't expect to
break things, except maybe you gave bad arguments or so. It's quite easy to
fuck up with git-rebase, or to merge the wrong commits, etc.

Mike
