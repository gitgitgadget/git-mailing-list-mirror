Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820419E83C
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461422; cv=none; b=Jy777T5B84I+1eIR85LnLE5fPZO72Y9XGWjKDTl3Pg2vU4z+2E9XuG1sxqalvEsAJvIG+ZFFiLnf5Et04s3lpfkLd+KNsnIeJtvgguhUHG3sCCxTsksBCaTo676UoqhmRLq9OKRkjjY/6utbBQ5q+vSklvj499m8s95GYZoRIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461422; c=relaxed/simple;
	bh=uwFHRaX2IT8bQsE/l9JnvW2LZ+GWpe9X8e/+ZsS4cpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSsY8ZCefX6/get3eyc264QV/h386DPdeiAM5zHbvfYFTmh5NP0TjHj1Y2mqK2x8s1wac3Uz04UIyvdkZCtOE1Fu/NVoa+IhQYF2rCWfobUfLOl6KSepwEqm9yCvuN2FJpLwg2SV8rvHBeUXxuaydSigc9gKzcHJdK/FHQCANLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=neXCWuIC; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="neXCWuIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753461411; x=1754066211; i=tboegi@web.de;
	bh=acYv7NvZhHGB+ljK9xk1Ad/AOMjhkSeKelrgfF7p7gw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=neXCWuICtzKiTacSCMln2TI9ChTH5dGHZXl4LpX5Vi6nnvExVvAss5s35Fb8Dypx
	 cW3gc76k4o7t3WqJHtnUcm4D/SBJyWaTeQfiaEqSpDre1xoKSlSyDTX+R3HjjVskj
	 U6wjAZa1iiPKcOeWvQVy9kxxuYb7uWZ33sUYgysyp7kAlhZxqWKn1hSUvz/Jfb/c0
	 hA6+KEYW+ttMqDvP2NdyImbgB3QLnsTVgicOlJKZWuF0E9YTdPDMednzLoAYAxIk3
	 3294Wba696aK7HqiQo4iGqFDYASJypVBTW+yaDomghXcKIFntvBUn89LroUd/Mv0I
	 HjcECERsAD+yARiBTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1uwSae3dmU-00V98b; Fri, 25
 Jul 2025 18:36:50 +0200
Date: Fri, 25 Jul 2025 18:36:50 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Kirill Sploshnov <sploshnov1998@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Subject: [RFC] Add config option to enforce committing
 .gitignore / .gitattributes before other files
Message-ID: <20250725163650.GA5869@tb-raspi4>
References: <CAOUUZ_wzNC=D4ZLf9Qw0xhFP+3ycTcPinRSCQA7aOJsiXA_FUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOUUZ_wzNC=D4ZLf9Qw0xhFP+3ycTcPinRSCQA7aOJsiXA_FUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:iJTlsDTkPxaelQ6OEFl02RUWSFd2xH0ZWNA0vwCiHPjPJOjaKbw
 cPqJnrEyD53gnDV1cY5PJ/hZ2Hhz7H+djw9FOTtem2Jut4L6k1qp22A85qKzo0RK0u7wwVP
 sEwWl4UA7Mid8XkOAH3dV71mm7FqjiT+NNdHy7V8xK73MobSwMnEZPn5VutqZGGnxk/iplZ
 vZgc0XuOkdRQELk9/UvRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qko4vxEqQgs=;ibxDMFIZslzG89MJi/4tYYRVuUn
 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

On Fri, Jul 25, 2025 at 12:40:30PM +0200, Kirill Sploshnov wrote:
> Hi Git community,
>=20
> I=E2=80=99d like to propose a new optional safety feature in Git related=
 to
> .gitignore and .gitattributes handling.
>=20
> [Problem Statement]
>=20
> Some software ecosystems - such as game development tools (Unity,
> Unreal Engine) and other project-based environments - rely on
> predefined project folders that include .gitignore and .gitattributes.
> These files:
>=20
> - Exclude large generated files, build caches, and temporary data.
> - Configure Git LFS for specific binary asset types.
>=20
> To minimize interference with the rest of a repository, these files
> are often shipped inside each project folder, not at the repo root.
> This allows multiple projects or heterogeneous formats to coexist.
>=20
> However, Git only applies ignore and attribute rules after these files
> are staged or committed. In practice, many users copy a project into
> an existing repo and immediately run:
>=20
> > git add .
>=20
> This stages everything - including an arbitrarily large cache or

Thanks for the detailed description.
However, I am unable to reproduce it here.
As an example, I ran this code:
tb@mac:~> cd /tmp
tb@mac:/tmp> mkdir 250725-gitignore
tb@mac:/tmp> cd  250725-gitignore
tb@mac:/tmp/250725-gitignore> git init
Initialized empty Git repository in /tmp/250725-gitignore/.git/
tb@mac:/tmp/250725-gitignore> echo *.bak >.gitignore
tb@mac:/tmp/250725-gitignore> touch a.bak
tb@mac:/tmp/250725-gitignore> git add .
tb@mac:/tmp/250725-gitignore> git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   .gitignore

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Your description indicates some problems.
Are you able to demonstrate these with a shell-script ?
The next step could be to find somebody to do the changes,
and sends them, together with a/the test script, to this list.

