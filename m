Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD6B20220
	for <e@80x24.org>; Tue,  2 Aug 2016 22:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcHBWJB (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:09:01 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36591 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557AbcHBWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 18:08:55 -0400
Received: by mail-it0-f44.google.com with SMTP id f6so282831151ith.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 15:08:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dPkjbeHOv8QYwkTG4NHJVT/sZW8lXDKhR4norBqshFk=;
        b=Gf1zkOt4s6VM0QfGJS8+SntjdP6OyrRd1bOLqcv5KuSd3UxI3wLXdc9pCnVSB4D+xP
         2lcSXG/l40gwsKPMMGMAlH6F4BTYN/dv3TGTTiU84W16RQB0jhqEW6hiZnK8WtCjgamD
         bGoS7anFDOSuL2iWJlTB3DizuACKByheGrz3SMg94gQtH2WUiR4+6Vv6kOqyWDKSMzL2
         qtT12lRqdfKOu3gI+nSKONE1Ns+omEG3kRjvIM9mnwJOtbYkOyE00QuZvNDtjBN8bM4U
         fMF+Yi8XHk5E6RsShYlJWpbNQO0f5qFot8NLsli2d62JvrP3pMy0aO1EhuydCpddRceq
         xxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dPkjbeHOv8QYwkTG4NHJVT/sZW8lXDKhR4norBqshFk=;
        b=Xl76qlp1HDAYnqIjAFhpKAUaW0L7ygoLcsa6iM6m96QjsHnuRzbFxaQTNUNPG/m39H
         KVwc2X5gU6b/FKddm5/E4J5PiVztdkKBqyhlSx+6e+tHYkhfnb489sNnmPGzah98GiXR
         F+JG+yv7BpDh/QiEXJyIrQwiOpB+ohtRrkW2uUgE4XavUInH0l5q/hpIocIh8FLwCRWw
         Bi3Nuj/gychE6oYsPz/GwSXrWth8aEMSlQQmXe9HmkOhxznXzw+BqiS/UJV+AssfNa4X
         qbXzuTuSG0RyYHYqkzL81su9M54nqsn24EF5bSOF5IdlINow8TmHgySftFbqUIGcRRfE
         rY4g==
X-Gm-Message-State: AEkoousZni0WBYnXL/Gf39IUmu/eRNdqjvTSqCWPpBEOsuFaOHko+KaZx0mM0KiF1XZvGttgRNxSHJKWQ/dKzNi6
X-Received: by 10.36.217.12 with SMTP id p12mr68518697itg.46.1470175320815;
 Tue, 02 Aug 2016 15:02:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 2 Aug 2016 15:02:00 -0700 (PDT)
In-Reply-To: <xmqqtwf2c0aw.fsf@gitster.mtv.corp.google.com>
References: <20160802182152.20637-1-sbeller@google.com> <xmqqtwf2c0aw.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 2 Aug 2016 15:02:00 -0700
Message-ID: <CAGZ79kYChcixXtOc2HigHCY7S5bteO1QZau+4cqQYbxtHW3wDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule documentation: add options to the subcommand
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 2, 2016 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When reading up on a subcommand of `gi submodule`, it is convenient
>
> s/gi /git /;

will fix.

And in the neighboring thread you just pointed out you used to just correct
spelling fixes like this. I think it really depends on the workflow of the
contributor. As I do the interdiff of the next version of the series against
your tree I'll be likely to notice such typos in the content, but not in
commit messages.

>
>> to have its options nearby and not just at the top of the man page.
>> Add the options to each subcommand.
>>
>> While at it, also document the `--checkout` option for `update`.
>
> I do find the resulting per-subcommand description easier to read
> with this change.
>
> Perhaps we want to go one step further and change the SYNOPSIS so
> that per-subcommand options are not described there at all?
> I.e.e.g.
>
> -    'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]...
> +    'git submodule' [--quiet] update [<option>...]

will do.

My original intention was to get rid of the duplicates in the OPTIONS
section, where each option has

    This option is only valid for <subcommand> and <subcommand>

in its description. So I looked at the `stash` man page, which has
the options listed with the subcommands (and also has [<options>]
in the SYNOPSIS but also some of the options as well).

I think only the long option lists (i.e. those that are more than one line)
will be collapsed. The short options are ok, specifically when you just
want to know e.g. if foreach supports the recursive option. Then you
can open the man page and have no need to scroll down to the foreach
command.

Thanks,
Stefan
