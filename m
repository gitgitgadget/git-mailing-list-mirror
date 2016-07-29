Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4EA1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 17:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbcG2Rn6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 13:43:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35886 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcG2Rn4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 13:43:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id x83so16688959wma.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 10:43:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C/VrD8Ta59hxXkRxyyhKWI5An3P87Oodddf0MbXmaKc=;
        b=Fq7uqSGkMm0quO9orK6B29OZy44mLCrFwHoXIWBkS2yZiyQ+NGRl58tTH5IfP6+Pgd
         hCrI6csCd4a8euOOh58DKKaDRYPPrVupPFnLw3/EWB92r8ERZfltlD+UJmqGw2dFZpPh
         D7U1Zbw5aWL+jyFQK5aBYQ1zqbjlZuiutszMD5kWfHxI53t5qTNYxkAQACDmzvE+B53L
         yqxA4yWHnItHKRe8lvd+R7Kfrj5Qpv87xr0+qbgvPkdwmw7soQbZtY6NFTpS/wso2MYG
         5iVpSGEAfh6F5m1o1/6firx8ssErqjgDyGwWENqCX3xZA90N/a8y693JXK72vYeiWXop
         QGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C/VrD8Ta59hxXkRxyyhKWI5An3P87Oodddf0MbXmaKc=;
        b=G0HVmMRSRFhuk6kQP10VQkHAASqQ7ZwiJW5G3V9DsP5rjApw5BGO2IIX05qgz2Nbw4
         3FJALoscXkD1hHFGlWFnh9ctGzKp+VSrbMUjBYF6qONZIcGYSbWLREzHu+Iw7aOfPW79
         egJsCpO/yG9du05vMGfqhvTLbk5y53s4vHiaB+2ywltzQw+tl2rXIRFJe2QdJZ6wOBwH
         zhTyB6BrDnbeasILZdaj751mf71vDMegyap60muiUIjM+ay0Rd5Ux2BTwovSJh+g5eU6
         cxrBtSH2svBklwBj9iEK/xcJQb8Run5vdYUj4hjYOn+oJur1mNJYQIb3Y/ubvbt6trnz
         TjbA==
X-Gm-Message-State: AEkoouvsPEYEgJV4MSDWu7ap+SA0tDKGa9YCRQdm70WkdMO3gNJKDUnmJJHCvGg8e9chlA==
X-Received: by 10.28.111.4 with SMTP id k4mr47970738wmc.94.1469814234368;
        Fri, 29 Jul 2016 10:43:54 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d80sm4060618wmd.14.2016.07.29.10.43.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 10:43:53 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/5] Git filter protocol
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160729165018.GA6553@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 19:43:49 +0200
Cc:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, e@80x24.org,
	ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: 8BIT
Message-Id: <9C2A3438-84BA-49FE-87AA-1084995A1E89@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <579906C5.1050809@gmail.com> <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com> <20160728132906.GA21311@sigill.intra.peff.net> <579B087F.7090108@gmail.com> <31219A33-CA8A-44D1-9DE0-6448AA1A7571@gmail.com> <20160729155740.GB29773@sigill.intra.peff.net> <FA73FFDF-51D1-49FD-A24E-72A2C033E2F3@gmail.com> <20160729165018.GA6553@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 29 Jul 2016, at 18:50, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Jul 29, 2016 at 06:20:51PM +0200, Lars Schneider wrote:
> 
>>>> That being said a "fail" response is a very good idea! This allows
>>>> the filter to communicate to git that a non required filter process
>>>> failed. I will add that to the protocol. Thanks :) 
>>> 
>>> Maybe just send "ok <size>", "ok -1" (for streaming), or "fail <reason>"
>>> followed by the content? That is similar to other Git protocols, though
>>> I am not sure they are good models for sanity or extensibility. :)
>>> 
>>> I don't know if you would want to leave room for other "headers" in the
>>> response, but you could also do something more HTTP-like, with a status
>>> code, and arbitrary headers. And presumably git would just ignore
>>> headers it doesn't know about. I think that's what Jakub's example was
>>> leaning towards. I'm just not sure what other headers are really useful,
>>> but it does leave room for extensibility.
>> 
>> Well, "ok <size>" wouldn't make much sense as we already transmitted
>> the size upfront I think. Right now I have implemented the following options:
> 
> Maybe I'm confused about where in the protocol we are. I was imagining:
> 
>  git> smudge
>  git> <filename>
>  git> <size>
>  git> ...pkt-lines...
>  git> pktline-flush
> 
>  git< ok <size>
>  git< ...pkt-lines...
>  git< flush
> 
> That is, we should say "I have something for you" or "I do not" before
> sending a size, because in the "I do not" case we have no size to send.


Right now the protocol is like that in the happy case (non-streaming):

git> smudge
git> <filename>
git> <size>
git> ...pkt-lines...
git> pktline-flush

git< <size>
git< ...pkt-lines...
git< flush
git< success

(diff to your version: no "ok" in front of size answer ... plus the
size answer is not present in the streaming case)


Here is the reject case (non-streaming):

git> smudge
git> <filename>
git> <size>
git> ...pkt-lines...
git> pktline-flush

git< 0
git< reject


Do you see a problem with this approach?


> A more extensible protocol might look like:
> 
>  git> smudge
>  git> filename=<filename>
>  git> size=<size>
>  git> pktline-flush
>  git> ...pkt-lines of data...
>  git> pktline-flush
> 
>  git< ok (or success, or whatever status code you like)
>  git< size=<size>
>  git< pkt-line-flush
>  git< ...pkt-lines of data...
>  git< pktline-flush
> 
> That leaves room for new "keys" to be added before the first pkt-flush,
> without having to change the parsing at all.

Alright. Will be in v3!


>> "success\n" --> everything was alright
>> "reject\n" --> the filter rejected the operation but this is no error 
>>               if "filter.<driver>.required = false"
>> <anything else> --> failure that stops/restarts the filter process
>> 
>> I don't think sending any failure reason makes sense because if a failure
>> happens then we are likely in a bad state already (that's why I restart the
>> filter process. I think the filter can report trouble on its own via stdout,
>> no? I think this is what Git-LFS already does.
> 
> Git-LFS sends to stderr because there's no other option. I wonder if it
> would be nicer to make it Git's responsibility to talk to the user,
> because then it could respect things like "--quiet". I guess error
> messages are generally printed regardless of verbosity, though, so
> printing them unconditionally is OK.

OK!

Thanks,
Lars
