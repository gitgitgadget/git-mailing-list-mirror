X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 18:53:54 +0100
Message-ID: <20061113175354.GA16094@diana.vm.bytemark.co.uk>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com> <7v8xigar36.fsf@assigned-by-dhcp.cox.net> <20061113091736.GA31693@diana.vm.bytemark.co.uk> <20061113174457.GA16979@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 17:55:09 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061113174457.GA16979@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31306>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjg0v-0000Nc-JK for gcvg-git@gmane.org; Mon, 13 Nov
 2006 18:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755289AbWKMRya convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 12:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbWKMRy3
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 12:54:29 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:49936 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1755289AbWKMRy3
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 12:54:29 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gjg0I-00058r-00; Mon, 13 Nov 2006 17:53:54 +0000
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On 2006-11-13 12:44:57 -0500, Shawn Pearce wrote:

> Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > There really should be a flag to make git fetch do this job. And
> > if we use separate remotes, the flag should probably default to
> > "on".
>
> And also to automatically stop fetching any branch which is no
> longer listed on the remote system, rather than reporting a "Fetch
> failure".

Yes.

> I probably would keep the local ref (they are cheap) just in case
> the user was counting on that branch and then the remote system
> pulled the rug out from under them. :-)

Sounds like good default behavior. But I smell the potential for
another command flag here. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
