Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304451F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeCPUOj (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:14:39 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:45717 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeCPUOi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:14:38 -0400
Received: by mail-ua0-f195.google.com with SMTP id x17so901063uaj.12
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+CS3N9deyzNTj5rNNJeddbW2GRqxY7dbbEhnvVGaiJI=;
        b=q+gL8EEIj5PioKLX5E28FEL/ECusQC33XLSXH+vkCQWMhaIcbnWhDNAL7RT9x9Oi97
         R4rsCtwYWiHPnaU0M8IdjP+G/yS8y4p0BQA3IpATSDx8u2hGwBgq8KIu5jgX6QwiAtlr
         g10uH0SoOxBvY82L3gsK/69R4/+cMebe/4362sQEvWT9ZkCOFIpVshC0fQRMkpYGYarZ
         bVV8ExgcO5OTSH5U09arkpFLRVKDlM41+06EtSS3uIM2rWdd50/yIa7QfpbyjcwUdKie
         QFbaH+jCn5grNF2n5kQyG7OVBEnZMOvl3mvbgYnkYdiREPB1PIs9wxMtmcXxgxwNm9xN
         9CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+CS3N9deyzNTj5rNNJeddbW2GRqxY7dbbEhnvVGaiJI=;
        b=njzKhsAKGJDeazjC3wLnhJKo+cu8lBmXwWapC/Ff4pjBvSh3fhIYz0VEkEKidZKix5
         5ox/mx6Fi+EOnpB3QWRgSBi0Ts6kWe3+xZIVt++LQ8XbOftm2lvj6SBUSPCpeC9Tj0YZ
         m8YWslvRYq1f0BIwaojdT0oMWGCRR98kmvQF5YUdRoqpgt57CKeL47dlntpiCVfaJvx8
         fgzveuO0LCFvm7vjknYSh1UR20vr3pcZp8VBlQkUL1TFbwwrIciS6FlrDcWM1aU9NvjB
         R4xMrzWG0TZApbx0HVyxRILjWSFSerU1EEVV4nLAwR6x0d+EyPpUTx+b9EUilQTIKa3o
         TnPA==
X-Gm-Message-State: AElRT7E+CqzUt8G0Y6BbB5ClmX7GWGOUGVqGauKVIq3YFwCOD54JD9qp
        FPrK1WPXmJ9D8kPeb7rwN7UiEHCSmbkFyxQaQjwbOg==
X-Google-Smtp-Source: AG47ELs1auJvr64Lmtj7XCmQ67VUlIp1fuSO22KXYsFkn9r9PqXgmxsGbzddiMRyP7VzLgsUCI9P5dN+N8bxpzxFWo8=
X-Received: by 10.176.18.226 with SMTP id o34mr2208345uac.5.1521229729428;
 Fri, 16 Mar 2018 12:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 16 Mar 2018 12:48:49 -0700 (PDT)
In-Reply-To: <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com> <878tasdpqo.fsf@evledraar.gmail.com>
 <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com> <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 16 Mar 2018 20:48:49 +0100
Message-ID: <CAM0VKjmVgiWsqo8rQWwP9+mEq0tLinc8xoUM=8XdMP3VTBwJxw@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> You should forget '--stdin-packs' and use '--stdin-commits' to generate
>> the initial graph, it's much faster even without '--additive'[1].  See
>>
>>   https://public-inbox.org/git/CAM0VKj=3DwmkBNH=3DpsCRztXFrC13RiG1EaSw89=
Q6LJaNsdJDEFHg@mail.gmail.com/
>>
>> I still think that the default behaviour for 'git commit-graph write'
>> should simply walk history from all refs instead of enumerating all
>> objects in all packfiles.
>
> Somehow I missed that one.  Thanks for the link to it.
>
> It is not so surprising that history walking runs rings around
> enumerating objects in packfiles, if packfiles are built well.
>
> A well-built packfile tends to has newer objects in base form and
> has delta that goes in backward direction (older objects are
> represented as delta against newer ones).  This helps warlking from
> the tips of the history quite a bit, because your delta base cache
> will tend to have the base object (i.e. objects in the newer part of
> the history you just walked) that will be required to access the
> "next" older part of the history more often than not.
>
> Trying to read the objects in the pack in their object name order
> would essentially mean reading them in a cryptgraphically random
> order.  Half the time you will end up wanting to access an object
> that is near the tip of a very deep delta chain even before you've
> accessed any of the base objects in the delta chain.

I came up with a different explanation back then: we are only interested
in commit objects when creating the commit graph, and only a small-ish
fraction of all objects are commit objects, so the "enumerate objects in
packfiles" approach has to look at a lot more objects:

  # in my git fork
  $ git rev-list --all --objects |cut -d' ' -f1 |\
    git cat-file --batch-check=3D'%(objecttype) %(objectsize)' >type-size
  $ grep -c ^commit type-size
  53754
  $ wc -l type-size
  244723 type-size

I.e. only about 20% of all objects are commit objects.

Furthermore, in order to look at an object it has to be zlib inflated
first, and since commit objects tend to be much smaller than trees and
especially blobs, there are a lot less bytes to inflate:

  $ grep ^commit type-size |cut -d' ' -f2 |avg
  34395730 / 53754 =3D 639
  $ cat type-size |cut -d' ' -f2 |avg
  3866685744 / 244723 =3D 15800

So a simple revision walk inflates less than 1% of the bytes that the
"enumerate objects packfiles" approach has to inflate.


>> [1] - Please excuse the bikeshed: '--additive' is such a strange
>>       sounding option name, at least for me.  '--append', perhaps?
>
> Yeah, I think "fetch --append" is probably a precedence.
