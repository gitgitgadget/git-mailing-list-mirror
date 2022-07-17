Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40C5C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 20:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiGQUBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGQUBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 16:01:45 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403C1208E
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 13:01:44 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id kh20so7515946qvb.5
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 13:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wIQd+uoq8QMeefUEt+Gsmt4NsebSfBQ9cmln7mBCi84=;
        b=AM3dPn5+M3HT6PTLLLTQwE/O1zchwj3FY/HjakEAdmPGRhJldjtJ27n13Ms4RfUE4G
         2wxBeMDgWKIPzl6Le0OZ695cE64Sw6PAeBV0N2iPQbxCvLgA50yiybZzfLKWlmsxcaig
         YqEF5TqvS4lNSbSvzJyRdvF3m32EumQZnSm1AIuMjm2Db4fpE+tstWlOKdPjn+Z9OLmZ
         8rLlFv3EG0Rr9BlCZN+Qo8Nf0YL18Qg2k9Iaz8DpC63d7c5D9GOBMhO5XnW+OGzMZdGw
         9Ny7EuXwYxO0L9cbFM8USmTL0QZVdVtFGym9VL3OGGO+0MdCyRJJjYUH1g8n/FhUz/fY
         8VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wIQd+uoq8QMeefUEt+Gsmt4NsebSfBQ9cmln7mBCi84=;
        b=JJW/vXOG4qnZoVHQOvZwNPuhLEe1K5V+rfbLSgLk37UJvgQI6NzBe3Q0lxxTM2N2qb
         5SK46aw8LKwWMWOz1/2ykucR4rPTQ3FlqSHPRPglhmtAYNqN3QYv08EcqEHV1N4SBmT4
         Q0SMdM5EAgpXEC5phDLy2DyKidB3Xvz6lAtCjn+bWL24E/FIJx4+3NItkCZpKgy92GvC
         jnof0kr2CfwbDQc/VVVZCpNhgNGfTHmOtIFyNQFbFlCx0s8jPnNDxZJebAgAKZtNxLD/
         U1bz+IDwuVfxshesbVlSwURKUzFiOiMsjZF6KGSaEguar2p4bsaAj7OjS9QyAVwNxAev
         rYiQ==
X-Gm-Message-State: AJIora9+SKSjEGimMyr1THluzFI3+VBQehpL+M4IUDwyO00nq5bd8Frh
        WrZHpp4GdYhkItL3ALy8SLcsbM9ow5eXjw==
X-Google-Smtp-Source: AGRyM1viGU+RTepuw/7633ubzylJ9OeLuO0Q3InaT6L0oK3CIYcctmveCw/IlnJP02OZnlaquJenJA==
X-Received: by 2002:a0c:ca14:0:b0:472:f2ed:a51d with SMTP id c20-20020a0cca14000000b00472f2eda51dmr18766349qvk.58.1658088103452;
        Sun, 17 Jul 2022 13:01:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bm17-20020a05620a199100b006b5cccf62fbsm7785870qkb.46.2022.07.17.13.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 13:01:43 -0700 (PDT)
Date:   Sun, 17 Jul 2022 16:01:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Contributor's Summit Registration, Sept 14, 2022,
 Chicago
Message-ID: <YtRqpk2uKrfZxqO1@nand.local>
References: <YtRqU5rAOsLw5s03@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YtRqU5rAOsLw5s03@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 17, 2022 at 04:00:19PM -0400, Taylor Blau wrote:
> Hi again,

In case it wasn't obvious, the subject line should read "Sept 14, 2022",
not "2020".

Thanks,
Taylor
