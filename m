X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 10:32:44 +0100
Message-ID: <20061201093244.GP12463MdfPADPa@greensroom.kotnet.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <200611301530.51171.andyparkins@gmail.com>
 <20061130163304.GN12463MdfPADPa@greensroom.kotnet.org>
 <200612010001.57111.andyparkins@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 1 Dec 2006 09:33:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612010001.57111.andyparkins@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32879>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq4lc-0005qY-Af for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759285AbWLAJdI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759286AbWLAJdI
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:33:08 -0500
Received: from psmtp04.wxs.nl ([195.121.247.13]:16044 "EHLO psmtp04.wxs.nl")
 by vger.kernel.org with ESMTP id S1759285AbWLAJdH (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:33:07 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by psmtp04.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0J9L0088H96KTX@psmtp04.wxs.nl> for
 git@vger.kernel.org; Fri, 01 Dec 2006 10:32:44 +0100 (MET)
Received: (qmail 19652 invoked by uid 500); Fri, 01 Dec 2006 09:32:44 +0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 12:01:54AM +0000, Andy Parkins wrote:
> On Thursday 2006, November 30 16:33, Sven Verdoolaege wrote:
> > > Well, I know what the commit is /that/ was all that was stored.  So I
> >
> > Then I have no idea what you are talking about.
> > A commit _contains_ all the history that lead up to that commit,
> > so if you have the commit, then you also have the history.
> 
> It's not so much an actual commit, as a reference to a commit in another 
> repository.

This is heresy.  Any object referenced in a tree should be in the repo
(possibly via alternates).

