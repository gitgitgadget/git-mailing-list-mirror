Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1048DC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 08:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjDSIbt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 Apr 2023 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjDSIbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 04:31:40 -0400
Received: from kautler.net (kautler.net [85.214.242.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1065A118FB
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 01:31:28 -0700 (PDT)
Received: from mail-oa1-f49.google.com ([209.85.160.49])
        by Masters-of-Disaster.de with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <Bjoern@kautler.net>)
        id 1pnI14-0005sI-4D
        for git@vger.kernel.org; Fri, 14 Apr 2023 13:54:58 +0200
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-18779252f7fso9338075fac.12
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 04:54:58 -0700 (PDT)
X-Gm-Message-State: AAQBX9eulNb+ciNk6aQ5B/Q4YpafKHB7YE6g2B461QifN1XPJJIxnNfj
        lcKrNL0EJShukMVljt8++lCMpGW13FreDCwEejk=
X-Google-Smtp-Source: AKy350ZJn8EjHh+HWvJ8dS1KwAxQ38JZKOQ1yXzUOizrxIFEUIKgqykrVvlYjRIxgPe32/ib565ZFrjsUKLEA1Kj27A=
X-Received: by 2002:a05:6870:3386:b0:17a:dcce:86bf with SMTP id
 w6-20020a056870338600b0017adcce86bfmr2704199oae.8.1681473291608; Fri, 14 Apr
 2023 04:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKChYSo9x5k0Ly2CNs5tbZ+jMdxBmDLZ9gm_645pwXZsCQ4ySg@mail.gmail.com>
 <20190318211737.GC29661@sigill.intra.peff.net>
In-Reply-To: <20190318211737.GC29661@sigill.intra.peff.net>
From:   =?UTF-8?Q?Bj=C3=B6rn_Kautler?= <Bjoern@kautler.net>
Date:   Fri, 14 Apr 2023 13:54:40 +0200
X-Gmail-Original-Message-ID: <CAKChYSonyAw9Gr+vxDsCr4dDE0hvc9ZM6+spJo19h85R357Qkw@mail.gmail.com>
Message-ID: <CAKChYSonyAw9Gr+vxDsCr4dDE0hvc9ZM6+spJo19h85R357Qkw@mail.gmail.com>
Subject: Re: fast-import should fail on invalid unsupported paths
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just want to note that this is still reproducible using 2.40.0. :-)

Regards
Björn
