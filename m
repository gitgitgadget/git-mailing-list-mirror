Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9092018B
	for <e@80x24.org>; Mon, 18 Jul 2016 21:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbcGRV2X (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 17:28:23 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37066 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbcGRV2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 17:28:22 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so2722815ith.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 14:28:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zTIAsRyo5Bau19yD6zSxx+rQnLzAvGOB4qCNjf8yDiA=;
        b=kooGLHMYgMYGPDceUkrLDJ8awF3UvReQxn24HKtSKrcgJHVPgMGQEh2qrHgLi7YpCb
         aBnmnzdyXKGzQnuhi1VXOytbGt2acZAmZcWWw0lnPJalS/ToohokLAh1dRwpCzYV07Ee
         1gsAd5LPQ2kYtWjDatElo4csdPPEeDzrLPtyj1tT41R9cP0vwpQGHP0+ey9WjCmwpW72
         nJ61ecrWCy0atZlTrR+FAC2Xr53QidDnJaF1AjqqRULIlQJzibnqIoOnsmlc6mWtWZkH
         fVMgasX5Rf1xxXj3TPhtSsoAY3dNM2N61SckB/L5rCymQF5WB1KvTMNkVvfknBR1Reyf
         OlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zTIAsRyo5Bau19yD6zSxx+rQnLzAvGOB4qCNjf8yDiA=;
        b=UzI0A6G1VCe76QT/rHCjHSyH4nKDh9X4D0mm9BEXTnIlMm9GUUEflQDX3sSadsFy9t
         lY8tDr1U8o847RZc8lR+zVoaBF/q8BHN36i+jgyGMAzDpADl+qs0dE18hOfQWRc5jgzc
         5nnCBQi2T4XXbl4W6KMz/D8Hifr7XY4ao2a0voOeSAaUKoof2HqlI1puYxbQjk4TJIe4
         H5GLwWJp5dmAQe0hFdhJ1IuCsKEJbIW4aX6dZyYHkOS1FNmRDrpycS3gyV9Bv3FJyakJ
         EuJ6DOTsXWTWjkEsG/u4mikOgPU+JD/CZlJpbk/3VkJ9aKwM4dORTq0RfFHrE3z7tnXd
         oG9g==
X-Gm-Message-State: ALyK8tIHbG3SVgjt87XZR0jPKMmIYfqUrKXnLizGycuAB7KCJhGDTOnBJJ1oJxOKlylDAMD801TkHneKXAbCwg==
X-Received: by 10.36.50.206 with SMTP id j197mr48239090ita.70.1468877301210;
 Mon, 18 Jul 2016 14:28:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Mon, 18 Jul 2016 14:28:20 -0700 (PDT)
In-Reply-To: <xmqq7fciis45.fsf@gitster.mtv.corp.google.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <CACBZZX5wjhYosupW=-n7UbbXAQug+sgSNS+jm_uUn6QwC8p6Aw@mail.gmail.com>
 <CAPp-Vra5ri7V03SSkU6=UnWrsq-jk0XcNpQuzGH8kQxE-TkPjA@mail.gmail.com>
 <CACBZZX4N37Ty2yZosHA+PexscLc_Y4_QDZNktVM8bza_5cGu+g@mail.gmail.com> <xmqq7fciis45.fsf@gitster.mtv.corp.google.com>
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Mon, 18 Jul 2016 23:28:20 +0200
Message-ID: <CAPp-VrZoJ3JwUTZ9Bjv2NwLUE3ia9fNcanbujFB5P+Kw8hAzoQ@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git <git@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>> The reality of the current situation is that it's largely mitigated in
>> practice because:
>>
>> a) it's hard to hand someone a crafted blob to begin with for reasons
>> that have nothing to do with SHA-1 (they'll go "wtf is this garbage?")
>>
>> b) even in that case it's *very* hard to come up with two colliding
>> blobs that are *useful* for some nefarious purpose, e.g. a program A
>> that looks normal being replaced by an evil program B with the same
>> SHA-1.
>
> Thanks.  That's a nice rephrasing of
>
>   http://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901%40ppc970.osdl.org/
>
> where Linus explains SHA-1 is not the security, and the real
> security is in distribution.

If the real security is in the distribution, than why git supports
signed commits and objects?

The security of the signatures do depend on the hash. Saying the hash
is not a security feature and offering GPG signing based on that hash
is a damn big lie. You can change the hash algorithm to a secure one,
or change the signing method to be independent of the hash algorithm,
or you can stop offering signatures at all, but something has to be
done here.
