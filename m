From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 08:57:02 -0500
Message-ID: <20061022135702.GU75501@over-yonder.net>
References: <1161478005.9241.210.camel@localhost.localdomain> <20061021212645.2f9ba751.seanlkml@sympatico.ca> <1161487417.9241.220.camel@localhost.localdomain> <20061021233014.d4525a1d.seanlkml@sympatico.ca> <20061022100028.GQ75501@over-yonder.net> <20061022074422.50dcbee6.seanlkml@sympatico.ca> <20061022130322.GS75501@over-yonder.net> <20061022092845.233deb43.seanlkml@sympatico.ca> <20061022133336.GT75501@over-yonder.net> <20061022094041.77c06cc7.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:57:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbdpA-0000qA-NI
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWJVN5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWJVN5F
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:57:05 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:10228 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1750921AbWJVN5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:57:04 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 582E22842A;
	Sun, 22 Oct 2006 08:57:03 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id C83D861C57; Sun, 22 Oct 2006 08:57:02 -0500 (CDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061022094041.77c06cc7.seanlkml@sympatico.ca>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29748>

On Sun, Oct 22, 2006 at 09:40:41AM -0400 I heard the voice of
Sean, and lo! it spake thus:
> 
> The fact is that once you start distributing them to other
> repositories you CAN NOT GUARANTEE their stability.

Terminology.  When those revisions get distributed to other BRANCHES,
their stability is forfeit.  We know.  We don't care.  We only care
about the numbers on ONE BRANCH.


> Those number may already be used by _HIS_ branch and when he tries
> to get _YOUR_ branch.. there is a conflict.

Terminology again.  When he has his branch and gets my branches, he
has two branches, mine and his, side by side, and the numbers in his
'my' branch still correspond to the numbers in my 'my' branch.  When
he merges the REVISIONS from my branch into his, my numbers have no
meaning on his side (there's not a 'conflict' because numbers don't
get copied, they get derived).


> So while you may not have seen a problem yourself,

You keep insisting that there's a PROBLEM here.  You're right, I don't
see one.  I KNOW the numbers only refer to a branch, I KNOW that when
you're talking about a different branch the numbers are meaningless,
and I'm perfectly fine with that because referring to revisions on *A*
branch is exactly what I USE the numbers for.

There doesn't have to be a 'central' branch, nor is there any wish for
such to be.  Any given revno only refers to *A* branch, it doesn't
have to be central to a darn thing.  HEAD in git only has meaning in
the context of *A* branch (and even 'worse', only refers to that
branch at a specific time[0]), but you'll keep on using it every day
anyway I wager.



[0] See again particular term of art "branch".


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
