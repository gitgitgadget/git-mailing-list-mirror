X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Nicholas Allen <allen@ableton.com>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 13:54:38 +0200
Message-ID: <4540A1FE.4050300@ableton.com>
References: <20061022185350.GW75501@over-yonder.net>	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>	<20061023222131.GB17019@over-yonder.net>	<Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>	<20061024002622.GC17019@over-yonder.net>	<Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>	<20061024163458.GH17019@over-yonder.net>	<Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>	<20061025002713.GN17019@over-yonder.net>	<Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>	<20061025235306.GD17019@over-yonder.net>
	<45408A53.10400@op5.se> <ehq78n$ec7$1@sea.gmane.org>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1161863700 17553 80.91.229.2 (26 Oct 2006 11:55:00 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Thu, 26 Oct 2006 11:55:00 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Thu Oct 26 13:54:57 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gd3p2-000060-QI
	for gcvbg-bazaar-ng@m.gmane.org; Thu, 26 Oct 2006 13:54:56 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gd3os-0007xM-RD; Thu, 26 Oct 2006 12:54:46 +0100
Received: from mail.ableton.net ([62.96.12.115])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <allen@ableton.com>) id 1Gd3om-0007wk-1o
	for bazaar-ng@lists.canonical.com; Thu, 26 Oct 2006 12:54:40 +0100
Received: from wks-xp-thg.office.ableton.com ([10.1.15.81])
	by mail.ableton.net with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.62)
	(envelope-from <allen@ableton.com>)
	id 1Gd3ok-0003J4-S0; Thu, 26 Oct 2006 13:54:38 +0200
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehq78n$ec7$1@sea.gmane.org>
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
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:18830 gmane.comp.version-control.git:30196
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30196>
X-Mailing-List: git@vger.kernel.org


> 
> 4. Supports Renames. I could agree with "Somewhat" because of not yet
> implemented --follow option to git-rev-list (and therefore all porcelain).
> Perhaps it would be closer to truth to leave the marker (background color)
> as for "Somewhat" and write "N/A" with note that Git has contents and
> pathname based heuristic detection of renames, or just put "Detect" or
> "Detection" here.
> 
> I would certainly change description of what means that SCM doesn't "Support
> Renames" or has it implemented partially. Current explanation relies
> heavily on _implementation_. The correct wording of current definition
> would be that SCM doesn't support renames if history of a file "as visible
> to SCM" is broken into before rename and after rename part, and that SCM
> support it partially if you can track history of renamed file from
> post-rename name but there is left in void history of pre-rename file.
> But with this definition Git _does_ "Supports Renames".

I would have thought that supports renames would also involve flagging a 
conflict when merging a file that has been renamed on 2 separate 
branches. ie 2 branches rename the file to different names and then one 
branch is merged into the other. In this situation, the user should be 
told of a rename conflict. Bzr supports this as far as I know. Not sure 
about git though as I have never used it.



