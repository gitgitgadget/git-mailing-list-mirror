Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A1B20189
	for <e@80x24.org>; Wed, 22 Jun 2016 16:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbcFVQxn (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 12:53:43 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35707 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbcFVQxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 12:53:42 -0400
Received: by mail-it0-f48.google.com with SMTP id g127so49058392ith.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 09:53:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HP9TXWHPYxLyiy0Yxhkc8at07DMQuVuL0ZJlS8Xa9Xc=;
        b=LWJ1ZSmNJ3ODwmSPhIrqpbgMZKkHkIcDoCGtiKljPU1mgw8SUT7To+cYlExdjSJe/m
         Fg2Y3iQsSVbYKlKUzLHzvk9u/eyJoPaUnxh85Pm6U/sUnf1xQljWsAnKu1NjFgT3UsOR
         ltwCCvj+GZIzVc5fESOV9CTYq66UugfLBtiWZaZDFe9YxzZvb/TmUNDRG6T076ZUkERc
         8NuQ1at7/NvUK9CghxCVy4MlSSUEj+PAWvvs/7waz0VGmN7LF+1DnlN7QxgoSh0rQf9D
         jy1tw4d304ZzNBAZE3hBfifdB+eYLTe4fFtmtINKz5BHwO3I7ibcvKHmx/Q1vDwCNb/Z
         6krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HP9TXWHPYxLyiy0Yxhkc8at07DMQuVuL0ZJlS8Xa9Xc=;
        b=RG7mItCHd5sCTG+DKbYwgvCnvvJV4YtteucDZxRiYCCblr2KStYg0fWOqfjuhfFnzy
         ff78N9HiDubEkYCJQQd5A+3CoA2ndIl5rTiQUxKLAiH7ljQ6eyOIL3CHaYFNblObrODQ
         hZHBUvFGxYF6xaMOzwY0G6nGCxIv+3vtr4QkRIZATGDi/Cf1Wcn/c9RiFGkyhGwZ5s0j
         ibGnjW0KdJ08JRfi2crKF2XLBNbPDOAtHvqvRvWaICDA5ZVVe3j1k1DL2OdW6ZbthJyh
         m9Dow7ago5BiI+lxVeujfkO6CtXkuHw0M6bqe05ZWMyHZ09FTq21xOkzdIBQqmuXN+ff
         Cbqw==
X-Gm-Message-State: ALyK8tJUaOi683Hx6MU6260ZeEGru6nJaEPQVIhynVAqZdmJLbcPckSuO1t69W2Cb/Jgk6M0Er81WR6Pifid1A==
X-Received: by 10.36.53.211 with SMTP id k202mr15850028ita.59.1466614421284;
 Wed, 22 Jun 2016 09:53:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.149.76 with HTTP; Wed, 22 Jun 2016 09:53:40 -0700 (PDT)
In-Reply-To: <20160527200122.GA26608@sigill.intra.peff.net>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net> <20160526015114.GA12851@sigill.intra.peff.net>
 <20160527044027.GA26143@gmail.com> <20160527050054.GA25774@sigill.intra.peff.net>
 <xmqqshx4row8.fsf@gitster.mtv.corp.google.com> <20160527182444.GA1871@sigill.intra.peff.net>
 <CAPc5daV1zAwAHDmkc93kGvwCEFoioZNVta2xGsFJj9jq1H1H4A@mail.gmail.com> <20160527200122.GA26608@sigill.intra.peff.net>
From:	Armin Kunaschik <megabreit@googlemail.com>
Date:	Wed, 22 Jun 2016 18:53:40 +0200
Message-ID: <CALR6jEisU=ZCZADcTx685vSrz96jUaxfAbKMEPQn0KRFqtVw=A@mail.gmail.com>
Subject: Re: t7610-mergetool.sh test failure
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Another thread I'm trying to revive... the discussion went away quite a bit
from the suggested patch to conditionally run this one test only when mktemp
is available.

I'll create a patch when there are chances it is accepted.

I could think of a way to replace mktemp with a perl one-liner (or
small script)...
conditionally, when mktemp is not available... maybe in the build process?
As far as I can see, perl is absolutely necessary and can therefore be used to
"solve" the mktemp problem...

...or maybe I should stop bringing this up again :-)

Armin
