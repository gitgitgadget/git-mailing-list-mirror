X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Tue, 21 Nov 2006 11:56:32 +0100
Message-ID: <20061121105632.GA17021@diana.vm.bytemark.co.uk>
References: <200611202201.45521.jnareb@gmail.com> <20061120222812.GE12285@fieldses.org> <ejtal6$p8s$1@sea.gmane.org> <20061120224800.GF12285@fieldses.org> <ejtbph$tod$1@sea.gmane.org> <87y7q5y8s6.wl%cworth@cworth.org> <tnx64d9xgex.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 21 Nov 2006 10:57:00 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <tnx64d9xgex.fsf@arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31985>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmTJ3-0008AW-LD for gcvg-git@gmane.org; Tue, 21 Nov
 2006 11:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030845AbWKUK4p convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006 05:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030846AbWKUK4p
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 05:56:45 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:25107 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1030845AbWKUK4p
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 05:56:45 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GmTIm-0004aU-00; Tue, 21 Nov 2006 10:56:32 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-21 10:06:30 +0000, Catalin Marinas wrote:

> I personally don't like mixing StGIT and GIT commands unnecessarily,
> unless there is no other option (like "git log" since "stg log" has
> a different meaning). There are people (including me) who use StGIT
> almost exclusively, without relying on the GIT commands. That's why
> I duplicated some of the GIT commands.

I, on the other hand, tend to freely mix git and stgit commands. For
example, I often commit things with the git emacs modes, but I do all
my merging with stgit.

This is all very straightforward once you learn that stgit just adds a
thin layer of extra metadata on top of git. All the really valuable
information is stored in git; what stgit adds is e.g. convenient names
for patches, and the distinction between commits that are patches and
commits that aren't (so that you won't edit supposedly immutable
history by mistake). To me, stgit is a convenient way to edit git
history, which happens to make patchset maintenance very easy.

However, interoperability could be much better than it is. I think
stgit maintains too much extra metadata on top of what git already
has.

--=20
Karl Hasselstr=F6m, kha@treskal.com
