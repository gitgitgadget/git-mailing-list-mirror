Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF99C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbiBKTpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:45:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348914AbiBKTpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 14:45:09 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0938F
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:45:08 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so6805528ota.10
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JIC4hgoBo3PZ7N9W2JdDOPQrVWnvOiP5P/ONODXEt/o=;
        b=RGR7aj6P4D0QRkitGsoSfMaagt82W2ptSW474/i76e0UVSdzNayGEkqFbZH1aKqfa4
         qfeTOxZhrAb8KWh0TlzAs9TlR8uyvRZ7NHkYqkwVyL+2cFAUFoGwrtgVrPLywjDr/Xwi
         VqGF8O9sfB6jDD6FUC7/biFhjtOYAxpXh3x3n/vF7ya8Z+RQwwDq1ZB882n1s+U+FuTK
         QPrU7d1TmtBogVQ7P4Gjv1nGufTs6RWQoBFk7mI63aCeg/FMBBarQqGaSgS3S5lAXdjV
         m/HugUMiyRzt2b+iS2Zck8tjwvoPapLANZlyJFJVWZZqFQxGM7kUxi/McLOws7jweGaH
         rcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JIC4hgoBo3PZ7N9W2JdDOPQrVWnvOiP5P/ONODXEt/o=;
        b=BT08A/zrtQLy3Q0cLMVVw5m1w9Jz9gy5DvATSeZhqL3tD+NhWNcqT9nLUAPicjlN3f
         a+S3E3zO0lsWxtFgKFVRnemzY/Ldp1uLAum/ftBug6phLbAb1jVHWxlkAAkDA5Fb1DiB
         HEuobn3l6Cq800vpwibQ2g1y5KqKl+s4oYoezUF6I8vlnQ6VDbwqg5e/ja05Jsa9unjy
         7XHVuKtKr283DPe2rjEHWCTdnHnDxlE20YvZlQtynigUktLV8O0aV2N5+fr7ziid90D4
         00C+lQSOI+TLf/4hN9IB8Pf1z8oOcTMLfeaDWo60UbJCHwZUUcjv4v7vx3vPbK6JzeO4
         8dPg==
X-Gm-Message-State: AOAM530KtesaB6Z+peLO45TTCXJgVTtfGuZocvxQj75vHKD/FHQ1O12f
        nCKCTLfGQMz+EXKSqylGq7SFrJkm2vVeGfe8ShXiFhDNxo4=
X-Google-Smtp-Source: ABdhPJy/i+UJOeKO9hp3jvuHFl3Gq53LlM3lFax4Q/dKfoXy9/siXc5UJGkV79Xqmjfr+BD1GmjTlYdf9z6YVk4FrSA=
X-Received: by 2002:a05:6830:1084:: with SMTP id y4mr1129656oto.42.1644608707319;
 Fri, 11 Feb 2022 11:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20220210233346.1009735-1-calvinwan@google.com> <xmqqo83dcnxq.fsf@gitster.g>
In-Reply-To: <xmqqo83dcnxq.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Fri, 11 Feb 2022 11:44:56 -0800
Message-ID: <CAFySSZDk3s_yD-WOajEucXFiirOJVB2Sa=KMCYHOMRwpkK5VmQ@mail.gmail.com>
Subject: Re: Review process improvements: drafting a ReviewingPatches doc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the suggestion Junio!

I will start us off by showcasing an individual review by Jonathan Tan
I received recently[1]. Overall, I appreciate how thorough Jonathan
was with his review. It covers everything from overall architecture of
the code to small stylistic nuances in the commit message. The review
can be generally separated into two sections: one that goes line by
line through the entire changeset and suggests possible improvements,
and then another section that summarizes the overall direction the
patch author should take to move the patch into a mergeable state.

For an individual review, I am glad the following was included in the revie=
w:
1. Stylistic improvement for the commit message
2. Suggestions for clarifying the patch context
3. Rule for referencing merged code
4. Variable name correctness
5. Showcases where certain functions/variables/classes should belong
for better structure
6. Suggestions for code that can be refactored
7. Makes considerations about edge cases
8. Determines whether the test cases are sufficient and if not,
suggests new test cases
9. Stylistic improvements of the test cases
10. Suggestions for overall architecture of the patch

Some items I think that were missing:
1. The review does not answer whether the overall idea of this patch
is worth merging. (There is some loss of context here since internally
here at Google this feature has been deemed worthy and the legwork for
the server side of this patch has already been merged up).
2. Jonathan jumps straight into the review. A brief summary at the
beginning to bring context and to tell the patch author what he/she
did well would be nice.

I do many things wrong in my patch, but at no point is Jonathan
demeaning towards me. He assumes the best intentions, and makes his
best effort to help me improve my patch. To be able to clearly see the
path forward and to see my patch welcomed on the list motivates me to
continue working on this patch.

[1] https://lore.kernel.org/git/CAFySSZCZfekrdBH1NMArgPLdF4o1KQVY251BLyFgRx=
p=3DpDgEOA@mail.gmail.com/T/#m5a033fd28089d41befc937e8adbb133874eee528





On Fri, Feb 11, 2022 at 9:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> calvinwan@google.com writes:
>
> > In continuation of Emily=E2=80=99s "Review process improvements"[1], I =
am
> > drafting a ReviewingPatches doc to help standardize the review process
> > here on the git mailing list and to provide a rubric/checklist for new
> > reviewers. In order to do so, I am looking to compile examples and
> > input from everyone by asking the list a set of questions biweekly.
> > Please contextualize your answer in terms of whether this was a
> > maintainer, individual, or drive-by review.
>
> Often people other than the patch contributors themselves find
> others' reviews a useful learning opportunity.  I take it that your
> "contextualize" request is asking for comments like "As the
> maintainer, I found this review by an area expert very helpful
> because ...", as well as "I sent this patch and a drive-by typofix
> at this URL was not very helpful"?
>
> When soliciting input from the list, it would probably make it
> easier for others if you led by example by sending your answers,
> to show the level of detail you'd find useful.
