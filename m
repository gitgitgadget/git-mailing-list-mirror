Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC7C1F462
	for <e@80x24.org>; Wed, 24 Jul 2019 16:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfGXQQg (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 12:16:36 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33533 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfGXQQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 12:16:36 -0400
Received: by mail-qk1-f172.google.com with SMTP id r6so34207471qkc.0
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YTl1SMCwAUf581VVfImO2XbDxWlZLn+UbaqSeQtSppg=;
        b=TI+nDnIkMOMb6XSSY1j+1aAF75PrjtStqMdvoacR5Y3TcHW9dfK9PU5uC7m9NtGKad
         lmWNCcIfLN03/oX6iP2FlPwnrCqzaKqaXnyNmF/sh+gL2HLdKOLlFQ6fAzMFAIl5Vf26
         iCRBsv1U9XSRAq1fbLRyms/X7fpMyRmk/SAJ80HtRk5MU8Pavhn9kKL5hYczwbZ4Bd45
         R3+qCac18uUkJ5ImKTc2Mq2kWOBpORsknLQsSDq5StUwttquvLkMjZF0OZXbK75zeXli
         DbXDqtEiW54zhXr3iFUtOHgcoht4Fko8P4ueWWm7t1NZziWCkUmfdnrhpQS0OHOnmcbQ
         UDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YTl1SMCwAUf581VVfImO2XbDxWlZLn+UbaqSeQtSppg=;
        b=M7F+n84HaVDNvZk8U85ZM7IsIHGisHi6QyqfnmHEPW6qWt09SeSv2KOMw59sLcMLS7
         VQwqEeKOtdyz40NQBmWfdcmZSoIHp4Zm3yTgOh3RNQT1kxhZtLtzywPJppCK8MNvxzrw
         f+7QNbBp9AbzOyvMMYcsnHPImRDoTBW7PbqqVse0fZHi7VUYE2J7IJG3LO4GRzqsNY9V
         WSIhTkPIFRmyQNeW2yt+xgayAcATSG55giago2Uihe9ugiSBenuH1nrnXCUX5EB2Aoc7
         ebcYNAHoYkytJ7bpk0rdti+slsrZUYGcU722VfHoPd0HGx2JiAYuIxpUonmQiDRtV5Xx
         eWyQ==
X-Gm-Message-State: APjAAAUnooiCZCS/7pcakIxyXVNyKqkQIt/jnx8ZEj+lZT8DORx/tYsN
        WsWbdHlb0Hcz/xex3aW3lS7bxpyLAP07/F/BvpJ1B/0N4L7Drw==
X-Google-Smtp-Source: APXvYqwy0TZSsnm4LLTWf20tUDb4S2mqyN/sl0qXLO8fvLYTMXc2GPbFrCN/U2Vc9SKE0fC1uOj3+FMu29zCZPgE2uI=
X-Received: by 2002:a37:dc1:: with SMTP id 184mr55132347qkn.10.1563984995154;
 Wed, 24 Jul 2019 09:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <6962093F-3E16-432E-AD00-CF6DA4916FD4@dynacommerce.com>
In-Reply-To: <6962093F-3E16-432E-AD00-CF6DA4916FD4@dynacommerce.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 24 Jul 2019 09:16:24 -0700
Message-ID: <CAJoAoZ=txFYEc9WhNyLqHn3n=4aEX0Eye6EOdqK0bD3Vpmj=sw@mail.gmail.com>
Subject: Re: Need help
To:     Gobinda Nandi <Gobinda.Nandi@dynacommerce.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gobinda, if you have a consistent way to reproduce the issue, check
out `git bisect`: https://git-scm.com/docs/git-bisect

 - Emily


On Wed, Jul 24, 2019 at 12:11 AM Gobinda Nandi
<Gobinda.Nandi@dynacommerce.com> wrote:
>
> Hi,
>
> I have cloned a project using GIT. There I am facing one issue and nobody=
 is confident that when that issue was not there. They are convinced that e=
arlier it was working well but noe its not. I am trying revert the version =
but still I am finding the issue. I know this can depend upon several varia=
ble but at least can you suggest how to check from git log.
>
> If this is not a right place ask this type of query then plz ignore it.
>
> Regards
> Gobinda Nandi
> Software Engineer
>


--=20
Emily Shaffer
