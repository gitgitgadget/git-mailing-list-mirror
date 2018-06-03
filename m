Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123C71F403
	for <e@80x24.org>; Sun,  3 Jun 2018 17:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeFCRnn (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 13:43:43 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:46925 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFCRnn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 13:43:43 -0400
Received: by mail-oi0-f47.google.com with SMTP id h79-v6so19989847oig.13
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TfbAbCEwlcYQLdh9QAkQLpNwnSv756r9tEkd0UklonE=;
        b=m3Kn8b1nq9DTv/JawpLL125RBusjjFyFPogDcOzBOpqOgNqFJbXa0kx2Fj6xYJMdqx
         +78Uvi8vKssNic5H6db6RRJQdN/vmoTIPGrLu7C2vCYWGlexvnicenb1eZ1dYwIRdLrB
         KN0UaQZQcw07H656kzY/B5Y2YRrX7H2TlOrdT/iC95R2aSuq7s/qGyWDY/eAB+rt3Qa/
         gvVbxRlbnghFvZx+mMM1gficKZzd/DDgFo/3Wiyg8P78UYbXPu0Pd2HDG3ijVnnmGYca
         kYMYK37TAUkEM8fHMkGtVJ6jopG17fX8J7tRS7YrZiCHmHAUqv+pwmE04JmX9gwBX11G
         JvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TfbAbCEwlcYQLdh9QAkQLpNwnSv756r9tEkd0UklonE=;
        b=lo1oVAKtS6iyq3Kezru/Uu7qUy7VGIu1zBSt4nYA2g34KlFXGtxxOHxfBsvmBGnJLO
         wk6HTFKWcZmQFevIpcSAcvT+SCg6m317YY1WiqXqYutO9WwOzcD0vyVkaVIkLEQkE+LH
         GAfx72fq3qJZtjAxy8D8wlxeac5BYSJjQklhT6SqnbNKwpa1go8jFyQgheJM5Rw1OguX
         Wdq81ooqeboZgLdca9UoZ/0WNq/NtW2QTBG8WK1eaWsf02eiqEW4GNitA8g6y8SRhhnO
         m0JV8E8dlzROi3X/hUrVAkzoshzKwuhnyEmDRDsZr2egHRZri+iFQJuwiW8sIs+eOgWj
         bZ0g==
X-Gm-Message-State: ALKqPwdX+p/cHDrXHjk0WNezEMK6Qawtg54Ie65ceqH6EUrkWx7J8dON
        h3J9NTp2aM5glspKaaTn4J4ETSiEeqSHFk583h0Elg==
X-Google-Smtp-Source: ADUXVKLfsAb8rOTXJhHLgjc31zgH6yo2aUV0zYln/Sc1uXZzqjMJ6NSlHJqW3dg+F4n7rBX7kRnyN5+PoBHk+5aOw1o=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr7913799oie.30.1528047822415;
 Sun, 03 Jun 2018 10:43:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 10:43:12 -0700 (PDT)
In-Reply-To: <20180603005834.rwl5mx7llrv767xn@HP>
References: <20180603005834.rwl5mx7llrv767xn@HP>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 3 Jun 2018 19:43:12 +0200
Message-ID: <CACsJy8Ar93y19JuYK+_NDQOn=4+8EH6e+9vWOQZNMGnLgExF-w@mail.gmail.com>
Subject: Re: git glob pattern in .gitignore and git command
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Geekaholic <geekaholiclin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 3, 2018 at 2:58 AM, Yubin Ruan <ablacktshirt@gmail.com> wrote:
> To ignore all .js file under a directory `lib', I can use "lib/**/js" to match
> them. But when using git command such as "git add", using "git add lib/\*.js"
> is sufficient. Why is this difference in glob mode?

Historical reasons mostly. '**' comes later when '*' already
establishes its place. You can use '**' too with "git add
':(glob)lib/**/*.js'". See
https://git-scm.com/docs/gitglossary#gitglossary-aiddefpathspecapathspec
-- 
Duy
