From: Sean <seanlkml@sympatico.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 18:56:22 -0400
Message-ID: <20061017185622.30fbc6c0.seanlkml__41847.3392761827$1161334883$gmane$org@sympatico.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
	<200610172301.27101.jnareb@gmail.com>
	<45354AD0.1020107@utoronto.ca>
	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
	<45355CBB.80108@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 11:01:16 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaqFg-0004qI-S0
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 11:01:16 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GapNL-0007lP-Fr; Fri, 20 Oct 2006 09:05:07 +0100
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <seanlkml@sympatico.ca>) id 1GZxrG-0002kS-4b
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 23:56:27 +0100
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.81]) by
	bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with
	Microsoft SMTPSVC(6.0.3790.1830); Tue, 17 Oct 2006 15:56:24 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GZwv8-0007Tx-St; Tue, 17 Oct 2006 17:56:22 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Message-Id: <20061017185622.30fbc6c0.seanlkml@sympatico.ca>
In-Reply-To: <45355CBB.80108@utoronto.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Oct 2006 22:56:24.0362 (UTC)
	FILETIME=[786898A0:01C6F23F]
X-Mailman-Approved-At: Fri, 20 Oct 2006 09:04:04 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29423>

On Tue, 17 Oct 2006 18:44:11 -0400
Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

> That can lead to feature bloat.  Some plugins are not useful to
> everyone, e.g. Mercurial repository support.  Some plugins introduce
> additional dependencies that we don't want to have in the core (e.g. the
> rsync, baz-import and graph-ancestry commands).

Shrug, it's really not that tough to do in regular ole source code.
On Fedora for instance you have your choice of which rpms you want
to install to get the features of Git you want.

> Plugins also don't have a Bazaar's rigid release cycle, testing
> requirements and coding conventions, so they are a convenient way to try
> out an idea, before committing to the effort of getting it merged into
> the core.

Hmm.. It's pretty easy to test out Git ideas too.  People do it all
the time, and without plugins.  Junio maintains several such trees
for instance.  Dunno.. I just think plugs _sounds_ good to developers
without much real benefit to users over regular ole source code.

> The bisect plugin is just as performant as any other bzr command.  (The
> whole VCS is in Python.)  Most people don't use it, so we don't ship it
> as part of the base install, but anyone who wants it can have it.

Sure, and anyone who wants to use StGit on top of Git can download and
use it as well.

Sean
