X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: git and bzr
Date: Tue, 28 Nov 2006 01:01:46 +0100
Message-ID: <456B7C6A.80104@webdrake.net>
References: <45357CC3.4040507@utoronto.ca>	<20061021130111.GL75501@over-yonder.net>	<453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 00:02:11 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32466>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoqQ6-0006ek-D5 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758631AbWK1ABu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 19:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758632AbWK1ABu
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 19:01:50 -0500
Received: from alf.nbi.dk ([130.225.212.55]:40714 "EHLO alf.nbi.dk") by
 vger.kernel.org with ESMTP id S1758631AbWK1ABu (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 19:01:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by alf.nbi.dk
 (8.9.3/8.9.3) with ESMTP id BAA18711; Tue, 28 Nov 2006 01:01:47 +0100 (MET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello all,

Following the very interesting debate about the differences between bzr
and git, I thought it was about time I tried to learn properly about git
and how to use it.  I've been using bzr for a good while now, although
since I'm not a serious developer I only use it for simple purposes,
keeping track of code I write on my own for academic projects.

So, a few questions about differences I don't understand...

First off a really dumb one: how do I identify myself to git, i.e. give
it a name and email address?  Currently it uses my system identity,
My Name <username@computer.(none)>.  I haven't found any equivalent of
the bzr whoami command.

Now to more serious business.  One of the main operational differences I
see as a new user is that bzr defaults to setting up branches in
different locations, whereas git by default creates a repository where
branches are different versions of the directory contents and switching
branches *changes* the directory contents.  bzr branch seems to be
closer to git-clone than git-branch (N.B. I have never used bzr repos so
might not be making a fair comparison).

With this in mind, is there any significance to the "master" branch (is
it intended e.g. to indicate a git repository's "stable" version
according to the owner?), or is this just a convenient default name?
Could I delete or rename it?  Using bzr I would normally give the
central branch(*) the name of the project.

(* Central or main on my own system.  Not intended to be central in the
sense of a CVS-style version control setup:-)

Any other useful comments that can be made to a bzr user about working
with this difference, positive or negative aspects of it?

Next question ... one of the reasons I started seriously thinking about
git was that in the VCS comparison discussion, it was noted that git is
a lot more flexible than bzr in terms of how it can track data (e.g. the
git pickaxe command, although I understand that's not in the released
version [1.4.4.1] yet?).  A frustration with bzr is that pulling or
merging patches from another branch or repo requires them to share the
same HEAD.  Is this a requirement in git or can I say, "Hey, I like that
particular function in project XXX, I'm going to pull that individual
bit of code and its development history into project YYY"?

Last off (for now, I'm sure I'll think of more): is there any easy (or
difficult) way to effectively import version history from a bzr
repository, and vice versa?

Thanks in advance for any comments,

    -- Joe
