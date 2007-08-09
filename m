From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 9 Aug 2007 22:39:57 +0200
Message-ID: <20070809203957.GA14441@diana.vm.bytemark.co.uk>
References: <1186549433.2112.34.camel@dv> <20070808092027.GB7860@diana.vm.bytemark.co.uk> <20070808213917.GA22521@diana.vm.bytemark.co.uk> <1186611514.7383.4.camel@dv> <20070808232349.GA23172@diana.vm.bytemark.co.uk> <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net> <20070809073801.GA31482@diana.vm.bytemark.co.uk> <1186665883.28228.31.camel@dv> <20070809141848.GA6342@diana.vm.bytemark.co.uk> <1186677210.31394.28.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 22:40:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJEo5-0001L5-09
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 22:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764712AbXHIUkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 16:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764670AbXHIUkO
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 16:40:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1298 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761219AbXHIUkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 16:40:11 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IJEnV-0003op-00; Thu, 09 Aug 2007 21:39:57 +0100
Content-Disposition: inline
In-Reply-To: <1186677210.31394.28.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55471>

On 2007-08-09 12:33:30 -0400, Pavel Roskin wrote:

> On Thu, 2007-08-09 at 16:18 +0200, Karl Hasselstr=F6m wrote:
>
> > You should be able to do something like
> >
> >   $ stg applied > .git/patches/branch/applied
> >   $ stg unapplied > .git/patches/branch/unapplied
> >
> > and then manually change the version from 3 to 2, and be ready to
> > go. I haven't tested this, though!
>
> That seems to work. Thank you!

What? You mean I didn't forget any step? ;-)

> "branch" should be substituted with the current branch, of course.

I was just too lazy to type the brackets. Or maybe I'm just evil and
_want_ the lock-in effect. Who knows? :-)

> > I saw the same problem today.
> >
> > https://gna.org/bugs/?9710
>
> I've attached the test case to that bug. You are right, git-gc is
> involved.

Thanks.

> > I haven't seen this problem at all -- in my repositories, "stg
> > branch -l" just works. Will try to reproduce (hopefully tonight).
> > Do you have a recepie on how to reproduce this from scratch?
>
> It's a problem with git-gc too! Just clone some repository and run
> "stg branch -l" in it. It with show master. Run git-gc, and "stg
> branch -l" will show "No branches".

Well, well! In that case, I'm off to kill two birds with one stone!

> I see that in my Linux repository there are files in
> .git/refs/remotes/wireless-dev but not in other directories under
> .git/refs/remotes/

Presumably the only nonpacked refs are the ones that have been updated
after the last ref packing. Or however it works.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
