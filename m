Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2031720899
	for <e@80x24.org>; Sat,  5 Aug 2017 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdHESDM (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 14:03:12 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35303 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdHESDL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 14:03:11 -0400
Received: by mail-io0-f175.google.com with SMTP id m88so14960064iod.2
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OfhiihHdbPSzEUjqleuUwSm8+GRO1YqzhFi3Xl1N8xI=;
        b=dqQJLEkgxnGzOzfomoIO0+O9Q7B4pcPqHqR+CntQtWhDtQ6iljl3rj+C7kR5F1GdRQ
         KiX0/j+jewRw4uCES/QOS0xLAhgihLacJfYcEb1cpUIn8Ep0gknecCoLak+gY4I+3/uQ
         q/KRbVspATJtoQvkTcgthqoI6KuYO0mkZcoe5skAybbtoNFeNfab6keqCYtyNsYpdUL7
         +Yfgr/df0jLEaSkl/wS8puf5b92pRiN2ScCOb7HGw+G9m6W9IEYPsPOp3U/MNUSH2NIb
         sFUQ7z/Je5hN1eWLkQ5ECM3ePdYFixuY9ZF/5ccur3eMh8hWNIgRwRyyQIBo2SFPNI6G
         TvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OfhiihHdbPSzEUjqleuUwSm8+GRO1YqzhFi3Xl1N8xI=;
        b=aFQ8a+LuBEVXP1WiLZ0qU99IZtH4PhEMjtPrTQqoT7FCty2oLqbq+NbMvj845Sv5Ql
         yuGIYIzXd3mH98aFQQzYVohizh4IYwApARtKBNhUC9+bG7vTKfdox6/ybfjiRjrN4jC2
         hKkao5u7Dr/0YNGmGX3kHSr+PL/EOnVVGQvdpSfT9dTqNYhDn12b0wWYmuzDR+DGqqY5
         OoBqueKcKp3GvcLBr4lBj8eFgBlmI3K9fE89oiL6TB+MrFWKU9nJh01WK2X8t8GqvB1X
         77N5CZh1kbpvGE4IhYY1nHROfJjcUe/OqI3vIEoPTXYHrs+afyPdI8yqJkG2m7lp3XRe
         On4w==
X-Gm-Message-State: AHYfb5jpAAjQActaCjUNlK5I7beTc6NnmQ53I9A/xEO2FyIPXLUU48wB
        CqA7CAxUbExthvXaEI5QsPpJT1ojdA==
X-Received: by 10.107.20.16 with SMTP id 16mr6349210iou.226.1501956190510;
 Sat, 05 Aug 2017 11:03:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Sat, 5 Aug 2017 11:03:09 -0700 (PDT)
In-Reply-To: <CAP8UFD2oqdaQqVwuGqqj9OOnm5Pyufpck=rod0UFQEWrROJsXQ@mail.gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-9-pc44800@gmail.com>
 <CAP8UFD3_zX0=h9tuNA-w+30V4P8zZGyUCEnpciTkwRWpXjjmNg@mail.gmail.com>
 <CAME+mvUAspzuzbB4pFiQeOtT7NGRTO25M-k8o8hoysMFLGy_0w@mail.gmail.com> <CAP8UFD2oqdaQqVwuGqqj9OOnm5Pyufpck=rod0UFQEWrROJsXQ@mail.gmail.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Sat, 5 Aug 2017 23:33:09 +0530
Message-ID: <CAME+mvXGK2zeCHgayS8=ti75CBY6Vp7Qkq+mgvWStQ+vEyLtPg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 5, 2017 at 10:25 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Aug 5, 2017 at 12:28 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>> On Tue, Aug 1, 2017 at 4:57 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> On Mon, Jul 31, 2017 at 10:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
>>>
>> We can avoid it to behave same for "" and NULL, by checking if diff_cmd
>> is "cmd_diff_files", since its value is set NULL by this case.
>>
>> ret = compute_summary_module_list(strcmp(diff_cmd, "diff-files") ?
>> NULL: sb.buf, &info);
>> strbuf_release(&sb);
>
> It looks error prone, more fagile and less efficient to me.

I think by using enum { DIFF_INDEX, DIFF_FILES },
we can avoid using strcmp() here, and make it more efficient
not only here but also in other parts of the code, since
all such steps involving strcmp could be removed.

Thanks,
Prathamesh Chavan
