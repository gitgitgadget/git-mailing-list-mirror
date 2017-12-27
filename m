Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44271F404
	for <e@80x24.org>; Wed, 27 Dec 2017 21:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbdL0V6l (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 16:58:41 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45587 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdL0V6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 16:58:40 -0500
Received: by mail-yw0-f195.google.com with SMTP id y187so7953724ywd.12
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YT5G6DBwnQL8j+QPo2krWS5IPl7oNQ8w1qGNyFjDso0=;
        b=BO5KUM5oFlHYuzPkakbh3+Y6hnpa9ZseZ0JJKvbaWKFyanzSGh/QED9fMxGW9OnwZF
         /fLRqYSjo8uSL3tusf5CYt/ur4EtmYvAkA2PZDtFf6pWAqmhOtlFxcisp0gnPAm8zPA1
         421ALskVmvVHwsMAtS3uRNg8noPEQCJbgHjrZ22Ph4HUokMnBIzXk1ttpVXD8aan39FX
         ksJrRFUugON1msTl8ZqWymbN4Pb8aQvWk4ckAGRaIjmPn3LD/+/yC1Krs+x0sFKZijih
         9JHj2HkLLFilVkBwxvb1sOGboNutl85oQ2HQ9p+RAbPWMiOV5dnv37KTOEos0nUaPI1L
         vDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YT5G6DBwnQL8j+QPo2krWS5IPl7oNQ8w1qGNyFjDso0=;
        b=O7yp+ktSVFZEO6SRxQcb/XWNM0v5HMddoZa9pSZ2KCVI9yT/WIDnENqK/YKyO/Qs16
         J2J1Ku2BTU4tLGgcG1XMW8pn+cHwRBA6pQiP66REI6gDYFUoLiBC1C5tlP6hF1ujGTNB
         djN65UMU1AOW2NcVwgBAGrd5v0oxRLCLjB4DkIdTSLh0EIzJlEtqPF4ZID2j/0wcb5qn
         XsHOIPKPE3xfUEp4elgqEyjRoc9KOePUEhWMZFvdCPqfDky940oJbnvn4FavcIy8nQ5J
         pAdnZxEvvPXpZ7JdSaq/TfgyLEj7BbyENNo4jaKQJO7gPXcRq6h7pKuL4gCnHu7to48w
         uj5A==
X-Gm-Message-State: AKGB3mLDlLzGMxone7WBbmA2qPvD+CBMvfzB81HlaaN9+tbW7LBvSxsh
        lNwSs7bvtl+UakkV+EgekPrJxrJ6YHIgxOw1Cbo=
X-Google-Smtp-Source: ACJfBotL1rl1VnyQ6O7h71n2CaM5CHH+u0rvCZGRr/W0C8iYzggba9TUsHrUQdUJvSIm5pQJTUb/W8EfSa8+oti6LwQ=
X-Received: by 10.129.175.25 with SMTP id n25mr13174983ywh.189.1514411920034;
 Wed, 27 Dec 2017 13:58:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.172.93 with HTTP; Wed, 27 Dec 2017 13:58:19 -0800 (PST)
In-Reply-To: <xmqqmv24m186.fsf@gitster.mtv.corp.google.com>
References: <20171127045514.25647-1-liambeguin@gmail.com> <20171203221721.16462-1-liambeguin@gmail.com>
 <20171203221721.16462-9-liambeguin@gmail.com> <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
 <xmqqmv24m186.fsf@gitster.mtv.corp.google.com>
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Wed, 27 Dec 2017 22:58:19 +0100
Message-ID: <CAKm4OoVMRd-ZkaB9Z8Mxnavfy077=LifJq9OEeg-mvjEGz4K6A@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] rebase -i: learn to abbreviate command names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On 27 December 2017 at 20:15, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Dec 4, 2017 at 5:17 AM, Liam Beguin <liambeguin@gmail.com> wrote=
:
>>> +static const char command_to_char(const enum todo_command command)
>>> +{
>>> +       if (command < TODO_COMMENT && todo_command_info[command].c)
>>> +               return todo_command_info[command].c;
>>> +       return comment_line_char;
>>> +}
>>
>>     CC sequencer.o
>> sequencer.c:798:19: error: type qualifiers ignored on function return
>> type [-Werror=3Dignored-qualifiers]
>>  static const char command_to_char(const enum todo_command command)
>>                    ^
>>
>> Maybe drop the first const.
>
> Thanks.  This topic has been in 'next' for quite some time and I
> wanted to merge it down to 'master' soonish, so I've added the
> following before doing so.

Thanks for taking the time. I had prepared the patch but was waiting to get
home to send it.
Only comment I have, maybe s/sequencer.c/rebase -i/ in the subject line
so it matches with the rest.

Since this came up, would it be a good thing to add -Wignored-qualifiers
to the DEVELOPER flags?

>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Wed, 27 Dec 2017 11:12:45 -0800
> Subject: [PATCH] sequencer.c: drop 'const' from function return type
>
> With -Werror=3Dignored-qualifiers, a function that claims to return
> "const char" gets this error:
>
>     CC sequencer.o
> sequencer.c:798:19: error: type qualifiers ignored on function return
> type [-Werror=3Dignored-qualifiers]
>  static const char command_to_char(const enum todo_command command)
>                    ^
>
> Reported-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 115085d39c..2a407cbe54 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -795,7 +795,7 @@ static const char *command_to_string(const enum todo_=
command command)
>         die("Unknown command: %d", command);
>  }
>
> -static const char command_to_char(const enum todo_command command)
> +static char command_to_char(const enum todo_command command)
>  {
>         if (command < TODO_COMMENT && todo_command_info[command].c)
>                 return todo_command_info[command].c;
> --
> 2.15.1-597-g62d91a8972
>

Thanks,
Liam
