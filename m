Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70B3BD625
	for <git@vger.kernel.org>; Tue, 19 May 2026 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224271; cv=none; b=mcXnnY0BFog3eAOFGoyHmwEXWLb8ux1oz3zylDyQpE/ShF2n6wsGZphGnFYdMhBW3m7OV+S+ZFkyHh6PL06INcXmqVIxrBgXaQNaxT1XpPSgmCiovBVm1ccaasS8aJr3To6w59peebz0g1fqCoslQt9aaSQyLuzpb/s6TSBPtl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224271; c=relaxed/simple;
	bh=4zq9kBjVgR9FgbutnmzcLf3+yGQYi8NX929zrXrDh5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFWNmfpnid94j8uaLISyl4Kxx1G6ssBJAc94qHE9AmTWJxe4V7lPIjUsLcA9r0CdqpZWgxxIDmtUoCx8QLwE47TODs8Og1w6f9AgtMu4qIYrisBs3e5O9sjDrUnDLxIRjyT7e6m4hTldBrGdKL22M5KvVectx+d5twz2ABILlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=pOiLjbV1; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="pOiLjbV1"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 96C2CDF9CD4
	for <git@vger.kernel.org>; Tue, 19 May 2026 22:57:39 +0200 (CEST)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 5CE44B0054C;
	Tue, 19 May 2026 22:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779224251;
	bh=4zq9kBjVgR9FgbutnmzcLf3+yGQYi8NX929zrXrDh5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOiLjbV1YabTYYVP2i8HeT8b6cB7D1EeKMQnlzhEKid8+4U9QHofL/+bXVS1HXbUK
	 YxzCKl2ilslwfJQtL0vZirweDX6lNSi/66kqHG/fjKHWRKPEJSX1lAqtt47JLKK+tD
	 kjcnzot0s1yDN49cRqS21iaRbJpdZOYNtZ89+ioJ4KPJYMp0ktv7dncfrwNHDxApSz
	 pkKQpxceDToUirmF58bc5jq2LQLXFFzDPECs3P+bCCqhWzdgyfbLBWRht502ApLCt7
	 bZQ1MGiA7sOlhghT/mTGz8fnNBLHNw/Ercid4Tt1nAtX/A0Xtqno+qjsBq1rsJVqZw
	 Ue3XePSHn3z/Q==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] doc: convert git-bisect to synopsis style
Date: Tue, 19 May 2026 22:57:29 +0200
Message-ID: <5072065.GXAFRqVoOG@piment-oiseau>
In-Reply-To: <xmqq4ik5d0le.fsf@gitster.g>
References:
 <pull.2117.git.1779049615.gitgitgadget@gmail.com>
 <dca7f192f1e5cdfb57682feace0a4b3a10204376.1779049615.git.gitgitgadget@gmail.com>
 <xmqq4ik5d0le.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 18 May 2026 02:26:37 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > Convert Documentation/git-bisect.adoc to the modern synopsis style.
> >=20
> > - Replace [verse] with [synopsis] in the SYNOPSIS block
>=20
> This was expected.
>=20
> > - Remove single quotes around command names in the synopsis
> > - Use backticks for inline commands, options, refs, and special values
> > - Apply [synopsis] attribute to in-body command-form code blocks
>=20
> This is very much unexpected.  I think everybody thought [synopsis]
> was invented to be used for the SYNOPSIS section at the beginning of
> each manual page, and ...

In fact, the synopsis style was already applied before outside the SYNOPSIS=
=20
sections in diff-generate-patch.adoc when describing the output of the -p=20
option.


This formatting reaches beyond the synopsis, but the rationale is simple. E=
ach=20
time a listing contains some <placeholder>, what is actually described is a=
=20
model, not an actual output. The <placeholder> needs a special formatting t=
o=20
convey its special meaning.

That may mean that the naming of "synopsis style" may not be adequate.

>=20
> >  SYNOPSIS
> >  --------
> >=20
> > -[verse]
> > -'git bisect' start [--term-(bad|new)=3D<term-new> --term-(good|old)=3D=
<term-
old>]
> > -		   [--no-checkout] [--first-parent] [<bad> [<good>...]]=20
[--] [<pathspec>...]
> > ...
> > -'git bisect' help
> > +[synopsis]
> > +git bisect start [--term-(bad|new)=3D<term-new> --term-(good|old)=3D<t=
erm-
old>]
> > +		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]=20
[<pathspec>...]
> > ...
> > +git bisect help
>=20
> ... a change like this is very much expected and understandable, but
>=20
> new appearances of [synonsis] in places like:
> > +[synopsis]
> >=20
> >  ------------------------------------------------
> >  $ git bisect reset <commit>
> >  ------------------------------------------------
>=20
> and
>=20
> > +[synopsis]
> >=20
> >  ------------------------------------------------
> >  git bisect old [<rev>]
> >  ------------------------------------------------
>=20
> were a bit surprising and confusing.  They are not exactly command
> syntax definitions (which is the SYNOPSIS section is about), but
> examples of usage.=20

Are they? the "[<rev>]" block is typical of synopsis syntax, not something =
you=20
would actually type in.

> The one with '$' command line prompt feels
> particularly confusing, as the prompt is not something that the
> end-user gives, unlike what we write in the synopsis section.
>=20

The '$' is an error to me. Will fix.

> Other than that, this is quite exciting.




