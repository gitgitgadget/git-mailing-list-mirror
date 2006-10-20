From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 12:13:50 +0200
Message-ID: <20061020101350.GF20017@pasky.or.cz>
References: <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	<453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
	<45382120.9060702@utoronto.ca>
	<Pine.LNX.4.64.0610192202340.3962@g5.osdl.org>
	<45387F04.5010101@research.canon.com.au>
	<Pine.LNX.4.63.0610201034170.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 12:14:07 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GarOA-0002xp-Hp
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 12:14:06 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GarNy-00059N-Ny; Fri, 20 Oct 2006 11:13:54 +0100
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.or.cz)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <pasky@machine.or.cz>) id 1GarNu-00059I-HH
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 11:13:52 +0100
Received: (qmail 5784 invoked by uid 2001); 20 Oct 2006 12:13:50 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610201034170.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29436>

  Hi,

Dear diary, on Fri, Oct 20, 2006 at 10:38:48AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Fri, 20 Oct 2006, Lachlan Patrick wrote:
> 
> > How does git disambiguate SHA1 hash collisions?
> 
> It does not. You can fully expect the universe to go down before that 
> happens.
> 
> The only reasonable worry is about SHA-1 being broken some time in future, 
> i.e. being able to construct a malign version of some source code _which 
> has the same hash_. There were plenty of discussions about that; Please 
> search the mailing list. (The consent was that those do not matter, 
> because an existing object will _never_ be overwritten by a fetch, so you 
> would not get that invalid object anyway.)

  well, that's somewhat a bold statement, since when you have a way to
fabricate malicious objects, you probably can socially engineer to have
it distributed to a large portion of repositories if you try hard
enough. Or you hack kernel.org and replace the object. Who knows.

  But the thing is that noone has come any closer to this kind of attack
at all. Currently known attacks are that you can relatively fast (which
doesn't mean "5 minutes"; I think that in case of SHA1 the complexity is
still huge, just smaller than intended, but I may remember wrong; you
can get a MD5 collision of this kind within one minute on a standard
notebook) create a _pair_ of objects sharing the same hash, where both
objects contain a big binary blob. So you would first have to engineer
to have one of those objects accepted officially, then engineer the
malicious one getting in. Generating an object that hashes to a
predetermined value is much harder problem and AFAIK there's no much
progress in breaking this.
