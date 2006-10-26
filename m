X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Andreas Ericsson <ae@op5.se>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 12:13:39 +0200
Message-ID: <45408A53.10400@op5.se>
References: <20061022185350.GW75501@over-yonder.net>
	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	<20061023222131.GB17019@over-yonder.net>
	<Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>
	<20061024002622.GC17019@over-yonder.net>
	<Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>
	<20061024163458.GH17019@over-yonder.net>
	<Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>
	<20061025002713.GN17019@over-yonder.net>
	<Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>
	<20061025235306.GD17019@over-yonder.net>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1161857636 27278 80.91.229.2 (26 Oct 2006 10:13:56 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Thu, 26 Oct 2006 10:13:56 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, David Lang <dlang@digitalinsight.com>,
	git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Thu Oct 26 12:13:51 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gd2FB-0001eb-VM
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 26 Oct 2006 12:13:50 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gd2FA-00056D-T8; Thu, 26 Oct 2006 11:13:49 +0100
Received: from linux-server1.op5.se ([193.201.96.2] helo=smtp-gw1.op5.se)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <ae@op5.se>) id 1Gd2F5-00054v-I4
	for bazaar-ng@lists.canonical.com; Thu, 26 Oct 2006 11:13:43 +0100
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 4465D6BE18; Thu, 26 Oct 2006 12:13:43 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 28D556BE13; Thu, 26 Oct 2006 12:13:40 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061025235306.GD17019@over-yonder.net>
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18818 gmane.comp.version-control.git:30178
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30178>
X-Mailing-List: git@vger.kernel.org

Matthew D. Fuller wrote:
> 
>> 3. pull from each other frequently to keep in sync.
>>
>> this changes the topology to
>>
>>    Master
>>    /   \
>>  dev1--dev2
>>
>> if they do this with bzr then the revno's break, they each get extra
>> commits showing up (so they can never show the same history).
> 
> These two are either/or, not and; either they pull (in which case
> their old mainline is no longer meaningful), or they merge (in which
> case they get the 'extra' merge commits).
> 
> 
>> in git this is a non-issue, they can pull back and forth and the
>> only new history to show up will be changes.
> 
> In git, this is a non-issue because you don't get to CHOOSE which way
> to work.

Yes they do. They can (and in this case probably will) create a 
topic-branch named "the-other-dev/featureX" and keep it solely for 
tracking the other peers changes, keeping their own topic-branch for 
their own changes, and another branch where they merge both changes in, 
or cherry-pick from each branch to get to the desired result fast. This 
works easily because in git
a) branches are as cheap as I can ever imagine an SCM making them.
b) the "slice the DAG and view anything you like from any branch you 
like any time you like and mix them however you want" approach of the 
visualizers makes it trivial for a 10-year old fledgling programmer to 
see what changes what, and where, and by whom, and why.

The "b" above was a feature I didn't know I needed until it became 
available to me. Thanks to Paul Mackerras (spelling?) for creating the 
wonderful gitk tool, and to Marco Costalba for making a faster and, imo, 
more capable version of it.

>  You always (if you can) pull and obliterate your local
> mainline.  In bzr, it's only an 'issue' because you CAN choose, and
> CAN maintain your local mainline.

Git puts emphasis on code. Bazaar puts emphasis on developers and 
branch-structure. Depending on your preferrence, I imagine one suits 
some people better. I really, really, really don't care if my branch-tip 
gets moved because I hadn't made any changes to it while the other dev 
hacked away or if it causes a merge because we had decided to work on 
different parts of the feature. Perhaps this is a result of the insanely 
good visualizers (kudos again to Paul and Marco) that easily lets me see 
who did what when and where anyways. What I *do* care about is being 
able to easily make sure all the devs have the same code to work and 
test with.

>  You CAN choose, right now, to do a
> git and pull back and forth and only new history show up as changed by
> creating a 'bzr-pull' shell script that does a 'bzr pull || bzr merge'
> (though you'd be a lot better off adding a '--fast-forward-if-you-can'
> option to merge and aliasing that over).
> 
> More basically, though, I don't think that "histories become exactly
> equivalent" is a necessary pass-word to enter the Hallowed City of
> Truely Distributed Development.

The only issue I have with bzr's revno's and truly distributed setup is 
that, by looking at the table, it seems to claim that you have found 
some miraculous way to make revnos work without a central server. Since 
everyone agrees that they don't, this should IMO be listed as mutually 
exclusive features.

On a side-note, git has made my life easier, so I childishly want to 
defend it and see it on top of every list in the world. Something I'm 
sure I share with more people on this list and with some of the bazaar 
users/devs. ;-)


