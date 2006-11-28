X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Aaron Bentley <aaron.bentley@utoronto.ca>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 12:07:07 -0500
Message-ID: <456C6CBB.70702@utoronto.ca>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1164733685 15338 80.91.229.2 (28 Nov 2006 17:08:05 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Tue, 28 Nov 2006 17:08:05 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
Original-X-From: bazaar-ng-bounces@lists.canonical.com Tue Nov 28 18:08:02 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gp6Qd-0001S5-CH
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 28 Nov 2006 18:07:31 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gp6QV-00067X-AT; Tue, 28 Nov 2006 17:07:23 +0000
Received: from server4.panoramicfeedback.com ([66.216.124.41])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <aaron.bentley@utoronto.ca>) id 1Gp6QP-00066C-Ep
	for bazaar-ng@lists.canonical.com; Tue, 28 Nov 2006 17:07:17 +0000
Received: from server4.panoramicfeedback.com ([66.216.124.41]
	helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gp6QI-0002lD-00; Tue, 28 Nov 2006 12:07:10 -0500
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
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
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:19783 gmane.comp.version-control.git:32549
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32549>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> in order to realize how well git blame follows both renames _and_ pure 
> data movement).
> 
> The reason this is a good example is simply the fact that it should 
> totally silence anybody who still thinks that tracking file identities is 
> a good thing. It explains well why tracking file identities is just 
> _stupid_.

No need to be aggressive about this.  Yes, it's true that file identity
doesn't directly solve this problem, but it doesn't prove that an
identity-based approach is wrong.

In the end, everything comes down to identity of some kind.  Because if
you're going to apply someone else's changes, you must apply them to the
same thing that they changed.

Git determines identity based on content, while bzr has the user
indicate it.  Both approaches work.

Bzr supports merging based on line identity (our weave merge, not our
knit merge).  At the moment, our concept of line identity is based on
file identity, but there's no reason it has to stay that way.

> You simply couldn't have done that kind of split sanely with file identity 
> tracking (well, that one only had a single copy, so you could argue that a 
> file identity tracker with copies could have done it, but the fact is that 
> (a) they never do and (b) "git blame" can equally well track stuff that 
> comes from _multiple_ different "file iddentities").

I think you're wrong about that.  There's nothing stopping bzr from
inferring a file split, or even explicitly recording it.  bzr doesn't
record copies, because we think there are no sane merge semantics across
copies.

> So yes, "git blame" is a _hell_ of a lot more powerful than anybody elses 
> "annotate", as far as I know. I literally suspect that nobody else comes 
> even close.

I notice that blame has an option to limit the annotation to recent
history.  I can only assume that is for performance reasons.  bzr
annotate doesn't need a feature like that, because annotations are
explicit in bzr's storage format.  I expect that even if we were to
extend annotate to track content across files, it would still be so fast
that we wouldn't need it.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFbGy70F+nu1YWqI0RAt75AKCAy0ALi0IKzqZpgnavJrx97+lhDgCfaMSe
fs4Lt77k1/OXC82aFbh5pKg=
=/OiA
-----END PGP SIGNATURE-----



