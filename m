From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 13:47:44 -0700
Message-ID: <20080909204744.GL10015@spearce.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <20080909195930.GA2785@coredump.intra.peff.net> <7vljy159v7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdA8u-0003Zv-Eb
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbYIIUrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbYIIUrq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:47:46 -0400
Received: from george.spearce.org ([209.20.77.23]:47777 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbYIIUrp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:47:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 078BD3835C; Tue,  9 Sep 2008 20:47:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vljy159v7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95427>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> To my ears, it rhymes rather well with a famous quote from $gmane/217:
> 
>     You're freezing your (crappy) algorithm at tree creation time, and
>     basically making it pointless to ever create something better later,
>     because even if hardware and software improves, you've codified that
>     "we have to have crappy information".
> 
> After reading the discussion so far, I am still not convinced if this is a
> good idea, nor this time around it is that much different from what the
> previous "prior" link discussion tried to do.

Yup.  Same here.

I didn't see any information about why this "origin" link is
needed here, just how it might work.

And some of that "how" scared me because it was doing some sort of
"soft" reachability, where errors aren't noticed but we are expected
to protect the data from prune/repack forever once it has entered
the repository.

-- 
Shawn.
