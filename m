X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Author name and e-mail address in .stgitrc
Date: Sat, 11 Nov 2006 23:30:17 +0100
Message-ID: <20061111223017.GA20192@diana.vm.bytemark.co.uk>
References: <20061111113553.GA11224@diana.vm.bytemark.co.uk> <200611111531.16304.robin.rosenberg.lists@dewire.com> <20061111145708.GH11224@diana.vm.bytemark.co.uk> <200611112126.32380.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 22:30:38 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611112126.32380.robin.rosenberg.lists@dewire.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31243>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj1Mp-0008BC-FL for gcvg-git@gmane.org; Sat, 11 Nov
 2006 23:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753527AbWKKWaX convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbWKKWaX
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 17:30:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:36622 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1753527AbWKKWaW
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 17:30:22 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gj1Mg-0005Gf-00; Sat, 11 Nov 2006 22:30:18 +0000
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

On 2006-11-11 21:26:31 +0100, Robin Rosenberg wrote:

> l=F6rdag 11 november 2006 15:57 skrev Karl Hasselstr=F6m:
>
> > But I haven't gotten the impression that specifying them in
> > ~/.stgitrc is deprecated. The example stgitrc has a section with
> > author name and committer name, for example.
>
> The only docs I know of that mentions stgitrc also states that it
> isn't required, so why use it unless you have to (or for some reason
> want to)? Just because there are many ways, doesn't mean all but one
> have to be deprecated.

No, but having a config option for something that git already provides
several ways to specify can't possibly be a good idea, especially
usability-wise. The only use I can think of is if you _want_ to have
different identities for git and stgit in the same repository, and
that's just mad.

I'm preparing a patch to fix this. Stay tuned. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
