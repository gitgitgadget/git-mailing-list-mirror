X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 18:36:57 +0100
Message-ID: <20061114173657.GC5453@diana.vm.bytemark.co.uk>
References: <20061114134958.5326.qmail@science.horizon.com> <ejcl6l$bo0$1@sea.gmane.org> <20061114154739.GB5453@diana.vm.bytemark.co.uk> <200611141815.24236.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 17:37:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611141815.24236.jnareb@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31353>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk2De-0005tV-LN for gcvg-git@gmane.org; Tue, 14 Nov
 2006 18:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966035AbWKNRhF convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755459AbWKNRhF
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 12:37:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14862 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1755458AbWKNRhD
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 12:37:03 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gk2DR-0002jr-00; Tue, 14 Nov 2006 17:36:57 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-14 18:15:23 +0100, Jakub Narebski wrote:

> Karl Hasselstr=F6m wrote:

> > On 2006-11-14 15:53:18 +0100, Jakub Narebski wrote:
>
> > > And what would happen if you want to checkout other branch?
> > > Where the ID in the HEAD would go to? HEAD just _has_ to be
> > > reference to _branch_.
> >
> > The id that used to be HEAD would not be saved anywhere. It would
> > still be reachable from your refs, presumably, just like before
> > you checked it out. (It would not be the case that you had made
> > commits on an unnamed branch that would now get lost, because the
> > tool would refuse to commit until you had created a name for the
> > branch.)
>
> If HEAD would contain an commit ID directly, then you shouldn't be
> able to commit at all.

I agree. You aren't on a branch, so you can't commit. (Of course,
creating a branch for the commit you're on is trivial: "git checkout
-b <branchname>".)

> Not very useful, it is.

Well, as long as you only want to visit the past, not change it, it
can be useful. For example, we could skip the "bisect" branch, since
you aren't supposed to commit to that anyway.

--=20
Karl Hasselstr=F6m, kha@treskal.com
