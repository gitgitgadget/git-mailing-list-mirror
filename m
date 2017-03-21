Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169D420323
	for <e@80x24.org>; Tue, 21 Mar 2017 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756924AbdCUI2w (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 04:28:52 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37810 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755420AbdCUI2v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 04:28:51 -0400
Received: by mail-wm0-f46.google.com with SMTP id n11so6529954wma.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rJgQ0q9hAXXe02Aulc+aXdG/rrt0vlSrh3Sa3UomnZ8=;
        b=V97I4IdGUeJeSg9xlIMs18DbEAmRMDOmC+k74En9K84Qx0CN3AsGaXiC/lKpti5ZIZ
         SiqGPLYc88tZOk/5+7srekGbd7zg4GaO3830S0WYz8+AutYf2wYLhcO7PYY0e/zJ/3IZ
         b1j+RTR2Tj14N04rW3nDH4nFqL+gLudEc0xibd+qrnqVn96aUIB/nQib5H22VQwifcQX
         SaVQra/8O9DzE5bWsAVynPLR/HYTnnnFlm3TZVVtPXwgjcUB3zO6axxBlVa5DuKB+hsc
         CckI3GbCP+jyTDLfvP6uAWN/QprsHKw0wZkNofmQn9hNBmosWHfonfNkAI6RO+Pw2S3J
         ohpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rJgQ0q9hAXXe02Aulc+aXdG/rrt0vlSrh3Sa3UomnZ8=;
        b=Y1rR2c5HJD+eBXCJwFmjIYOfbbJ6vkExyTBw4Pj0CSMQVN0NoS75hLamkl8VosTRLi
         Irws5GxSApHvDNOQkVFJIdKGcPVX3ft9ZJ0zZGHvHBuygVr9GGTKCGmhs9W2iiBM4Wkr
         /VJRhv1k/XoTJwqro3VBuAtEEhLVok15aAVohP5NB8U1GY9ofx5D6YwS9fruPbTCnufZ
         iPffVqOSP0T5221xdZhIwTYBNEUZrquGkR17cd+I6prg88zzPg39MGPuANnCkamMLw2L
         eZhB5AaAA0V2KOiH8BHbXJjOvuyjXnR8hC1wA2Z+UDTSdAcJTQVeasv2QpSEW8dy8GJv
         bsUw==
X-Gm-Message-State: AFeK/H2xcN0z2d8HhUP3LI5aJs9LpLNw9O9DgP1vQWx1ymLvSyRqposgZx5B26hXy/+4uQ==
X-Received: by 10.28.215.74 with SMTP id o71mr1477420wmg.23.1490084929003;
        Tue, 21 Mar 2017 01:28:49 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB7DE7.dip0.t-ipconnect.de. [93.219.125.231])
        by smtp.gmail.com with ESMTPSA id 191sm16659345wmv.25.2017.03.21.01.28.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 01:28:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2017, #02; Fri, 3)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>
Date:   Tue, 21 Mar 2017 09:28:47 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA6E546F-3594-4673-A43B-7E4D4CEA8F68@gmail.com>
References: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com> <5C8A09B2-0C99-4BD9-A82B-B333EF1F155E@gmail.com> <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Mar 2017, at 22:08, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 04 Mar 2017, at 00:26, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>>=20
>>> * ls/filter-process-delayed (2017-01-08) 1 commit
>>> . convert: add "status=3Ddelayed" to filter process protocol

Sorry for the delayed response. I am still pursuing this topic but
unfortunately I wasn't able to spend time on it recently.


> For example, your async_convert_to_working_tree() returns Success or
> Delayed [*2*] and the callers of write_entry() cannot tell which the
> paths on the filesystem needs a call to checkout_delayed_entries()
> to finish them before they can safely tell the outside world that
> these paths are safe to use. =20
>=20
> It seems to me that any caller that calls checkout_entry() needs to
> essentially do:
>=20
> 	- compute which entries in the index need to be checked out
>          to the filesystem;
>=20
> 	- for each of them:
> 		- call checkout_entry()
>=20
> 	- call checkout_delayed_entries(), because among the
>          checkout_entry() calls we did in the above loop, some of
>          them may have "delayed", but we do not know which one(s).

Agreed. Would it be OK to store the "delayed" bit in the cache
entry itself? The extended ce_flags are stored on disk which is not
necessary I think. Would a new member in the cache_entry struct be
an acceptable option?


> Output from "git grep -e checkout_delayed_entries -e checkout_entry"
> seems to tell me that at least builtin/apply.c and
> builtin/checkout-index.c forget the last step.

For all these "single" checkout entry places the delayed checkout
makes no sense I think. Would you prefer something likes this:

checkout_entry(); finish_checkout();

or this:

checkout_entry(..., DISABLE_DELAYED_CHECKOUT);

in all these places?


> I'd understand the design better if the delayed-item list were a
> part of the "struct checkout" state structure, and write_entry(),

This works [1], however I had to remove "const" from=20
"const struct checkout *state" in a few places. OK?


> when delaying the write, returned enough information (not just "this
> has been delayed") that can be used to later instruct the
> long-running filter process things like "you gave me this 'delayed'
> token earlier; I want the result for it now!", "are you finished
> processing my earlier request, to which you gave me this 'delayed'
> token?", etc.  One of these instructions could be "here is the
> path. write the result out for the earlier request of mine you gave
> me this 'delayed' token for.  I do not need the result in-core.  And
> take as much time as you need--I do not mind blocking here at this
> point."  In a future, a new instruction may be added to ask "please
> give me the result in-core, as if you returned the result to my
> earlier original async_convert_to_working_tree() call without
> delaying the request."
>=20
> Within such a framework, your checkout_delayed_entries() would be a
> special case for finalizing a "struct checkout" that has been in
> use.  By enforcing that any "struct checkout" begins its life by a
> "state =3D CHECKOUT_INIT" initialization and finishes its life by a
> "finish_checkout(&state)" call, we will reduce risks to forget
> making necessary call to checkout_delayed_entries(), I would think.

Agreed. How would you want to enforce "finish_checkout(&state)", though?
By convention or by different means?


> *2* By the way, the code in write_entry() should have a final else
> clause that diagnoses an error return from
> async_convert_to_working_tree() and act on it---an unexpected return
> will fall through to the code that opens output fd and

It is ok for async_convert_to_working_tree() to fail if the filter is =
not
required. That's how it is currently implemented upstream.


I will post a new round to the mailing list soon. Here is a preview if
you want to look at the const changes etc:
=
https://github.com/larsxschneider/git/commit/a0132e564faaf5bca76af0ccc4ec6=
fe900be739a?w=3D1


Thanks,
Lars=
