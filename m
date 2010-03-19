From: Ben Finney <ben+bazaar@benfinney.id.au>
Subject: Re: About single user setup for lightweights
Date: Fri, 19 Mar 2010 15:01:08 +1100
Message-ID: <87y6hpufi3.fsf@benfinney.id.au>
References: <87r5nht6uf.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar@lists.canonical.com, mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 05:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsTOw-000307-3J
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 05:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716Ab0CSEB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 00:01:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:36670 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab0CSEB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 00:01:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NsTOn-0002yf-MD
	for git@vger.kernel.org; Fri, 19 Mar 2010 05:01:25 +0100
Received: from eth595.vic.adsl.internode.on.net ([150.101.214.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:01:25 +0100
Received: from ben+bazaar by eth595.vic.adsl.internode.on.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:01:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: eth595.vic.adsl.internode.on.net
X-Public-Key-ID: 0xBD41714B
X-Public-Key-Fingerprint: 9CFE 12B0 791A 4267 887F  520C B7AC 2E51 BD41 714B
X-Public-Key-URL: http://www.benfinney.id.au/contact/bfinney-gpg.asc
X-Post-From: Ben Finney <bignose+hates-spam@benfinney.id.au>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:y0fK6EAlLEMu/0xHPls7Nimp3g0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142559>

Harry Putnam <reader@newsguy.com> writes:

> Hold your fire on this one if possible. I'm not just a lazy slug who
> can't think and study for himself.

Hopefully you're in for a smooth ride; I'd be disappointed if any of
these communities are hostile to an honest and specific enquiry like
yours.

Welcome, and thanks for learning about modern VCS options!

> I'm a little confused about the different way of using rcs that git,
> mercurial bazaar and probably several others offer.

I got a bit confised by that sentence. You would do well to use =E2=80=9C=
VCS=E2=80=9D
(Version Control System) to refer to the class of program. =E2=80=9CRCS=
=E2=80=9D refers
to a particular VCS, one that is still in current use for some purposes=
=2E

> I've not used anything but cvs.  I use it at least every couple of
> days but really only a limited set of commands, and no deep knowledge
> even of that style.

Good news; you'll have little un-learning to do :-)

> My usage is basically to keep up with rc files for the several OSs' I
> tinker with
[=E2=80=A6]
> To me, keeping up with cvs is always a PITA.  I've never hit on a
> handy and efficient way to do it. Even for a just my light usage.

I don't know what =E2=80=9Ckeep up with CVS=E2=80=9D means. Can you exp=
lain what part of
your workflow is a PITA?

> How would a workflow actually go:
> I'd create and populate a repo, then what?.

You could choose which files should be common between different
machines, add those to the repository and choose not to track the rest
in the VCS. Other ways of doing it are also feasible.

> Create clones on each machine I guess and if I found a need to change
> or add files, I'd then push back to the original repo? Its sounding a
> whole lot like cvs so far.

> So, am I likely to see some improvement in the chore of keeping up an
> [VCS] system with git, mercurial or bazaar?

Pending an explanation of what =E2=80=9Ckeeping up=E2=80=9D means, I th=
ink one of the
big benefits you'll get is that the modern VCS designs:

* treat the whole working tree as the thing to be represented in each
  revision; and

* have significantly better merging capability compared with CVS.

> Anther thing I'm really curious about concerns binary rcs. I'm
> thinking of photo editing and things like flash where I might be
> changing a project over time and want access to past versions.

You can do this with any VCS, but binary files don't have a good generi=
c
way to represent differences efficiently, whereas text files do. So
tracking binary files will work, but will be rather inefficient in term=
s
of memory usage and repository data.

--=20
 \         =E2=80=9CIf you can do no good, at least do no harm.=E2=80=9D=
 =E2=80=94_Slapstick_, |
  `\                                                     Kurt Vonnegut =
|
_o__)                                                                  =
|
Ben Finney
