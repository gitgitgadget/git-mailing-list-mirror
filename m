Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A42321262
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621451; cv=none; b=Drr8fz9LMbhGjHKB6xMbjLIqSKaMkNfW+bw++dCpM6exGd46oGuIVmRJzlYXCyvU2i4+/9bi0bjiVbZ46LJmYbRG4+zGrVniZToS/11s5PqaKacREKwiU03ZQOQ8Qu7XFkY3g1OzDhB+qzbpthzk+wjSxfdLI6kmV9owkK/mWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621451; c=relaxed/simple;
	bh=9rnphKqm4wzpWAl91WVAO5qTXhFvFeqDM5MoJvBxZb8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iC2HarxL6C3qjUae4IP7onLHV3TklDukvFDfQClIBvWVuOzOPoRI3xEpAEeupCzfIRgowkjzH7Crq+WL2vBSgSxMB0ThV+nYVEPrQzKmtkL4BVw7X9ukNp0ZYVA1Waa/zwE1oZJqr+U5Z1poyzLPn5MBdcw4VuooigBSy2oV2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZvILZXJO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZvILZXJO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758621440; x=1759226240;
	i=johannes.schindelin@gmx.de;
	bh=Q3pRRE9iBPRxcMdzJ+arzzT75hFGUhuqQ9roh0tcaSk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZvILZXJOfhRdKHbXhMRpeal/EsP+VQ+ZedkdgC+zFedV3j7ZwuLmIWQUjNHO9rlt
	 6+YwTBc4S5cnhGmjLdG8gRF9q31/w+hePD1mwjRKNUWPrcp5iHXfqcVJAU5S6VHYU
	 WL82r6qqw860GEHWQd4J61Cb9ZwugjQXrZxcsUj0tAn6byrfj6zY2rreGzqqAlwjx
	 QYZjUEj8coDsCEu4MtzCGoz/NMsgNdxlOcNvwObwEybPnhp4QE7oRkaSBeeLbDlmD
	 F57+c0Zc/G3kukWOjBlAz94ToyLKPAISyEqJ/0LzJGez0nKHqhvfboctK/fTnTHFA
	 /ReuN/ScEMG1Qg1zBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.228]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1uHexz218R-013S3l; Tue, 23
 Sep 2025 11:57:20 +0200
Date: Tue, 23 Sep 2025 11:57:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood123@gmail.com>
cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
In-Reply-To: <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
Message-ID: <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com> <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de> <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Kl7LXWUlVuBIfuK2qEDs8oBZtE5T1c4G/0sQwIiH99wFmV27icr
 7YDyVWiJF8clnQA45wqRPGpwN4LSJBVz/VwO4J+8gEg6PYawR8coQL4ilXEjXdwlVNrrWCq
 1E8LvmJuryWY80XnBXbdIhc6qrzIKaTFBBTMQkultz2t8y3t+hRnod4QMU/PFgJ033BElA4
 QIbG81RgBO95tkC3+401g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j6urafwB15M=;vShvCuOHrdQbby+pB7517WyzaHj
 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
 dAh8T+ImiI26heebOk5
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Sun, 20 Jul 2025, Phillip Wood wrote:

> Hi Johannes
>=20
> On 19/07/2025 22:53, Johannes Schindelin wrote:
> > Hi Ezekiel,
> >=20
> > On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:
> >=20
> > > diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
> > > index e69de29bb2d1..96975975a1ba 100644
> > > --- a/rust/xdiff/src/lib.rs
> > > +++ b/rust/xdiff/src/lib.rs
> > > @@ -0,0 +1,7 @@
> > > +
> > > +
> > > +#[no_mangle]
> > > +unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
> > > +    let slice =3D std::slice::from_raw_parts(ptr, size);
> > > +    xxhash_rust::xxh3::xxh3_64(slice)
> > > +}
> >=20
> > I know that this is a pretty small file, but I do notice that it does =
not
> > have a license header.
> >=20
> > This reminds me of the unfortunate oversight to be careful about makin=
g
> > (and keeping) libgit.a's source files compatible with libgit2's licens=
e to
> > nurture a fruitful exchange between those two projects.
>=20
> I'm not sure I follow your reasoning here. libgit2 was started after git=
 and
