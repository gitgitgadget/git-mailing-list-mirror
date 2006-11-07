X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 14:56:09 +0100
Message-ID: <20061107135609.GA32376@diana.vm.bytemark.co.uk>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de> <200611070225.24956.Josef.Weidendorfer@gmx.de> <20061107065400.GA25737@diana.vm.bytemark.co.uk> <200611071153.32840.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 7 Nov 2006 13:56:41 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611071153.32840.Josef.Weidendorfer@gmx.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31072>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhRR6-0004bS-H9 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 14:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750996AbWKGN4Q convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006 08:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbWKGN4Q
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 08:56:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3594 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1750996AbWKGN4P
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 08:56:15 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GhRQv-0008TY-00; Tue, 07 Nov 2006 13:56:09 +0000
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 2006-11-07 11:53:32 +0100, Josef Weidendorfer wrote:

> On Tuesday 07 November 2006 07:54, you wrote:
>
> > Having more than one local branch for a remote branch is advanced
> > enough that the user should know how to create branches with any
> > name they choose.
>
> But such an advanced szenario is exactly the reason to introduce
> these long branch names like "origin/next", isn't it? When a newbie
> probably never is confronted with this szenario, then why give him
> longer branch names per default? Do you see the contradiction in
> this argument?

Well, I see your point. However, forcing users to have to unlearn and
relearn when they want to use more of git's power feels wrong. It
would present an artificial barrier for users wishing to proceed from
the newbie stage.

It's more important to have simple rules than to make these rules
generate short names. Long names are not conceptually difficult, just
a bit cumbersome at times.

> IMHO it should be the other way around: when an advanced user gets
> this conflict, he knows how to rename the branches by using this
> more elaborated scheme.

But what happens when an unexperienced user gets this conflict for the
first time (having for the first time used two different remotes)?
Your scheme forces her to learn two new things instead of one,
creating the artificial barrier I mentioned above.

--=20
Karl Hasselstr=F6m, kha@treskal.com
