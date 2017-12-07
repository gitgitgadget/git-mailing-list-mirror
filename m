Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E8E20C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdLGACP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:02:15 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37889 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdLGACN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:02:13 -0500
Received: by mail-wm0-f53.google.com with SMTP id 64so9977655wme.3
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 16:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=21qrhHEuNtc9xqx0c+nbiGu1eq9g4xELM/CJR9HQPf4=;
        b=i+771a315XoHDYobD/r9ps8VQRbZiDRuUFydIYrujtKxSCUG/EjVAhbFGUzYRL/Ehw
         /z9733uaNBTM5sJt7+K2W9TvF5AxOhbGAbv2Ak9qDOIr8xv5DGm9BbX1qV+gX44UNezZ
         GLxdV2YLcOLhNVjDpwB+xeA8GleHtYHn2F212EkTBSW5XrqnvW5aNQ/8yEpGHWFx2DxU
         qoE4bqgfp6cMbyXmyp6gFmNU3N/BoRq+Uw2210ckuV3vXsh6tK/SUugd2rWC3lFMHnDZ
         dZH9xzRgIcdgQNV2P3i8dLW4sNHl07ppObbKKoiP7y+1vLD/OzM2S8dsSEs7Aii8I/nj
         ypSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=21qrhHEuNtc9xqx0c+nbiGu1eq9g4xELM/CJR9HQPf4=;
        b=MJyP/V18ZlZOCQHupoAV3Ms9lo/GEIrqbLo2FU/4R1f0pdj7PMoL+RFiJ2kqw5/MUx
         BHTnW5yuDyqam0Jr4GmfIiX8nIJow+EzvK+U6iduGt7M14hAXO6JWWX86819rsZKGclf
         E+UsRdfRfT3ouVEHrzui+GtXA0C5qfnTs5N2GKIpLfZEYM9kdM9MuQvTqXk4mCvyurNk
         8kSUnBN3dBNg0q1IJe/g3I5v8HWw1uFSRFfjhhfBiOAM5fMuBTTuhuikLLTDV3LDf2F0
         lFuH2AMAbb+5Cz/KA8NNny+NzpSTFC5/bdiFOIrC1628opsu7cDr3brjrObtaEqjznC3
         8Kqw==
X-Gm-Message-State: AJaThX5xjqQ0aqkJmDLBr0MKljkJywxpvcNVIDSGnxsdYpSCWHOYkRmu
        Vajqw23YrwBBM7PS9ijxwBAaqICeeb/Yii6V2bAc5Q==
X-Google-Smtp-Source: AGs4zMZnmsW1HVLeHbQTjPdr0sHVol0m4hF8QvaA9SHlmEg98q0+Plq7G52+SD+ZvqivDSnLP3yP1f/NiYE1FJjyzyo=
X-Received: by 10.80.208.195 with SMTP id g3mr42509493edf.246.1512604932467;
 Wed, 06 Dec 2017 16:02:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 6 Dec 2017 16:01:51 -0800 (PST)
In-Reply-To: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Dec 2017 16:01:51 -0800
Message-ID: <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
Subject: Re: git commit file completion recently broke
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 3:53 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hi,
>
> I'm still investigating, but thought I'd send an email. I recently
> updated to jch branch, and found that completion for git commit does
> not work as expected.
>
> If I have a git repository with a modified file in a subdirectiory,
> then git commit <TAB> produces the name of the subdirectory instead of
> the file names.
>
> This occurs regardless of where I run the git commit command.
>
> Thanks,
> Jake

I think I narrowed this down to "git diff-index --name-only --relative
HEAD" producing a list of files *not* relative to the current
directory.

Thanks,
Jake
