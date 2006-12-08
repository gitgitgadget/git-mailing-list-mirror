X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 08 Dec 2006 19:45:32 +0100
Message-ID: <20061208184532.GE940MdfPADPa@greensroom.kotnet.org>
References: <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se>
 <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se>
 <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se>
 <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org> <457061A7.2000102@b-i-t.de>
 <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
 <1165602554.19135.309.camel@cashmere.sps.mot.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 8 Dec 2006 18:45:48 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	Git List <git@vger.kernel.org>,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <1165602554.19135.309.camel@cashmere.sps.mot.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33720>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gskj4-0003PR-AR for gcvg-git@gmane.org; Fri, 08 Dec
 2006 19:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760838AbWLHSpf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 13:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760840AbWLHSpf
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 13:45:35 -0500
Received: from smtp15.wxs.nl ([195.121.247.6]:45515 "EHLO smtp15.wxs.nl"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760838AbWLHSpe
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 13:45:34 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp15.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0J9Y00J6RXFWYM@smtp15.wxs.nl> for
 git@vger.kernel.org; Fri, 08 Dec 2006 19:45:32 +0100 (CET)
Received: (qmail 2960 invoked by uid 500); Fri, 08 Dec 2006 18:45:32 +0000
To: Jon Loeliger <jdl@freescale.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 08, 2006 at 12:29:14PM -0600, Jon Loeliger wrote:
> Why not have a "glue" object at the "stub"-interface of
> the supermodule tree that provides policy mappings to
> the sub-modules.  Perhaps indicating git URL location,
> mappings of branch names between super- and sub- modules,
> special commit SHA1s, user policy or config choices at
> the boundary, and things like that.
> 
> Is that the sort of direction we are headed?

Not unless you have something useful in mind that could be put in
these glue objects.  URLs and branch names, in particular, should
not be stored in the repository itself, but in configuration files,
since they will be different for different copies of the repo.

