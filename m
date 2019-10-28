Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54081F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfJ1JqA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 05:46:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41018 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbfJ1JqA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 05:46:00 -0400
Received: by mail-io1-f65.google.com with SMTP id r144so9945044iod.8
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQZgmHxtHfPKzF+6C5Ofe26Y8KXr+WD2I7S6rHVh4Y8=;
        b=oiATUk4LYsSSQrDVn6PX07YZiB9rP/EYYGCt8lP03dpKo+2dH2fZH29S1DkRBLDfMl
         0HaUMgFWCy66gyDu7KFoi+BflVlCUlQQuQSr9GYL1Gm8oJaBZsbjiooQ27b5TqEZg5fo
         RJBAhHzLQa3XY4hyn4r8E3UxX7m2omlFJfy30Lm+aoLQMTSYO1HTgyIps4ZUE2gV5Zto
         SEPortFhe7BIV2LDWNKeNYn5lKYtLNGDJIiNQtuxp/R7tCjeb2mCfU+R145NbnGc9MYB
         vwQ1EMBuaehK86CRMCQRfYRSO6tH56LI88nNcqxqqrcJYEsg7wnHIelqjO9RhO7YFqeu
         OX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQZgmHxtHfPKzF+6C5Ofe26Y8KXr+WD2I7S6rHVh4Y8=;
        b=il6NerH/PBiSwllMIQkvWIJvXuD+Y6xzShO7vvzhe/B7WBypATFtkcY1ze0Qxfb40Q
         w1eQje0xtxhMJ0jqPlKAZdPyx1QIsMn49HF/HVYntrOlfTOS2EvFWD7HTyHNwQq59T82
         62Bc5zzyrK14dsRhevKiTVtN8boouWctWWUAWX/o9kOjBm1kXbhzloWgvNElMlGUSr5A
         GBVq6xD0C6M/LJUfukpTwKwc7EjlPnnjQnTasofc+Bey9TK4uIoppI80/W0y48YutOq+
         6pr4umYfOVXXkltEN2qZtPwid8/uGEMfNDilFyJYy3R+a4lGmcbeUUs9Je5CDpt2/yWc
         yb7A==
X-Gm-Message-State: APjAAAWHHZS8yucrV84rQ0feIsjlw+bEmQmcV5Tv729zlaiz7E+6/86U
        5KivZO37ukFGgc+6yS5yRvma4c52wz2QbdFTkjo=
X-Google-Smtp-Source: APXvYqzThnktwFm1epoReU2AbV7pIOvfU6o/LqUm46GH+Eh+TXJ6tCvx7BOZYW1CzWtF9l2zx8hQSHXse3Mpi0xJ1ns=
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr9425896ion.70.1572255959608;
 Mon, 28 Oct 2019 02:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191027163038.47409-1-mirucam@gmail.com>
In-Reply-To: <20191027163038.47409-1-mirucam@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 28 Oct 2019 02:45:48 -0700
Message-ID: <CAPUEspjGUXC-rbF2gpeOfYcajm4mtGRiVNc+Bc3++JgapDLzxg@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH] dir: add new function `path_exists()`
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
