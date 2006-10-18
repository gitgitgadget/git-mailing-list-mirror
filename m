From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 09:02:18 -0400
Message-ID: <20061018090218.35f0326b.seanlkml__34760.2584785365$1161335526$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org>
	<45359B2A.1070102@utoronto.ca> <4535E844.8010604@op5.se>
	<20061018103220.GS75501@over-yonder.net> <45360DAE.8000702@op5.se>
	<20061018124320.GT75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 11:12:02 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaqPw-0006sX-84
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 11:11:52 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapNQ-0007lc-G9; Fri, 20 Oct 2006 09:05:12 +0100
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GaB3u-00086A-Ia
	for bazaar-ng@lists.canonical.com; Wed, 18 Oct 2006 14:02:28 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Wed, 18 Oct 2006 06:02:20 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GaA7n-0000wp-C4; Wed, 18 Oct 2006 08:02:19 -0400
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Message-Id: <20061018090218.35f0326b.seanlkml@sympatico.ca>
In-Reply-To: <20061018124320.GT75501@over-yonder.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Oct 2006 13:02:21.0088 (UTC)
	FILETIME=[A5C65A00:01C6F2B5]
X-Mailman-Approved-At: Fri, 20 Oct 2006 09:04:05 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29428>

On Wed, 18 Oct 2006 07:43:20 -0500
"Matthew D. Fuller" <fullermd@over-yonder.net> wrote:

> The difference is that bzr ALSO chooses to support and optimize for a
> different case in the default UI presentation, because We[0] consider
> that far and away the common case on the one hand, and that people
> trying to use the more complex case are ipso facto more able to use a
> behavior differing from the norm on the other.
> 
> [0] Note how adroitly I again speak for other people.  Practice,
>     practice!

Just to be clear here, Git is also able to  supports this model if
you so choose.  It's quite easy for a server to generate Git tags
for every commit it gets.

It's just that this is basically a non issue in the Git world.  People
who use Git aren't crying out for salvation from sha1 numbers.  So I
think this entire discussion is a bit overblown.

But just to be clear, there is nothing in the Git model that prohibits
tagging every commit with something you find less objectionable than
sha1's.  They can appear in the log listings and in gitk etc, and
everyone who pulls from the central server will get them.  In fact,
for some imports of other VCS into Git, exactly that is done; so every
commit can be referenced by its sha1 _or_ the "friendly" number it was
known by in its original VCS.

Sean
