Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1147C1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbeBLVtY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:49:24 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:43538 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeBLVtX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:49:23 -0500
Received: by mail-qk0-f173.google.com with SMTP id i184so9092931qkf.10
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 13:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Tqtchx8g4AvhyQbf8VB6UyJoC6rRkVI/HnDLimbNHsM=;
        b=Asulv7Vh4KZ/b3Gui8u4OKIDXJ6HHV4TfPoj2lYevhnqduNWmGCR04Dgw8VnSwP+D/
         RZ6SYP+w+OTa38cbcBcCRg6k5fnHGsP5929i6vwbFrCEgm/J62fbY1qN8HqBeEwJGeY+
         AE8Pci6bHe8AhNHlUKY9xPyjjtaZgQPz5qcnzV9EkdZf3WikWc5WwudgwaNEPiJeJiyt
         W8zL9tpydu8Cmj/uT0Xb4CiZRw/nNmGQQl8gW+8vWLxf3Z9PL+Mm3LYYovWBsZM5Is0S
         +TJgO19/8RwMhLpMDWmRW4bH8jO2Lrg/rfutlteyvsXse3jsn7AqOFKwiKAJQ5OPeIDU
         edgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Tqtchx8g4AvhyQbf8VB6UyJoC6rRkVI/HnDLimbNHsM=;
        b=aam3aEiA8ivSl6oYmMUAn2bCuAuIZ9CxWSUlJDmIGNDihjJcfSzOvn/+0+Q6f5RgYF
         dnwwv6hhA/S3cgm2FE2MxycxP6o4KDwKSO+FodwCj9u/H3Pq51dg+kz3AL6YqQ1GtYi/
         vN2QGeZ2DXADEBDyUSeGrJh4PcdX3Evw36OMMNLtAaHsBOSJ90KC05+6okfcM1JEJaGY
         1JcT/8bR/pSEx8sHNKe0tC6uMb36P9w056erU94m2BQnO0moh5bs3Mw67rqJLz8ehtDb
         tGIrJP3kQQUnAtenbwRK6+lRzseLvWXNl/qPRv4U8qLO+N0amPD7WcEYt24Y7KP3sUGG
         Ewvg==
X-Gm-Message-State: APf1xPDq+SndlEBpbqIdui4tabHm4vGlf+WWNaI//Y0jd7e5Px+76nQc
        pgXe6xRJD1Jaxw53bk435Fg5ElD2Qq/Cs9P2U08=
X-Google-Smtp-Source: AH8x226sXFaPQjTQR0qDPeqG3BEAvKp/eJjRxCr5LatapIsy8K/cN+Jtv3udFlT401J8no3Wu/UHC6LlIsxDJ5EbMIQ=
X-Received: by 10.55.183.70 with SMTP id h67mr19449688qkf.331.1518472162482;
 Mon, 12 Feb 2018 13:49:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 13:49:21 -0800 (PST)
In-Reply-To: <42C41062-D27D-4BB8-8D8D-9272D37FAE88@gmail.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com> <20180212031526.40039-2-sunshine@sunshineco.com>
 <42C41062-D27D-4BB8-8D8D-9272D37FAE88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 16:49:21 -0500
X-Google-Sender-Auth: rtEDpjZqNxLEsAA7YHRs12GJLEY
Message-ID: <CAPig+cSbtATV8daCsDxXTfGPgGh-qrvoVzfBSB+WP3EuiDXNxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] run-command: teach 'run_hook' about alternate worktrees
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 3:58 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On 12 Feb 2018, at 04:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +int run_hook_ve(const char *const *env, const char *name, va_list args)
>> +{
>> +     return run_hook_cd_ve(NULL, env, name, args);
>> +}
>
> I think we have only one more user for this function:
>         builtin/commit.c:       ret = run_hook_ve(hook_env.argv,name, args);
>
> Would it be an option to just use the new function signature
> everywhere and remove the wrapper? Or do we value the old interface?

I did note that there was only one existing caller and considered
simply modifying run_hook_ve()'s signature to accept the new 'dir'
argument. I don't feel strongly one way or the other.

However, as mentioned elsewhere[1], I'm still not convinced that this
one-off case of needing to chdir() warrants adding these overloads to
'run-command' at all, so I'm strongly considering (and was considering
even for v1) instead just running this hook manually in
builtin/worktree.c.

[1]: https://public-inbox.org/git/CAPig+cQ6Tq3J=bS8ymDqiXqUvoUiP59T=FGZgMw2FOAx0vyo=Q@mail.gmail.com/
