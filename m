From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 19:25:39 -0400
Message-ID: <20061021192539.4a00cc3e.seanlkml__25816.3545084701$1161473173$gmane$org@sympatico.ca>
References: <45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	<453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
	<45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
	<20061021130111.GL75501@over-yonder.net>
	<87ac3p1jn7.wl%cworth@cworth.org>
	<1161472030.9241.174.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 01:26:12 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQE7-0000SR-69
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 01:26:04 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbQDs-0007bM-CJ; Sun, 22 Oct 2006 00:25:48 +0100
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GbQDm-0007b3-Pr
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 00:25:44 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Sat, 21 Oct 2006 16:25:40 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GbPHf-0002ZY-F2; Sat, 21 Oct 2006 18:25:39 -0400
To: Jeff Licquia <jeff@licquia.org>
Message-Id: <20061021192539.4a00cc3e.seanlkml@sympatico.ca>
In-Reply-To: <1161472030.9241.174.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Oct 2006 23:25:41.0286 (UTC)
	FILETIME=[3944EC60:01C6F568]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29688>

On Sat, 21 Oct 2006 19:07:10 -0400
Jeff Licquia <jeff@licquia.org> wrote:

> Several of us have pointed to the (branch, revno) combination as a
> sufficiently reliable communication method, and we may be right about
> that.  But, so far, those revnos have been entirely local to a single
> branch, and have also been as absolutely reliable (locally speaking) as
> a revid; the branch "foo" may go away, but while it's around, "revision
> 14 of branch foo" will always mean the same thing.  But we're now adding
> the 0.12 revno scheme, with "global" revnos.  Will those be as reliable?
> Will "revision 2418.1.4 on bzr.dev" work as well as "revision 2418 on
> bzr.dev" does now?

There is no need to speculate, the numbers will only be reliable on a local
basis.  So yes you can force a single repository like bzr.dev to always "win"
any conflict and force the other guy to change ie. a central repo model.
But they can not be maintained consistently in a truly distributed
system.  As Linus pointed out that is fact, not opinion.

Now the opinion of the bzr people is that it doesn't matter and that for
all important cases it works well enough.  If all the people who don't like
the look of sha1's self select bzr, so be it, but that doesn't change the
fundamental argument.

But just to reiterate, the design of Git is flexible enough to where you
can automatically generate "revno" tags for every commit in your repo
_today_.  You'd end up with the exact same problems that bzr will
eventually hit, but Git already has everything you need today to refer
to every commit in your repo as r1 r2 r3 r4 etc...  

Sean
