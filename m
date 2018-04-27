Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA621F42D
	for <e@80x24.org>; Fri, 27 Apr 2018 19:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758326AbeD0TIW (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 15:08:22 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40415 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758062AbeD0TIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 15:08:21 -0400
Received: by mail-wr0-f176.google.com with SMTP id v60-v6so2700116wrc.7
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fdPbaa0oC5QcWOxBz+air1htx3hy2/RLOOyzyHVUKCk=;
        b=J/NrQUX+dimWmcDPwj0MM8WR8UK0hxWSTWAN0CKUMcxk+JF5+s/O3zG4xV1mMxyubK
         DbPw67piHLxM76wBfpi5g99Aqv39dJyiSDY1b5qf9FwWF8KBEb3u379iNce8qDe0ErO8
         el4vztM7aXCQEPXr5LOugVZUUtjw6f97HgbOf4vb71dy9ORR7DpDpZQVX+i3+Ojr9bL4
         97ZDD2IRNVJmBzNSQC6cohgXBR5wx+Nf59JQmdhslWpDE2d/PuN33EuzAXz0sf3pGQys
         X3Fuaj9CzCY8VwTsD+XJxWkFpPf7llyyZfhyghXhwmeRqTvpNMVVuR+wUD0BhTUcwFMM
         cvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdPbaa0oC5QcWOxBz+air1htx3hy2/RLOOyzyHVUKCk=;
        b=pIaO7Fkd5ixoysTn7I/NRnRlirr+nvqJxRPnxVCoTMHFLA5/Z5p4HfDJw1VcAg/e2h
         yoJLEvDtGVQynvqsNP7SspQ30GpAH7fLbnSA2I6R5FoyWaU0Ihrp73c0gORBf4HoZ/E3
         SXmZdQ20h9oDHQF0YTBRFVcq9UQxbwMVr07C9gZvZPaOumubjkiVE/w91hSV57XuZ9wx
         Kv6PjnU6sLXyHrGfYMbIv8mEt+r98amfHwNKwOjZgHBA/j9jQdxhiu4g37NKQvBUy4Iv
         hlbqbp6grqsr8qJm8coCGOV62Lf0ilziA61Fh1b+36Dfi82tFsyjGvOpK0TKEnvMxkEN
         9N7A==
X-Gm-Message-State: ALQs6tCwNCP8EaYLY7AtcfEe61yEs/zX8rB7ZCvIKvHzfresSftgboEj
        ppTP5+dtoCrtZSRzDuPaFatnYB4E
X-Google-Smtp-Source: AB8JxZpjjCNFr6GeW8oK8WNAnYXzedCHJPHDpQfL8CUxAj02xYSvINgFY4rOpK8u/G5PzrPexSPDXw==
X-Received: by 2002:adf:b972:: with SMTP id b47-v6mr2647622wrg.238.1524856100631;
        Fri, 27 Apr 2018 12:08:20 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:b0f7:2e70:f673:62a9? ([2001:a62:81d:ab01:b0f7:2e70:f673:62a9])
        by smtp.googlemail.com with ESMTPSA id v66sm1895441wmd.4.2018.04.27.12.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 12:08:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180427170440.30418-1-asheiduk@gmail.com>
 <20180427170440.30418-3-asheiduk@gmail.com>
 <CAN0heSpdc51+7-uWcLVXU72qLZgZApdME8ywBJaQQy4DiWHAfg@mail.gmail.com>
 <a3253c99-63a4-22bc-53a0-4d94c01a564c@gmail.com>
 <CAN0heSquZ9WGQE=SCZ0DkgsbKPc80r5TmYhNXOGKFJ6MaJ_sOQ@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <61a137f6-f4bd-c15e-b8c9-00c8425c11ac@gmail.com>
Date:   Fri, 27 Apr 2018 21:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSquZ9WGQE=SCZ0DkgsbKPc80r5TmYhNXOGKFJ6MaJ_sOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.2018 um 20:45 schrieb Martin Ågren:
> On 27 April 2018 at 20:28, Andreas Heiduk <asheiduk@gmail.com> wrote:
>> Am 27.04.2018 um 19:18 schrieb Martin Ågren:
>>> On 27 April 2018 at 19:04, Andreas Heiduk <asheiduk@gmail.com> wrote:
>>>> The two '<path>' parameters are not optional but the option
>>>> '--no-index' is. Also move the `--options` part to the same
>>>> place where the other variants show them.
>>>
>>> Should this commit message be updated after the changes you did to
>>> address Junio's comment? This text suggests you want to place --no-index
>>> in [] (and you did in v1) but you do not do that below.
>>>
>>>> All three items are already correct in the synopsis.
>>>
>>> Same here, now you actually do change things there.
>>>
>>>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>>>> Reviewed-by: Martin Ågren <martin.agren@gmail.com>
>>>
>>> Strictly speaking, my Reviewed-by was on another patch. I do find this
>>
>> Sorry, I've added that trailer after reading "The diff LGTM.", then
>> applied Junio's changes and forgot to remove the trailer.
>>
>>> one better though thanks to Junio's suggestion (except the mismatch with
>>> the commit message).
>>
>> I'll fix that with this:
>>
>>         doc: align 'diff --no-index' in text with synopsis
> 
> s/with/and/ since they both change? It's not that the first changes to
> match the second, but they actually both change to match each other (and
> to be correct, obviously).

Corrected

> 
>>         Make the two '<path>' parameters in DESCRIPTION mandatory and
>>         move the `--options` part to the same place where the other
>>         variants show them. And finally make `--no-index` in SYNOPSIS
>>         as mandatory as in DESCRIPTION.
> 
> Great! Junio had some good reasoning about how --no-index is
> sometimes optional, but not always. Not sure if it's worth spelling that
> out. (Although one could argue that it already did trip us up once. :-))

The post-context already explains that.

> Eric's point about "--options" vs "options" seemed right to me. If you
> address that, note that this message says "--options".

