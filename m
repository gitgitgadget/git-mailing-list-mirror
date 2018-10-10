Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32481F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeJKGwO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 02:52:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35361 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKGwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 02:52:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so7552948wrt.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cJgBOjAQsZncyRkcm1jWy9buaHosBmokRkYX+eBeD7E=;
        b=SzSNfq1HyCpn0v2Hmkcd6WX+pQmAfRpNqBYdI9jWCjjG6IX75vy7azQRhr60cqky2N
         gwFHQWT6ATn3wXzUnzNhq7xcJM4E8zGO8Mx9AGUvJF8h/sawbhJopvQ+MgwqKRv9Wo+i
         rVydO6SN3C5p1kpklzArBbWrgf3BCt+FCSmH6tHdayrvzwWolBJfQmihQfA9TNLLAgwE
         lKWfaLllg1HFe7beorNx5MKSaFmk+DOTwweFn77g+0KfL+NQzeF/VkRDSE9xOlnClHHS
         TYPpkm4rPnWj2FkBnGEzOHoRbwPOsc3a0NVx15xv91PPvwC6we0QRTwyt9p7UDS6BIVi
         8BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cJgBOjAQsZncyRkcm1jWy9buaHosBmokRkYX+eBeD7E=;
        b=AHvdk9JRm1C9MuYP8NkElZ5IXy/HUu75Z6P50C5mdoVkkUMS7lyNa4n1muagQhpG2X
         AYGtor7bQNwERYVntlpYoggKUnQAAYomzUCDigAGyrO1UunkYosnYPOzf1imsIBKztx+
         UtFpx40yLgnI++4B+GSRAQeb4mzCZ03hzXWKMLwBd58QkQ/cUwHdkZn37i7jBkWkH3gv
         /9d5wYH/l7I+InBVDzHVNq8eyukU81MHQM/xoDOrcfYhr7xRn72LmVr0i+eagIE8lziV
         q9iaX3eQCflbWeZ1v9rHVLjnpM/eBw1hZXTCKChHfvOQ63YtYR4rZWWTPM9KvTrqoAwe
         2GuQ==
X-Gm-Message-State: ABuFfohy6CIPtJ2CjjYm9Pzl12rfnMnaPsyfmtudCrmrAYBSd9je1Lnq
        mxvlFiluSbW+migK33i8Kc0=
X-Google-Smtp-Source: ACcGV60Goce6lhyjrF3VkjMjwxsM41uSpETDxgh20wD07FcugyTsBdkIoLFTiSjb/QdK04Y1rS6m3w==
X-Received: by 2002:a5d:6383:: with SMTP id p3-v6mr25769194wru.291.1539214068215;
        Wed, 10 Oct 2018 16:27:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u191-v6sm20378743wmd.31.2018.10.10.16.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 16:27:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mihir Mehta <mihir@cs.utexas.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fix a typo and clarify a sentence
References: <xmqq36tdla1a.fsf@gitster-ct.c.googlers.com>
        <20181010222654.19871-1-mihir@cs.utexas.edu>
Date:   Thu, 11 Oct 2018 08:27:46 +0900
In-Reply-To: <20181010222654.19871-1-mihir@cs.utexas.edu> (Mihir Mehta's
        message of "Wed, 10 Oct 2018 17:26:54 -0500")
Message-ID: <xmqqo9c1jsb1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mihir Mehta <mihir@cs.utexas.edu> writes:

> -Just in case if you are doing something exotic, it should be
> +Just in case you are doing something exotic, it should be

Thanks.  Somehow I didn't notice this change earlier, but it looks
good, too.

Will queue.
