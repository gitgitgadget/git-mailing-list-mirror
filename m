Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61F41F404
	for <e@80x24.org>; Sun, 28 Jan 2018 13:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeA1NlX (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 08:41:23 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33893 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeA1NlW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 08:41:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id 36so4385016wrh.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 05:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y8iA8MpDkoca7LBFQZY2chem4oo9DpcYmdv378MkAZE=;
        b=gNLw+ZxdemOQrNcelSWEcrLiRbbAeVmNHGMx8BQCulxjB9g+P8JjftTJOFQgYvZBzu
         AXon/sjRH2Qe47t1O620a5Zu9WHx6rOtckFXDkjxPr41omrvgr/NNGRadcc3qjbKHoOz
         faLEhZU7h0HZpjFJA0s9Cbx7EV5OiDp2aWg4OSPdXZVKQ/h6dboQANgMJgl4J6QIZYWI
         /sMgp+J5EQXeCL0+/RCXCOpezzpsudirXeVr9Yw8BBMUqXJAGZUg9dgtmy5cUCH6kL/O
         GChdSSt9NJuo/8/PHJu6ShySuLBst9tZRwcMhb//86ImK0Qe8cP1fIkwF3CquGeIZsEe
         J9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y8iA8MpDkoca7LBFQZY2chem4oo9DpcYmdv378MkAZE=;
        b=E6unrKVZEyAe37v1yYOfcGp/OemLT421Ow9Jw5n4hdoUG9WFMa6exhqt/TfT2uYk6E
         1wpS18mAC+YpHXBnCL5auUYdi0Wuu+wQsQKZqAX8dheLWEnNINL2rd9Rr4sWxMXveg7I
         3cIaUGsTDtL1IMZZldqHsHxj/ZszMQ+0J9x8R1RndiNGGVRF+rbFoZIq33RDIX1IUW1U
         iJFmhAT8UB6Z499wvb2NhpSrOEIGP19nypzQNAdCF3+JWPc7mTtjnMr0tp75OAO78/yU
         lKKznROO3mMPjbruaPFthV+Fm2a3DAgWhQ2KEdFmCMD3DcmPdHaDP5qIWSMGYXtfRttf
         uzug==
X-Gm-Message-State: AKwxytcMjq1sFtyDTw3MCIQEc7Qfn++yb9D29SG2fWu8UNnpR7nLWHf0
        URKm0xcTN/4Ep3x4ev6WubFwsCvhowDsekvfIg==
X-Google-Smtp-Source: AH8x227+evLAxydNIowEe0+U3fFrivlPm3ThkTyxHNZwcHtx6i3vDy3ogawU2c/Rp6SXKgvqHBR5laXvCbpBh01Ywp4=
X-Received: by 10.223.175.213 with SMTP id y21mr11699998wrd.135.1517146881580;
 Sun, 28 Jan 2018 05:41:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.196.8 with HTTP; Sun, 28 Jan 2018 05:41:20 -0800 (PST)
In-Reply-To: <87d127i5qs.fsf@evledraar.gmail.com>
References: <157d942b-99a9-4a75-92b9-8eb8adb17032@googlegroups.com> <87d127i5qs.fsf@evledraar.gmail.com>
From:   Michael Felt <aixtools@gmail.com>
Date:   Sun, 28 Jan 2018 14:41:20 +0100
Message-ID: <CANvxniWbhF+cuQFU+7qg1KYG9kMPLj6ENAd+d2kBvv6pXkgkfg@mail.gmail.com>
Subject: Re: Git For Aix 6 and 7
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     raikrishna76@gmail.com,
        git-packagers <git-packagers@googlegroups.com>,
        git@vger.kernel.org, Thom May <thom@may.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have git on my portal www.aixtools.net (See
http://www.aixtools.net/index.php/git)

These are installp packages - and what you install, you can uninstall.

There are some dependencies (e.g., python, gnu grep, and a few
others). Can't say I use it daily, but I do use it weekly.

For additional questions or issues with this packaging - please post
on http://forums.rootvg.net/aixtools - I see that a lot sooner than
any email (on gmail).

HTH,
Michael

On Thu, Jan 18, 2018 at 3:47 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jan 18 2018, raikrishna jotted:
>
>> Hi Team,
>>
>> I have an urgent requirement to install Git client for Aix 6 and 7, coul=
d
>> you please help send me or navigate me to the correct url.
>> My present infrastructure comprise of Aix and Linux servers , I am
>> successfully using Git on Linux however I am struggling to find correct
>> package for AIX platform.
>>
>> Appreciate your quick response.
>
> Hi raikrishna. The git-packagers list is a rather small list so perhaps
> someone on the general git list (CC'd) knows the answer to this.
>
> I'm not aware of anyone providing binary git packages for AIX, but I
> don't use it so maybe they exist.
>
> The last mention on the mailing list I could find of someone packaging
> it was this from Michael Felt's (CC'd)
> https://public-inbox.org/git/CANvxniXkbAKgjm+NZ0cyyCToEYp23Kd8s4yxSqUOsAU=
AHJSA7g@mail.gmail.com/
>
> The last AIX-related patch to git is actually mine, but I haven't logged
> into an AIX box in over a decade, see
> https://github.com/chef/omnibus-software/commit/e247e36761#diff-3df898345=
d670979b74acc0bf71d8c47
>
> So it looks like there's a chef build recipe for it, maybe that's
> something you can use?
>
> I would not be surprised if building git on AIX, particularly with a
> non-GNU toolchain, fails in all sorts of interesting ways. People here
> on the list would be happy to help you work through those failures,
> we're keen to port git to whatever we can get our hands on, but these
> platforms experience quite a bit of bitrot.
