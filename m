Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADAA41FAE2
	for <e@80x24.org>; Mon,  5 Feb 2018 21:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeBEV0Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:26:16 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46502 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeBEV0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:26:14 -0500
Received: by mail-ua0-f194.google.com with SMTP id j23so19634382uak.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YKBVG6zeW7Ii/cSJAA/r7BgMLkmff1DZkEzFF0aJWyg=;
        b=tGSYaCs4Vy1KwLKaOgpTNYYBVgvAa9EHz9/f4JeI3mIM36L/Lc5fhHtwfiyVwncga4
         cqIB5Yey6Co8GcXIIeynTAZ7rWejYIzzWT0DnoFEH1qHY3QrB0rEP2ZB2iiJH70Qjnh9
         2yaw4HLul9qvlA2iK1KQhNyMy5F7boL5tsJcVl2GMYtM5AYVHv6D2hvYdxmKsmjw6/So
         5LgVzkgCxjysHa11tiB7XpqJhWdo8rnhEMT2uXCnC9O16PqVNb8mDRG5KsCT9UDQB8o8
         uxb+bCqyoy5NfeyZ/cgNF7I1IFg7y6OTcHZTsNJzCCG5mK1BtVkTzBUS8hy9G6cdtAFy
         +BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YKBVG6zeW7Ii/cSJAA/r7BgMLkmff1DZkEzFF0aJWyg=;
        b=RlVicC81C5raiaEIQ7VkwsT1OGeNG+oPGgJWxooeqwnUfPG+vpWdjVrRQopd3IhfoG
         UA67uwHnVFEERTf5G76/t65j9gmIYnCdr5xX1p4RoTPC5gJRblOdU5T0NWLWqloOxQNQ
         8hFcQW8hSlo/K0+RgoZZ6i+q7DKbmKEPffJ6huMmolkc+SvNq5MhoIzxx/js+35K3CC1
         GrLsbUTJB+B5dnKCbg+G5yHn67drA7AJi1VLgPUTu+4z4KJCZsnXxTF2OtCwSXwSkFCr
         6wrTvZuQfDGlxXGYUz34zwUV3+oCC8UwO3gdfMeFIHIEa/Bl5IQbETgKrpUL/FZ4YKsy
         dnYA==
X-Gm-Message-State: APf1xPB1brNh3IQ5w3tYnrmk1maMc8kbR5QSG6t6aX/2X/khdGfUGDo7
        9Ox+a9bwYXTaOR5b7E62l4hJHSGjAiKgYj/wibg=
X-Google-Smtp-Source: AH8x226haYDCR9FpZDnE4lz08BQK9N1uyZm0EdhqMD/2rdkij+ZEr1wTXN58b49VZq7yxDOnVU3neIXXRcqjcmZUyt8=
X-Received: by 10.159.38.33 with SMTP id 30mr215295uag.9.1517865973719; Mon,
 05 Feb 2018 13:26:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Mon, 5 Feb 2018 13:26:13 -0800 (PST)
In-Reply-To: <CAGZ79kYsYkKVgF-Bwe3HNFraaYC0DWruXE92E4x8b0oJd_Bg6w@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-28-newren@gmail.com>
 <CAGZ79kYsYkKVgF-Bwe3HNFraaYC0DWruXE92E4x8b0oJd_Bg6w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 5 Feb 2018 13:26:13 -0800
Message-ID: <CABPp-BH=09HtTO11G6a6gjGS35oBCjzO55+pR3KN3XuXedre_Q@mail.gmail.com>
Subject: Re: [PATCH v7 27/31] merge-recursive: fix overwriting dirty files
 involved in renames
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 12:52 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
>> This fixes an issue that existed before my directory rename detection
>> patches that affects both normal renames and renames implied by
>> directory rename detection.  Additional codepaths that only affect
>> overwriting of directy files that are involved in directory rename

Ugh, "dirty" not "directy".  I must have gotten my fingers trained to
type "directory" too much.  I'll fix that up.

>> detection will be added in a subsequent commit.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>
> So this fixes bugs in the current rename detection with
> overwriting untracked files? Then this is an additional
> selling point of this series, maybe worth covering in the
> cover letter!

Yes, with a nitpick: the existing issue it fixes is with dirty files
(by which I mean uncommitted changes to tracked files) involved in
renames rather than being an issue with untracked files.

I did mention this fix in my original cover letter[1], but it would
have been really easy to miss because it was a really long cover
letter, and the mention came at the very end.  Quoting from it:

"""
These last three deal with untracked and dirty file overwriting
headaches.  The middle patch in particular, isn't just a fix for
directory rename detection but fixes a bug in current versions of git
in overwriting dirty files that are involved in a rename.  That patch
could be backported and submitted independent of this series, but the
final patch depends heavily on it.
"""

[1] https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
