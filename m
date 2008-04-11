From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git annoyances
Date: Fri, 11 Apr 2008 09:00:16 +0200
Message-ID: <20080411070016.GA25970@diana.vm.bytemark.co.uk>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <32541b130804091008h1a757552o14dd8e937ed19058@mail.gmail.com> <20080410084119.GA8979@diana.vm.bytemark.co.uk> <32541b130804100805o4ad1e9a6x38e9b1fcf17c5d1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 09:02:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkDGx-0004qX-OG
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 09:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbYDKHBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 03:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbYDKHBG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 03:01:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2598 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbYDKHBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 03:01:05 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JkDFA-0006oZ-00; Fri, 11 Apr 2008 08:00:16 +0100
Content-Disposition: inline
In-Reply-To: <32541b130804100805o4ad1e9a6x38e9b1fcf17c5d1d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79267>

On 2008-04-10 11:05:07 -0400, Avery Pennarun wrote:

> On Thu, Apr 10, 2008 at 4:41 AM, Karl Hasselstr=F6m <kha@treskal.com>=
 wrote:
>
> > The @rev is called a "peg revision", and is different from the
> > "operative revision" specified with the -r flag. The peg revision
> > is used in conjunction with a path to specify the file (or
> > directory) you want, and the operative revision is used to specify
> > which revision of that file you mean.
>
> Yes, but I believe you get the one from @rev if you don't specify
> -r.
>
> For example, I can ask for an "svn diff svn://blahblah@56
> svn://blahblah@59" and it'll feed it to me as expected.

Ah, I didn't know that. But the URL I threw at you agrees:

> Note that even when you don't explicitly supply a peg revision or
> operative revision, they are still present. For your convenience,
> the default peg revision is BASE for working copy items and HEAD for
> repository URLs. And when no operative revision is provided, it
> defaults to being the same revision as the peg revision.

Clearly, I need to use Subversion more, and not fool around with git
all the time. :-)

> > (This complexity is needed because subversion has a concept of
> > file identity.)
>
> File renames make diffing and merging complicated no matter whether
> you track them or not.
>
> svn's tracking of file identity is additional, but doesn't increase
> the (UI) complexity in the common case. At least with svn, a newbie
> can even get real work done without even knowing about -r *or*
> @notation.

I don't quite agree with you here. Subversion stores extra state, and
that state needs to be considered (in the general case) when
predicting what Subversion will do. There are a large number of simple
cases where the user doesn't have to care, as you say, but every so
often there's a case that's not so simple, and in those cases I
_really_ prefer git's data model to Subversion's.

> Compare that to arbitrary differences in behaviour between
> "git-fetch" vs "git-fetch a" vs "git-fetch a b", or the difference
> between HEAD^ and HEAD~1 and HEAD@1. git is very powerful, but also
> definitely more complex for beginners.

Oh, I'm not arguing on that point. I like git because it's beutiful on
the _inside_.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
