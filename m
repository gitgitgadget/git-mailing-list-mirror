Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317DA2022A
	for <e@80x24.org>; Sat, 29 Oct 2016 12:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755538AbcJ2Mhv (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 08:37:51 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33932 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbcJ2Mhv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 08:37:51 -0400
Received: by mail-lf0-f53.google.com with SMTP id b81so74338946lfe.1
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n3tXpU7znCzOGC7EOQ0e4T3bJLExIFA8JhukUPIUAdU=;
        b=a/hxcUxkcYFpG5LCKvFEL9dz9IaZu7DGTUKSJuGenZQ/pOMt6XlL1Z8igcFkdTBu52
         XfYk/btLakRZfMu0zAZ5ZSI86tmkRpIrdaW6XyaUXlxe1+EVnwSaN9wrWICve8RgRozt
         XKlWY4y2Zy5D71HfniXeoxvKvrbaCAenf9xxVyhNUkVGQTf2vHhkdlkA+v0qD5/GTcid
         q798LmaPpvylJBrIYNGYKlSradh0HipMlDsCd2HRqMv99/KduQhCku48w/20y5RCVNLH
         qc2k/DLbmFDluyHMAVgoHMJBJ+0RP7rSX4/c/MKuq4xab8+SdMpHhLunkvInhDJpHZPv
         6cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n3tXpU7znCzOGC7EOQ0e4T3bJLExIFA8JhukUPIUAdU=;
        b=PSDv0xNACsw3T/fEsJWvXMac3rdg5sfEqYC4ewSpYo4ZsZVPSnVcKmRo5pwzXHsIu8
         tS8GLjxTHHiDetsr5/e4iWnLT0ZqL4JxKD3N6YZ5AleAk3M1pULmDa3UvmmGGIxSzh48
         hqZp2m6TLKUNzjHTtLhh/9sT6NlQkInOm607On5tOVUEyYO7fHpdEnBhT/WG0C0lft/j
         xZBbWdIU7hoEXr2Q3xZhFuntYRFML6/s2DfmrQ/tEZCot3OidHNTPSuAJY0gwu507uCw
         gd6MWd5COrgDsAB3rNiXa08YM6k3xKM3Bq3rMVRtn59BI4KzEgqedSyPtrMLtLPjOwQ9
         Ahzw==
X-Gm-Message-State: ABUngvejoDDGP0aewH37An+xzYnkMXr8mYiXQ74jvgPXnvaStg6iTuQCheTGNzUiC89m2YggT+r2YWsq2/mi9A==
X-Received: by 10.25.72.82 with SMTP id v79mr13183734lfa.130.1477744669074;
 Sat, 29 Oct 2016 05:37:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 29 Oct 2016 05:37:48 -0700 (PDT)
In-Reply-To: <xmqqzilovtye.fsf@gitster.mtv.corp.google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <xmqqzilovtye.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 29 Oct 2016 14:37:48 +0200
Message-ID: <CAP8UFD2j9zcZXG0ffuoiyGDHzOjySmtxLpZNzkoqcA0keq0V_A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Make other git commands use trailer layout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2016 at 3:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> This is built off jt/trailer-with-cruft (commit 60ef86a).
>>
>> This patch set makes "commit -s", "cherry-pick -x", and
>> "format-patch --signoff" use the new trailer definition implemented in
>> jt/trailer-with-cruft, with some refactoring along the way. With this
>> patch set, the aforementioned commands would now handle trailers like
>> those described in [1].
>>
>> [1] <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
>
> Ooooh.  Looks delicious ;-)

Yeah, I am very happy with this goal being reached :-)

Thanks,
Christian.