However, there may be other solutions.
Since you ask for a new config option: This needs to be applied
to each and every workstation in use. How could this be done ?
And if it is done from a central IT department, the there
may be a way to configure git hooks on the work station.

Another way may be to configure the git server to refuse these
kind of commits being pushed by running a ci-script.
Not to talk about the chance to educate users of a tool
to do it in a better way.
Having said all this, there may be other suggestions,
but first we need to understand the technical problems (that can be
solved by a tool).

> binaries that should have been excluded or redirected to LFS. This
> causes:
>=20
> - Bloated history and additional cleanup.
> - LFS pointer issues and git workflow disruptions ("encountered files
> that should've pointers but weren't" errors for other repo users).
>=20
> This problem is especially common when:
>=20
> - Teams copy/import projects frequently.
> - Team members include non-engineering roles (artists, designers).
> - Tight schedules or manipulation of large amounts of small projects
> daily make careful staging problematic.
>=20
> [Proposed Solution]
>=20
> Introduce an optional config that requires .gitignore and
> .gitattributes to be committed before other files:
>=20
> > [commit]
> >     requireIgnoreFirst =3D true
>=20
> [Behaviour]
>=20
> - If the option is set to true and ANY .gitignore or .gitattributes
> differ from HEAD (newly added or has changes) and other files are
> staged in the same commit THEN the commit fails.
> - Enforcement happens at git commit (not git add) to minimize disruption=
.
> - Error message includes a ready-to-use fix:
>=20
> > Error: .gitignore and / or .gitattributes changes detected and must be=
 committed before committing other files. Please commit them separately fi=
rst, before adding other changes:
> > git reset && git add <path to .gitignore> && git add <path to .gitattr=
ibutes> && git commit -m <commit message>
>=20
> The idea is motivated by the [pre-commit](https://pre-commit.com/),
> the de-facto standard extension to use for git hooks managements - it
> behaves similarly, forbidding to commit anything if
> .pre-commit-config.yaml has any changes, requiring it to be committed
> first to avoid inconsistencies.
>=20
> P.S.: this option could potentially be extended to include not just
> predefined paths but a list of patterns in a [.gitignore pattern
> format](https://git-scm.com/docs/gitignore#_pattern_format), but I see
> little incentive to have this customizable as of now - can be
> discussed, but the simpler suggested option should be sufficient for
> all cases.
>=20
> Benefits
>=20
> - Prevents accidental commits of caches or binary artifacts.
> - Reduces Git LFS misconfiguration disruptions.
> - Minimal intrusion - one local config setting. May be set up globally
> for companies / users with many repos.
> - Easy to advocate as a solution for the given software product users.
> - Zero assumptions about any repo layout or user's local / global git
> configuration.
>=20
> Alternatives Considered
>=20
> 1. Repo-level .gitignore / .gitattributes:
>=20
> - Requires potentially frequent updates whenever the project's
> underlying format is changed (new ignored folder or binary extension
> added).
> - While less likely - users can still commit root .gitignore changes
> together with other project data yet-to-be-ignored - which makes the
> problem rarer, but not solved.
> - No way to limit settings to specific folders in general, unless
> users themselves enforce some naming convention - effect will be
> global (see zero assumption point above).
>=20
> 2. Shipped git hooks:
>=20
> - Requires per-repo setup.
> - Not all teams employ git hooks in their workflows - forcing their
> usage is likely more overhead than just setting a single option.
> - For more advanced git workflows users may already have custom hooks,
> and git does not have a concept of hook wrappers / chaining - this
> makes it quite hard to provide a self-contained solution provided by
> the Software in question.
>=20
> Additional Motivation
>=20
> - As mentioned above, such an approach is employed by other widely
> accepted tools, such as pre-commit.
> - Other similar Git safety settings exist, like
> [receive.denyCurrentBranch](https://git-scm.com/docs/git-config#Document=
ation/git-config.txt-receivedenyCurrentBranch).
> - GitHub=E2=80=99s [.gitignore templates
> repo](https://github.com/github/gitignore) demonstrates the ubiquity
> of project-level ignore files, some of which could definitely benefit
> from the current approach, making their effect more local &
> manageable.
>=20
> Contribution
>=20
> If there is a consensus on the feature and the concept is accepted by
> the community - I am willing to contribute an implementation as the
> next step.
>=20
> Thank you for considering this proposal - I am looking forward to
> hearing from you!
> Best regards,
> Kirill Sploshnov (GitHub: NormanXpp)
>=20
