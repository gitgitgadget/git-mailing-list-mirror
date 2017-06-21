Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F0920401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbdFURpt (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:45:49 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35207 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753081AbdFURpr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:45:47 -0400
Received: by mail-pf0-f180.google.com with SMTP id c73so27989446pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=FMAIzuPmlRIjKv3ZlFba4qiSwK8cyM0QVdqDdjfuqwY=;
        b=X7PRQxq33zfNhIxgOL69zcg/pfnuhb45NbFQ+UyJhUoi8HJZRx3sfSicFlwCNbiUYU
         4BzVViCVRvtCI6KIvet5ys6RB9shnpHbhuw8+he6xvjDyUX+kdXJR1G+OI1fXm06IV2F
         fWt0PdVWy/xMHiedZnNFbH8dDkENbF5lP1amZrIOtGp0W4eV8MpdWx4DTgmfT0Jmlkfc
         ad402V7pojUVJh2ZmvrNJ/4vQlRDXbX7j+l0uLGJbLPtzUpdf1yfu4DkCxIVbwJZVdxJ
         aKhImCNsOtHe3BJrFpiu++SDzz26Io55hLERlMmuEnXgjDHVadmz6K4Wp8EAgBnCQMlc
         mjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=FMAIzuPmlRIjKv3ZlFba4qiSwK8cyM0QVdqDdjfuqwY=;
        b=kcoga48kkO+dt2y0J/VX7CO/D+XxNzkE2eq7jbPm3Y94ECLOZ7Dcq65ICUe+KD4qib
         9w1ysdocwZRqISQPx6q7op2xluBpaM4QzXdofOhwFwAxMxmBYZlkCq/6yR+aL6hrglDa
         J8w45F1m1gsgb1KH+pBCYn3FEKbyUYLiAKydRwqvMXxvPPNQn2XYT1RK2PRS5p6oF5UM
         fakajawf048j1LwWShrhqN08NAD0pxpS+NfnHFga9y4v4ZOsciP9YpIwIIR+Y7UH9okm
         4bn7YEsGcFKu+UteNK1MTaD2Daj6QTNome79/XfDjNxV+t6MsqwQW6ilSOqh8ZufOrYr
         6Rug==
X-Gm-Message-State: AKS2vOy4KGaMVrjqFbI8qlZY3kKYc1j0bt+rTsCEEfxL+oFhhLnhGZye
        cG1jUoanKLs9lA==
X-Received: by 10.98.101.6 with SMTP id z6mr37822063pfb.221.1498067147190;
        Wed, 21 Jun 2017 10:45:47 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id 70sm636741pft.104.2017.06.21.10.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 10:45:46 -0700 (PDT)
Message-ID: <1498067135.32360.3.camel@gmail.com>
Subject: Re: [PATCH/FINAL] status: contextually notify user about an initial
 commit
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Date:   Wed, 21 Jun 2017 23:15:35 +0530
In-Reply-To: <87fuet8kbs.fsf@gmail.com>
References: <1498012463.1487.2.camel@gmail.com>
         <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
         <1498055714.20886.1.camel@gmail.com> <87fuet8kbs.fsf@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-06-21 at 16:52 +0200, Ævar Arnfjörð Bjarmason wrote:
> No, this is a bug in your patch, the test suite should pass under
> poison.
> 
> The issue is that you changed the test code I gave you (to also add
> more
> tests, yay) along the way to do:
> 
>     test_must_fail test_i18ngrep ...
> 
> Instead of the correct form:
> 
>     test_i18ngrep ! ...
> 
Yeah, I did it after reading info about 'test_must_fail' in 't/README'.
I thought it should be used for tests that fail which seemed to be a
misinterpretation. Thanks for pointing it out. Fixed it!

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
