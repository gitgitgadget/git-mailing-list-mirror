Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0840220248
	for <e@80x24.org>; Sun,  7 Apr 2019 20:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDGUFM (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 16:05:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40437 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGUFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 16:05:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so9777804edw.7
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=udEtgTuRPPKvzyxaYGIOMEqdWI05YjkQsjOCyPo8vsg=;
        b=Helr4+2IKVSSIJuF/aagvLcRHQEfrnieWQ3wWPW7zEP6L0FFg6uzZCq+ecgtkhuN4L
         zPNIQlMDFngLE53WwUyk19h5PVdENL5uEqlXKU+5T86sPr2zy2s8N+FAZx7bm2bB4S9F
         gukZNDCp0oj83nLQRpiD2+UpHsHEz32T50RTf7/zC20pjy78OywEEnEH+rgS4356YSdY
         6FUZDJam3UZW0PIGn0ObBnOgZ45FmttxLtXVqFXXMc2RQuGyo047vtKxqcXtrqXuzTOo
         cx+Qy7ooYKHvYBNcG1mYdJ+xVjiDi9YBhFT4F+U+oZnryEizFvcFalNTg9BloKhtdpZj
         U1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=udEtgTuRPPKvzyxaYGIOMEqdWI05YjkQsjOCyPo8vsg=;
        b=Spd/AJBDxr2uai3HjAWOrbSavn95dfZTVZANUD4NogPW3mRzzXWPpNfDZWmpc8EA31
         Ma85DHEq5aVUbqUlysCKOcOAHy9uW3T7whsrKzaFgfV266k3kByVPSP+RAvhf7aanv1e
         3I6hShNLVhbJvP2wNaCmSwKRugaBRPhKkpNJ+shU4NseV/yby86UBHoYc7mdyWowsQGK
         ZGqav6AMal7tEkkNwj4WiaPlU1kcL6tt+ov1gRq4pph2KPcQTZLgMKw0eF6rj9QhqUfR
         v/gPsYQf9h8xIgKVIgQRKTcSIdukRt/XweYnoBLH45PeLKSoQSSmYtQrXnioisXIap8P
         S1Lw==
X-Gm-Message-State: APjAAAXPdR55Gkzd2nQJ+s/sYbW20T/eDX3gXyQ1Fjw9Z8GQgeUm5roG
        5WoCuWPCcHqMxYNgjT7vf00=
X-Google-Smtp-Source: APXvYqyA7VFLRJVcUlNuO8Ar5sbHoLUN/JCo4W8fMtsjTbBaglGYmUsmPOkQXuX5SHNSEAv0QR9hJg==
X-Received: by 2002:a50:b4e2:: with SMTP id x31mr16048089edd.210.1554667509596;
        Sun, 07 Apr 2019 13:05:09 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e14sm8309928ede.89.2019.04.07.13.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 13:05:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] describe doc: remove '7-char' abbreviation reference
References: <20190406132747.16376-1-philipoakley@iee.org> <20190406132747.16376-3-philipoakley@iee.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190406132747.16376-3-philipoakley@iee.org>
Date:   Sun, 07 Apr 2019 22:05:07 +0200
Message-ID: <87bm1ha8ek.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 06 2019, Philip Oakley wrote:

> While the minimum is 7-char, the unambiguous length can be longer.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> noticed while looking int the Git-for-Windows patch thicket -
> was looking for the ~n^m style!
> ---
>  Documentation/git-describe.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
> index ccdc5f83d6..a88f6ae2c6 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -139,7 +139,7 @@ at the end.
>
>  The number of additional commits is the number
>  of commits which would be displayed by "git log v1.0.4..parent".
> -The hash suffix is "-g" + 7-char abbreviation for the tip commit
> +The hash suffix is "-g" + unambiguous abbreviation for the tip commit
>  of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
>  The "g" prefix stands for "git" and is used to allow describing the version of
>  a software depending on the SCM the software is managed with. This is useful

Both the old/new version are subtly wrong. Whether the new one is better
is another matter.

First, there's more places we mention the now-incorrect 7 characters, at
least these (one of which you're fixing). Found by grepping for ' 7 '
and '7.*abbr':

    Documentation/git-branch.txt-181---abbrev=<length>::
    Documentation/git-branch.txt-182-       Alter the sha1's minimum display length in the output listing.
    Documentation/git-branch.txt:183:       The default value is 7 and can be overridden by the `core.abbrev`
    Documentation/git-branch.txt-184-       config option.
    Documentation/git-describe.txt-65---abbrev=<n>::
    Documentation/git-describe.txt:66:      Instead of using the default 7 hexadecimal digits as the
    Documentation/git-describe.txt-67-      abbreviated object name, use <n> digits, or as many digits
    Documentation/git-ls-tree.txt-93-Object size identified by <object> is given in bytes, and right-justified
    Documentation/git-ls-tree.txt:94:with minimum width of 7 characters.  Object size is given only for blobs
    Documentation/git-ls-tree.txt-95-(file) entries; for other entries `-` character is used in place of size.
    Documentation/gittutorial-2.txt-44-
    Documentation/gittutorial-2.txt:45:What are the 7 digits of hex that Git responded to the commit with?
    Documentation/gittutorial-2.txt-46-
    [...]
    Documentation/gittutorial-2.txt-52-name), and that the contents of a Git object will never change (since
    Documentation/gittutorial-2.txt:53:that would change the object's name as well). The 7 char hex strings
    Documentation/gittutorial-2.txt-54-here are simply the abbreviation of such 40 character long strings.

It was never correct that we'd pick 7 characters, we'd *try* that before
e6c587c733 ("abbrev: auto size the default abbreviation", 2016-09-30)
but would pick a longer one if it was unambiguous.

Whereas "unambiguous abbreviation" isn't correct either, and arguably
less correct. At least 7 is what we *still* pick as a fallback in lieu
of the auto-sizing, but just "unambiguous abbreviation" implies that in
a repo with some 10 objects we might show just one character, or that
we'd post-e6c587c733 pick say 7 characters in a repository where it *is*
unambiguous but where we've auto-sized to 12.

I've been meaning to follow-up on
https://public-inbox.org/git/20190204161217.20047-1-avarab@gmail.com/
where I among other things wanted to just have these instances all say
"commits will be abbreviated as described in XYZ in linkgit:<something>"
and summarize what happens there.

I don't mind if this goes in, I mainly wrote this E-Mail as a brain dump
since it jolted my memory on the topic, and so that I could dig it up
later & see how I intended to follow-up on those #leftoverbits
