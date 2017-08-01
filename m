Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8E82047F
	for <e@80x24.org>; Tue,  1 Aug 2017 17:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbdHARqO (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 13:46:14 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:37175 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdHARqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 13:46:14 -0400
Received: by mail-lf0-f54.google.com with SMTP id m86so10039629lfi.4
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sgqlQ0Z2Heo7Fk1EAI3M5aYE0dVqpExlSu3ZZkt44J8=;
        b=i9Y4z6+nUFX238ChXJnLXg31JxNCqkp+acunVv1nbcNqCcfz7jgKpZl8LqiAGXwe5a
         IJHNsucjand74zDRVc/n+P7PSukjTfDgIvRulvi+PGmnXlG6CKBrRNM5Ixy16tnR3bjl
         mJpwq6e1giA0lZiXb+/YiO8kfF/hwo6zbjCKOAsbreHw3EZsvrQCyBueiq1FrDaaZwQE
         xt57HuL3VPgkTUd0VCL1TI16EXQRag88QA6jYt0qlksYwmMlL7MV8Y2OLZqMYTiRUdJo
         uU1PqwoA8pMgz3DV0nVaROIEz5qa6KvtrodFGGGgJPsLsZhryYGpCZCGdBqFIhYLJBTt
         W3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sgqlQ0Z2Heo7Fk1EAI3M5aYE0dVqpExlSu3ZZkt44J8=;
        b=eFvt5/tYDKPS65KdysQ8JrEcQ90Rs2bX2K5Wh5x+TmofhZS/QOMtIs+gKioc/pOy91
         D851hlBpTGK19MKdladd/Lxpx6beVmFZ8w4Kz2OhoXperMxMwyc3dj+ZvNDCOJQDerMO
         bvkaVgdf2DMa3IfXZl1FriG9sL6NV3lOZSohhodeGj+ZS2oMPKwIFUCdgf0YX01hQ/mC
         2v09ef0bgEPCot4jTwW61kQ8TKHUTQNocjJfS/ahzyNfyt1OGGObKZBkHOXBUzhHvS2f
         qsG/81hmQjv03b5VPrBzqoHbMXqMBjc5EshY3PI+ppE+URboKRLJaryGuktExb+b0Ag8
         DVpA==
X-Gm-Message-State: AIVw113xUmIG0/9a2XFGj/b9n1WZOFpBSdxMI2bBlPeOKrwSQqaVNlwP
        g2Z/PiQDIcIYFXvvyMiklI9LPhLbnKgV
X-Received: by 10.25.232.41 with SMTP id f41mr6360677lfh.90.1501609572480;
 Tue, 01 Aug 2017 10:46:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Tue, 1 Aug 2017 10:46:11 -0700 (PDT)
In-Reply-To: <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
References: <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
 <20170801160539.5587-1-kaarticsivaraam91196@gmail.com> <20170801160539.5587-2-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Aug 2017 10:46:11 -0700
Message-ID: <CAGZ79kZgV1=2HcYeXyoCy2Jk6v__trvTh_-rH+kbFX7fgWziyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: add another way to identify if a patch has been merged
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 9:05 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Documentation/SubmittingPatches | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 886fe3650..7197709ee 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -386,6 +386,10 @@ Know the status of your patch after submission
>    tell you if your patch is merged in pu if you rebase on top of
>    master).
>
> +* If you made your change in a separate branch (<branch>) you can use
> +  "git cherry master <branch>" to see if the change has been merged
> +  into master.
> +
>  * Read the Git mailing list, the maintainer regularly posts messages
>    entitled "What's cooking in git.git" and "What's in git.git" giving
>    the status of various proposed changes.

Actually I am slightly negative on this one, because of
occurrences like [1].

Our SubmittingPatches is already considered *too long* for most people
who just want to drop a drive-by patch.

Adding more knowledge (which btw is about general git usage and not
specific to our development workflow; you'd find the same tip in the
kernel community).

I wonder if we need a document that describes workflows.
(Oh, look we have 'man gitworkflows'! I did not know)

So maybe we want to cut a lot of workflow related commendatory from
the SubmitingPatches and then encourage to read such man page?

[1 ]https://public-inbox.org/git/CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com/



> --
> 2.14.0.rc1.434.g6eded367a
>
