From: Kevin Geiss <kevin@desertsol.com>
Subject: Re: git-archimport
Date: Fri, 11 Nov 2005 16:24:28 -0700
Message-ID: <20051111232428.GS9131@raven.localdomain>
References: <D92ED0A1-B83A-43C3-B39C-AA8A21934D7F@desertsol.com> <46a038f90511101332r3389734uc1aa1effd2898e15@mail.gmail.com> <20051110214959.GO9131@raven.localdomain> <46a038f90511101421o7988a1bfi89eb0e33bd34e4bb@mail.gmail.com> <20051111051910.GP9131@raven.localdomain> <46a038f90511102158k5078e37fn2558cf69bc5794fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Geiss <kevin@desertsol.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 00:25:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaiFz-0001Kk-W4
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 00:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVKKXY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 18:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbVKKXY3
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 18:24:29 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:12504 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S1751378AbVKKXY3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 18:24:29 -0500
Received: from kevin by desertsol.com with local (Exim 4.50)
	id 1EaiFw-0004hN-9f; Fri, 11 Nov 2005 16:24:28 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511102158k5078e37fn2558cf69bc5794fa@mail.gmail.com>
X-PGP-Key: http://www.desertsol.com/~kevin/gpg.txt
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11645>

it's not really public, perhaps I can make it public though. can a tla mirror
be served over http? or does it require ssh?

I'm confident the gpg signatures aren't the problem. I imported some branches
yesterday which were all signed, they worked fine.

I suspuect the problem is that after tagging the oco branch from the base
branch, there are several places where I replayed some patches from one of the
branches to the other. some patches were skipped, some were replayed.  there
was definitely a lot of hard core cherry picking going on, in both directions.
do you think that would cause a problem?

the branches I've imported successfully were things where I had version 1, then
tagged that to create version 2, then tagged that to create version 3, with no
replay or merging going on between the branches. (everything was gpg signed
though)

On Fri, Nov 11, 2005 at 06:58:34PM +1300, Martin Langhoff wrote:
> On 11/11/05, Kevin Geiss <kevin@desertsol.com> wrote:
> > gpg: Signature made Mon Feb 14 12:28:10 2005 MST using DSA key ID E1E6A3B1
> 
> I've never imported a signed changeset, perhaps that's the problem. Is
> the repo public so I can test it myself?
> 
> cheers,
> 
> martin
> 
