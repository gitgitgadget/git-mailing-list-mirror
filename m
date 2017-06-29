Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F15B202BE
	for <e@80x24.org>; Thu, 29 Jun 2017 09:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdF2JXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 05:23:06 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34607 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbdF2JXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 05:23:05 -0400
Received: by mail-ua0-f178.google.com with SMTP id z22so53325026uah.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aDxb5Z5UsyBoCPjAOi0iO5SrWeJiZC3zCGPNbMMGU+Q=;
        b=HQWlgCmb8aP7aj2iP3LU4EhxJNKs53IcnVeJ2OkbZBvZ4GN5X2qi3iQxQLVgZq+ST5
         ti+bwvbIV+04tERTZ0oDoye0K+sosmhYoUILwle8gOOjMfcV92lKejWDiL7UDH+K2Af7
         m/ILKs3AgBTsui88yfoGUAgpq3yq3L9iLkFqxOTbOexB5ypbeJfPir9AfdiEGmtZsVuu
         YuFfMIdq5g1wOl64MinT3CH/bp8EM08ZT2M3HmKIiL2SiRezAI5KnntiuGhacbpnqCXO
         /v1FqmbLHsQBe7Kow3cAxKaW/HOOcLmCKXmanTsfgni0wT/vIhsUNAXcH1PQ5hi3/hyA
         2QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aDxb5Z5UsyBoCPjAOi0iO5SrWeJiZC3zCGPNbMMGU+Q=;
        b=Kpwea9y+w9kJu2F2UtVGImoX1mfZXulIYQhWNyIVtpgzwEzSmRsTInbE650WNJSHYu
         4xt+ntJ08zePWTHKIqJAwSEp5lBeQ3iCwTnBOfHScXm9xMF5AcqFRFJfNrfOQJ8vlaGI
         V2+jp6FZTaQMjm3e0K7DwNz2x0gfEXDjTyvrMl3zQ/hUg2uAdcr4MCGbjjkQF6bKOgi0
         FuZdgAOWsav+ySOTanxoGdzehrjgjYSu5vxHYSPHGULLqw8fD4QIsjVM4n/ves/c8AlW
         BTbPSuaKL7ZX6rXWDuMrQCAQ8L2D8jgkfsPvaP72lNZZZNAI6YsZgSRvqMIuTc2U+blK
         4xGw==
X-Gm-Message-State: AKS2vOyWUaI0iASSAiSdCj6u38tfkO74Gn+2OP7EgWzue9E8rl3kdJXx
        Dvm6MM6GqItYXZXTF1Ty9MjvSQQOsULv65w=
X-Received: by 10.176.91.69 with SMTP id v5mr6822288uae.140.1498728183930;
 Thu, 29 Jun 2017 02:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.18.223 with HTTP; Thu, 29 Jun 2017 02:23:03 -0700 (PDT)
From:   Laurent Humblet <laurent.humblet@gmail.com>
Date:   Thu, 29 Jun 2017 11:23:03 +0200
Message-ID: <CAFirYm_LLCUNdppZ7kKGwijJNNvhCaQtoJzRBVRsvhF+=bqgrw@mail.gmail.com>
Subject: Warning suggestion for git stash drop
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Would it be possible to add an optional Yes/No when doing a 'git stash
drop'?  Something similar as what happens when pushing on a remotely
checked out branch (with a config setting to turn the warning on/off).

I know that you can always get your dropped stash back using git
reflog but a small warning might be a useful feature to avoid unwanted
stash drops on a regular basis.

Thank you for your work on this amazing little software,
All the best,
Laurent
