From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Thu, 4 Oct 2007 19:29:30 +0200
Message-ID: <20071004172930.GC21717@diana.vm.bytemark.co.uk>
References: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com> <20071004083304.GB17778@diana.vm.bytemark.co.uk> <20071004154508.GA15424@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 19:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdUW9-0000a6-9R
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 19:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbXJDR3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 13:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbXJDR3h
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 13:29:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2161 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbXJDR3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 13:29:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IdUVu-0006HK-00; Thu, 04 Oct 2007 18:29:30 +0100
Content-Disposition: inline
In-Reply-To: <20071004154508.GA15424@old.davidb.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59988>

On 2007-10-04 08:45:08 -0700, David Brown wrote:

> On Thu, Oct 04, 2007 at 10:33:04AM +0200, Karl Hasselstr=F6m wrote:
>
> > > I did the 'stg refresh' from a directory that was not being
> > > tracked by git. It is in the .gitignore list. This appears to be
> > > the root of the problem.
> >
> > Mmmph. This is not the only StGit command that's apparently not
> > safe to run from a subdirectory. See e.g.
> > https://gna.org/bugs/?9986.
>
> I get an "Error: This item is private" from that page, so I'm not
> sure what that is.

Bleh. For some reason that bug was marked "private" (possibly because
it was posted anonymously), and I didn't realize because _I_ could
read it just fine ... Sorry about that; I've made it public now.

> Just yesterday, I had 'stg push' empty out my patches when I ran it
> from a subdirectory. Fortunately, in this case, the old versions
> were in the log, but I can imagine someone less familiar with what
> git and stgit are doing not knowing how to recover this.

Yep. I hadn't really realized how bad this was, because I always run
stg from the root dir. Wonder how I picked up that habit? ;-)

Thanks for the report.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
