From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 13:45:43 -0700 (PDT)
Message-ID: <m3y6bjnadu.fsf@localhost.localdomain>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:46:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGfg-0003tc-QM
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab0IBUpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 16:45:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39248 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0IBUpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 16:45:46 -0400
Received: by fxm13 with SMTP id 13so621050fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=l9/2Rew7poSfMwklgevtyRAl5X2jhxd9EljYYC1UToI=;
        b=OwGn+pyLNl+cCprU41gm2buobLTVII6ffQ+SzKnbzJxhxQMjWUyNl7P7xE0+2ES8gd
         esvsNP2BQiHUPj3XuzR8j4eIFl+1s3yv2Km+to9/1lr4ySjQKbzMyNBWUp3x9dn7Ycqd
         N1gFX7cghlJ7Ua+tOhWEIOIxhmx/fpYSSepmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=kAc182NT4MvDBhIdpgOSYWFAmRYqZxRXy3N8qmOMMNs+cBdr7O3TOUKKoTe7UTvKrN
         1pqBJVsJ6q6poRB8pk1RnPMpdRj29zL52tE62sm/cBT6wheJDPLZrkCJ1KcAXI8V69lK
         OE7MuS/+qYNmiTSpZLYK5W/EkzfxcKsFssu/Q=
Received: by 10.223.121.147 with SMTP id h19mr9208925far.76.1283460345486;
        Thu, 02 Sep 2010 13:45:45 -0700 (PDT)
Received: from localhost.localdomain (abvy215.neoplus.adsl.tpnet.pl [83.8.222.215])
        by mx.google.com with ESMTPS id e17sm481198faa.15.2010.09.02.13.45.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 13:45:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o82KiqGI015441;
	Thu, 2 Sep 2010 22:44:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o82KiUeQ015431;
	Thu, 2 Sep 2010 22:44:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100902192910.GJ32601@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155202>

"Shawn O. Pearce" <spearce@spearce.org> writes:
> Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:

> >  * would you, or anyone else with enough knowledge of how this stuff
> > reaallly works, be willing to put some low-priority back-of-mind
> > thought into how to create a "canonical" pack format
> 
> We have.  We've even talked about it on the mailing list.  Multiple
> times.  Most times about how to support a p2p Git transport.
> That whole GitTorrent thing you are ignoring, we put some effort
> into coming up with a pack-like format that would be more stable,
> at the expense of being larger in total size.

If I remember it correctly the main idea of GitTorrent was instead of
dividing file into pieces of data like in BitTorrent (pieces being
downloaded in parallel from different peers) it divides set of objects
into "reels" (which are special case of bundles, IIRC).

> >  questions (not necessarily for nicolas) - can anyone think of any
> > good reasons _other_ than for multiple file-sharing to have a
> > "canonical" pack-object?
> 
> Yes, its called resuming a clone over git://.
> 
> Right now if you abort git:// you break the pack stream, and it
> cannot be restarted.  If we had a more consistent encoding we may
> be able to restart an aborted clone.
> 
> But we can't solve it.  Its a _very_ hard problem.
> 
> Nico, myself, and a whole lot of other very smart folks who really
> understand how Git works today have failed to identify a way to do
> this that we actually want to write, include in git, and maintain
> long-term.  Sure, anyone can come up with a specification that says
> "put this here, that there, break ties this way".  But we don't
> want to bind our hands and maintain those rules.

If I remember the discussion stalled (i.e. no working implementation),
and one of the latest proposals was to have some way of recovering
objects from partially downloaded file, and a way to request packfile
without objects that got already downloaded.

IIRC.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
