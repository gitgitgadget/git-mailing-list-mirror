Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719341FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 07:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032265AbdDUHKb (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 03:10:31 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33184 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945680AbdDUHKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 03:10:30 -0400
Received: by mail-lf0-f47.google.com with SMTP id 88so40217102lfr.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rLprq2LS4Lwhbuj8n+SnPGWMoJeZ/iVw3XM9MS9QUsY=;
        b=YkD0UCKMSTsG2z9YMEdhv7USZlk/zm3f61lgXw7KgkPJ1feKj/0w8vRatYCBY5bhG6
         Lruc4KQUGYVs0dtK0s9rUNWFMYWe9ssMnXheUv0m8a4Ij5sjsVZs/ULGiPBW6Pga9FXp
         A0eQlOqzQ7QutZlPY7sXiDUm7hUj3vHZjlYbIbhkYMWEvyGw7Dzw2zHPt0TRHRkjpjiv
         2aGE9EC/Y0FJ5mbcZHJyZBu5/GGszoP4S0f3MJUpUag70QRObGVZMu7WjF85raUIDWL7
         ho+w0lAjO6C/NSp5IJNcnCVSshSCvFK80IOWrwQg6RdBJEt8pB4/r2aZgoZtTVsBIJ4a
         gdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rLprq2LS4Lwhbuj8n+SnPGWMoJeZ/iVw3XM9MS9QUsY=;
        b=uGJb7Vv3q/WmyjoiUuOvBTBXBCahu+hTgVswfsea/dsTdeKJRvMawTH9ooMzbow8Gw
         f5mb8jhsQLb7Qt6tWWo4FWKdcyt1OzgVxPbOBigxj3LR7tHfCvGDWjLjcqZyJtrmonhi
         MWk64shUe7d49OkUzOv/O5Rhs59nJqrzdA3XjkeGEfd+Onq7oL4KKrSixYcb65A1SHK9
         yR9EtjQLiDfW1LxPLRYtmT1wq0Dsm2BRX4rOS5B84I5o+ASoK8UfQTFKcnpSv5JsMUvP
         Tm6Jv6KRXtnRQBGimwf/HtQY5Sgcvyz5upBjmtnetSOAVxCSigzlH0I6NMrOfqasZd9R
         vmtg==
X-Gm-Message-State: AN3rC/5nNXj+w2Hl2lU4fdUtK+e5H2Ony1VOEJDzLQdpQlzKSCsFokMW
        ZcidYsSNbioeOi/vPfm8kx5HNcGxrg==
X-Received: by 10.25.18.211 with SMTP id 80mr3837700lfs.129.1492758628648;
 Fri, 21 Apr 2017 00:10:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Fri, 21 Apr 2017 00:10:28 -0700 (PDT)
In-Reply-To: <20170420212436.GC4989@hank>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Apr 2017 09:10:28 +0200
Message-ID: <CAP8UFD25tJgQD=bREOG-_q0jCLw-nxhO6pYbOaaYMuAH4VxN3Q@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 04/20, Christian Couder wrote:
>>
>> Could you try with the following patch:
>>
>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>
> Yeah, I tried with and without that patch with the same result.
> Unless I'm screwing something up when testing I don't think this fixes
> the issue unfortunately.

Ok, I will take a look soon.

By the way I think that GIT_TEST_SPLIT_INDEX has become redundant now
that there is core.splitIndex.
So perhaps in the long run it will be best to deprecate
GIT_TEST_SPLIT_INDEX and eventually remove it.
