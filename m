Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9530EC6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWS/zgyx"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D7BC0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:55:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507d7b73b74so7319143e87.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698735320; x=1699340120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/rdwXtV24LWNAx73tsMZP2uyZ4WmBmzSuC9fkIj1Eo=;
        b=QWS/zgyxNFpE5LqkJPcIuO4i4zWhmuCYLgEhs+nA24qqy63J6+kiYEz3qp3zfFyAeS
         79iRBj/USIFL6elu1ZsDNLuwGR0ZU1phVI8tXPM/oMqj6Z3Mw7bjcQ6Wbb64FMXQcuWU
         WEC/oJcPuBVMHhmLoasOW4MkOJWmK+KoFPmQblc3T4fsRSAXtt3Fohmdk053osOMNF0F
         JuEGTR66kM3pUw96zxv+j1V+0ccRqJb/Pnw/59GJd6IGKjB+n9fvo7u5Yq50LXJRiEsk
         oQDW11jpDhOvg/EUFpNl9yUPoCwtJdiQ9SsmNf3Ur6WvKn1SaAShDOAp/yEC5oIQTueA
         qy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698735320; x=1699340120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/rdwXtV24LWNAx73tsMZP2uyZ4WmBmzSuC9fkIj1Eo=;
        b=lNv7FdFvjyeNqrdFkLkSD4fOcBVV8uLZ4edom3ufoXmQG5ZV7axUk8Lv6rqFs0OwCh
         2FvCtgN2FpnSHknrlmFEYyybwAulvnYhWmR628NGAzBuTh62iPgqWXQdVUp5L+lr74Vg
         p5gfelxmUmreQrRc2xyzH3bpaZJkHBEckQ9d/MpJtmR1Gkc3fN6+AJ4E8r44rwZWTvtX
         VQcqIl4wauLxDexy7Y+6+1/+aePxISNve9fcrpMDHpiJ1CG40LFtt51i/Z6LjpMUztqM
         C2HJLtViIKW6RhT4aBrtGyIR9X0KXltGRRiTDzqkRBFgm9Gutk54Yni1t83NIiDIiR8+
         RRhA==
X-Gm-Message-State: AOJu0YwM3ASzR9ulTBLtQxoDHJ8XhPfChekeSlLJRtLhjvA3AB0wvfyV
	DjYtit0C+5EunmYLrdXMY15r4lvaKEm1w5jHaczD3c5sG1g=
X-Google-Smtp-Source: AGHT+IGNRXXBLRMm8sMXqBIexaPOcBR1bzQEaAIjpH3WbLzLDEIQIsX3F79hw/5rgl4S+aEMFu+Aa6BpP6VkHXLBrCk=
X-Received: by 2002:a05:6512:48c6:b0:507:9fa0:e247 with SMTP id
 er6-20020a05651248c600b005079fa0e247mr8232799lfb.32.1698735319857; Mon, 30
 Oct 2023 23:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com> <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
In-Reply-To: <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 30 Oct 2023 23:55:07 -0700
Message-ID: <CABPp-BEjV0H=waNQfKNNqibs3g_BU1CCrNjb8G8h_jXrt8kaiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sequencer: remove use of hardcoded comment char
To: Tony Tung via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Tony Tung <tonytung@merly.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 30, 2023 at 10:09=E2=80=AFPM Tony Tung via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Instead of using the hardcoded # , use the user-defined comment_line_char=
.
> Adds a test to prevent regressions.
>
> Tony Tung (2):
>   sequencer: remove use of comment character
>   sequencer: fix remaining hardcoded comment char

The second commit message seems to suggest that the two commits should
just be squashed; there's no explicit or even implicit reason provided
for why the two small patches are logically independent.  After
reading them carefully, and digging through the particular changes
being made and what part of the code they touch, I think I can guess
at a potential reason, but I feel like I'm crossing into the territory
of mind reading trying to articulate that reason.  (Besides, my
rationale would argue that the two patches should be split
differently.)  Perhaps a comment could be added, to either the second
commit message or the cover letter, to explain that better?

More importantly, though, I think the second commit message is
actually wrong.  Before and after applying this series:

$ git grep -c -e '".*#' -e "'#'" -- sequencer.c
sequencer.c:16

$ b4 am c9f4ff34dbdb7ba221e4203bb6551b80948dc71d.1698728953.git.gitgitgadge=
t@gmail.com
$ git am ./v2_20231031_gitgitgadget_sequencer_remove_use_of_hardcoded_comme=
nt_char.mbx

$ git grep -c -e '".*#' -e "'#'" -- sequencer.c
sequencer.c:12

Granted, four of those lines are code comments, but that still leaves
8 hard coded references to '#' in the code at the end (i.e. the
majority are still left), meaning your second patch doesn't do what
its subject line claims.

And, most important of all is still the first patch.  As I stated
elsewhere in this thread (at
CABPp-BFY7m_g+sT131_Ubxqo5FsHGKOPMng7=3D90_0-+xCS9NEQ@mail.gmail.com):

"""
I think supporting comment_line_char for the TODO file provides no
value, and I think the easier fix would be undoing the uses of
comment_line_char relative to the TODO file (perhaps also leaving
in-code comments to the effect that comment_line_char just doesn't
apply to the TODO file).

However, if someone prefers to make the TODO file also respect
comment_line_char, despite its dubious value, then I expect any patch
should
  1) audit *every* reference found via git grep -e '".*#' -e "'#'" sequence=
r.c
  2) add a test case (or cases) involving --rebase-merges -i that
trigger the relevant code paths
If they don't do that, then I fear we might make the bug more likely
to be triggered rather than less.
"""

Personally, I would rather not accept patches changing the handling of
the TODO script relative to comment_line_char until the above is done,
and I worry that half measures _might_ end up being more hurtful than
helpful.

I feel quite differently about patches that make COMMIT_EDITMSG
handling use comment_line_char more consistently since that code
simply writes the file without re-parsing it; although fixing
everything would be best, even fixing some of them to use
comment_line_char would be welcome.  I think the first two hunks of
your second patch happen to fall into this category, so if those were
split out, then I'd say those are good partial solutions.
