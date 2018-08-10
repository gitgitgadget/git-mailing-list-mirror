Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A757F1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeHJUth (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 16:49:37 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:46892 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbeHJUth (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 16:49:37 -0400
Received: by mail-oi0-f44.google.com with SMTP id y207-v6so17258054oie.13
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOnASOzUqExcbMrRjte4yvPle8VP6UWVLTSFz3Ef9Bw=;
        b=loS/lxRpqexVQyymShKUZEoTEpevdle3wcDaaHEQ68sH3yy3Dc3oiehLZIRN6LUchz
         48qeD7WNmL/H0N8l4PH7kZpDrJKHCh5Z2+LEBSWzwnPMMSOXqXl+Udr9d12Um8OwMWHk
         Tybgy9+nYtOa/3xI5gEtSbyt+pYEn92PeXPU7vtGoy5sQ/Ce6MUlWFWe/tWZL1t0B3W6
         kVZgz50+7TS+jgSoSXl4x0M5X23fRaPo2031Q7nmObXu6zR0idfWNb0U1jdS8N+54J1T
         pvS+B51iWoe/ElyMK+7OpMRuqtICOfDZipoBz2nrkdZBaQrhvqDFtX9EbtQyupw7ss1H
         5dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOnASOzUqExcbMrRjte4yvPle8VP6UWVLTSFz3Ef9Bw=;
        b=o8H1IZxLd1djYykoobNeycW9wcq4CGc+Eg4EPCxpkYvsr0cecku6La67jFq8q9jaEn
         V2HW3f0F4moC0ZDBnc39RymexbV/O+t7am1fif7jTpO9+PsxAAHx8HCp0OpxcLpICx+j
         WTm1AcBZmrtk0Qc703qKIDMsh32jxhAegK/rJZZOg8riHpa3WDRjSLQ/9Z+ppG20Y14I
         ktziFdJxI4o0W2d8vIO/sHQnj4L9XZXE0ltyKwK1dyR4ZrfCH6W0eL/CH6LEaTlIUaT7
         4uRzXz7ev+NeXSqo1WgNRHw/3uOMq7EIKdTdqEIB4xkB24kNh9iYuH9eKtBWx7kxkGvl
         DqBw==
X-Gm-Message-State: AOUpUlGh0Fxw9mT00eRhUHt6Elh3A7zRRrBRFumDSszxuRR4ttnVRczm
        HgKlMg/PEOUfYI2uEX+B15uPYkxWZY4kmeJZ72Ec7W2/
X-Google-Smtp-Source: AA+uWPzI8fPMeTpHu+llQg69B0riIlcfcOKVW3fZ4D24ISzYnTxrdHj4ZPgJdQmKTsPVMqZKtZOc9losMSC1t2+JplI=
X-Received: by 2002:aca:a12:: with SMTP id 18-v6mr7267504oik.292.1533925118737;
 Fri, 10 Aug 2018 11:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn5wXY7924hftXhCXh_N_htWoiaGEV5f7ZEM4-PE57_1oA@mail.gmail.com>
 <20180810181205.GA7516@sigill.intra.peff.net>
In-Reply-To: <20180810181205.GA7516@sigill.intra.peff.net>
From:   Paul Jolly <paul@myitcv.io>
Date:   Fri, 10 Aug 2018 19:18:27 +0100
Message-ID: <CACoUkn4RREF61=pPMz14bws6TKA2LPC1+b-vix5j0V3g5pBzyA@mail.gmail.com>
Subject: Re: Change in behaviour in git fetch between 2.18.0 and 2.18.0.547.g1d89318c48
To:     peff@peff.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think this is the bug from:
>
>   https://public-inbox.org/git/20180729121900.GA16770@sigill.intra.peff.net/
>
> The fix is in e2842b39f4 (fetch-pack: unify ref in and out param,
> 2018-08-01), and is currently in the 'next' branch, and marked for
> merging to master in the next integration cycle.

Thanks for the pointer, sounds like my case exactly.


Paul
