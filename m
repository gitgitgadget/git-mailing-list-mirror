From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 09:28:45 -0400
Message-ID: <BAYC1-PASMTP015345662E5CDF8D3E7117AE030@CEZ.ICE>
References: <20061021130111.GL75501@over-yonder.net>
	<87ac3p1jn7.wl%cworth@cworth.org>
	<1161472030.9241.174.camel@localhost.localdomain>
	<20061021192539.4a00cc3e.seanlkml@sympatico.ca>
	<1161478005.9241.210.camel@localhost.localdomain>
	<20061021212645.2f9ba751.seanlkml@sympatico.ca>
	<1161487417.9241.220.camel@localhost.localdomain>
	<20061021233014.d4525a1d.seanlkml@sympatico.ca>
	<20061022100028.GQ75501@over-yonder.net>
	<20061022074422.50dcbee6.seanlkml@sympatico.ca>
	<20061022130322.GS75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:28:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbdNi-00055a-R3
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWJVN2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWJVN2s
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:28:48 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:3396 "EHLO
	bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750896AbWJVN2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:28:47 -0400
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 22 Oct 2006 06:28:46 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbcRZ-0000xj-Eq; Sun, 22 Oct 2006 08:28:45 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061022092845.233deb43.seanlkml@sympatico.ca>
In-Reply-To: <20061022130322.GS75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2006 13:28:46.0794 (UTC) FILETIME=[0094E2A0:01C6F5DE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Oct 2006 08:03:22 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> Perhaps the difference is that we're making a [fine] distinction
> between "useful in a truely distributed system" and "useful when
> WORKING in a truely distributed system".  cworth's point back up a few
> posts is good; nearly all of my use of revnos is in direct interaction
> with the tool, where the revnos just came from looking at the history.
> And of those uses that aren't in that class, nearly all of THOSE are
> very transient.  Non-local (in time or space) stability in either of
> those cases is a total non-concern.

Sure, but if they're just a local feature then why propagate them with
the distributed data?  If they're meant only to be used locally,
they can be guaranteed to be stable by never replicating
them, with obvious benefits for the local user.  However bzr makes the
(IMO) mistake of including them in the data that is distributed 
between repos.  This suggests bzr team just doesn't care about the
distributed models where this will not help and will quite possibly
lead to frustration and confusion.  And yes, I know that you
haven't seen those situations yourself yet.  Obviously, it's the
Bzr teams trade-off to make, but if an avid user like yourself thinks
of revno's as local, perhaps they've made the wrong choice.

Sean
