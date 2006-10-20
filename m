From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 22:53:30 +0200
Message-ID: <20061020205330.GK20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	<200610201821.34712.jnareb@gmail.com>
	<45390168.6020502@utoronto.ca> <20061020172125.GF18019@spearce.org>
	<Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
	<20061020202318.GJ20017@pasky.or.cz>
	<Pine.LNX.4.63.0610201345440.5248@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 22:53:37 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb1N1-0004eA-2C
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 22:53:35 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gb1Mz-00060v-Kc; Fri, 20 Oct 2006 21:53:34 +0100
Received: from w241.dkm.cz ([62.24.88.241] helo=machine.or.cz)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <pasky@machine.or.cz>) id 1Gb1Mw-00060i-Uj
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 21:53:31 +0100
Received: (qmail 7517 invoked by uid 2001); 20 Oct 2006 22:53:30 +0200
To: David Lang <dlang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610201345440.5248@qynat.qvtvafvgr.pbz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29538>

Dear diary, on Fri, Oct 20, 2006 at 10:49:53PM CEST, I got a letter
where David Lang <dlang@digitalinsight.com> said that...
> On Fri, 20 Oct 2006, Petr Baudis wrote:
> 
> >
> >Dear diary, on Fri, Oct 20, 2006 at 07:48:58PM CEST, I got a letter
> >where Linus Torvalds <torvalds@osdl.org> said that...
> >>So yeah, I've seen a few strange cases myself, but they've actually been
> >>interesting. Like seeing how much of a file was just a copyright license,
> >>and then a file being considered a "copy" just because it didn't actually
> >>introduce any real new code.
> >
> >Well it's certainly "interesting" and fun to see, but is it equally fun
> >to handle mismerges caused by a broken detection?
> >
> >I've talked to some people who really didn't mind (or even liked) Git's
> >heuristics when it came to _inspecting_ movement of content, but were
> >really nervous about merge following such heuristics.
> 
> remember, git only stores the results. so when you are merging it doesn't 
> even look for renames.

Of course it does look for renames; when you use the recursive strategy,
it will try to merge across renames.
