Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D721F404
	for <e@80x24.org>; Thu, 18 Jan 2018 08:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755250AbeARI4x (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 03:56:53 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:38904 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbeARI4v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 03:56:51 -0500
Received: by mail-it0-f41.google.com with SMTP id w14so12045165itc.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=axWNb9WKvbb2aM8xwj6xOx+vyfWc8nGbKAY/wl299KA=;
        b=cNgYAvEafbbEgsPc6N+fyoVBKRMQUJFSGDISbYCtyd+vi0lUdrO7KjFa5xeI12I3q6
         cfnL22nge6lASyE3WPJhgYexfbvE6izzm5fEIa9bbunyauNl9juht0WPa4WxU60b6yvl
         Hk/uIpVMBXX7ysHiiKvrD1sES45jiRaWZYkouHue0hVvxGDR4ETGp52WEXndstqvSJYj
         JWYpkL+0MK3eqsK+1fU6cPpNTSXVHaB41erTaPmpYrmUwE7O/J5o72C4R9JfjdGleZ58
         9bl3TJ7IJU68FXzYT7pxMfFaRsKf+GWftHaAsrvfPH2PeugVhP/DI96ZxkW6HoqvHuzX
         fZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=axWNb9WKvbb2aM8xwj6xOx+vyfWc8nGbKAY/wl299KA=;
        b=SuHuMg/LrbTrKTR1OxPxN6lQUejNNzvFB0QIULO27guP7eL0Fx2/d3VWlsvijrzjcs
         Fr59gigMre8sA7cX3NJXqyH9YV6bmuhcS0jy7/sMhS3q0L8Y46i/ooU4kiG7cOlnhi25
         XSMp3KnMUK20qGaYilYghdCnx6htC/64Ya7C4Ft/+h/fQw1D+olgrA+ygsRDAX5jKL4q
         jeLeF6ulUwZugHwWHv3XgFqrh9HJMLxXgUDguLgz4TVF86VnW7XO2hng3RwiH4QjS0zi
         WS2sk5OeLirctbxfNGYfLZuxG8Sgup2ajwh1EpIOY+2BampV6exZs6s+atXEY0R7cC/U
         XLIQ==
X-Gm-Message-State: AKwxytcPwaVN66xonM1THjocqytS0FWOHdwpfZ+vZpwbxNnQXM/oGv9X
        VejJd8d0w2T2V8GJS0qlHd5t7hWAlPb0y85+36k=
X-Google-Smtp-Source: ACJfBos8Ee/E33/eKm9CJwabDoJkwl5lWVK7Ml9YoLFLLsvQBxKjuH8dGV8YNHWMHoJeugBAxGyykK4siGvI5cX7yTY=
X-Received: by 10.36.137.84 with SMTP id s81mr19379312itd.75.1516265810494;
 Thu, 18 Jan 2018 00:56:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Thu, 18 Jan 2018 00:56:50 -0800 (PST)
In-Reply-To: <bda13f22-b6ca-f46d-9730-ff00ec536b0b@jeffhostetler.com>
References: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com> <718e2723-9547-8cd6-ac46-07e8631da09a@jeffhostetler.com>
 <xmqqshbd1o8a.fsf@gitster.mtv.corp.google.com> <bda13f22-b6ca-f46d-9730-ff00ec536b0b@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 18 Jan 2018 09:56:50 +0100
Message-ID: <CAP8UFD0P7kVo2NP4Wq7OaSV4H1+sqHapuzW5AQef+enNS0S5hw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2018, #02; Tue, 9)
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 11:03 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/10/2018 2:57 PM, Junio C Hamano wrote:
>>
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>>
>>> On 1/9/2018 6:33 PM, Junio C Hamano wrote:
>>>>
>>>> --------------------------------------------------
>>>> [Cooking]
>>>>
>>>>
>>>> * jh/fsck-promisors (2017-12-08) 10 commits
>>>
>>> [...]
>>>
>>>> * jh/partial-clone (2017-12-08) 13 commits
>>>
>>> [...]
>>>
>>> Parts 2 and 3 of partial clone have been simmering
>>> for a while now.  I was wondering if there were any
>>> more comments or questions on them.  I don't recall
>>> any existing issues.
>>
>> Me neither.

I am still not very happy with fetch_object() not returning anything.
I wonder what happens when that function is used to fetch from a repo
that cannot provide the requested object.

Also I think the "extensions.partialclone = <remote>" config option is
not very future proof. If people start using partial clone, it is
likely that at some point they will need their repo to talk to more
than one remote that is partial clone enabled and I don't see how such
a config option can scale in this case.

>> I do not mind merging them to 'next' during the feature freeze, but
>> we won't be merging them to 'master' soon anyway, and I'd like to
>> see us concentrate more on finding and fixing regressions on the
>> 'master' front for now.
>
> I didn't want to rush this -- just check to see if there was
> any thing that I should focus on while waiting for 2.16 to ship
> and settle down.

Thanks for already having commented on the patch series I sent to
integrate the external odb with the above work,
Christian.
