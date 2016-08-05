Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C14C2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbcHEPE7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:04:59 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33301 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934986AbcHEPE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:04:58 -0400
Received: by mail-it0-f65.google.com with SMTP id d65so1867496ith.0
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 08:04:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N4Q3hI3R1rhAwrRRD3LTvAErPOfylnogpwtm8jEIhUk=;
        b=u7R4MDSGqLnA8zvtkDV2CiwYYLcF7u74BPKvnCqAmEdEkvrykfFFwmDnm5KozHJOlI
         MXS0nDygTaVCBSW6xPCxV0Vohs4LHgRuEF+WeUglDpABLtVGMKOw2OmG2SX0myPlwIGR
         NEheKBJ2dpOoMX7GxlzPOBn9JKD8MuH/1VWLEsIEeWShqotoI+26SpEKmmvOpjaqb6Av
         4iSm2uRrBybM7mH21ojs/UUY7JNBs4Ik7IP4n/d/TSf76yxPaPZukDKGsiaERZv2zjeK
         rsVln0+t1RPBoDjPaX87cJME6QnHKxvVLCxk2/UEzL0eT1Bp3PTF1mwkuv2BePo7CcjU
         iE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N4Q3hI3R1rhAwrRRD3LTvAErPOfylnogpwtm8jEIhUk=;
        b=I1RPUAHje8dRlops7tERdPcDZqzU7TN5iwBRwz74V/J5GmWXDPenbww6zsbUAKW04S
         6rGn8MRi8VtFjvEVzhsXYB0XdVlTflyaFWrx2IxoPNYJpXxsFMcZKAhM/IKIZxeXaZHP
         lkzvzxK8qVfUyWZ7xZsQovLn0h6W7Uj8lplnkId04lKshnQ7PFpz6jH+jXuVxoTk81sy
         zNPR43kZAB7mQEfAuxynXF50Ryuv9KwfteehoxS7x1s21EO4Bs/7suRAXQvw9r0Vapz5
         IjOCjasaH8LCgXtZ9OBCiQ00Co0aFL3Mu4Ejf4v4g2vloIIMfA2N0/luMhDtsIqoy6M2
         tCTA==
X-Gm-Message-State: AEkoousqm92sAkD6ouU6HBaGdRbGuedce1LMLRkpm/c63yltqj/z8wIk8HK7/jYGz8c7YTMZVXF8gvlepyw/Cw==
X-Received: by 10.36.207.8 with SMTP id y8mr5050818itf.63.1470409497733; Fri,
 05 Aug 2016 08:04:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Fri, 5 Aug 2016 08:04:27 -0700 (PDT)
In-Reply-To: <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
References: <20160710004813.GA20210@dcvr.yhbt.net> <20160805092805.w3nwv2l6jkbuwlzf@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 5 Aug 2016 17:04:27 +0200
Message-ID: <CACsJy8DkNUD_dKwnx9nZsgvSxgdA8MH=2+rEWzMFdkigmhpJ5g@mail.gmail.com>
Subject: Re: [ANNOUNCE] more archives of this list
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 11:28 AM, Jeff King <peff@peff.net> wrote:
> There was discussion a long time ago about storing a common zlib
> dictionary in the packfile and using it for all of the objects. I don't
> recall whether there were any patches, though. It does create some
> complications with serving clones/fetches, as they may ask for a subset
> of the objects (so you have to send them the whole dictionary, which may
> be a lot of overhead if you're only fetching a few objects).

I'm nit picking since it's not actually "all objects". But pack v4
patches have two dictionaries (or more? i don't remember) for commits
and trees :)
-- 
Duy
