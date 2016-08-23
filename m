Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D151FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755971AbcHWVMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:12:24 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34777 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755960AbcHWVMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:12:23 -0400
Received: by mail-yb0-f179.google.com with SMTP id d10so55033991ybi.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qu6gDDEFry5V8AtnQ9jPwVpRsfLcIfPSapi6LgVoBnA=;
        b=QWJtm6UA1eJWaYTNzjAy6uZhTigmdNW1a6zGJyLhlbnnCcy0XSdNNFZLs3xP2spGlP
         c6vbsWOyj+mpUYOfXFaeI9rJGhPI8gpww/6u/LgGkspaWO69ZOaWY2d4DRZjtlZICo/2
         Hw7P8ZlJpquTs6dHe7u/4kUnLgSxwuuhn073hmpwcdce2W2ry8RGx1CJSnz4FJDVyy8H
         iM5Q46J0QcwTRGYLGzf6vEaIJTauUXiEoBKVvRuopjVOviCjBIRB5tb5cB9+0ZteTCJk
         xbWGinkycxrr8Je2m8ONVRuIO5qg6lwVn3RJxymIexoxJL6tbDo4ogB7z7BUZqYQ+WKP
         WZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qu6gDDEFry5V8AtnQ9jPwVpRsfLcIfPSapi6LgVoBnA=;
        b=aVwiTnZ2G4eFWsHGTb1l0UZ+W74TCrnGym8cYSycXbuRNJBSPoEwd9eDxeTlOkRspQ
         v0A4/Ym+CmTIH00O0gomOazj9e5SK3A+9J+XmVKinQxV3jJi+5hNp3VpKOf7xP9QJ6Th
         +aZCWAB1xErHxQHK21wQFe1A2UIOJLAHs4murYrIwPKVxOLcK66y334AvfxjGft5f4Eg
         gLvT89q2ZBeNjAMVhFT8c7kimADuZEDZtu0JsE4xnYTgB2s+c0GhgdZlLH42++y2wL+x
         laRt87A8chn79p+4+aP1LWYeYzgwR5qf0exyCs1+EHFgtChwk+vwXZHKcI/pMOortDK2
         5GNw==
X-Gm-Message-State: AEkoouuYhSnCDyD8H3iyeobw3ojUtcjKy0bwDm80Ojm3lwlyo2mQqkH3niVY5oaGJB7fc7ALWNBAMvAmBTPLoQ==
X-Received: by 10.37.97.136 with SMTP id v130mr336664ybb.164.1471986397727;
 Tue, 23 Aug 2016 14:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 14:06:17 -0700 (PDT)
In-Reply-To: <xmqq37lvxx5o.fsf@gitster.mtv.corp.google.com>
References: <20160819234959.26308-1-jacob.e.keller@intel.com> <xmqq37lvxx5o.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 14:06:17 -0700
Message-ID: <CA+P7+xp1ipo1dDT+f4GF76+EY=vGx2kEqOsy0jdgCmzA=Ud1eQ@mail.gmail.com>
Subject: Re: [PATCH] format-patch: show 0/1 and 1/1 for singleton patch with
 cover letter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Change the default behavior of git-format-patch to generate numbered
>> sequence of 0/1 and 1/1 when generating both a cover-letter and a single
>> patch. This standardizes the cover letter to have 0/N which helps
>> distinguish the cover letter from the patch itself. Since the behavior
>> is easily changed via configuration as well as the use of -n and -N this
>> should be acceptable default behavior.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>
> This obviously changes the behaviour, but I do not think of a reason
> why this change is a bad idea.
>

Yes. The basic idea is "number all files outputted if we generate more
than 1 file" Since a cover letter is a separate file, we number 0/1
and 1/1.

Thanks,
Jake
