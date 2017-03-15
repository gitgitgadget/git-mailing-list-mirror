Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3AF202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 18:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdCOS3I (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 14:29:08 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32907 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdCOS23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 14:28:29 -0400
Received: by mail-pg0-f46.google.com with SMTP id n190so12848459pga.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FLUTaPn4nPAf4HDHfyajz0Vp4ShWkG9xuifCX9nByDM=;
        b=JJsL0ylN6Z4+y8wTIWRHqfzCIcK19XHBhbcLS36j1RM+OagQxMoGKaJCXidDGEGZAn
         3Z1u11+59tMoPTAHSZvugqTQS2Nl9MdC7m450FvzG97CFjnFo0gFM9bhwEPHLSetgqBv
         GviUdPeDZIIIf3AQDRtsb4+iNzurjSO4NZpmLTdSZf24Fe9PCcQZtowSqHIgE6OflcC3
         ZvrPDk4QdlsK2y6Bvi6O5E86oWjXQr462sQLRS35gHPtSXO52sturAyXwqgAg/k6Emsu
         8nrzqg5Z7Ae3HcoyFZRNkLGovGd/L4Y12Ycft5bKIvN2cSwx6oclUeuPbHmN5XhGGq86
         F2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FLUTaPn4nPAf4HDHfyajz0Vp4ShWkG9xuifCX9nByDM=;
        b=QvwBipw3zsoImerzkOQshwst2qiBds8sv9ukjzKy0Rv7Y0oABUaAWc2PHDvf1G3+Fq
         sbOg8FdwrPiN725rYeba5OVnsKFRI2zuzOiicMIyar6w/hUzZPDyErxRbv1ue7zwdEnI
         1nUp6XGsIvF8A+eJCcK+6P6zoHi/P0Tqi74bKiLklxxE2AN1PmHvX9wfxFNn7EFF9Q+I
         ROCUcPkrIrAZ1U5cVKkBa7Xsxbrr/6jAAQFYzNlyX4OK7v29JFCdauWmVEJZQ8FqT+KY
         j3sRhzBWPZCXqfE+MsZ8VIM1VxuE+UgmYulkvuvaG2CmtCgwJ4zMKlecDPZFWU0nCX4N
         3Wbw==
X-Gm-Message-State: AFeK/H3j2aEKHYcgeGLPNVRJO4joSL0qnNDwqABlgdb9oTFRRjbDFjCRkOKWGsj7wMM4aTXhY8yLAUvTHwLuLJHI
X-Received: by 10.98.20.8 with SMTP id 8mr5363039pfu.10.1489602508260; Wed, 15
 Mar 2017 11:28:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 11:28:27 -0700 (PDT)
In-Reply-To: <0ae83f7f-e178-31b3-87ea-324e3f00d469@free.fr>
References: <20170312200248.3610-1-jn.avila@free.fr> <20170312200248.3610-2-jn.avila@free.fr>
 <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com> <0ae83f7f-e178-31b3-87ea-324e3f00d469@free.fr>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 11:28:27 -0700
Message-ID: <CAGZ79kbZp_aMNsChE2AEHcVcokKRdkMKqUdwjanYi2jyO=mapg@mail.gmail.com>
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 12:58 AM, Jean-No=C3=ABl Avila <jn.avila@free.fr> w=
rote:

> The use of po files introduces tools to automatically mark the
> paragraphs that need to be retranslated or if the translation was near
> enough to be reviewed (entries are translated with the approaching
> translation and marked as "fuzzy"). Using po, it is also possible to use
> translation memories (such as the po file for the programs).
>

Well for writing code exactly, we often rely on commit messages
of the past, which is not available to users of the po tool IIUC.
Sometimes we have commits rewording the Documentation to
point out a subtle detail. Specifically for these changes
it would be good to have the reason for the change in Documentation
available for translators.

(Just a passerby note)

Thanks,
Stefan
