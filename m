From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg pull/rebase
Date: Wed, 11 Jun 2008 21:07:32 +0200
Message-ID: <20080611190732.GA23670@diana.vm.bytemark.co.uk>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk> <b0943d9e0806100302j159f5b7fq6d970316b902b39b@mail.gmail.com> <20080610104244.GC30119@diana.vm.bytemark.co.uk> <b0943d9e0806100843j28bb3353y5889a50712377959@mail.gmail.com> <20080611061110.GA15034@diana.vm.bytemark.co.uk> <b0943d9e0806111000s4faecfa8o4e4042245c6ff2ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6VgZ-0004jn-Hl
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580AbYFKTHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 15:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754972AbYFKTHr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:07:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2022 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbYFKTHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:07:47 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K6VfR-0006x7-00; Wed, 11 Jun 2008 20:07:33 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806111000s4faecfa8o4e4042245c6ff2ba@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84642>

On 2008-06-11 18:00:25 +0100, Catalin Marinas wrote:

> 2008/6/11 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-06-10 16:43:27 +0100, Catalin Marinas wrote:
> >
> > > 2008/6/10 Karl Hasselstr=F6m <kha@treskal.com>:
> > >
> > > > But what exactly is "rebasecmd" useful for, when you already
> > > > have "fetchcmd" and a built-in rebase?
> > >
> > > In case the built-in rebase is not enough. Can you use "git svn
> > > fetch" followed by plain "git rebase"? There are some comments
> > > in git-svn.txt that recommend to use "git svn rebase" to
> > > preserve linear history.
> >
> > You most definitely can. I've been doing so daily for more than a
> > year:
> >
> >  $ git svn fetch -q
> >  $ stg rebase -m svn/branch
>
> Maybe, I haven't tried (I just followed the git-svn documentation).
> Is the imported svn history linear?

Yes, it's linear. (Can git-svn do anything else?)

> If it works, I no longer have a need for a rebasecmd option.

As I said, it works for me. And I can't really think of a case where
it wouldn't work. Try it and see!

> > And of course,
> >
> >  stg rebase [committish]
> >
> >    The same as "stg pull --no-fetch --rebase [committish]"; that
> >    is, no fetch, just rebase.
>
> I'm OK, as long as we keep a "rebase" alias :-)

I guess you and Jakub have me cornered here. ;-)

> > > See my interpretation of the word "pull". I can change my mind,
> > > no problem, but it would be interesting to see what a native
> > > English speaker says (though you are probably closer to English
> > > than me :-)).
> >
> > Mph, I don't know about me being "closer". I thought you were the
> > one living in the UK? ;-)
>
> I was more thinking about the native language roots (Germanic vs
> Latin in my case, I've only lived in the UK for 7 years) :-)

English is too far from Swedish in this case. My guideline in these
matters is my overconfidence in my own English skills. (And in this
particular case, having followed a mailing list where every month a
new unsuspecting user is taught that pull =3D fetch + merge.)

> > Regardless, I don't think we're actually in disagreement -- as I
> > understand it, we both think that pull =3D fetch + integrate. And
> > "rebase" is one possible value of "integrate".
>
> I think the disagreement is that I consider "fetch" in the above
> equality to be mandatory.

Well, I too consider "pull" to imply "fetch", so I don't see a
disagreement. I only called it "stg pull --no-fetch" instead of "stg
integrate" or whatever because (1) users will have an easier time
finding it that way, and (2) we have too many stg subcommands already.

> But I think your proposal is OK.

Yay!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
