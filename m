Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413F01FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 07:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755972AbcHSHVQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 03:21:16 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37169 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755641AbcHSHVA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 03:21:00 -0400
Received: by mail-wm0-f44.google.com with SMTP id i5so27308064wmg.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UDvoq1MklmNyHIFyGvPUdDgKrc4+yGIsczOjaWKjSnU=;
        b=A2LYA/S9JT4nz79r5RWbhRBPDUb7Ed0EcjJsjHnA4FGdirX8MiCEyZXT22NRsJzUo6
         HgwCVAQ/F1GL76+KQ1TMy2bYA5hP23+j8XKgab+aspE+uyhlb4NbN4l7+JeC8E1yXGJG
         4+wx+imXpooHLCSjK3mheQymONNks0ywwc8QQy+7IwsBkKn73lTNn/k7vuUdi39EiKZu
         I5gNqDFtKvMFBa8OBpSKhCcITxBuPRC/AGfA87J12NoVgb0qackFVxoj0NDQrfETcLxo
         YTXj14ynWHhX5+k5EOkoaqkwCYuln77MN9M43DTYCxhzFE9ajxBqmDWL6Ir69pXtjyKD
         Q7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UDvoq1MklmNyHIFyGvPUdDgKrc4+yGIsczOjaWKjSnU=;
        b=enjK44zVQqPTMImFWISE3qEH5P46PIlvKHTtSfUac480AKrPFq0GEpealf3MkXyoqN
         OxwHKTMzuxofcSGNulv7IPtVRZvfVptlAEb6bfjOXuycHrH6mIL25dt9pndcpBpF1HuD
         WCEl+0q5WHVrFyWwb23EYo0ZORajhmK8puCJi+LtCb81kK9Ih6/26MczgL1Wqtx23fOr
         lcpd35pxQSuZzFov4IEeN7uBZ5+DavPGE+o6AnvXJip+8gPuc5hO1t7saI6He2tS5PlS
         Y4/hGUVQ3MhYOZwSQj6C6b/KZCW92w9N+bzIHfVcaBnFR98Rx/b4YoHsEbate8n690KH
         8Spw==
X-Gm-Message-State: AEkoouts20lOOv6QXnk7vdTHL0fV33SiIWvlBgRi+1N7XeVz7JLiF/VqSUrcl3Mk5mmWztb5I2Lz21FUbftRAg==
X-Received: by 10.28.51.210 with SMTP id z201mr610240wmz.98.1471542389120;
 Thu, 18 Aug 2016 10:46:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Thu, 18 Aug 2016 10:45:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1608180954400.11774@nftneq.ynat.uz>
References: <87y43wwujd.fsf@thinkpad.rath.org> <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz>
 <xmqqeg5oejmn.fsf@gitster.mtv.corp.google.com> <34d64f4f-3cda-385c-cdce-5f1852d545e3@gmail.com>
 <xmqq8tvwcvrc.fsf@gitster.mtv.corp.google.com> <12866c04-f910-2a83-b445-6eada3d2efc9@gmail.com>
 <alpine.DEB.2.02.1608180954400.11774@nftneq.ynat.uz>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Thu, 18 Aug 2016 19:45:48 +0200
Message-ID: <CANQwDwebocSzwrLRNoZMCkXy0D2HrSrXSyLxV=jNJ4xzCWDhHw@mail.gmail.com>
Subject: Re: Working with zip files
To:     David Lang <david@lang.hm>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nikolaus Rath <Nikolaus@rath.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 August 2016 at 18:56, David Lang <david@lang.hm> wrote:
> On Thu, 18 Aug 2016, Jakub Nar=C4=99bski wrote:
>
>> JN>> You can find rezip clean/smudge filter (originally intended for
>> JN>> OpenDocument Format (ODF), that is OpenOffice.org etc.) that stores
>> JN>> zip or zip-archive (like ODT, jar, etc.) uncompressed.  I think
>> JN>> you can find it on GitWiki, but I might be mistaken.
>>
>> Using 'unzip -c' as separate / additional `textconv` filter for diff
>> generation allows to separate the problem of deltifiable storage format
>> from textual representation for diff-ing.
>>
>> Though best results could be had with `diff` and `merge` drivers...
>
>
> can you point at an example of how to do this? when I went looking about =
a
> year ago to deal with single-line json data I wasn't able to find anythin=
g
> good. I ended up using clean/smudge to pretty-print the json so it was
> easier to handle.

Pro Git has a chapter "Customizing Git - Git Attributes" about gitattribute=
s
https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes

The section "Diffing Binary Files" has two examples: docx2txt (with wrapper=
)
for DOCX (MS Word) files, and exiftool for images. For JSON you could use
some prettyprinter / formatter like pp-json.

"Performing text diffs of binary files" section of gitattributes(1) manpage
covers 'textconv' vs 'diff', and uses 'exif' tool as textconv example.

HTH
--=20
Jakub Nar=C4=99bski




--=20
Jakub Narebski
