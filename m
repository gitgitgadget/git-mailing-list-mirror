X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 00:36:08 +0100
Message-ID: <200612020036.08826.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 23:37:05 +0000 (UTC)
Cc: sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32989>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHw7-00066g-H5 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162251AbWLAXg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162389AbWLAXg2
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:36:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:42930 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1162251AbWLAXgK (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:36:10 -0500
Received: (qmail invoked by alias); 01 Dec 2006 23:36:08 -0000
Received: from p5496B457.dip0.t-ipconnect.de (EHLO noname) [84.150.180.87] by
 mail.gmx.net (mp018) with SMTP; 02 Dec 2006 00:36:08 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 00:09, Linus Torvalds wrote:
> 
> On Fri, 1 Dec 2006, sf wrote:
> > Linus Torvalds wrote:
> > ...
> > > In contrast, a submodule that we don't fetch is an all-or-nothing 
> > > situation: we simply don't have the data at all, and it's really a matter 
> > > of simply not recursing into that submodule at all - much more like not 
> > > checking out a particular part of the tree.
> > 
> > If you do not want to fetch all of the supermodule then do not fetch the
> > supermodule.
> 
> So why do you want to limit it? There's absolutely no cost to saying "I 
> want to see all the common shared infrastructure, but I'm actually only 
> interested in this one submodule that I work with".

So you are for a global submodule namespace in supermodule repositories,
do I understand correctly?

Otherwise, how would you specify the submodules at clone time given the
ability that submodule roots can have relative path changed arbitrarily
between commits?

