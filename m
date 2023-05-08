Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20161C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjEHRAQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 8 May 2023 13:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjEHQ76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:59:58 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008E55BB
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:59:54 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-61b79b97ed8so22427386d6.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565193; x=1686157193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY//aTXCulv6ebBhO2y7vKXnMi7Lhi+A9OdABI/oVp8=;
        b=T+y1GwbSpes0p7vo2QVeig3k/ThCXPlNaeArYcfdFHa30yY8ONfpAig9BG8r4dW11q
         FalLUh6ZiiymTaaKQ5clcT1WXtCVRjV2AG9JST3TJ1WsLWiyKTP/SueJfx/nLinB1IUN
         yPp/coXeh+v7aExdaD1CMO6YAtbp3ga9jQnY46qsHg6fAYtq1LFXxsSNSCxu5WDoQ1OX
         6cetvIq5VT5JCUFqroqGI00FNgrsr1kvJrVw8SmFh5A2xmiLVCLZj7p6v2vpxoYAal3W
         ClX/UppVXQogAxSglPRRqvDJIhAFkwfz+tGqdkdV1dbaBPP+LWARdDl0Q1y66nQ9FVHe
         jkRA==
X-Gm-Message-State: AC+VfDwp3hI/6D0whZQIV2u0ICHuY1UctqivZZkUkQyhThSL/wufj+7K
        JH5u6zdg1PZeXjSyZIbwO0wS+P72bxqdneNZyVE=
X-Google-Smtp-Source: ACHHUZ7AJlb8fbRyTQiAtiZaeddIZIpUnMhU11qNXUmk+QAwGYPrcHPScNJ98AZGMweK9KlftB2fvn5XNR6cDqenvwA=
X-Received: by 2002:a05:6214:20aa:b0:5e0:e52c:5d7a with SMTP id
 10-20020a05621420aa00b005e0e52c5d7amr15053643qvd.38.1683565193300; Mon, 08
 May 2023 09:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqcz3s3oz7.fsf@gitster.g> <20230501143848.19674-1-maxim.cournoyer@gmail.com>
 <87r0rqvp2z.fsf@gmail.com>
In-Reply-To: <87r0rqvp2z.fsf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 May 2023 12:59:42 -0400
Message-ID: <CAPig+cTEngaoEbipX9cFSZn3Mro5qW_OKeK32Wkoof-cy0jBiA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] send-email: add --header-cmd option
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 11:07 AM Maxim Cournoyer
<maxim.cournoyer@gmail.com> wrote:
> Just checking if everything is OK with this submission?  If not, let me
> know.

According to Junio's most recent "What's Cooking"[1], this patch
series is slated to be merged to his "next" branch, which means there
is nothing else you need to do. Eventually it should make it into
"master" and (presumably) into an actual release. You can monitor the
"What's Cooking" emails to see how the patch series progresses.

[1]: https://lore.kernel.org/git/xmqqmt2ibcq2.fsf@gitster.g/
