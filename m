Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E00D1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbcG2QU4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:20:56 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34238 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbcG2QUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:20:54 -0400
Received: by mail-wm0-f42.google.com with SMTP id q128so42994741wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 09:20:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qL7tPLMPFTCYyC31QZFi4GNH78crwbw1A78rildDcL0=;
        b=zOqWofydGPfbxERQ1xh/zALKdTkwiBl1ziEH3H+9d/QrcRsLcPDpOeKru5mCmlGTtc
         v4b9cpZ8AnG/GJgo/lB/ouEq2nUyP1v4kJ1wcoB8yKBIvXe1eqw1oUY3hES7JfASA5nI
         55czlEFxJLqEGonhfH8YrQhXeFEn6F8d1VNsdhIHQYF0gveiJvXtU7bRkbETZfMC/2J+
         21rHCcqoJ7beiGOnZu/l5dUmLlXoiE/SJytrtvbsJFN9z9dXtkbdltkP7rgNniu4JG5Y
         pUy/y9Yl4eccaiODHmVKQpi0fei4Nv8XxZKR07rH3tbJwdwD3I4dXHYsgOy/zpqmdahv
         vfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qL7tPLMPFTCYyC31QZFi4GNH78crwbw1A78rildDcL0=;
        b=ICe8elFU2V2R2kalOiGCVAuqykRPwV2CPLYyu6ZriiINg9tnKXQlqadsZZDQ7Vu9Dj
         +N90QanoUlB6xsmNHGPOMFVl1mV4cdY4MevfaBLQuS6ZcFNrn8TjUlU/uwJa62InuXzf
         rBGrLaODC0xGDoXk+J1jrn5qfwEddJ5TARVRBSzrQly4tGFY9b2vp0uKfYaigkUmTEby
         ZoG//oyYV2bbycA/bUTigDxpWB9HLRe8OYmJMn4XIeAjhBsfvwIgf/qaAGt2D8mH0u70
         ilIhqCUZAvF18zNFyYC+YG/7dVcnNel9f3ZPjEpCEqS+ZFdq1bB7ajqxKyef7fXXO50g
         DtXQ==
X-Gm-Message-State: AEkooutcHEy1rkhIe7wwWq718d70jh+k3IBRRfHX0YQQmf/L6T3ZAwB3ozEX+nEDqXyJCA==
X-Received: by 10.28.193.8 with SMTP id r8mr43474424wmf.13.1469809253073;
        Fri, 29 Jul 2016 09:20:53 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id hy3sm17226011wjb.8.2016.07.29.09.20.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 09:20:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/5] Git filter protocol
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160729155740.GB29773@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 18:20:51 +0200
Cc:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, e@80x24.org,
	ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: 7bit
Message-Id: <FA73FFDF-51D1-49FD-A24E-72A2C033E2F3@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <579906C5.1050809@gmail.com> <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com> <20160728132906.GA21311@sigill.intra.peff.net> <579B087F.7090108@gmail.com> <31219A33-CA8A-44D1-9DE0-6448AA1A7571@gmail.com> <20160729155740.GB29773@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 29 Jul 2016, at 17:57, Jeff King <peff@peff.net> wrote:
> 
> On Fri, Jul 29, 2016 at 10:14:17AM +0200, Lars Schneider wrote:
> 
>> My current implementation supports only two cases. Either the filter
>> knows the size and sends it back. Or the filter doesn't know the size
>> and Git reads until the flush packet (your "unknown" case). "Approx" is 
>> probably hard to do and fail shouldn't be part of the size, no?
> 
> Ah, OK, I missed that you could handle both cases. I think that is a
> reasonable approach. It means the filter has to bother with pkt-lines,
> but beyond that, it can choose the simple or streaming approach as
> appropriate.

Right.


>> That being said a "fail" response is a very good idea! This allows
>> the filter to communicate to git that a non required filter process
>> failed. I will add that to the protocol. Thanks :) 
> 
> Maybe just send "ok <size>", "ok -1" (for streaming), or "fail <reason>"
> followed by the content? That is similar to other Git protocols, though
> I am not sure they are good models for sanity or extensibility. :)
> 
> I don't know if you would want to leave room for other "headers" in the
> response, but you could also do something more HTTP-like, with a status
> code, and arbitrary headers. And presumably git would just ignore
> headers it doesn't know about. I think that's what Jakub's example was
> leaning towards. I'm just not sure what other headers are really useful,
> but it does leave room for extensibility.

Well, "ok <size>" wouldn't make much sense as we already transmitted
the size upfront I think. Right now I have implemented the following options:

"success\n" --> everything was alright
"reject\n" --> the filter rejected the operation but this is no error 
               if "filter.<driver>.required = false"
<anything else> --> failure that stops/restarts the filter process

I don't think sending any failure reason makes sense because if a failure
happens then we are likely in a bad state already (that's why I restart the
filter process. I think the filter can report trouble on its own via stdout,
no? I think this is what Git-LFS already does.

I am working on the docs right now and afterwards I will send a v3 :-)

- Lars
