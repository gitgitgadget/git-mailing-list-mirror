X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 00:03:14 +0100
Message-ID: <200612020003.14377.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <4570AF8F.1000801@stephan-feder.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 23:03:36 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <4570AF8F.1000801@stephan-feder.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32981>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHPi-00014U-Ke for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162168AbWLAXDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162145AbWLAXDQ
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:03:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:30941 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1162169AbWLAXDQ (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:03:16 -0500
Received: (qmail invoked by alias); 01 Dec 2006 23:03:14 -0000
Received: from p5496B457.dip0.t-ipconnect.de (EHLO noname) [84.150.180.87] by
 mail.gmx.net (mp044) with SMTP; 02 Dec 2006 00:03:14 +0100
To: sf-gmane@stephan-feder.de
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 23:41, sf wrote:
> Linus Torvalds wrote:
> ...
> > In contrast, a submodule that we don't fetch is an all-or-nothing 
> > situation: we simply don't have the data at all, and it's really a matter 
> > of simply not recursing into that submodule at all - much more like not 
> > checking out a particular part of the tree.
> 
> If you do not want to fetch all of the supermodule then do not fetch the
> supermodule. Instead fetch only the submodules you are interested in.
> You do not have to fetch the whole repository.

But what, when I *want* to fetch the supermodule because of the source
tree which is only available in the supermodule?

Of course, you can argue that the only objects in trees of a supermodule
should be submodule commits, but this is quite restricting the usage of
supermodules.

See further arguments for a submodule namespace in my other mail.
You probably want to specify policies about submodule handling. This
information has to be indexed by some name independent from a 
supermodule commit.

Josef
