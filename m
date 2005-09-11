From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 12:06:11 +0100
Message-ID: <20050911120611.B8236@flint.arm.linux.org.uk>
References: <59a6e58305090507387d412b3d@mail.gmail.com> <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org> <59a6e58305090606082a23b048@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 13:07:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEPfB-0007f5-6n
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 13:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVIKLGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 07:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVIKLGQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 07:06:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46096 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932467AbVIKLGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 07:06:16 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EEPf2-0005hK-Tc; Sun, 11 Sep 2005 12:06:13 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1EEPf1-0002SO-Gx; Sun, 11 Sep 2005 12:06:11 +0100
To: Wayne Scott <wsc9tt@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <59a6e58305090606082a23b048@mail.gmail.com>; from wsc9tt@gmail.com on Tue, Sep 06, 2005 at 08:08:57AM -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8291>

On Tue, Sep 06, 2005 at 08:08:57AM -0500, Wayne Scott wrote:
> On 9/5/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > > Really 'git commit' should detect problems like this automatically and
> > > prevent them from getting in the tree.
> > 
> > Well, that would depend on having the fixed git-merge-base in the first
> > place, which in turn would mean that such a commit wouldn't happen at all,
> > so it's kind of circular. It's not worth fixing anywhere else, since once
> > you fix it in git-merge-base, it just becomes a non-issue.
> 
> This just error checking to prevent future bugs from getting committed
> to the tree.  These kinds of things are very hard to repair after the
> fact.

They don't get repaired.

The real problem is that there needs to be a way for cogito to remain
more up to date with git, so that when problems are fixed in git they
can propagate into cogito faster.

I'm not sure separating cogito from git is a good solution though -
I've no real view on how stable the interface between those two bits
are, but I'd hate for a git upgrade to break cogito in some subtle
way.

-- 
Russell King
