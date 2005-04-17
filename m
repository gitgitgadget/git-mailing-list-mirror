From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 19:20:00 +0100
Message-ID: <20050417192000.C13233@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417170539.B13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170937020.7211@ppc970.osdl.org> <4262A767.4040300@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:19:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNEMM-0004N2-Kq
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVDQSWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVDQSUf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:20:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31757 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261396AbVDQSUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 14:20:06 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNENG-0008LK-7A; Sun, 17 Apr 2005 19:20:02 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNENE-0005nN-I6; Sun, 17 Apr 2005 19:20:00 +0100
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4262A767.4040300@dwheeler.com>; from dwheeler@dwheeler.com on Sun, Apr 17, 2005 at 02:13:59PM -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 02:13:59PM -0400, David A. Wheeler wrote:
> On Sun, 17 Apr 2005, Russell King wrote:
> >>BTW, there appears to be "errors" in the history committed thus far.
> >>I'm not sure where this came from though.  Some of them could be
> >>UTF8 vs ASCII issues, ....> 
> ...
> >>One thing which definitely needs to be considered is - what character
> >>encoding are the comments to be stored as?
> 
> Linus Torvalds replied:
> > To git, it's just a byte stream, and you can have binary comments if you
> > want to. I personally would prefer to move towards UTF eventually, but I
> > really don't think it matters a whole lot as long as 99.9% of everything
> > we'd see there is still 7-bit ascii.
> 
> I would _heartily_ recommend moving towards UTF-8 as the
> internal charset for all comments.  Alternatives are possible
> (e.g., recording the charset in the header), but they're
> incredibly messy.  Even if you don't normally work in UTF-8,
> it's pretty easy to set most editors up to read & write UTF-8.
> Having the data stored as a constant charset eliminates
> a raft of error-prone code.

Except, I believe, MicroEMACS, which both Linus and myself use.  As
far as I know, there aren't any patches to make it UTF-8 compliant.

The alternative is, I suppose, iconv.  However, iconv in _my_ glibc
seems buggy (segfaults) and my efforts for building glibc 2.3.2 for
ARM have failed.  Effectively that means iconv is inaccessible to
me.

-- 
Russell King

