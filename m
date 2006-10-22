From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 09:40:41 -0400
Message-ID: <20061022094041.77c06cc7.seanlkml__4078.99909555471$1161524523$gmane$org@sympatico.ca>
References: <1161472030.9241.174.camel@localhost.localdomain>
	<20061021192539.4a00cc3e.seanlkml@sympatico.ca>
	<1161478005.9241.210.camel@localhost.localdomain>
	<20061021212645.2f9ba751.seanlkml@sympatico.ca>
	<1161487417.9241.220.camel@localhost.localdomain>
	<20061021233014.d4525a1d.seanlkml@sympatico.ca>
	<20061022100028.GQ75501@over-yonder.net>
	<20061022074422.50dcbee6.seanlkml@sympatico.ca>
	<20061022130322.GS75501@over-yonder.net>
	<20061022092845.233deb43.seanlkml@sympatico.ca>
	<20061022133336.GT75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 15:42:02 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbdaP-0006vI-5I
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 15:41:57 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbdZu-0007cN-AM; Sun, 22 Oct 2006 14:41:26 +0100
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]
	helo=BAYC1-PASMTP11.CEZ.ICE)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GbdZE-0007Yl-Pe
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 14:40:47 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
	over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); 
	Sun, 22 Oct 2006 06:49:34 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1Gbcd7-0000zU-S5; Sun, 22 Oct 2006 08:40:41 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061022094041.77c06cc7.seanlkml@sympatico.ca>
In-Reply-To: <20061022133336.GT75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Oct 2006 13:49:34.0812 (UTC)
	FILETIME=[E87551C0:01C6F5E0]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29746>

On Sun, 22 Oct 2006 08:33:36 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> Because they're 'local' to a given "branch"; see my message to cworth
> a little while ago for expansion of the rather particular meaning of
> the word used here.  If somebody takes a clone of my _branch_, it's
> the same "branch", so the numbers will be the same (and that's
> desired).

The fact is that once you start distributing them to other repositories
you CAN NOT GUARANTEE their stability.  Those number may already be
used by _HIS_ branch and when he tries to get _YOUR_ branch.. there
is a conflict.  AND THERE IS NOTHING YOU CAN DO TO FIX THAT.  It's
a fundamental flaw with distributing revnos.  The reason you likely
haven't seen a problem so far is that the bzr world seems to favor
the use of a central server that has the effect of more or less
synchronizing branch numbers to most of the nodes in the system.
However, that's only one model.  So while you may not have seen a
problem yourself, there are _inherent_ limitations of the system
you've embraced.

But it seems like nobody on the bzr team cares or wants to hear about
it, so let's just move on.

Cheers,
Sean
