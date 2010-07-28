From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 28 Jul 2010 20:32:37 +0200
Message-ID: <201007282032.42106.jnareb@gmail.com>
References: <4C472B48.8050101@gmail.com> <201007261056.58985.jnareb@gmail.com> <20100727183658.GB25124@worldvisions.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com, Marc Branchaud <marcnarc@xiplink.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>, Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 20:33:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeBRF-0002yT-Nc
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 20:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab0G1SdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 14:33:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42646 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab0G1SdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 14:33:00 -0400
Received: by bwz1 with SMTP id 1so4110402bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=e6f6IoB0vVeB66iTIxCFBwL3nLRyGEAYOL5YiWPVxqE=;
        b=MZSdnT6JIl60RpAJ30fahE1wIenhyjVJpkj4/pT8SvF8u1lsFT0SxylmI1ReoIR9tT
         8UgbBSHAI4rlL/iTrUBtjV9KbqkZjiHO3d+CE5UjhgtIeINa3u9D+g0VYvq27LV4P4Uj
         0BMWy6MpzGtWJHbegpPW0QMMwr25p+iI4yx3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iWjEQJfxbmmLx2hgS5brw2emdWifIuwzBHbztt31ecjLMZlgC6zuIvCVsRjuLys8oA
         fdFvly5n2zIdxk/bSURBE84I9oqOWc8fDS4G+N+z6bDmf8keFpC+s9UjnwLsr6A58Z47
         wp4KL7GRIA/4a3YMqkF7aAYInhnFi0uNVesZY=
Received: by 10.204.81.203 with SMTP id y11mr8127667bkk.152.1280341978587;
        Wed, 28 Jul 2010 11:32:58 -0700 (PDT)
Received: from [192.168.1.13] (abvz244.neoplus.adsl.tpnet.pl [83.8.223.244])
        by mx.google.com with ESMTPS id y2sm4989027bkx.8.2010.07.28.11.32.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 11:32:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100727183658.GB25124@worldvisions.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152112>

On Tue, Jul 27, 2010, Avery Pennarun wrote:
> On Mon, Jul 26, 2010 at 10:56:58AM +0200, Jakub Narebski wrote:
> > On Sat, Jul 24, 2010, skillzero@gmail.com napisa=C5=82:
> > >
> > > git-submodule might be technically possible in this situation, bu=
t
> > > having to commit and push each submodule and then commit and push=
 the
> > > super module makes it slightly worse than just dealing with the
> > > space/download/performance issues of one huge repository.
> >=20
> > But this is just a matter for improving UI for dealing with submodu=
les,
> > isn't it.   For example having "git commit --recursive" would help
> > with 'having to commit each submodule', though how you would write =
commit
> > messages then: perhaps supermodule commit message could be by defau=
lt
> > composed out of submodules commits (if any).  "git push --recursive=
"
> > (or some support for push in "git remote") would help with 'having =
to
> > push each submodule'.
>=20
> For "recursive" commit, for my own workflow, I would rather have it w=
ork
> like this: from the toplevel, I can 'git commit' any set of files, as=
 long
> as they all fall inside a particular submodule.  That is, if I do
>=20
> 	git commit mod1/*.c mod2/*.c
> =09
> it should reject it (with a helpful message), because the commit woul=
d cross
> submodule boundaries.  But if I do
>=20
> 	git commit mod1/*.c
> =09
> I think it should create a new commit in mod1, leave my superproject
> pointing at that new commit, and stop (ie. without the superproject h=
aving
> committed the new commit pointer).
>=20
> Why?  Because my normal workflow is:
>=20
>   - make a bunch of superproject/submodule changes until they work.
>   - commit the submodule changes with a submodule-relevant message
>   - commit the superproject change with a supermodule-relevant messag=
e
>  =20
> I wouldn't want to share commit messages between the two, so actually=
 having
> a single commit process be "recursive" would not do me any good.

I think it is quite good idea, but it covers only one of the three most
common (I think) used versions of git-commit:
 * git commit <files>        # your proposal covers this
 * git commit -a             # but I think either this
 * git commit                # or this is actually more common

Also "git commit ." in a submodule cannot be done in this proposal,
because it is indistinguishable from "git commit <submodule>" committin=
g
state of submodule in supermodule.

Perhaps it would be matter of porting "--relative=3D<path>" or adding
"--submodule=3D<name>" option to git-commit?

> However, pushing is a separate issue entirely.  Having push be recurs=
ive
> would be easy, but it doesn't solve the *real* problem with pushing: =
git
> doesn't know what branch to push to in the submodule, and the submodu=
le most
> likely isn't pointing at a pushable repo at all, even if the supermod=
ule is.=20
> This is why I keep coming back to the idea that I really want to push=
 all
> the submodule objects into the superproject's repo.

I think there should be two easy to obtain variants of recursive clone:

1. Current one, where each submodule gets its own repository in the pla=
ce
   it is checked out in working area (in worktree) of supermodule.

2. New one, where submodule repositories are in .git/submodules/<name>
   in supermodule GIT_DIR, and submodules use gitfiles (probably with
   some notation that path is relative to supermodule, like e.g. //<pat=
h>
   or .../<path>).

I'm not sure though how it would translate into pushing...

--=20
Jakub Narebski
Poland