> chose to use an incompatible license. I wasn't around at the time but is=
n't
> there a list of git contributors who are happy to re-license their
> contributions with the linking exception used by libgit2?

Let me provide some historical context that might clarify the licensing
concern.

When libgit2 was created, the goal was to demonstrate that Git
functionality could be packaged as a reusable library, inviting innovation
via 3rd-party products. The project took existing Git code (with
permission) and wrapped it with a proper API. The hope was that this would
eventually become the foundation for Git itself.

What we learned from that experience is instructive: license
incompatibility became an insurmountable barrier to code sharing between
the projects.

Lack of functionality prevented commercial products using libgit2 to
provide powerful user interfaces that outshine Git's own user experience,
unless they accepted the limited functionality.

Even when volunteers wanted to port new Git features to libgit2, the
licensing prevented it.

This fragmentation weakened both projects - libgit2 couldn't benefit from
Git's innovations, and Git couldn't leverage libgit2's API improvements
nor corporate contributions that would have been more likely to target
libgit2 than Git.

You can see this in full action: merge ORT, partial clone, sparse index,
etc. All of those features are missing from libgit2, with little hope to
end up otherwise.

Innovations such as geographically-distributed, redundant data stores, or
Xet-like big-file storage to replace e.g. Git LFS with a fully native
solution, haven't happened, despite libgit2's architecture offering the
extensibility and proper delineation to make such improvements cleaner
and much more straight-forward than Git's own source code would allow.

> > With Rust, we still have a really good chance to learn from history an=
d
> > avoid that mistake: Gitoxide is a very exciting project with clear ove=
rlap
> > in its mission to implement Git functionality in Rust. Gitoxide is
> > dual-licensed under the Apache License v2 and the MIT license (see
> > https://github.com/GitoxideLabs/gitoxide?tab=3Dreadme-ov-file#license)=
.
> >=20
> > Would you mind adding a license header to that file that explicitly al=
lows
> > the contents of the file to be used in Gitoxide, to get the Rust effor=
t
> > started on a good foot?
>=20
> I wary of that for two reasons. Firstly over time it is de-facto re-lice=
nsing
> git as the amount of rust code grows and the amount of C code shrinks wh=
ich
> deserves a wider discussion. Secondly it makes it harder to convert our =
C code
> which is licensed under GPL2 (or in the case of xdiff LGPL) to rust if t=
he
> rust code uses a different license.

The industry adopted libgit2 widely precisely because it provided what Git
didn't: a clean API for building tools. But the licensing barrier meant
that innovation had to happen in isolation.

Due to the feature disparity, we saw "libgit2 evacuation" efforts,
starting with Visual Studio, later GitHub and GitLab followed, where work
was duplicated by moving away from libgit2 towards a distinctly non-API
way to invoke Git functionality: by spawning full-blown `git` processes
and communicating by parsing `stdout`, risking regressions due to typo
fixes such as the infamous "up-to-date -> up to date" patches. Such a lot
of extra work, away from proper API calls, just because of that
fragmentation!

With Rust and Gitoxide, we have a rare opportunity to avoid this
fragmentation from the start. Gitoxide's permissive dual licensing means
code can flow both ways. This isn't about "slipping in" a license change -
it's about learning from what happened before.

By the way, you made it sound as if I asked to re-license existing code,
which is not the case. I specifically asked for new code to be licensed in
a way that avoids to straight up prevent collaboration with the Gitoxide
project from the get-go.

It would not even take more than something as simple as GPLv2+exception.
We do have prior art for that: The Git project itself suggests in its very
own `COPYING` file to use the following license in new files:

        This file is licensed under the GPL v2, or a later version
        at the discretion of Linus.

Note the exception? For new Rust code (and of course excluding code that
has been ported verbatim from GPLv2-licensed code), GPL v2 could be used
with an exception along these lines: This file is licensed under the GPL
v2, with the exception that it can be freely used in the Gitoxide project.

I am not a lawyer (which everybody but laywers are nowadays required to
say), therefore this likely needs some tweaking.

> If someone wants to start a discussion about re-licensing git (and is
> prepared to do all of the associated admin in the event that it happens)
> then by all means do so but I don't think it we want to slip such a
> change into this series.

The "wider discussion" you mention is exactly what we need; Starting with
compatible licensing makes that discussion possible rather than
purely theoretical and moot.

Ciao,
Johannes
