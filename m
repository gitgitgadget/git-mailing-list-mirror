From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 14:09:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707141402230.3133@beast.quantumfyre.co.uk>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
 <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070711202615.GE3069@efreet.light.src>
 <200707120857.53090.andyparkins@gmail.com> <1184261246.31598.139.camel@pmac.infradead.org>
 <20070713003700.GA21304@thunk.org> <1184367619.2785.58.camel@shinybook.infradead.org>
 <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
 <1184370414.2785.79.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810304-1361360343-1184418597=:3133"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 15:10:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9hOC-0000jo-R1
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 15:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135AbXGNNKC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 09:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbXGNNKC
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 09:10:02 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:41456 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276AbXGNNKA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2007 09:10:00 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0410BC6106
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 14:09:57 +0100 (BST)
Received: (qmail 13231 invoked by uid 103); 14 Jul 2007 14:09:57 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3665. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.036366 secs); 14 Jul 2007 13:09:57 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 14 Jul 2007 14:09:57 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <1184370414.2785.79.camel@shinybook.infradead.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52478>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810304-1361360343-1184418597=:3133
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 14 Jul 2007, David Woodhouse wrote:

> On Fri, 2007-07-13 at 16:18 -0700, Linus Torvalds wrote:
>> Why would anybody force you to do that?
>>
>> The "switch between branchs in the same repo" is really convenient.
>> But nobody *forces* you to do it.
>
> This is true. I already mirror a bunch of CVS and SVN repositories into
> git so that I can use them without too much pain=B9, and I can do the sam=
e
> for git trees which use branches too; mirroring them into a bunch of
> separate trees for easy access.
>
> On the occasions I actually try to _use_ branches, I find it very
> suboptimal. Perhaps it's just because I'm stupid. I'm sure that's why I
> ended up committing changes to the wrong branch. But having to rebuild
> (even with ccache) after changing branches is a PITA. Just changing
> branches at all is a PITA if you have uncommitted changes (which I
> usually do because I've usually tested _some_ random patch in a build
> tree for the hardware which is closest to hand). Pulling a whole bunch
> of unwanted changes on the 'development' branch while on GPRS, when all
> I really needed was a single commit from the 'stable' branch also didn't
> amuse me, although I'm sure if I had the time to play with it I'd have
> been able to avoid that.
>
> I can, and do, mirror stuff from all kinds of suboptimal version control
> systems into single-branch git trees. And I include multi-branched git
> trees in my definition of 'suboptimal'. My ability to do that doesn't
> really help the newbies who are expected with branches, though.

You can flatten a multi-branched git repo without mirroring into multiple=
=20
single-branch repos - The ability to pull out branches into separate trees=
=20
from a single repository was what the git-new-workdir script in contrib=20
was written for.

While I find branches quite a natural concept having used the for the past=
=20
few years in Subversion and CVS before that (and after that branches in=20
git are a delight to use), I still like to have access to all of the=20
branches that I am working on as separate trees.

git-new-workdir allowed me to do that by scripting an approach described=20
by Junio.  Though maybe it has been superseeded by some built-in feature?=
=20
I haven't been following things that closely recently, and ISTR that there=
=20
was talk of a feature that would make the script obsolete.

--=20
Julian

  ---
You're at Witt's End.
---1463810304-1361360343-1184418597=:3133--
