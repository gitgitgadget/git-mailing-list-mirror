Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5810D12EBE1
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721495677; cv=none; b=Kh7BatXiXPh0DXzchyWniEqxqpYr0JaSaCKSyr9c0Jcd5lHC7DCI0baQppYJ4QMA8fTu7g4qUixzF+7LdK0fLEC/VHWnLscJ+gEFOdSAGZDROSGAABMgPTsjIAm0LwzULxQPR8fIcJ/+2OtaXJa4mSz9UzjQFSnzlI2MrzfgMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721495677; c=relaxed/simple;
	bh=8tYLqRU2hk1TlE4AmqqKDQZIeEteH0hxCdR4CHDVAJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=By5oOZ9PTFzqKtSJLlivEt9AV1qGftD2lqUcs+RjnVoS/GrxG79mIWl5VUZWOtwYJ+VHjPL637tyhSbWsHwtuRl8Rk7vXNy7gJKBAJAr6tJWFPktvbcxCadQSpKAZXLCemEy9jlbQTeScdwDA8TbTKvoxqkhGHXoIeef1pKAvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=GINJtfSd; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="GINJtfSd"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 5FDF2CD49C
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 19:14:17 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2ce:49ae:b84a:b1f])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1D18BB0053E;
	Sat, 20 Jul 2024 19:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721495650;
	bh=8tYLqRU2hk1TlE4AmqqKDQZIeEteH0hxCdR4CHDVAJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GINJtfSdDzRkF7zOLteX4yxCL6Hl6DJpJnacVLvxn51L/bUbQoiyxQJBlYTJQoz6X
	 zIuuo96TtYoG6dWSyCbjeCR+j8DMx//lEqu/F9XL1H31bqkBZrvaHmMbLUjM2qqdp+
	 7JKq9nP09HcSw3pBRx7GyyCpQJgZ5tWGfTO41jb2xiN98cNArVcyj1EHRedBcpOZ6O
	 Aq8WOe644bVZqEFL1+6/iqFhcywk4TfSdcS1VuKpgOL4AHVcajXYg8m7wMhzxUSNpG
	 EbVVl9hskEINL/65CXyFpLxNSalqZIMgPUtHy+tCNNfUGNDThgS59gFM3TXCqODQu9
	 8McnxU1gPDFBQ==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Cory Kramer <corykramer@google.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Documentation Bug
Date: Sat, 20 Jul 2024 19:14:07 +0200
Message-ID: <22362805.EfDdHjke4D@cayenne>
In-Reply-To: <xmqqle1xjm1s.fsf@gitster.g>
References:
 <CAJ7O7F7Zxd-FUbdJh-zxr1FOrUmZQuwx4CHLbQ-ppbkSN79Z-Q@mail.gmail.com>
 <xmqqle1xjm1s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 19 July 2024 20:04:15 CEST Junio C Hamano wrote:
> Cory Kramer <corykramer@google.com> writes:
> 
> > In the docs for git-clone the brackets become mismatched for any
> > options that have a [no-] counterpart.
> > https://git-scm.com/docs/git-clone
> 
> Interesting.  The preformatted pages that were directly generated
> from the sources at https://git.github.io/htmldocs/git-clone.html
> has no such breakage.
> 
> Cory, thanks for reporting.
> 
> I think 76880f05 (doc: git-clone: apply new documentation formatting
> guidelines, 2024-03-29) is where the alleged "breakage" came from.
> 
> Comparing it with pages that weren't updated by the topic that ends
> at 58dd7e4b (Merge branch 'ja/doc-markup-updates', 2024-04-09), like
> 
>     https://git-scm.com/docs/git-clone
>     https://git-scm.com/docs/git-add
> 
> I notice that the latter is rendered with "--[no-]ignore-removal"
> correctly shown.
> 
> Two possible action items are
> 
>  - Compare the preformatted pages at https://git.github.io/htmldocs/
>    between git-clone and git-add and re-evaluate if the earlier
>    ja/doc-markup-updates topic did to the SYNOPSIS is really what we
>    want (the difference is harder to assess by looking at the pages
>    at https://git-scm.com/docs/).
> 
>  - Update the machinery that formats our documentation sources and
>    renders at https://git-scm.com/docs/ to grok the mark-up used by
>    ja/doc-markup-updates topic (currently in use for clone, init,
>    and nothing else).
> 
> Do anybody remember what transmongering produces the copy shown at
> git-scm.com from the source?  Is it computed from the preformatted
> pages, or from the source?
> 

Hello,

This discrepancy is the another instance of asciidoc.py vs. asciidoctor. The 
toolchain for git uses asciidoc.py, whereas git-scm.com uses asciidoctor to 
process the source txt files.

Asciidoc.py does not have the concept of generalized roles, whereas 
asciidoctor interprets   [foo]`blah` as blah with role foo in the synopsis, 
making in effect foo disappear in the output. Note that square brackets not 
directly followed by an inline markup do not define a role, which is why we do 
not have the issue on other parts of the documentation.

This behavior of asciidoctor is not consistant (at least in my understanding), 
as it behaves like asciidoc.py when the same markup is used in a definition 
list.

In order to get a consistant result across asciidoctor and asciidoc.py, the 
only hack I have found is to use the {empty} entity to split the bracket part 
from the inline format part. It is ugly, but unfortunately the roles are a 
wanted feature by technical writers because it adds semantics to the source.

The main difference of rendering introduced by my patch is that placeholders 
and keywords are clearly differentiated. When visualizing with the man command, 
the reworked pages are following the general style applied to placeholders 
(which are underlined) and keywords (which are bold).

I can shortly submit a small patch to fix this, by introducing the ugly  
{empty} entities where needed. Despite not being active lately, I still have 
in project to propose reworked pages for git-add, git-status, git-diff and git-
commit in a short future.

Best regards,

JN






