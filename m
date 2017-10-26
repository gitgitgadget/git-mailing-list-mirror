Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4001FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 08:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbdJZIos (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 04:44:48 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:47379 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdJZInS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 04:43:18 -0400
Received: by mail-wm0-f45.google.com with SMTP id r196so6385408wmf.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fFCZgsLY1FTIhp4x1h2oT527JYyB6NvkZYzqebUDYI0=;
        b=tFPH3ystVaQ+czMQDwMwWxi2lRxtasSkWcKktovzvdt7fQtUrxkjMfVB7R6j00PzEq
         /MaT/K9oEhKw8v6oewWbbTukhlAYoi+5KxFNH+S5F95slyhPzDv9gZndX/wvNBpUMXnB
         xxLtPR7nLYepqeagDTDLmjwsqlDZE/PfPNaZp6nkxLFEUDTSEHVJiyWt3h/levUsr7aB
         MaNYWgnTHStets3/1aXOXMPEgBM1dS+4bHbrgcDn28HQB90Dk1t+nYMOm200O6qI72EI
         CQsJ0c80FojM6Pgb0p9BaIjueVthuPZK4vPP528m29i1VIFtwBhqsw3wUj7nSJNEHgTw
         l5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fFCZgsLY1FTIhp4x1h2oT527JYyB6NvkZYzqebUDYI0=;
        b=B3TeWcFUj0PdGAOdGbAs4hvE3VkcpKV+qhwRGSsVddEwep7KsjcFuKUcPdqezSzaAC
         Y0G4u53LJOfCv3cG0UqIRPq+BVRErn3KZPQHC5wZDRjnXV4sSudn8xKaA+Eut6hRYseI
         66PvZvwO8idme1npPqQSjJc/khoM+t6LbTYO5f6jLNidrUyE74JtX1728qodO6Mh98EL
         D/teNe5HtrDVDS7bNO3JPwNx4H6utlJmo6Ivdy+RP9m6JnPBJ3idTUHgbYwKKmQGG9/C
         YQ9qwb/+ICMPlWkWvT84xrbOlMgC8cEcDkLN6kQyaIHEsFyqhdDG80oYPy9QLxb5nwaY
         jerg==
X-Gm-Message-State: AMCzsaXhWbbBi6KMJDAecJTB+hVpcTpvRviCRXLNkC4WhvxW/frXz18u
        y+a6SSM6oYNwSDecdTM/TdGe1YuQ5YxsB4STd6w=
X-Google-Smtp-Source: ABhQp+RRUQoKLEdEMPgUBKDdYr1uG0VVwNKfM4MXYaf+Y4iBU7vwyW8oGcAk0mu09dBIayWvha3VSggpyBjqlAxajLc=
X-Received: by 10.80.139.65 with SMTP id l59mr27439629edl.187.1509007397434;
 Thu, 26 Oct 2017 01:43:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Thu, 26 Oct 2017 01:42:56 -0700 (PDT)
In-Reply-To: <20171026072213.p6llaqrbdss7nbu4@ruderich.org>
References: <20171025224620.27657-1-sbeller@google.com> <20171026072213.p6llaqrbdss7nbu4@ruderich.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 26 Oct 2017 01:42:56 -0700
Message-ID: <CA+P7+xp2S9U1y0ENj0Z=B6-DY3XWKCg16xCCzVjHDLwAcMbGZQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] color-moved: ignore all space changes by default
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 12:22 AM, Simon Ruderich <simon@ruderich.org> wrote:
> On Wed, Oct 25, 2017 at 03:46:18PM -0700, Stefan Beller wrote:
>> On Mon, Oct 23, 2017 at 7:52 PM, Stefan Beller wrote[1]:
>>> On Mon, Oct 23, 2017 at 6:54 PM, Junio C Hamano wrote:
>>>>
>>>>  * As moved-lines display is mostly a presentation thing, I wonder
>>>>    if it makes sense to always match loosely wrt whitespace
>>>>    differences.
>>>
>>> Well, sometimes the user wants to know if it is byte-for-byte identical
>>> (unlikely to be code, but maybe column oriented data for input;
>>> think of all our FORTRAN users. ;)
>>
>> ... and this is the implementation and the flip of the default setting
>> to ignore all white space for the move detection.
>
> Hello,
>
> I'm not sure if this is a good default. I think it's not obvious
> that moved code gets treated differently than regular changes. I
> wouldn't expect git diff to ignore whitespace changes (without me
> telling it to) and so when I see moved code I expect they were
> moved as is.
>
> And there are languages where indentation is relevant (e.g.
> Python, YAML) and as color-moved is also treated as review tool
> to detect unwanted changes this new default can be dangerous.
>
> The new options sound like a good addition but I don't think the
> defaults should change. However unrelated to this decision,
> please add config settings in addition to these new options so
> users can globally configure the behavior they want.
>
> Regards
> Simon
> --

Even languages which are indentation sensitive often move blocks of
lines between indentation levels a lot. I personally think the default
could change.

However, I would suspect the best path forward is leave the default
"exact match" and allow users who care and know about the feature to
change their config settings.

Thanks,
Jake
