From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 09:28:45 -0400
Message-ID: <20061022092845.233deb43.seanlkml__11180.3832035095$1161523756$gmane$org@sympatico.ca>
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
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 15:29:15 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbdO4-00058l-C3
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 15:29:12 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbdNj-0006yz-DA; Sun, 22 Oct 2006 14:28:51 +0100
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GbdNg-0006yg-M2
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 14:28:49 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Sun, 22 Oct 2006 06:28:46 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbcRZ-0000xj-Eq; Sun, 22 Oct 2006 08:28:45 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061022092845.233deb43.seanlkml@sympatico.ca>
In-Reply-To: <20061022130322.GS75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2006 13:28:46.0794 (UTC)
	FILETIME=[0094E2A0:01C6F5DE]
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29743>

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
