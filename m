Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B8220954
	for <e@80x24.org>; Tue, 28 Nov 2017 12:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbdK1MbL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 07:31:11 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:40170 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbdK1MbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 07:31:09 -0500
Received: by mail-wr0-f172.google.com with SMTP id s41so177012wrc.7
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 04:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7BoVt+w83UsGmK9VbbWuhKXF0LlQjOLS6up+LQBx40g=;
        b=F6wyvcgI8YFYfxwzFNYO1093S+RFX+60PczjOqCOGEQqBiAuVOwgkKPGhc4ucyqVDj
         aoBU/pPElmjB1pES4AS3QXpUyw/Wtb9OdinNipcV4eUzzDv5qlq6Jw7ZbkgVe7SgZXHF
         KOkJ9aT7TZ6pB+ZKkKb/M9+9Z7lVMKWqz83zpXZ1puF4FG5mCnBChw4v/ViE+RNdAlU1
         Z6cEdwQuVvMI4llrjEjrSGMe4TnNSIfimYgwEK0T6Peqyexikf+B1WHpmni3FLLPbiXs
         eVsVtujME/J340TMGFeHTT1c65dikuhsTc/L/RFwQXdtNgzLv2U+0HMXpeHDD7caQDuZ
         /DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7BoVt+w83UsGmK9VbbWuhKXF0LlQjOLS6up+LQBx40g=;
        b=YhDMAysI6jKYl/Nt2qd3/p2awfx5SNSA6ig9cheKbQWKhLkjlRSDinb8pX2Js8PBwa
         6IWZcSNGJxY1bOZYHg9XDiOP4nLWEYZMJL+wsqNhCAtId21U8l7Ewdznk0gpRzrgNw33
         wtTMc0POVoYKvovsVq7YkrU1gFZ1lZepR5mnEp61n+sYMclvkGh3D1uLK3vfXhe5Z/yV
         w99WFTk5WwKIICAjMwE1joGYqnqH+TYOUrfDVtxMOmQs2GC8wELYo7xC46y6gS+CQZpZ
         I1APxNQgHEU39kns5kYQxO3FrLAQHGVQbiaH5S8pP6zNQgTFJigbbTm8FuxdVm1B4OPy
         GViA==
X-Gm-Message-State: AJaThX60xdvTY5cjHrBAOpC10H2CWcK2hFsNy8t9RD7tRNXva/XvptJ7
        WCR4dMbHCgCndKUQZb+9xUtg6ddz
X-Google-Smtp-Source: AGs4zMYXc4VuQS3VcZ3dgVUcbP+mHa42PRbWP/uGoNWAkApnCCVpDWbZ2Va0NmLf1wzDb7PtUIr1HA==
X-Received: by 10.223.182.7 with SMTP id f7mr2896616wre.71.1511872267810;
        Tue, 28 Nov 2017 04:31:07 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a74sm67258389wrc.7.2017.11.28.04.31.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Nov 2017 04:31:06 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171127230520.GA29636@sigill.intra.peff.net>
Date:   Tue, 28 Nov 2017 13:31:05 +0100
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <33DF54BF-8483-4DFC-99B8-4B25883FE28C@gmail.com>
References: <20171127134716.69471-1-lars.schneider@autodesk.com> <20171127200932.GA558049@genre.crustytoothpaste.net> <20171127230520.GA29636@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Nov 2017, at 00:05, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Nov 27, 2017 at 08:09:32PM +0000, brian m. carlson wrote:
>=20
>>> Show a message in the original terminal and get rid of it when the
>>> editor returns.
>> [...]
>>=20
>> Sorry for coming to the topic so late, but it occurred to me that we
>> might want to conditionalize this on an advice.* flag.  I expect =
there
>> are some people who will never want to see this, and letting them =
turn
>> it off would be good.
>=20
> I am torn between saying "yes please, I would absolutely set such an
> option myself" and "if we need advice.*, that is a good sign that the
> feature is mis-designed".
>=20
> Let me elaborate a bit on the latter.
>=20
> My gut feeling is that this is absolutely the wrong place to put a
> message like this. We don't know enough about what the editor is =
doing,
> so we have to take pains to avoid a crufty message in the terminal,
> including:
>=20
>  - playing ANSI-term trickery to erase the message
>=20
>  - hard-coding (!) emacsclient as a special case
>=20
> And that's why I say that "advice.*" is a bad sign, because it means
> those other techniques are failing, and somebody is seeing and being
> annoyed by the cruft.

I agree with your cruft assessments, especially regarding the hard-coded=20=

emacsclient thingy.=20

However, I really like Brian's "advice" suggestion. Would you be more
in favor of this change if we don't do emacsclient hardcoding and rely =
on=20
"advice.openEditor"? Maybe we could also remove the term trickery but
this seems to be convenient in practice.=20

According to the docs advice.* defaults to "true". For my use case it =
would
be ok if "advice.openEditor" would default to "false" as I distribute
a common Git config via "include.path" to my users. However, that is =
likely
confusing to the "advice" machinery and users.


> The right place for this message, IMHO, is for the editor itself (or a
> wrapper script) to say "hey, I'm opening a new window" (like =
emacsclient
> does).

I 100% agree. However, as you mentioned, the world isn't perfect.

Git's core concepts are pretty simple and most people understand them
if you explain them visually. However, applying/using these concepts
is often the problem. If you want to use Git efficiently then you need
to know lots of other things. Being command-line savvy is one of them.
=46rom experience I know that this is hard for many people. Especially
Windows users as they are not used to BASH and Unix-like command-line
tools. That's why I think "advice.openEditor" could help a few people.

- Lars=
