X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 19:08:18 +0100
Message-ID: <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org>
References: <20061125065338.GC4528@spearce.org>
 <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org>
 <45689747.3020403@midwinter.com>
 <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org>
 <Pine.LNX.4.64.0611260241320.20138@iabervon.org> <456C0313.3020308@op5.se>
 <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 28 Nov 2006 18:09:21 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32558>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp7Nj-0001BQ-Ks for gcvg-git@gmane.org; Tue, 28 Nov
 2006 19:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936007AbWK1SIU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 13:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936005AbWK1SIU
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 13:08:20 -0500
Received: from smtp13.wxs.nl ([195.121.247.4]:8621 "EHLO smtp13.wxs.nl") by
 vger.kernel.org with ESMTP id S936007AbWK1SIT (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 13:08:19 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp13.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0J9G0009DD1VUD@smtp13.wxs.nl> for
 git@vger.kernel.org; Tue, 28 Nov 2006 19:08:20 +0100 (CET)
Received: (qmail 13387 invoked by uid 500); Tue, 28 Nov 2006 18:08:18 +0000
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 28, 2006 at 12:28:47PM -0500, Daniel Barkalow wrote:
> It would be wrong to do "commit -a" in submodules if the supermodule 
> weren't being committed with -a, of course.

What if you say "git commit submodule" ?
I sure hope you wouldn't want to do a "commit -a" in the submodule.
One of the nice features of git is that you can still perform most
operations if you have a dirty state and I would very much want to
be able to commit only some changes in the submodule and then only
commit that change in submodule commits in the supermodule without
having my other changes in the submodule committed as well.

If you agree with the above, then why should "git commit -a"
do any different from "git commit submodule" if submodule was
the only thing that got changed ?

