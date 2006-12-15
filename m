X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Provide more meaningful output from 'git init-db'.
Date: Fri, 15 Dec 2006 09:59:00 -0500
Message-ID: <20061215145900.GA17860@spearce.org>
References: <Pine.LNX.4.64.0612142141420.18171@xanadu.home> <20061215054458.GA27750@spearce.org> <eluaf0$v7q$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 14:59:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <eluaf0$v7q$2@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34508>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEWl-0005Kw-DS for gcvg-git@gmane.org; Fri, 15 Dec
 2006 15:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752653AbWLOO7H (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 09:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbWLOO7H
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 09:59:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48506 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752653AbWLOO7G (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 09:59:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvEWY-00049Z-1s; Fri, 15 Dec 2006 09:58:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 1DE7020FB65; Fri, 15 Dec 2006 09:59:01 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> 
> > So now we print out what we did ("Initialized empty" or
> > "Reinitialized existing"), what type of repository ("" or "shared"),
> > and what location the repository will be in ("$GIT_DIR").
> 
> >  ----------------
> > -defaulting to local storage area
> > +Initialized empty Git repository in .git/
> >  ----------------
> 
> > +     printf("%s%s Git repository in %s/\n",

-------------------------------------^^^^

> It seems like this lack this " in " part you have mentioned in
> commit message and in tutorial.

Uh, no it doesn't.  See above.

-- 
