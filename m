From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Rebasing stgit stacks
Date: Wed, 17 Jan 2007 10:03:13 +0100
Message-ID: <20070117090313.GA9283@diana.vm.bytemark.co.uk>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <eojn5c$v9u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 10:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H76i6-0005hs-CU
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 10:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbXAQJDW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 04:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbXAQJDW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 04:03:22 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2541 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbXAQJDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 04:03:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1H76hN-0002WO-00; Wed, 17 Jan 2007 09:03:13 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eojn5c$v9u$1@sea.gmane.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36991>

On 2007-01-17 00:30:18 +0100, Jakub Narebski wrote:

> Yann Dirson wrote:
>
> > My example is quite similar to the one given by Guilhem: I had a
> > git branch coming from git-cvsimport, and my stgit stack forked
> > atop that branch. =A0At some point git-cvsimport fucked something,
> > and I regenerated a new mirror branch using it in a fresh repo.
> > Then I wanted to rebase my stack on that new branch.
>
> I'm all for calling this command "stg rebase". Currently you can do
> "stg push -a; stg commit -a; git rebase; stg uncommit -n <n>"...

Or simpler,

  stg pop -a
  git reset --hard <new_base>
  stg push -n <n>

This uses stgit for all operations that can conflict.

(BTW, I've never seriously tried git rebase; does anyone have an
opinion of how convenient its conflict handling is, compared to
stgit's?)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
