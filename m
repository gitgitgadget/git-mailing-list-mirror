X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Nicholas Allen <allen@ableton.com>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 13:36:23 +0100
Message-ID: <456ED047.3030102@ableton.com>
References: <45357CC3.4040507@utoronto.ca>	<20061021130111.GL75501@over-yonder.net>	<453F2FF8.2080903@op5.se>	<200610251146.06116.jnareb@gmail.com>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	<456B7C6A.80104@webdrake.net>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1164890254 5222 80.91.229.2 (30 Nov 2006 12:37:34 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Thu, 30 Nov 2006 12:37:34 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Thu Nov 30 13:37:32 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GplAF-0006K0-Ti
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 30 Nov 2006 13:37:20 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gpl9x-00038s-2k; Thu, 30 Nov 2006 12:37:01 +0000
Received: from mail.ableton.net ([62.96.12.115])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <allen@ableton.com>) id 1Gpl9S-000364-FF
	for bazaar-ng@lists.canonical.com; Thu, 30 Nov 2006 12:36:30 +0000
Received: from client0055.office.ableton.com ([10.1.15.66])
	by mail.ableton.net with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.62)
	(envelope-from <allen@ableton.com>)
	id 1Gpl9g-0002uS-Ju; Thu, 30 Nov 2006 13:36:44 +0100
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
In-Reply-To: <456B7C6A.80104@webdrake.net>
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:19901 gmane.comp.version-control.git:32731
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32731>
X-Mailing-List: git@vger.kernel.org

I also have a basic question about git regarding its content tracking 
and merging.

Does this mean if I have, for example, a large C++ file with a bunch of 
methods in it and I move one of the methods from the bottom of the file 
to the top and in another branch someone makes a change to that method 
that when I merge their changes git will merge their changes into the 
method at the top of the file where I have moved it?

If so that would be really quite impressive!

Cheers,

Nick

Joseph Wakeling wrote:
> Hello all,
>
> Following the very interesting debate about the differences between bzr
> and git, I thought it was about time I tried to learn properly about git
> and how to use it.  I've been using bzr for a good while now, although
> since I'm not a serious developer I only use it for simple purposes,
> keeping track of code I write on my own for academic projects.
>
> So, a few questions about differences I don't understand...
>
> First off a really dumb one: how do I identify myself to git, i.e. give
> it a name and email address?  Currently it uses my system identity,
> My Name <username@computer.(none)>.  I haven't found any equivalent of
> the bzr whoami command.
>
> Now to more serious business.  One of the main operational differences I
> see as a new user is that bzr defaults to setting up branches in
> different locations, whereas git by default creates a repository where
> branches are different versions of the directory contents and switching
> branches *changes* the directory contents.  bzr branch seems to be
> closer to git-clone than git-branch (N.B. I have never used bzr repos so
> might not be making a fair comparison).
>
> With this in mind, is there any significance to the "master" branch (is
> it intended e.g. to indicate a git repository's "stable" version
> according to the owner?), or is this just a convenient default name?
> Could I delete or rename it?  Using bzr I would normally give the
> central branch(*) the name of the project.
>
> (* Central or main on my own system.  Not intended to be central in the
> sense of a CVS-style version control setup:-)
>
> Any other useful comments that can be made to a bzr user about working
> with this difference, positive or negative aspects of it?
>
> Next question ... one of the reasons I started seriously thinking about
> git was that in the VCS comparison discussion, it was noted that git is
> a lot more flexible than bzr in terms of how it can track data (e.g. the
> git pickaxe command, although I understand that's not in the released
> version [1.4.4.1] yet?).  A frustration with bzr is that pulling or
> merging patches from another branch or repo requires them to share the
> same HEAD.  Is this a requirement in git or can I say, "Hey, I like that
> particular function in project XXX, I'm going to pull that individual
> bit of code and its development history into project YYY"?
>
> Last off (for now, I'm sure I'll think of more): is there any easy (or
> difficult) way to effectively import version history from a bzr
> repository, and vice versa?
>
> Thanks in advance for any comments,
>
>     -- Joe
>
>
>   




