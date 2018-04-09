Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1F11F404
	for <e@80x24.org>; Mon,  9 Apr 2018 05:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeDIFRw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 01:17:52 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:42907 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDIFRv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 01:17:51 -0400
Received: by mail-qk0-f179.google.com with SMTP id b198so7991218qkg.9
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FGeOQyZdzO5JYfDwtOtLV70EHUPeL4S4pOIOKASQx6g=;
        b=LQtUf5HitEhMNRdpGvMRnVm841lm7VQwUnDbQmseT5zUs1+ZJY3IQAcafh6TsX+Wys
         rDKYM3CsDGVOeEYttQG/2FbiMkxsyCSrf4SflzUScmzxueq+XMufyBG27kla2wFt+AGJ
         vh7kGk1lEFAK16AXsxHTg8/uZjkceAhK/PjpQCkoBrBoO818GZ7tmUE4/ahnddyrgwqx
         3iJpPrAsG6x9yIWYh/PLfvkuBU6+rFW0deHUQJ168jGJW0eKASG/kG+ZNBjYqOZ/GnRf
         HbNEBzubkcoosTPjAyLu1EmRE1dpMtTFsiCL2n1+/Mgqca/BxH5t2ty9k8hEnFqC5CB7
         O1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FGeOQyZdzO5JYfDwtOtLV70EHUPeL4S4pOIOKASQx6g=;
        b=CQgY1ubqSlqThjdY6jls58eEjAggRP2YxvbcBcdsfayhKghma7h5rnl8knbHnvunWW
         VbSixclPymYNRfAGO5aDB+02ReO/FXv4m9URjL/FUtN1zARwO2+Fsvb0fzUesVvSXH/O
         zrEA1WKgEVM6aeZASpQZys9cL4TGHIlAwPm5189VJetT6eQoAsJ7c/aj31Sd1mcqCf25
         KTAr7o6CimaRfKQ9oN25ksszipmq3q7GMPLVDqYbhauNgSdVsbiYMuo6cEJZ50L2aITB
         aeLTCvdTtyak6zZeSHH56YjSur3pEBC9WpKIK36QiqUyOamFndSpz0PtiILx2q8cTJI2
         vwlw==
X-Gm-Message-State: ALQs6tCtI972rt6Xnu3TZNnthR2ExubrDidEmSZgG4Uujvfed+xqXbjj
        quacZGIhtd/2skCn8nPM0Y13y88YuL1wInY7bZs=
X-Google-Smtp-Source: AIpwx48EcmmburWwVqnddrSc33vJtgyBoyNLaQcNQuVTqJ9To8+3x8i+YDydri7lyJ1thJyspk9PNCzl4UwqLyMzHEo=
X-Received: by 10.55.22.28 with SMTP id g28mr47619215qkh.152.1523251070934;
 Sun, 08 Apr 2018 22:17:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 22:17:50 -0700 (PDT)
In-Reply-To: <20180326165520.802-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 01:17:50 -0400
X-Google-Sender-Auth: 8hIrMSssLF9u3HotEfCPSl5be_U
Message-ID: <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 12:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> This is pretty rough but I'd like to see how people feel about this
> first.
>
> I notice we have two places for command classification. One in
> command-list.txt, one in __git_list_porcelain_commands() in
> git-completion.bash. People who are following nd/parseopt-completion
> probably know that I'm try to reduce duplication in this script as
> much as possible, this is another step towards that.
>
> By keeping all information of command-list.txt in git binary, we could
> provide the porcelain list to git-completion.bash via "git
> --list-cmds=3Dporcelain", so we don't neeed a separate command
> classification in git-completion.bash anymore.

I like the direction this series is taking.

> Because we have all command synopsis as a side effect, we could
> now support "git help -a --verbose" which prints something like "git
> help", a command name and a description, but we could do it for _all_
> recognized commands. This could help people look for a command even if
> we don't provide "git appropos".

Nice idea, and you practically get this for free (aside from the the
obvious new code) since generate-cmdlist.sh already plucks the summary
for each command directly from Documentation/git-*.txt.
