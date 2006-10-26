X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Vincent Ladeuil <v.ladeuil@alplog.fr>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 14:33:32 +0200
Message-ID: <87u01r9rz7.fsf@alplog.fr>
References: <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<20061026111338.GA15179@coredump.intra.peff.net>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: sea.gmane.org 1161866066 27810 80.91.229.2 (26 Oct 2006 12:34:26 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Thu, 26 Oct 2006 12:34:26 +0000 (UTC)
Cc: , bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Thu Oct 26 14:34:20 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gd4Qm-0006xC-VX
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 26 Oct 2006 14:33:57 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gd4Qe-0002Ch-0q; Thu, 26 Oct 2006 13:33:50 +0100
Received: from [217.167.26.75] (helo=srv-mail.altest.fr)
	by esperanza.ubuntu.com with smtp (Exim 4.60)
	(envelope-from <v.ladeuil@alplog.fr>) id 1Gd4QS-0002Ah-4a
	for bazaar-ng@lists.canonical.com; Thu, 26 Oct 2006 13:33:36 +0100
Received: from dune.altest.fr ([10.0.0.145]) by srv-mail.altest.fr with
	Microsoft SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 14:33:32 +0200
Received: by dune.altest.fr (Postfix, from userid 1000)
	id 831A3E9F2; Thu, 26 Oct 2006 14:33:32 +0200 (CEST)
To: Jeff King <peff@peff.net>
In-Reply-To: <20061026111338.GA15179@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 26 Oct 2006 07:13:39 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 26 Oct 2006 12:33:32.0483 (UTC)
	FILETIME=[F2C02930:01C6F8FA]
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18835 gmane.comp.version-control.git:30204
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30204>
X-Mailing-List: git@vger.kernel.org

>>>>> "Jeff" == Jeff King <peff@peff.net> writes:

    Jeff> On Thu, Oct 26, 2006 at 12:52:05PM +0200, Vincent Ladeuil wrote:
    >> Ok, so git make a distinction between the commit (code created by
    >> someone) and the tree (code only).

    Jeff> Yes (a commit is a tree, zero or more parents, commit message, and
    Jeff> author/committer info).

The parents of a tree are also trees or can/must they be commits ?

    >> Commits are defined by their parents.

    Jeff> Partially, yes.

I buy that this "partially" means "the other parts are irrelevant
to this discussion".

    >> Trees are defined by their content only ?

    Jeff> Yes.

So it is possible that : starting from a tree T,

- I make a patch A,
- you make the patch B,
- A and B are equal (stop watching above my shoulder please, or what is me ?),
- we both commit,
- we pull changes from each other repository.

We will end up with a tree T2 with a hash corresponding to both
T+A and T+B, but each of us will have a different commit id CA
and CB both pointing to T2, did I get it ?

    Vincent






