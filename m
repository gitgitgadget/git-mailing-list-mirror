Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD761F597
	for <e@80x24.org>; Wed, 25 Jul 2018 10:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeGYMFh (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 08:05:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39040 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbeGYMFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 08:05:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so5505697wmb.4
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=3P8RlRHHHM05E68cq61DAmrFnbk2DuD9kr/8fjEqxmQ=;
        b=t1OZH1woredkgLml0/mw7OTDnbmMAcqXW/XCrKa2toyDWV8pz8rwP0ySXX07NQ6CvC
         92qtQVZ+vZqloPh2XIOl+8WUCzQq9/3WQYDxLy4JuRMVhU4SwPYM7A7HHzBJIEgP3cqh
         W9g0IjhGFRAAIIlg2/eEIAhvk1Jkswwum2wU+cxUbDtOMks/b3H9JFTh0eLI9px9Tt6r
         hP/k/JqqK/naCKVU3FrHwOFgWfY5acbOsvcGYB4Kp51S1LUnbZ2POAaqB5XVgz8AUccm
         3kDHObzhdG+SIeZw3kcDLsF25tVEsZsiF6D0CV28IWqNF/C15W6yVAUIthGfEdRZukaG
         9Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=3P8RlRHHHM05E68cq61DAmrFnbk2DuD9kr/8fjEqxmQ=;
        b=QFKPIvjFfoFzJzcRVSqVcA324oT0EVSaDkoEYfqttj/C4TJlICcvroMjfghm7Rz1aN
         ZBaOIgBPcDaJlIBzHR0DHuoTbwTDJJSaYZeTu4AW9cIhhiiI/gvq4agnDjIYb5vO3gY9
         VaDkwo9zVaxMLFlMRCA5A/p3+OqmCVrCiT4bWqWlRS1E0E15YwJW8ghVMvFNuwyKo1nU
         HBgS21e/zRMZXX7se0m2bVPZboutbwel5McJNWGXVZMh45Nan4VTTMM82lJ2R8opG99k
         BAi/Qg0mqK8CgZyFVjyRB4+YRnLSVB3fdLzzdmOn83hZArQonNvrgXqiDclxWXmXpWn+
         A2AA==
X-Gm-Message-State: AOUpUlFprUWVFIdDtgsGM8fLll4Y2LXZDCnXID5KLlVEIoUhy9wj3OiU
        zbm/VBHPE6W6XBYZ0gv6meS957pAVMM=
X-Google-Smtp-Source: AAOMgpeMXtVfWP+dYkY893MJj4eIvT1JK2aGRjX5G80E8NTl7NAVB1FGsb8TrnjFyXx+BMFx9Vt8Eg==
X-Received: by 2002:a1c:d6cf:: with SMTP id n198-v6mr4572763wmg.61.1532516067701;
        Wed, 25 Jul 2018 03:54:27 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id a12-v6sm7558338wru.61.2018.07.25.03.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 03:54:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     mail@daniel-baumann.ch
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Remove superfluous tab in rebase
References: <db70d275-584e-3a3b-5201-dc04e4c5950b@daniel-baumann.ch>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <db70d275-584e-3a3b-5201-dc04e4c5950b@daniel-baumann.ch>
Date:   Wed, 25 Jul 2018 12:54:26 +0200
Message-ID: <87o9evbn6l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 25 2018, Daniel Baumann wrote:

> the attached patch removes a superfluous tab indentation in the
> interactive git-rebase messages.
>
> It would be nice to get rid of this to avoid visual disturbance with
> whitespace highlighting editors.

The code you're modifying doesn't exist in the "pu" branch since
249d626f2c ("rebase--interactive: rewrite append_todo_help() in C",
2018-07-10), rebase is being rewritten in C. From looking at it it seems
we no longer have this problem, but perhaps you'd like to check that out
for yourself?
