Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8738205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 12:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966308AbdAKM5y (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 07:57:54 -0500
Received: from mail-wj0-f172.google.com ([209.85.210.172]:34410 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966244AbdAKM5x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 07:57:53 -0500
Received: by mail-wj0-f172.google.com with SMTP id tn15so101752305wjb.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4obMhpq8NnXLgL8In8lyVAF5I26DNNBn0Ov4+pbyKTg=;
        b=S8nMG7EOfiv8dvoapIKiIKviz+EKrwRa8rIrXekdPZBMTBix4+F75ieJIESUH7dkDZ
         Jw6TPo0k5glqhmlPRFPJIMQrT1sjxImbsgcZz0jQFWyNrlK7n1tNxwUzyMPj3tTywp01
         L7p+mlhDj73akKqlgvtYTOnoBdaTOxQCPfyKlQYWSsUWFI1v1ApmpGd8qp58q0fLOuDk
         dCHi9uW8ruK7KZ8KvxhSIQtTSV/c+rXY3dmSHmWRodYVYsV27Vv5hepJgo5PINtxeCRp
         SgwQwDRnRWCwOchCZ1TGV/WdXA+V37u6Yf9BCordCY73/p5TZLr9JrwnAeuscq6YV6om
         pGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4obMhpq8NnXLgL8In8lyVAF5I26DNNBn0Ov4+pbyKTg=;
        b=gC0SZhl6JVy9alpGJWP1gDxU4SEUcmiVmLWkJP8dZ7+6T4lQilE0XQnjVG1xpyqrUL
         ZdXX7iFUpCgn6h1wNgaf1aMB9eovJATEEb0lT5HTDvHTw/oESQxzn1y4KlJq6zm1+z7V
         7AersND5HuFCSZcDTY/nq0kV30iseteidsMbTWMjdI0LyWfeLq5Qa6H9qobmDLTWdaSI
         vCa5I8iZqh8kw6CNStXyNc2OjVOvoMMWpCQDXabZD4Va6fUkXNTu6wkka13l6VqkZz6D
         pyqyNjSxOVtG5GFPluybqMAzbFp7QyBu/DNd4zimbKdQbLfb8hyQajIVZP/KVu3yntjz
         S2EQ==
X-Gm-Message-State: AIkVDXIlJA/eUwwEdguU7lfnmDuhz9VvgQOtw6y4iD9IPbV0Uk7KwFLNwaNtUoB0+6GCmA==
X-Received: by 10.194.77.129 with SMTP id s1mr5143185wjw.82.1484139470593;
        Wed, 11 Jan 2017 04:57:50 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e14sm20705373wmd.14.2017.01.11.04.57.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 04:57:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kYDPLDU5Dg_CTnpEX+D9bs6BUSSNTHkqpW2nY-b=e9+SQ@mail.gmail.com>
Date:   Wed, 11 Jan 2017 13:57:49 +0100
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B46B8E63-4447-4182-B95C-8D1E02D71F6F@gmail.com>
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com> <CAGZ79kYDPLDU5Dg_CTnpEX+D9bs6BUSSNTHkqpW2nY-b=e9+SQ@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Jan 2017, at 21:44, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Mon, Nov 14, 2016 at 1:09 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>=20
>> Git always performs a clean/smudge filter on files in sequential =
order.
>> Sometimes a filter operation can take a noticeable amount of time.
>> This blocks the entire Git process.
>>=20
>> I would like to give a filter process the possibility to answer Git =
with
>> "I got your request, I am processing it, ask me for the result =
later!".
>>=20
>> I see the following way to realize this:
>>=20
>> In unpack-trees.c:check_updates() [1] we loop through the cache
>> entries and "ask me later" could be an acceptable return value of the
>> checkout_entry() call. The loop could run until all entries returned
>> success or error.
>=20
> Late to this thread, but here is an answer nevertheless.
>=20
> I am currently working on getting submodules working
> for working tree modifying commands (prominently checkout, but
> also read-tree -u and any other caller that uses the code in
> unpack-trees.)
>=20
> Once the submodules are supported and used, I anticipate that
> putting the files in the working tree on disk will become a bottle =
neck,
> i.e. the checkout taking way too long for an oversized project.
>=20
> So in the future we have to do something to make checkout fast
> again, which IMHO is threading. My current vision is to have checkout
> automatically choose a number of threads based on expected workload,
> c.f. preload-index.c, line 18-25.

That sounds interesting! We are using "submodule.fetchjobs=3D0" to =
process
submodules in parallel already and it works great! Thanks a lot for
implementing this!


>> The filter machinery is triggered in various other places in Git and
>> all places that want to support "ask me later" would need to be =
patched
>> accordingly.
>=20
> I think this makes sense, even in a threaded git-checkout.
> I assume this idea is implemented before threading hits checkout,
> so a question on the design:
>=20
> Who determines the workload that is acceptable?
> =46rom reading this email, it seems to be solely the filter that uses
> as many threads/processes as it thinks is ok.

Correct.


> Would it be possible to enhance the protocol further to have
> Git also mingle with the workload, i.e. tell the filter it is
> allowed to use up (N-M) threads, as it itself already uses
> M out of N configured threads?
>=20
> (I do not want to discuss the details here, but only if such a thing
> is viable with this approach as well)

Yes, I think we could give a filter these kind of hints. However, it
would, of course, be up to the filter implementation to follow the =
hints.

In case you curious, here is the discussion on v1 of the delay =
implementation:
=
http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.co=
m/


Cheers,
Lars=
