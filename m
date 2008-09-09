From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Alternates and push
Date: Tue, 9 Sep 2008 07:57:14 -0700
Message-ID: <20080909145714.GD10015@spearce.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <9e4733910809061124r3759ea79sda98b549df3e6e58@mail.gmail.com> <20080906192106.GB18631@spearce.org> <20080909083551.GA10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 09 17:00:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4fh-0003rM-Ay
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 16:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbYIIO5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 10:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbYIIO5P
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 10:57:15 -0400
Received: from george.spearce.org ([209.20.77.23]:34639 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbYIIO5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 10:57:14 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1FD393835C; Tue,  9 Sep 2008 14:57:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080909083551.GA10544@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95394>

Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Sep 06, 2008 at 12:21:06PM -0700, Shawn O. Pearce wrote:
> > github should do what repo.or.cz does:
> > 
> > 	ln -s .../linus.git/refs digispeaker.git/refs/forkee
> 
> But it should be used only in controlled environment. If you happen to
> have permissions to write to the forkee, you can wipe out its refs with
> git fetch --mirror (and if you don't happen to have permissions, it will
> just fail, so currently you cannot use this on repo.or.cz forks,
> unfortunately). If you don't make sure refs are never packed (I do on
> repo.or.cz, historically because of dumb transports - do they support
> packed refs by now?), this won't work either. Maybe there are other
> considerations too.

All very good points.

The dumb transports do support packed-refs in more modern versions.
I forget when they learned it though.  Being nice to them by not
packing refs is still good if you can.

-- 
Shawn.
