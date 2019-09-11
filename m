Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C4C1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 06:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfIKGvl (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 02:51:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42525 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfIKGvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 02:51:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id c195so650457lfg.9
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9y+tlY8DBQXqD9HEUU9DX80uJAbIk+qANPCg+AD58HY=;
        b=vgJxocDSvFxV0Z3fXHaXAw0G+cgRFHwCEW7bIi33gDcPCJzUqUjCSmDVUViDBY5i0o
         6tv1A+28g7JsH10bdpL83r2JDXOjbE8u8e3g05Ltzzh0oHSBfz/+h/pBGsBIRFPIPVmc
         MUc7r6pXBfDraABjTS0nw7OcTcLnGRt67XEn3pmW7EtI+aCLXbTJ7AnsGKt2SyIuw+S2
         hcPtuPT22uj3Khk16p3P+TCg2o3y1SK43n4D7dFprl+CCHLVfxed3Yqk0wk2Nh25W7zd
         hpW4PWbcsfQTvIAzhmGJRN/PW4+QyhUp/KH6wuW9TyI1CvOZEFAersy+u/z6G4osUX+7
         I08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9y+tlY8DBQXqD9HEUU9DX80uJAbIk+qANPCg+AD58HY=;
        b=ghLJgfBubfZ3KvUmNkaU+BlmK9D9njrb+PNqQ+BsRWG1uXFk28D9vBZXkTyBj+BJX5
         Ug/kyLPV9XWyyYGyFL4EYlz1nAudX6zA3gFNudqTQkgvGMZfuzUSBzWyAhXRdhJ76k2u
         jYehBGm+YvUzMeUOHDoBPnH7kBHs7jRtfj96JLNH595jwky2jU4hf6QlqYS4UMX79ofZ
         u0tOFKf5OgyVgZ2y58jobMUyQ5TV6aYV3zUxUoVPuG+xFcjqhAC8rutPAWKVRdb2bWPE
         ggGcDBI2LMT6H2iufH6Ykm4EMbMIK27lLP6jZRFhbVXxpdEpJ18DXmS+ZfHUDtKckYVZ
         PouQ==
X-Gm-Message-State: APjAAAXXMQyiJa6cFIoeAX3npM7g1BmgXU0S3aa9VlqDvvdOes/GQpaq
        FpVWfaa7V0yK/7Pg+LJJT/tJR4n7mMdBqk9knt0=
X-Google-Smtp-Source: APXvYqzEuHcikiTkggHBeCE3Oxklb0XrN4gkpNIrwJ2cgt2hYIJnOjP40VnmB1WRwly96znhSg7QIhMm//SDnECgtLE=
X-Received: by 2002:ac2:43b8:: with SMTP id t24mr4024969lfl.24.1568184699155;
 Tue, 10 Sep 2019 23:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com> <20190910191217.qgb23x5tvaajppfh@yadavpratyush.com>
In-Reply-To: <20190910191217.qgb23x5tvaajppfh@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 11 Sep 2019 08:49:08 +0200
Message-ID: <CAGr--=+9t1m-8LdVnnhkUFS0LMss0WecUjjtR=s_b98qB9qKeA@mail.gmail.com>
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        davvid@gmail.com, Bert Wesarg <bert.wesarg@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Tue, Sep 10, 2019 at 9:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> This patch LGTM, but I'm not sure how to resolve the keybindings
> problem. Junio suggested we have configurable keybindings, and I agree
> with him, but until we do, something has to be agreed upon. And we also
> need to come up with a reasonable default.
>
> So, I don't have any preferences for either using Alt+3 for the commit
> message buffer, or Alt+4. Unless someone has objections, I'll go with
> Alt+3 for the commit message buffer, and Alt+4 for the diff.

I honestly don't quite follow the argumentation to use Alt+3 for the
commit message widget. Is Alt+4 (really) too awkward? And if it is,
how is Alt+3 better?
If you want to see it merged now (which I do, too), I propose we leave
it at Alt+3 for the diff, and Alt+4 for the commit message buffer.

As David A. mentioned in his email[1], git-cola utilizes CTRL+J/K/L
for navigation, maybe we should consider(?):
Alt+i: focus unstaged
Alt+j: focus staged
Alt+k: focus commit widget
Alt+l: focus diff view

[1] https://public-inbox.org/git/20190910085446.GB32239@gmail.com/#t

Best regards,
Birger
