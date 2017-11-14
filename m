Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A21B201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbdKNBCq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:02:46 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:55968 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdKNBCp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:02:45 -0500
Received: by mail-vk0-f42.google.com with SMTP id b7so11227693vkh.12
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0rvMzMexqI4XpAfvePPoPigo409JUi68VA5e0snBCHU=;
        b=UpjMWXFgIQSlCdQE23BcMkx54p28zpMwqfnL5bR/L3k814icBfo8zmeEOlRw7gE+s0
         M+Hp9bv+ykR3dGq7hFlbALPhuLIuEbEZoXN8BBojbaADznRCIrR5V96sgDZAzSMB96lO
         x1LASqG9BabXnFK+7jF1oJGHKvdL/Rc6c40yXJjzMxEI+E4MymZcOdq0nLxUmyc9pIUj
         7mVP5XRehLa/VQ/dZA6rTbHoDmiU0+oj1u4558CIR4r86QBpilpX0qam2RD20gse/sfe
         5Bit1+W9K2YmkfT8l31mZoYrG/GiKX65PPYvdPYWbiwiEgWdDJNpVsF+gKi1E0pWxIPI
         vLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0rvMzMexqI4XpAfvePPoPigo409JUi68VA5e0snBCHU=;
        b=AcHr/RHk3xYb/uLC0zI71ehXAUf1ydtfzc031zMjs0MsFA/h27TkdFCuuCxxnhqf14
         dBxB4IqMHzErW8eY6+AFB/0Efh47mL9lkRfYc8N3uUCwENX91KbY7zcSxs4ClXQRvKnZ
         vusw+uK0z6zIUUoISJUnJkl0XR2QQbDunGFv/9XQZgzg7shW0C9iJAeZSELRmg/oEtDn
         /4jh1oAUS+oMMDPCTyPS9zCfDmTLqquE+QRPvx+ZOmO2w1ji7hdWUxUUNp2vWHguj5eD
         lOEl0NXDmL1x2aTvdhZ+gitZDxaIDHBhd2eCMVJAkYHDZxZucaJ4lCs8vcXtYfW+PRHV
         6WWg==
X-Gm-Message-State: AJaThX6HhVdEP+GEgxah2kls72NbYjicwXeUoGwnKV+C2OOZ13cLwkpU
        Jd58FoIm7MxcqtJ8eBC4p2UGkBFB2LoNciRW5o0=
X-Google-Smtp-Source: AGs4zMZs5nsA2EUCioIQxFm+NzkcWOiAmlr30Cm4rCZVhWrw0WZEiK2uutYeZV6OouFzF6We/t1vFGa3hLAdQwu4dqY=
X-Received: by 10.31.238.138 with SMTP id m132mr8045851vkh.114.1510621364637;
 Mon, 13 Nov 2017 17:02:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 17:02:44 -0800 (PST)
In-Reply-To: <CAGZ79kYOW9+pP5ApKDHR2_VwPXyiLEEbbO0-3ka-SDCP6ryLPw@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-7-newren@gmail.com>
 <CAGZ79kYOW9+pP5ApKDHR2_VwPXyiLEEbbO0-3ka-SDCP6ryLPw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 17:02:44 -0800
Message-ID: <CABPp-BH2eGzTMzHvF9TD9uw_n8k_kbgvSF-ct8B9HMJRFAr6Ug@mail.gmail.com>
Subject: Re: [PATCH 06/30] directory rename detection: testcases to avoid
 taking detection too far
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 3:25 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:

>> +# Testcase 3a, Avoid implicit rename if involved as source on other side
>> +#   (Related to testcases 1c and 1f)
>> +#   Commit A: z/{b,c,d}
>> +#   Commit B: z/{b,c,d} (no change)
>
> This could also be an unrelated change such as adding w/e?

Yes, precisely.  Whenever I have a "no change" commit, the intent is
that there may be unrelated changes involved, they've just been
excluded from the testcase in order to make it minimal.

>> +#   Commit C: y/{b,c}, x/d
>> +#   Expected: y/{b,c}, x/d
