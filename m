Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3C41F403
	for <e@80x24.org>; Mon, 18 Jun 2018 11:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933488AbeFRLaz (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 07:30:55 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35377 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbeFRLay (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 07:30:54 -0400
Received: by mail-ot0-f174.google.com with SMTP id q17-v6so18057530otg.2
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JMCa3SEdK1hfS1whHRccEueUe9effcK0tZ0KEJnTK2E=;
        b=fdEBM6B+zxQAmgrLkbqYyZsCbAg6ecVrxalFR+Ed7aEzziPkEnh+Diwip4jrQCpQNg
         CXAbBL+djt1ztDSLUTOhRMSyfFReF54sveuoEA79xBnc2GLV3w4Zopc2RgoXpYVNRDhY
         uFikPeOZshoPSqXPIVoyNO/kztehyxrouq2ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JMCa3SEdK1hfS1whHRccEueUe9effcK0tZ0KEJnTK2E=;
        b=RO3l5iLNwXgxLJwEGtD/6ihbZLbP/ZBFsJU6k0WTuT4nWVQe/0kXVgoT/68SJimegd
         F1PISaAlK7hkFw6acd6tLCbLnbFVq8FSl4SmDZLOJB3pF1Gkb0PcLfWKblDgqmFRxi6z
         KExV3ROnKei8tKokXoLi4Di5ASTpUSMRqCMaYOfpksxr6QQexWNQ/4RAh/AIPkVLAxoS
         it2cLpI3od1q3SXwexRqY7YuiVp3jeZ8SSmgCrVSwIE1oFy2/N7Lo0QXUEg3Cw4fxC9Z
         fXqP6rszz1QYk3SkaXXRwn+gMhqT6Bh/aKHthY9LgbJu9zSgeLSGn2JT9H1IRiw/LbiD
         n5zA==
X-Gm-Message-State: APt69E2ktNR1P4FR3toA/PJrFGj5L82o7yukTiOxYVo35JX69UhIwDDZ
        rlvynUVHUxrEgWiQWLUc7APZIKdWvddNXkQ9lGdTHg==
X-Google-Smtp-Source: ADUXVKJxRfQYTuhbzf1zIf6toWSJY+Shd6ZOXeswPHe9iPmzM3B2qOh+1v1R5juEvldus6hLoYjjeBWSSlpBGsIgxh0=
X-Received: by 2002:a9d:4e82:: with SMTP id v2-v6mr7075003otk.255.1529321453920;
 Mon, 18 Jun 2018 04:30:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 04:30:53
 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 18 Jun 2018 12:30:53 +0100
Message-ID: <CAE5ih78DG1o2eKSNSbdJ4AeYLpAWVowp7NqhrobkxAdQ8ZTNdA@mail.gmail.com>
Subject: Re: Re :Re: [PATCHv3 0/1] git-p4 unshelve
To:     "merlorom@yahoo.fr" <merlorom@yahoo.fr>
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 June 2018 at 10:58, merlorom@yahoo.fr <merlorom@yahoo.fr> wrote:
> Yes Luke, my colleagues and I, we care ! Our repository is p4 (choice of the
> high management, sigh...). Some of us are working natively on p4, but others
> like me are working on git through git-p4. We often want to share pieces of
> codes to check compilation on misc platforms/configs, and shelve/unshelve
> mechanism is commonly used between nativ p4 users.
> For git-p4 users we have a temporary hack to unshelve, but it often fails to
> apply the whole p4 diff, and we end up finishing stuff by hand, checking
> line by line, sigh... Without speaking about diffs that are accross several
> local workspaces.
> Hopefully it is on small shelved p4 change lists for the moment, but we
> cannot deploy on a larger scale.
> Please continue your hard work on unshelve stuff.
>
> For your last remark, the members of our team often need to work on non
> synchro revisions, but still need to share via shelve/unshelve, and I am
> sure we will have conflits as you describe, leading unshelve to fail.
> Automatic fast import would save us the need to stop our current work, sync
> with p4 and launch a 1h compilation, before we could unshelve... So yes we
> need it !

OK, I'll give it a go, in my copious free time :-)

Luke
