Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA53C201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964777AbdBQWS4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:18:56 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:36893 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbdBQWSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:18:53 -0500
Received: by mail-it0-f53.google.com with SMTP id x75so27708820itb.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vA7k9vsQx1u9Pmu7f/lb0FSxIO86GJnOra9+XkKewF8=;
        b=qxd7HBS915cYE0UW91uA3VNMC52AsrUGySVvRAOjdKgXolLv9sL9GmGGZN0ZQvG2oV
         WXtz7sCXNpT6C4ZtRlYtQwBF75eZn1Nrj5MMkf7rhQhnIKmWILL+f9p6F0wNCzkdiHjd
         3ax2vmglk9iNFxN7JhaOCsXGu06hTZLjuaynusaM18NiTR8RrsKd1OCb3FuYwjVSr13n
         CfmTknduRCtTzzGKUBbM+SptTXZUGVM7YFkTlMPQMqOAr3fxY7LwMJ459aloUcDa62Jw
         jMtnLGYQMR9rIaFxR393wxVqJ9AwQCJtbJ/394vcpIE6mp2Ce422RHkwGNlU6i/hCWUb
         w3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vA7k9vsQx1u9Pmu7f/lb0FSxIO86GJnOra9+XkKewF8=;
        b=FMcc18RipCZUw7l2kGLfYmDnxaHeKZJbVp/tjEs1nzpciPfdQiKpODuZroazhSpEvl
         jjAIna3ugjzKchVpAdP/JbGB2ARJj35p99sLIssXJbbjGJSuZVDlvMEm4Lu4pKmiSMKr
         X3xrR8FCoeB5Zap955diBbuRW9CSAhLRCFgqGQpTZplAB594LeNRxcDbM1thgmv7fFcJ
         DP+4aCoehT+sJhHK+ekEOa9h4MzwDu1k5KVu8xgnw6MVtzFWlgZr29ONT4dYcr0z1gw/
         LVu4GUge5XDokcJh1iVTBBRxI3QKRUDsAepa3E5HJ44gUq3Am8K16Dx3giv38daJWRIv
         UesA==
X-Gm-Message-State: AMke39lb3ltN6Xqm+clqlKNm295pMwJpE0YZrmeWxMUD8EKOlcVUZV7e/aP94tTsYBPQ0plmNoPDebmJ5JzoEQ==
X-Received: by 10.36.103.9 with SMTP id u9mr6180874itc.91.1487369429361; Fri,
 17 Feb 2017 14:10:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.157 with HTTP; Fri, 17 Feb 2017 14:10:08 -0800 (PST)
In-Reply-To: <20170217204227.kreormjoo5lr6zu4@sigill.intra.peff.net>
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
 <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com> <20170217204227.kreormjoo5lr6zu4@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 17 Feb 2017 23:10:08 +0100
Message-ID: <CACBZZX7nJkRmSxTdvhgXz5Zuk0KeovSZM1D_eGqbBn7i20+ePQ@mail.gmail.com>
Subject: Re: git alias for options
To:     Jeff King <peff@peff.net>
Cc:     hIpPy <hippy2981@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 9:42 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 17, 2017 at 02:50:23PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> On Fri, Feb 17, 2017 at 9:23 AM, hIpPy <hippy2981@gmail.com> wrote:
>> > Git has aliases for git commands. Is there a (an inbuilt) way to alias
>> > options? If not, what is the reason?
>>
>> This has long been on my  wishlist, because there's a lot of
>> copy/pasted logic all over Git to make git foo --whatever aliased to
>> foo.whatever in the config, but only for some options.
>>
>> It should ideally be part of something every option just supports, via
>> the getopts struct.
>>
>> However, it can't allow you to modify whatever option you want,
>> because some things like git-commit-tree should not be customized
>> based on config, it would break things that rely on the plumbing
>> commands.
>>
>> So it would have to be a whitelist for each option we allow to be
>> configured like this via the getopts struct.
>>
>> Also there are surely other edge cases, like maybe the config option
>> now doesn't 1=3D1 map to the name for the option in some cases, or the
>> flag should be config-able but is has no long form (which we'd like
>> for the config), then we'd want to add that etc.
>
> I think your idea is roughly equivalent in functionality to just
> allowing aliases to override command names. E.g., anything you could do
> with:
>
>   [log]
>   follow =3D true
>   decorate =3D false
>
> could be done with:
>
>   [alias]
>   log =3D "log --follow --no-decorate"

Indeed, exact same thing, different syntax. Mostly I like this
suggestion better, although the bad side of it is that it's not as
easy to introspect with a dump of git-config -l.

> The reason we have historically not allowed that is for the
> "commit-tree" plumbing reason you gave above. One option would be to
> relax it for a whitelist of porcelain commands. Then your whitelist at
> least only has to cover commands, and not each individual option.
>
> I think there are a lot of corner cases in that whitelist, though. A lot
> of commands serve dual porcelain/plumbing purposes. E.g., "log" and
> "tag" are commonly used by both humans and by scripts.
>
> A first step in that direction would probably be an environment variable
> to tell Git to suppress command-aliases. Scripts would set that to
> ensure a more vanilla experience. It doesn't fix _existing_ scripts, but
> if that option were introduced, then over time scripts would start to
> use it. Then eventually it would be safe(r) to introduce something like
> command aliases.

The most gentle first step would be to try to turn the existing config
options where you can override cli-options into some declarative thing
from the current ad-hoc code we have for each one.

That would be no change in behavior, but would make it easier to
migrate more things in the future.

Anyway, words are cheap. Just replied because to the extent that hIpPy
wants to work on this I thought I'd sprinkle some historical caveats
from memory. Other than that no point in keeping talking about this
without patches.
