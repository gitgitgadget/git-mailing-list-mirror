Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35406202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 06:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdCJGIf (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 01:08:35 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35796 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdCJGIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 01:08:34 -0500
Received: by mail-qk0-f180.google.com with SMTP id v125so150655588qkh.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 22:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G1MKbBjU3l0TUkC3chvc+cFQQp4fbKQWxLIXW2fMpUM=;
        b=EYBscXA3VrvAnCw/XwE9Wacu/NaJ9RnoCF1CZq69AeXHrrwsKdMYpb7YbIf2c9UwZK
         6l7HrkM7yugIfbXhm/lIMzLKMF/moSfb5y6lbpAVR1RHi7mHmIRioSuetGl/FcFxOrgj
         9Cax79HpEhsX3fe+1NruWBDY0jYn9iQGolfBko7I+MYGj439o4RgD5SdZyaLlPn7KJNM
         OaqxtRJy8iHKTqS/d3XvYyNqL+pHHpICvhzaFocR2QeV0hab0oKs6b0CBcmq/8DDmGc9
         poScmGPlD5q/ZApu8tNuUsaJuzHApO6N8+cyQ0+kYRmBh6YQPivn3iG3RfKKfZV5XNIX
         l9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G1MKbBjU3l0TUkC3chvc+cFQQp4fbKQWxLIXW2fMpUM=;
        b=D79vO6iibvd2Whw7oJ5OLLTapBCCRUrlo2suciOKkd2D3HK+Vdbbjmsl3WzE4cM4RH
         vLzy+BTt3vHQuh/Ja5LPjEXCt5suWJ7eWFZisFuuFNp67jF5UY4vwBeiUEqbyOTPmN9L
         Uo08QvVYZZy6Ngj8U5Uzkghjb2af6wlOYdHGD638OEchVaOg5I6pSCfXv1w3vZVfIWLw
         KPeEn2ItB+JNNb87uDb1n6GQhFlovZDf6lWqbIG6b1C+mN/Kyj+JtTY2qQ1cuwo5c8oQ
         X/t/b3qrNUcjrZXl1WvdaWFHVe7oU1/6uH3JBNSllxIqEmsqnQBoyzG8cSJQ1ySywHKE
         UFmQ==
X-Gm-Message-State: AMke39n4t5o/DGwXxFCpMSzm81c7sty2XHQAR7VR6xq9y/NvsqObLU56um9qDZS5ADduR1iAtaBg2umbYAPx0Q==
X-Received: by 10.55.167.198 with SMTP id q189mr16687947qke.274.1489126112628;
 Thu, 09 Mar 2017 22:08:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.86.164 with HTTP; Thu, 9 Mar 2017 22:08:32 -0800 (PST)
In-Reply-To: <CAGZ79kYUkQ4u9zX=qXL_+ip74mi3DgbzGiJNxybrVYbr3m1U=A@mail.gmail.com>
References: <0102015ab11e8237-01e52ffe-882f-4589-8886-2c0b231ac3c6-000000@eu-west-1.amazonses.com>
 <0102015ab11ee091-f9f11bb5-559a-4c92-b5f6-9f7755e8f4b9-000000@eu-west-1.amazonses.com>
 <CAGZ79kYUkQ4u9zX=qXL_+ip74mi3DgbzGiJNxybrVYbr3m1U=A@mail.gmail.com>
From:   Shuyang Shi <shuyang790@gmail.com>
Date:   Fri, 10 Mar 2017 14:08:32 +0800
Message-ID: <CAE9=6briC+CW+yqpn-r_QbQmZq-oy-hQJ9DNhBkxd_A1FSquyw@mail.gmail.com>
Subject: Re: [PATCH GSoC] Allow "-" as a short-hand for "@{-1}" in branch deletions
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Really appreciate your help on this, but I guess I am cancelling this
patch for Siddharth's.

Thanks,
Shuyang
=E5=8F=B2=E8=88=92=E6=89=AC Shuyang Shi
Undergraduate
Department of CS, School of EECS, Peking University
Email: shuyang790@gmail.com
Mobile: +86-18301336991


On Fri, Mar 10, 2017 at 1:47 AM, Stefan Beller <sbeller@google.com> wrote:
> Welcome to the Git community!
>
> On Wed, Mar 8, 2017 at 7:31 PM, Shuyang Shi <shuyang790@gmail.com> wrote:
>> The "-" shorthand that stands for "the branch we were previously on",
>> like we did for "git merge -" sometime after we introduced "git checkout=
 -".
>> Now I am introducing this shorthand to branch delete, i.e.
>> "git branch -d -".
>>
>> More reference:
>>   https://public-inbox.org/git/7vppuewl6h.fsf@alter.siamese.dyndns.org/
>
> Following that link:
>
>> But there is a very commonly accepted long tradition for "-" to mean
>> "read from the standard input", so we cannot reuse it to mean "the
>> branch I was previously on" for every command without first making
>> sure the command will never want to use "-" for the other common
>> purpose.
>
> This contradicts the introduction of "git branch -d -" to mean to delete
> the last branch, but rather could mean "read from stdin which branches
> to delete"? It would be nice if you could clarify in your commit message
> which of both this is and how this fits into the big picture of "design
> cleanliness".
>
>>
>> And this has been tested:
>>
>>         Ivan:git Ivan$ (cd t; prove --timer --jobs 1 ./t3200-branch.sh)
>>         [00:21:26] ./t3200-branch.sh .. ok    12293 ms ( 0.04 usr  0.01 =
sys +
>>         5.97 cusr  2.52 csys =3D  8.54 CPU)
>>         [00:21:39]
>>         All tests successful.
>>         Files=3D1, Tests=3D113, 13 wallclock secs ( 0.07 usr  0.02 sys +
>>         5.97 cusr  2.52 csys =3D  8.58 CPU)
>>         Result: PASS
>
> Thanks for being cautious when developing on Git. However this part
> of the email would end up as part of the commit message. And as we expect
> all commits that land eventually to not break tests, this information is =
better
> put at a more non-permanent place, such as below the '---' line (where th=
ere is
> also the built stat. For example see [1] how to have different message pa=
rts
> (one permanent section and some chatter that is relevant for the process
> at the moment)
>
> Also for testing, the tests only ensure that the old behavior does not br=
eak;
> but we'd want to make sure the new functionality doesn't break in the
> future either,
> which can be done best by writing a test as well for this functionality.
>
> [1] https://public-inbox.org/git/xmqqvarj1kix.fsf_-_@gitster.mtv.corp.goo=
gle.com/
> and as a commit:
> https://github.com/gitster/git/commit/83218867fbf6d27c78efe3cfba01790b2f1=
d15d4
>
>> https://github.com/git/git/pull/337
>
> Oh I see, you're using submitgit to communicate the patch to the mailing =
list.
> I am not sure if it supports splitting up the message as I eluded to abov=
e.
> IIRC some people use submitgit for the patch and then use a webmailer
> (e.g. gmail) to send followup messages such as successful tests or what c=
hanged
> to prior versions.
>
> Thanks,
> Stefan
