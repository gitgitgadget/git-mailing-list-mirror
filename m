Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4D582021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965985AbcKKJMY (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:12:24 -0500
Received: from mail-yb0-f177.google.com ([209.85.213.177]:34198 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965735AbcKKJMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:12:19 -0500
Received: by mail-yb0-f177.google.com with SMTP id d59so3330327ybi.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RZVXSF+jDc4xGnIeyvVi6G50AshLv3skzdPqZvSVIvc=;
        b=Yhd3Jz0d6YquwdGopIC5WPRoeqSvvqG0BvBmosV75a8T7VBjAfgZzKZqN84wds1TWL
         O0alGQjsnY9qp6L7GjKOVpAteKaVrBgoJTdTqGMZn2DzDJ5sRdy/cY9VU5OJn8upvu8J
         92FuuYI3zJ4xBCwge2udkJdSOSq1rZavE5LVFE1ptphPom8eEJAofo6n32XDWZSBCY/X
         IOjqsHqzCplz3H2K5L188d5p/9esPBykR7u2bRtWhpb/k6J4HhaR/JvpXarNDq9bFP5B
         AiGEZgmXx0cntlXPziz//hfheg/5FFNw5hajXrBWmPbB2DbQwHqsS1P07HUiUPGkE6M4
         Cltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RZVXSF+jDc4xGnIeyvVi6G50AshLv3skzdPqZvSVIvc=;
        b=ejiduhGwJCMsc239W2y0BOP0VRgI8yHVYD+cMKFJyqROshAAx0v5WaJSz4JR632/7R
         oB/Cd1PP/SN2bPySaeetUYD+Jzoj8jz16zTHj5KIbbsuVY7spn885zbIs2S+peWSLD6z
         WKkXlRSzp1WGTTfmHLLv4zel6tAqAdmGLaaht+e076/+Yh0TpxuEOHJhV4NaTPkcr4aq
         OBdsatpEMysBvfRDZJNval/gpLoBRwpkIzCYQ7wNTPM4H07eBdPOZ9IrT2et3VMKRHQ+
         73kRrAPpmTQTOJaId/to77zgDubDsDysrbf9Ei2CqSEOUkXI8XiCxxxkVbH5CZRyUuCf
         Jlxg==
X-Gm-Message-State: ABUngvegiW0IaWnAHY+cvof5vDdVM/skxxMZqBmnMrwHC6I0xUp/jv5QyaZwbm/RorIZcihj0Sll47m54IuGcA==
X-Received: by 10.37.221.194 with SMTP id u185mr1612086ybg.61.1478855538463;
 Fri, 11 Nov 2016 01:12:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.113.66 with HTTP; Fri, 11 Nov 2016 01:12:17 -0800 (PST)
In-Reply-To: <20161111083649.d5newszupwyq5j6w@sigill.intra.peff.net>
References: <CACNr1V_fRfqvHUN=AQC8-Dj7ZAE7KXRAt+5skL3ZrcKu7SCLgA@mail.gmail.com>
 <20161111083649.d5newszupwyq5j6w@sigill.intra.peff.net>
From:   Qi Nark <narcotics726@gmail.com>
Date:   Fri, 11 Nov 2016 17:12:17 +0800
Message-ID: <CACNr1V_BE_m32sw1D4WnRjRfPHEdKa0mb1jcv6BG0VPATtyPFQ@mail.gmail.com>
Subject: Re: [credential.helper] unexpectedly save credential to multiple
 credential files
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 4:36 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 11, 2016 at 04:10:55PM +0800, Qi Nark wrote:
>
>> 1. git config --global credential.helper store
>> 2. cd to a local repository directory, git config credential.helper
>> store --file ./my_cred
>> 3. execute some git command which need credential like git ls-remote
>> 4. input my username & password, command done.
>>
>> As the result, **BOTH** the ./my_cred and ~/.git-credentials will save
>> the credentials I just input. But, shouldn't the local config override
>> the global ones, and only the ./my_cred should save it?
>
> No, that's the expected result. The set of credential helpers form a
> list, and each is run in turn. From "git help credentials":
>
>   If there are multiple instances of the credential.helper configuration
>   variable, each helper will be tried in turn, and may provide a
>   username, password, or nothing. Once Git has acquired both a username
>   and a password, no more helpers will be tried.
>
> That's talking about lookup, but the same principle applies to storage.
> But you may also find the paragraph below helpful:
>
>   If credential.helper is configured to the empty string, this resets
>   the helper list to empty (so you may override a helper set by a
>   lower-priority config file by configuring the empty-string helper,
>   followed by whatever set of helpers you would like).
>
> Note that the "reset" behavior was introduced in git v2.9.0, so you'll
> need at least that version.
>
> -Peff


Ok, that's fair enough. Thanks for your detailed explanation. The
version info is very important to me.

Thank you again.
