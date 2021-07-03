Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B79C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5238F61934
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 17:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGCRko (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 13:40:44 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:16424 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229557AbhGCRkn (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Jul 2021 13:40:43 -0400
X-Sender-Id: dreamhost|x-authsender|tessa@assorted.tech
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E4D3F3414A4;
        Sat,  3 Jul 2021 17:29:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a8.g.dreamhost.com (100-96-18-98.trex.outbound.svc.cluster.local [100.96.18.98])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 01E73341CEC;
        Sat,  3 Jul 2021 17:29:34 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|tessa@assorted.tech
Received: from pdx1-sub0-mail-a8.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.18.98 (trex/6.3.3);
        Sat, 03 Jul 2021 17:29:35 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|tessa@assorted.tech
X-MailChannels-Auth-Id: dreamhost
X-Versed-Imminent: 23688989144dd6c3_1625333375745_287142612
X-MC-Loop-Signature: 1625333375745:2562543877
X-MC-Ingress-Time: 1625333375745
Received: from pdx1-sub0-mail-a8.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a8.g.dreamhost.com (Postfix) with ESMTP id B8EA98A59C;
        Sat,  3 Jul 2021 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=assorted.tech; h=
        message-id:subject:from:reply-to:to:cc:date:in-reply-to
        :references:content-type:mime-version:content-transfer-encoding;
         s=assorted.tech; bh=JNRJGKWl/ZHU1GcFGjnChXnjoaw=; b=FH9KwHnPyiW
        G7Y2+hzPyfIdR1gTlBk/jL+vpd+imaS4kAP77ZI+j/R89alKljVb+Yq1kPiiyc/T
        ryR6Rlng56dg7E7MYAR+0LZw2VQs/sVmGJECZ0XMPUg7PjKM5YDV7YnTXgWlbf6y
        vxFc7B1rfiAK17/xPKztjGNnNFnKyxgE=
Received: from slate (scio-198-15-3-17.static.smt-net.com [198.15.3.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tessa@assorted.tech)
        by pdx1-sub0-mail-a8.g.dreamhost.com (Postfix) with ESMTPSA id 39BEE81D06;
        Sat,  3 Jul 2021 10:29:34 -0700 (PDT)
Message-ID: <81d63ed42d5c7b442cff616dcc2766bebc265381.camel@assorted.tech>
Subject: Re: Using .gitignore symbolic links?
X-DH-BACKEND: pdx1-sub0-mail-a8
From:   "Tessa L." <tessa@assorted.tech>
Reply-To: office@assorted.tech
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Date:   Sat, 03 Jul 2021 10:29:33 -0700
In-Reply-To: <87o8c34dq6.fsf@evledraar.gmail.com>
References: <1623983680.3494.0@smtp.dreamhost.com>
         <87o8c34dq6.fsf@evledraar.gmail.com>
Organization: Assorted Tech
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert, Peff, and =C3=86var,

Thanks for the responses on this.

Will attempt to better-articulate both my use case and my concerns.


---=20

First, an attempt to provide clarity regarding my use case.

This is a hypothetical representational of my project's structure
(symlinks designated by '->'):
```
..
.
./.gitignore  -> ./doc/.gitignore
./doc
./doc/readme.md
./doc/.gitignore
./main
./main/.gitignore -> ../doc/.gitignore./main/00_textFile.src
./main/00_textfile.src~
./main/00_textFile.src~
./main/01_differenTextFile.src
./static
./static/.gitignore -> ../doc/.gitignore
./static/executeable.sh
./static/executeable.sh~
```
The contents of these listed files (aside from the .gitignore, as
articulated below) don't actually matter, though it's possibly relevant
that the tilde-differentiated files are the default "temp/backup" file
for GNU nano.

By creating symbolic links between the single file in ./doc/.gitignore,
and other directories (repository root, ./main, ./static, etc...) means
repo-wide ignoring of nano's backup files can be added with the single
line:
```
*~
```
...in my ./doc/.gitignore. And just like that, I've eliminated the
entire visible clutter of those backup files from my filetree.

---


Having said that, it's worth noting that I was, also, trying to solve
the "...but adding the metaphorical '*~' to my gitignore on every new
project is a pain, and then if there's another global-ish file-pattern
to squash, updating each and every repo is a pain, too..." problem.

Thank you, Robert, for calling my attention to core.excludesFile,
that's going to be horrifically misused in my homelab sometime soon-
ish.


---

Having said *that*, I did not have visibility on commit 2ef579e261, and
am especially in favour of the mentality of "Let's do X instead of Y so
that (the) two cases behave consistently."

The subtle difference between my actual case of (ab)using symlinks to
point at a single 'ignore' file within the repo (vs linking from
outside the repo) is definitely not within the supported use of git as
a version control system, and I'm not expecting to halt progress
because of some edge case use like this.

I'd rather come up with a better path than "take it back", if that
makes sense.

---


That being said, I have concerns about the implemented approach here.

As a former information security professional, I'm comfortable saying
that the presented dichotomy of the "inherent conflict between security
and convenience" ignores how effective communication and user-consent
fixes the problem.

Arbitrarily breaking system-wide expectations for a low-level utility
(symlinking) in the name of security (it's still a hypothetical RCE,
right? There's not currently a working proof of this exploit?)
seems...problematic...in that it prioritizes something that *may*
happen over pushing breaking changes down the pipe and assuming that
the user will just figure it out...when often even highly technical
users completely miss that something has changed, much less on what
level.

Obviously, security has to happen at all levels...and, a bash-
compatible system has literally countably infinite amount of ways to
cause harm, if you're running someone else's code without attempting
some form of analysis beforehand.


I, and others who use bash or similar shells, are going to expect
symlinks to work consistently both inside git repos and out of it, and
'what if a malicious repo symlinks to Something Bad' seems...outside
the scope of doing version control.=20

Trying to detect exploits at this level (the version control system)
seems like a lot of complexity to add for something that is
fundamentally at odds with the philosophy of 'do one thing well'. And,
choosing to pursue and define what is or is not an acceptable use of
symlinks, or even changing behavior based on internal/external linking,
sounds a lot like scope creep to me.


I'm not saying that to downplay the seriousness of the security
concern...but hopefully to contextualize my deeper concerns about a
choice to not just start breaking the (working, system-level-
consistent) defaults, but to do so without somehow informing the user
and giving them a form of choice regarding the change.


---

I acknowledge that 'too many levels of symlinks' is technically valid
for 'zero levels allowed', but that's not what is functionally
communicated to the end user. I debated about calling out this
distinction, but decided to orient on how a less-technical user would
perceive the error.


In that mindset (of keeping an eye on what a less-technical user will
have perceive), I've watched with happy interest the process of
adjusting the defaults for various commands (git pull and git init,
especially).

The excellent use of user-communicating blocks of text in those cases
while preserving the in-use legacy defaults, while allowing an informed
choice (eg, presenting the user with a suggestion to run specific
command(s) to change the fast-forward behavior or to rename the default
branch on init, respectively) seems like a much better path to me.


If nothing else, I'd like to see that model of user-
querying/informing/consenting behaviour (from the fast-forward and init
examples) happen with this case, for consistency at the very least.


---

Back to my specific use case.

All three of the potential solutions subtly miss my need, so my
suggestion for a 'fourth option' would look something like a flag to
prompt a 'flat' (non-tree) interpretation of the file(s) inside the
repo when filtering the displayed file-list via gitignore/excludesFile.

So, instead of checking if each folder has a rule matching against it,
any rule in the .gitignore (or wherever the core.excludesFile points)
applies to the base-level of any directory inside the repo, resulting
in essentially the same behaviour.

This would eliminate my specific use of symlinks entirely, though it
doesn't touch on my concern about symlinks behaving differently inside
version control than pretty much everywhere else inside a symlink-
capable filesystem.


I don't have visibility on the complexities of adjusting/adding this,
so please correct my assumptions where they conflict with the realities
of developing the next release candidate.


Once again, I appreciate your time and communication on this.

--
Tessa L.

office: 503.893.9709
web: 	https://assorted.tech

On Fri, 2021-06-18 at 13:15 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
> On Thu, Jun 17 2021, Tessa L. H. Lovelace wrote:
>=20
> > The recent release candidate of Git (v2.32.0) hit my OS this week,
> > and
> > it included a line () on symbolic links for several specific files
> > are=20
> > now ignored.
> >=20
> > Thank you for putting the changelogs in an accessible location,
> > knowing that this was a known breaking change was useful in
> > debugging
> > why my workflows stopped working.
> >=20
> > I have two concerns.
> >=20
> > First, the error thrown is
> >=20
> > > "warning: unable to access '.gitignore': Too many levels of
> > > symbolic
> >=20
> >   links",
> >=20
> > ,,,which does not accurately represent what is happening.
> >=20
> > I spent a bit of time convinced that I'd broken something with the
> > symbolic links during setup, and an error such as "symbolic linking
> > no=20
> > longer allowed for 'filename'." would make more sense, given the
> > change under discussion eliminates *any* use of symbolic links.
> >=20
> >=20
> > Secondly, and more personally important to me, a system
> > administrator:
> > My repositories use symbolic links to allow a single .gitignore
> > file
> > to define my folder structure, allowing me to avoid hardcoding the=20
> > repo-specific folder paths into my configs.
> >=20
> > Is there a flag to disable this new behavior?
> >=20
> > If not, this change means I need to update dozens of files,
> > duplicates
> > all, or completely rewrite my .gitignore files to have shyteloads
> > of=20
> > arbitrary file paths in them, which I'd rather not do.
> >=20
> > Also, is there a justification for forcing this as the on-update
> > default new behavior, when a user-querying behavior (such as with
> > 'git=20
> > pull' defaults as they've changed recently) exists?
>=20
> [CC-ing Jeff]
>=20
> Breaking this was intentional, see=20
> https://github.com/git/git/commit/2ef579e261
>=20
> That doesn't mean we can't take it back.
>=20
> As discussed by Robert's reply and in that commit there's the
> workaround
> of .git/info/exclude and the core.excludesFile.
>=20
> However, we realize that sucks for many users. Let's say you have a
> script to clone a "tree" of repositories similar to but not using
> git-submodule (or they live side-by-side), such a thing won't Just
> Work
> anymore.
>=20
> At the end of the day there's an inherent conflict here between
> security
> and convenience. We really want a repository to be safe to just "git
> clone", i.e. we don't set up any hooks, execute code etc.; these
> gitattributes and gitignore issues were on edges of that.
>=20
> We can make it work as before, but it gets hard to distinguish the
> gitignore you mean, from a gitignore that's pointing to /dev/urandom
> (annoying), or to some crafted out-of-tree thing that'll cause an
> overflow in the parser and an RCE.
>=20
> Any way out of that that's configurable is going to be be the same
> opt-in problem as core.excludesFile is now.
>=20
> So I'd think our options are basically:
>=20
>  1) Do nothing, it sucks for some people (like you) but we think it's
> worth it
>=20
>  2) Some DWYM middle ground, e.g. we could discover if the link
> points
>     to another git repo, and only trust it then, or if it's in the
>     user's $HOME or whatever.
>=20
>  3) Bring back the old behavior, it was more of a "while we're at it
> for
>     gitattributes..." fix than something specifically a problem with
>     gitignore, the RCE threat is a hypothetical, and we can more
> easily
>     audit/be confident in the gitignore parser, probably...
>=20

