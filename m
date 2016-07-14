Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E5C20196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbcGNStB (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:49:01 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34420 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbcGNSs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:48:59 -0400
Received: by mail-io0-f172.google.com with SMTP id q83so84252219iod.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 11:48:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hiLpJgrOGaJzDnJ+bUMGNuW0BVTszMT2iBtT2PsZ9N8=;
        b=iS2UD4LgjfXqF2fv+ynjPzZS6h/2i15DgwnHfJE63RYx6LM6yFL0/c2XQlTiOW5I4J
         JPzcrCUVYc/SdiUDGWeoEbuQVh0u/1h4YYJ2B9h8zyAVw+h2g1NxY3eqCTcBxsoUJ7L1
         f53wNh8f6r5zA38lufVsQdPjph2qZ6hVUZ99gSv9Qr+FAiOwLzdLWUzsH72bsnc6znym
         3g2Nrdm31QV4z6n+2dC6AWjbE2DTl3sfHTQUQylTAuPI1rP5suYJsGRJj5RMoIijILaE
         8gFt4wTx3W4CYIVRgspbwpwVuP4ssWHhTwRg0mm3DXaBTW2pjbkfXn8vU1OJkvhXCtgZ
         phsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hiLpJgrOGaJzDnJ+bUMGNuW0BVTszMT2iBtT2PsZ9N8=;
        b=mrJzgKSdI0eYvhQ3NXU2Bq01dJsXmJJkGOu+eZlQVGtXWbinAxvsGIPUtvc89bJ22J
         saE2cFKgAkRL+Q30zOaFVVofCRY/pz/ZMwI3NhnF7hqRnz+42ENfHP2uGQXYIrhhf1yQ
         /CIiTsVE75Ed42YllLNdtNYGOjEltiMP3B4+FdKgY48OcIZlYASRNoRi9XzjgjlquKcD
         x5eVy0R9Gpnsgm0P8nQy6iwE8+RORFNihQi8Osg7rfUS14PcGe2rkRGvaPuajPaCdBg+
         KIxJ1jzFjKewcwLMz8oE9PX3hgATCxdtLZ5kXxipbxVTH7fe0pz/Fp6G9cA5HoUMM+TH
         K5cw==
X-Gm-Message-State: ALyK8tJ3Q2MRW706FOtpSv0pbYYikx7O5RnKduTLnYoY+M4MQ2ZHXTqYQqNxPMekuOp6mXV6X44mX10TLllqMlMF
X-Received: by 10.107.144.10 with SMTP id s10mr15635604iod.165.1468522138600;
 Thu, 14 Jul 2016 11:48:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 14 Jul 2016 11:48:58 -0700 (PDT)
In-Reply-To: <20160714184146.GE16497@sigill.intra.peff.net>
References: <20160714173920.22001-1-sbeller@google.com> <20160714184146.GE16497@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 14 Jul 2016 11:48:58 -0700
Message-ID: <CAGZ79kaj2vfvS3RXCWqkZNdF7UkjAuv_J00kENPjz7SNTUV7BQ@mail.gmail.com>
Subject: Re: [PATCHv5 0/4] Push options
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dan Wang <dwwang@google.com>, Eric Wong <e@80x24.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 11:41 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 14, 2016 at 10:39:16AM -0700, Stefan Beller wrote:
>
>> Jeff wrote:
>> > Junio wrote:
>> >> I think those extra knobs can come later.  If we are not going to
>> >> limit with max_options in the end, however, wouldn't it be more
>> >> natural for the initial iteration without any configuration not to
>> >> have hard-coded max_options at all?
>> >
>> > Yeah, I am OK with adding restrictive knobs later as a separate topic.
>> > As Stefan notes, upstream does not have the other knobs anyway, and IIRC
>> > the push-options feature is not even enabled by default.
>>
>> * now it actually is not a default. ;)
>
> Hmm. So that is a downside for people who have implemented separate DoS
> protection only in that upgrading git will open a new "hole" that they
> need to plug. But that is their problem, not upstream git's.
>
> -Peff

But this is not specific to DoS protection, but like most features.
Just look at the vendors
using linux that think carrying patches out of tree for their special
snowflake hardware
is cheaper than getting it upstream.... (This is not to be read as a
snarky comment, but
rather as a pointer to the similarity of the mechanisms involved).
Although I cannot tell
offhand another feature that would easily break downstream customization.

Stefan
