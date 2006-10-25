X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 19:27:13 -0500
Message-ID: <20061025002713.GN17019@over-yonder.net>
References: <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org> <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> <20061024163458.GH17019@over-yonder.net> <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 00:27:35 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30021>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcWc3-0007pP-Uo for gcvg-git@gmane.org; Wed, 25 Oct
 2006 02:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422869AbWJYA1R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 20:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWJYA1Q
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 20:27:16 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:973 "EHLO
 optimus.centralmiss.com") by vger.kernel.org with ESMTP id S1422869AbWJYA1P
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 20:27:15 -0400
Received: from draco.over-yonder.net
 (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213]) (using TLSv1
 with cipher ADH-AES256-SHA (256/256 bits)) (No client certificate requested)
 by optimus.centralmiss.com (Postfix) with ESMTP id 5D0952842F; Tue, 24 Oct
 2006 19:27:14 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100) id BB00C61C57;
 Tue, 24 Oct 2006 19:27:13 -0500 (CDT)
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

On Tue, Oct 24, 2006 at 11:03:20AM -0700 I heard the voice of
David Lang, and lo! it spake thus:
> 
> it sounded like you were saying that the way to get the slices of
> the DAG was to use branches in bzr. [...]

I'm not entirely sure I understand what you mean here, but I think
you're saying "Nobody's written the code in bzr to show arbitrary
slices of the DAG", which is true TTBOMK.


> everyone agrees that bzr supports the Star topology. Most people
> (including bzr people) seem to agree that currently bzr does not
> support the Distributed topology.

I think this statement arouses so much grumbling because (a) bzr does
support such a lot better than often seems implied, (b) where it
doesn't, the changes needed to do so are relatively minor (often
merely cosmetic), and (c) disagreement over whether some of the
qualifications included for 'distributed' are really fundamental.


> it's just fine for bzr to not support all possible topologies,

I think there's a real intent for bzr TO support at least all common
topologies.  I'll buy that current development has focused more on
[relatively] simple topologies than the more wildly complex ones.  I
look forward to more addressing of the less common cases as the tool
matures, and I think a lot of this thread will be good material to
work with as that happens.  It's just the suggestion that providing
fruit for simple topologies _necessarily_ prejudices against complex
ones that I find so onerous.


> (besides everyone understanding each other)

That's a good enough reason for me.  Before this thread, I wasn't
interested in using git.  I'm still not, but now I understand much
better /why/ I'm not.  And when (I'm sure it'll happen sooner or
later) some project I follow picks up using git, I'll have enough
grounding in the tool's mental model to work with it when I have to.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
