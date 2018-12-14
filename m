Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBF620A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 16:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbeLNQeI (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 11:34:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36289 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLNQeI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 11:34:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so5027544oix.3
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hJ+WAnr3qDao8MYBsDfqaLWNDS1kLW0MM2+MzijAS34=;
        b=isJZy15i54bMnTDWQL8o4+tYWGLegPeBObHYmOrRWZzitHDvKqoZ+Kh4xLi56g66da
         Kmaxtmq6a7VyRoy7CtvGyB2ADWV+PO30rFxE3tgEXvHLUhldAz/DMIgdt2FXbyzDItlc
         Cnw9APuz2/rCVy7PRBggJLhPLKHNUrVroQ1WU4U7mrDigISh19gBZz1q0bKVQV5NPhZe
         C4sfsfLL9Dip8Z2NDd1S72yVUhC4Htoc58sINb4PVmgsKiU60CocA6uqa4nINMV/mLBk
         ZSyjdFtVqBYdMCLjWmfNiMJ6zajou3pgfOwjsHvJ4NZYVuOXgnPxtsyZmRzHyfhwG2sh
         J05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hJ+WAnr3qDao8MYBsDfqaLWNDS1kLW0MM2+MzijAS34=;
        b=he2VeHiv0/FsHzKqDoKCPEOUwjAWlRe22QC8bi5sVjPQ1VugmKCvk/6Uft5mRge14i
         d349jhRKBzgy9BKf3dFPljrXUiyWx2mFozBer0tr7AGjSS+ivhDUYPwfofilFj/WH95r
         cW4BpH+g5E/jmgMlxV6mhXx/vSPDbvhf+Vimozj3YsuCU8Lk+9lVQm+fLSKIIfjNHDIp
         RYAJ8io/Q9tIvx+kXmCeIxA1RpEjEwlkxqaeoS6zFzl6YV885C4uAns4BMkYKg4jftOl
         elmBqFqvptJv9iMknMoOd/pfAs6A4d/KDijyyJpX+KDruADy1ttz5ftj50FmSHbEqBUf
         coOA==
X-Gm-Message-State: AA+aEWZF/FNYFjRgW2/pUhI7J+UVP72wQN8xro2XM3P5cmTalEk9YfZ7
        Oc//Yd9OaLZXZbSs+3PiD/zhQiPdsOax7xEFtl8=
X-Google-Smtp-Source: AFSGD/Vb9xouVRDQRztBVVHeqXPhocOz4TfWehs5N15AmolrIdZdwsf5ogeexBV20b8CuMwrdd7DkMfxEOI4Bjj0x2Y=
X-Received: by 2002:a54:458d:: with SMTP id z13mr2182755oib.277.1544805246515;
 Fri, 14 Dec 2018 08:34:06 -0800 (PST)
MIME-Version: 1.0
References: <CADBHO9E7Bzk9C5ciC416S+5-cS2ANA9d+CzSjKSG+HyxwrU+2w@mail.gmail.com>
 <20181214135818.7ta7y5feumzau4g3@rigel>
In-Reply-To: <20181214135818.7ta7y5feumzau4g3@rigel>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Fri, 14 Dec 2018 11:33:28 -0500
Message-ID: <CAJdN7Khgzjtzkzau4L771cvvT9D8FB4Fa43Vq_opaPxSKkXfuw@mail.gmail.com>
Subject: Re: Bug: `git commit --fixup` with duplicate commit messages
To:     rafa.almas@gmail.com
Cc:     oliverjash@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Dec 2018, Oliver Joseph Ash wrote:

> I believe I have found a bug in `git commit --fixup`.
>
> Steps to reproduce:
> 1. Create a git history with two commits (A and B) with the same
> commit message (e.g. foo)

> 2. Create a new commit using `git commit --fixup {SHA}`, referring to
> the last commit SHA
> 3. Run an interactive rebase
>
> Expected: the fixup commit should appear below the last commit in the tod=
o list.

Perhaps another useful behavior, when the ambiguity exists (i.e. absent
the trailer Rafael suggested), would be to keep the existing behavior
but notify the user, and point to a new section in the docs on the
subject:


pick aaaa foo
fixup dddd fixup! foo
pick bbbb foo
# ambiguous autosquash: dddd may have targeted bbbb instead of aaaa.
pick cccc unrelated

# Rebase 0000..dddd onto 0000 (4 commands)
# This rebase includes one or more ambiguous autosquashes.
# See git help rebase for more information (under AMBIGUOUS AUTOSQUASH)
#
# Commands:
# (etc)

On Fri, Dec 14, 2018 at 9:00 AM Rafael Ascens=C3=A3o <rafa.almas@gmail.com>=
 wrote:
>
> On Fri, Dec 14, 2018 at 12:30:28PM +0000, Oliver Joseph Ash wrote:
> > I believe I have found a bug in `git commit --fixup`.
>
> That's not a bug, it's actually the documented behaviour of rebase
> --autosquash.
>
> As you figured out, the squash/fixup is based on whether the message
> has the squash!/fixup! prefix and the subject matches. But it also
> allows specifying hashes.
>
> So for fixups, you can be explicit and use: git commit -m 'fixup! SHA'.
>
> Similarly for squashes. (But a little less friendly as you'll need to
> deal with passing an argument to -m that contains newlines).
>
> But adding 'squash! SHA' when the editor opens should also work.
>
> I believe the main reason this works based on subject message matching
> is to be more friendly with scenarios where you're sharing series of
> commits that include fixups and squashes. (Either via format patch, or
> by rebasing the series on a newer base without --autosquash).
>
> On such cases the commit you're trying to fixup will have a different
> OID, so any hardcoded OID will be useless while commit message matching
> works most of the time.
>
> One potential improvement to this is to teach --fixup and --squash to
> also add trailers like: "{fixup,squash}: SHA" or "target: SHA" and teach
> --autosquash to respect it when possible.
>
> Thoughts?

I like very much the proposal to use trailers to indicate the intended targ=
et.
"target: SHA" would probably be better. It could be used for a first pass a=
nd
if no match is found (in case of rebase or patch-by-mail) or the trailer is=
 not
present, fall back to the default approach of matching by subject line and
noting other potential matches as described above).
