X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 23:02:32 -0300
Message-ID: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>
References: <jnareb@gmail.com>
NNTP-Posting-Host: main.gmane.org
X-Trace: sea.gmane.org 1161914920 19441 80.91.229.2 (27 Oct 2006 02:08:40 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Fri, 27 Oct 2006 02:08:40 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 27 04:08:38 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GdH4X-00068J-Ak
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 27 Oct 2006 04:03:49 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GdH3j-0003Ps-NN; Fri, 27 Oct 2006 03:02:59 +0100
Received: from inti.inf.utfsm.cl ([200.1.21.155])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <vonbrand@laptop13.inf.utfsm.cl>) id 1GdH3g-0003PY-Lw
	for bazaar-ng@lists.canonical.com; Fri, 27 Oct 2006 03:02:57 +0100
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net
	[200.83.245.232])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9R22lfZ030210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Oct 2006 23:02:50 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9R22Wxf004208; 
	Thu, 26 Oct 2006 23:02:41 -0300
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: Message from Jakub Narebski <jnareb@gmail.com> 
	of "Thu, 26 Oct 2006 13:48:15 +0200." <ehq78n$ec7$1@sea.gmane.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2
	(inti.inf.utfsm.cl [200.1.21.155]);
	Thu, 26 Oct 2006 23:02:50 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5,
	clamav-milter version 0.88.5 on inti.inf.utfsm.cl
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
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18867 gmane.comp.version-control.git:30276
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30276>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:

[...]

> I'd rather split "Supports Renames" into engine part (does SCM
> remember/detect that rename took place _as_ rename, not remember/detect it
> as copiying+deletion; something other than rename) and user interface part:
> can user easily deal with renames (this includes merging and viewing file
> history).

I think that what to tool does in its guts is completely irrelevant, what
is important is what the user sees. Sadly, it seems hard to describe
exactly what is meant/wanted here.

[...]

> 7. Checkouts (as a noun). This probably read "Support Centralized and
> Disconnected Centralized Workflow" but that is perhaps too wordy. Git would
> have "No" for "Centralized"

Why? We could all agree that some repository is "central" and all push/pull
there. Or send patches by mail (or apply them via ssh). Sure, it's not CVS,
but...

[...]

> 13. Plugins. I would put "Somewhat" here, or "Scriptable" in the "Somewhat"
> or "?" background color for Git. And add note that it is easy to script up
> porcelanish command, and to add another merge strategy. There also was
> example plugin infrastructure for Cogito, so I'd opt for "Someahwt"
> marking.

Mostly an implementation detail for "extensible"...

[...]

> 19. Ease of Use. Hmmm... I don't know for Git. I personally find it very
> easy to use, but I have not much experiences with other SCM. I wonder why
> Bazaar has "No" there...

Extremely subjective. Easy to learn doesn't cut it either.

