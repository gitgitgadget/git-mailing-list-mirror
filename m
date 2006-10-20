From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 10:22:20 -0300
Message-ID: <200610201322.k9KDMKk0011370@laptop13.inf.utfsm.cl>
References: <aaron.bentley@utoronto.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 15:22:57 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GauKe-0001o6-T8
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 15:22:41 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GauKc-0007wK-78; Fri, 20 Oct 2006 14:22:38 +0100
Received: from inti.inf.utfsm.cl ([200.1.21.155])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <vonbrand@laptop13.inf.utfsm.cl>) id 1GauKP-0007vF-9N
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 14:22:27 +0100
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9KDMK1p015527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Oct 2006 10:22:21 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9KDMKk0011370; 
	Fri, 20 Oct 2006 10:22:20 -0300
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: Message from Aaron Bentley <aaron.bentley@utoronto.ca> 
	of "Wed, 18 Oct 2006 23:10:11 EDT." <4536EC93.9050305@utoronto.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2
	(inti.inf.utfsm.cl [200.1.21.155]);
	Fri, 20 Oct 2006 10:22:21 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88,
	clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29462>

Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> Linus Torvalds wrote:

[...]

> > The "main trunk matters" mentality (which has deep roots in CVS - don't 
> > get me wrong, I don't think you're the first one to do this) is 
> > fundamentally antithetical to truly distributed system, because it 
> > basically assumes that some maintainer is "more important" than others. 

> Linus, if you got hit by a bus, it would still be a shock, and it would
> still take time for the Linux world to recover.  Your insights and
> talent, both technical and social, make you the most important kernel
> developer.  And it stays that way because you deserve it.  Projects with
> good leadership don't fork, or if they do, the fork withers and dies
> pretty quickly.

So? It makes no sense to me to cater only to "successful projects"... most
projects /aren't/ successful ;-)

> It is fine to say all branches are equal from a technical perspective.
> From a social perspective, it's just not true.

Yes, but what matters here is the principle... if branches aren't equal, it
makes some things unnecessarily hard (i.e., forking, passing maintainership
over, ...). Sure, they aren't activities that should be actively
encouraged, but they shouldn't be made harder than necessary either.

> The scale of Bazaar development is much smaller than the scale of kernel
> development, so it doesn't make sense to maintain long-term divergent
> branches like the mm tree.  We do occasionally have long-lived feature
> branches, though.

Are you saying Bazaar is aimed at small(ish) projects (only)?

> > That special maintainer is the maintainer whose merge-trunk is followed, 
> > and whose revision numbers don't change when they are merged back.

> In bzr development, it's very rare for anyone's revision numbers to
> change.

"Very rare" != "never". The "very rare" cases /will/ come back to bite you,
once you grow accustomed to "hasn't ever happened"

[...]

> > I'll just point out that one of my design goals for git was to make every 
> > single repository 100% equal. That means that there MUST NOT be a "trunk", 
> > or a special line of development. There is no "vendor branch".

> I think you're implying that on a technical level, bzr doesn't support
> this.  But it does.  Every published repository

What makes a "published repository" special, as oposed to my local
playground?

>                                                 has unique identifiers
> for every revision on its mainline,

Are they different among repositories, even though they came from another
of the set?

>                                     and it's exceedingly uncommon for
> these to change.

See above.

>                   There are special procedures to maintain bzr.dev, but
> there's nothing technically unique about it.  People develop against
> bzr.dev rather than my integration branch, because they have
> non-technical reasons for wanting their changes to be merged into
> bzr.dev, not my integration branch.

OK.
