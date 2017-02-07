Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A0B1FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 01:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdBGBRd (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 20:17:33 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:32819 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBGBRc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 20:17:32 -0500
Received: by mail-lf0-f50.google.com with SMTP id x1so54484065lff.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 17:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TQ/igThdVSFbCckSrigHLpeQuMIv5tE5W9CdWh4VcLg=;
        b=Q6sZ1K4UMdyasYjiW4KUn2JS2+A8bi1XihgoTFptyD5VCEuiS4NDEPitbWT2ilWbi+
         MI+dnLpk0F7HTHjy/XlYUGwdavpuyY75QqhSZF43qnR8H5f/lA1lQQz83vOnoFOaWbCR
         dWX8ftKN8mpxDXdxJR58tJuZBXAYOu6v173FS+k9Cix7e28t4Ov4RAE3wwpN4IffBA/e
         VQyU3JvegdqWLnRrC3XaWB9ORmRzm/4g7aih22+O+aShmwhxSvjN5NnzN/M/Yy/kqTjl
         QDVyeJROGzlm6Qm6h7/FK6w9kejEHvb3V/D7njkvJjssZDvhL6uPhMdPGqssibJzIi4Y
         J1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TQ/igThdVSFbCckSrigHLpeQuMIv5tE5W9CdWh4VcLg=;
        b=Ff8aJ6AjOqxEHOG/Ykhn9zbOmDG/LG97leIv9Zm+86Vi/+0uXMAdLXewXDislua0U/
         drvTWyBfHRfefaFd3pPFmMaRGusF1eUXsbEKHgF8M2qtM8pdIx0I1q0gKqvlALxqRbtx
         nyh3vcJ5B3QofKnQrW4BWsWpUQjRSEbYujRzF6cQAyHEPelLWZRHbsifZXWu64kTKr5Y
         XH1VJvEHOsZZcFJCrLvfl5mPuTmiHMeRF3GRZ/X1gfBTW3O7hcM5cV1/LzvHrRBPCnzQ
         HFCeLu4CO+T2+rwQVrNceoa1IhC5irype9dUtsLonKtf0hnTtND0/cHfTfiIPbLYBcz5
         QJVg==
X-Gm-Message-State: AIkVDXK0OVy0cnhxG5racseFQWkNXEb6D/cNiY/n5Ypnw+SbpdtSiBVj15CKZsT4r3Lnpg0xUq28LAwvL7145g==
X-Received: by 10.25.141.12 with SMTP id p12mr4851307lfd.147.1486430250387;
 Mon, 06 Feb 2017 17:17:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Mon, 6 Feb 2017 17:17:09 -0800 (PST)
In-Reply-To: <CAM0VKjmhO9NQLz9TDv5M3OhxSBt-JdjaouVT0pTA-a6mGaF4_A@mail.gmail.com>
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com> <CAM0VKjmhO9NQLz9TDv5M3OhxSBt-JdjaouVT0pTA-a6mGaF4_A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 6 Feb 2017 17:17:09 -0800
Message-ID: <CA+P7+xpdhYG77LA6QkHrJwP0_3t4_0vB11Y0jyw6=w9_w=mY9Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <Karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 4:24 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>> * sg/completion-refs-speedup (2017-02-06) 13 commits
>>  - squash! completion: fill COMPREPLY directly when completing refs
>>  - completion: fill COMPREPLY directly when completing refs
>>  - completion: list only matching symbolic and pseudorefs when completin=
g refs
>>  - completion: let 'for-each-ref' sort remote branches for 'checkout' DW=
IMery
>>  - completion: let 'for-each-ref' filter remote branches for 'checkout' =
DWIMery
>>  - completion: let 'for-each-ref' strip the remote name from remote bran=
ches
>>  - completion: let 'for-each-ref' and 'ls-remote' filter matching refs
>>  - completion: don't disambiguate short refs
>>  - completion: don't disambiguate tags and branches
>>  - completion: support excluding full refs
>>  - completion: support completing full refs after '--option=3Drefs/<TAB>=
'
>>  - completion: wrap __git_refs() for better option parsing
>>  - completion: remove redundant __gitcomp_nl() options from _git_commit(=
)
>>  (this branch uses sg/completion.)
>>
>>  Will hold.
>>  This seems to break 9902 when merged to 'pu'.
>
> All failing tests fail with the same error:
>
>   fatal: unrecognized %(refname:strip=3D2) argument: strip=3D2
>
> That's because of this topic:
>
>> * kn/ref-filter-branch-list (2017-01-31) 20 commits
>>   (merged to 'next' on 2017-01-31 at e7592a5461)
>>  + branch: implement '--format' option
>>  + branch: use ref-filter printing APIs
>>  + branch, tag: use porcelain output
>>  + ref-filter: allow porcelain to translate messages in the output
>>  + ref-filter: add an 'rstrip=3D<N>' option to atoms which deal with ref=
names
>>  + ref-filter: modify the 'lstrip=3D<N>' option to work with negative '<=
N>'
>>  + ref-filter: Do not abruptly die when using the 'lstrip=3D<N>' option
>>  + ref-filter: rename the 'strip' option to 'lstrip'
>
> And in particular this commit, which, well, does what it's subject
> says it's doing, thus breaking backwards compatibility.
>

What about making strip a deprecated variant of lstrip?

Thanks,
Jake
