Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D091F829
	for <e@80x24.org>; Mon,  1 May 2017 01:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951679AbdEABmn (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:42:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36233 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951508AbdEABml (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:42:41 -0400
Received: by mail-pg0-f65.google.com with SMTP id v1so14189079pgv.3
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2jDS1y9v/rXzabJ+JPmL4JG8nfHYLzHyFv11wJowYCs=;
        b=IoJGd6/sP/xieNGMCqBRhdFPkPhFyIAviBXNA3+YQAFDwf7IXxrB4U5cqgP1GUumpM
         RV6xfsxsKqMFH1VKx/gxgQkwEe0oAe3DOC9lREZc9cd/k3NrYpNmfHrpYNpix6hbDstX
         yon2i+nk8eg6vxxVVRXnjkV3RGMTuY9IRBGoqFqY4nxXSX8kOm5OINQ5z6ngy5fitMeZ
         f03M4HeWU0vQU4edWB7rheEK/vPaE2Wf1T/XZACAf72LNf7fhpbLxFaqAVn0GVh58S4B
         ALC70+owE79m/mOR0a6SJBs4jA0Ac2uxb+YsH8gN0tsTBwgrfB73AENlNi0ifp2U+VfI
         U5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2jDS1y9v/rXzabJ+JPmL4JG8nfHYLzHyFv11wJowYCs=;
        b=GysUKyic8HpXIl7Ygu3GJjZp4uMEOzIIb+v58CPpxD13XF+rK9eaxhAI5cZ/cuhqso
         DQf9Xkj4bbY9wyjklRE0IhZCFowqmEEXlUpOmr5xwd/req4Fp67hohy6rYPWfNIhaaR8
         d4HNDEczo5cKQjRgjTBhYW4hOKny2kmiqyWX4FimqhSUOyoG8WGlW2ZkohZXE0CMv5ko
         a+5GWqpnPnod3bAd2pF2XqjXiKL3spETQcBCg/vC3o3buHFKKz7GNHLEwquhk+Vteg29
         wtIjVmrOIDhUd2QrZRNHxP1KINIFUheFiuIdKEc0DrheRgNnvfcdhHQLdEUkDQdp1wrA
         8rWg==
X-Gm-Message-State: AN3rC/5TD9bZUaYq3AgtTnSh1ZHM2Xi+2zdjevcecRn0kt+AX2Cy5d9O
        7VqNXHo9zFOlAg==
X-Received: by 10.99.64.135 with SMTP id n129mr12074756pga.103.1493602960594;
        Sun, 30 Apr 2017 18:42:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id d1sm8709295pfa.56.2017.04.30.18.42.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:42:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] changed submodules
References: <20170428235402.162251-1-bmwill@google.com>
Date:   Sun, 30 Apr 2017 18:42:39 -0700
In-Reply-To: <20170428235402.162251-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 28 Apr 2017 16:53:56 -0700")
Message-ID: <xmqq1ss9jqsw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> A little bit ago I was looking for a function in our code base which would be
> able to give me a list of all the submodules which changed across a number of
> commits.  I stumbled upon some of that logic in both our recurisve fetch and
> pull code paths.  Problem is both of these code paths were performing almost
> identical tasks, without sharing any code.
>
> This series is meant as a cleanup to submodule.c in order to unify these two
> code paths as well as make it easier for future callers to be able to query for
> submodules which have chagned across a number of commits.

Yay.  Nice to see code reduction.

>
> Brandon Williams (6):
>   submodule: rename add_sha1_to_array
>   submodule: rename free_submodules_sha1s
>   submodule: remove add_oid_to_argv
>   submodule: change string_list changed_submodule_paths
>   submodule: improve submodule_has_commits
>   submodule: refactor logic to determine changed submodules
>
>  submodule.c | 295 ++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 139 insertions(+), 156 deletions(-)
