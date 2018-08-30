Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3881F42B
	for <e@80x24.org>; Thu, 30 Aug 2018 03:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeH3H4U (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 03:56:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41892 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbeH3H4T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 03:56:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so3269622pgv.8
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 20:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4BMc8skHJ6E5Wjltf1hvH+BKcsX0nCy8ykDwKTmkqg=;
        b=cEHSF/k1kQZ4+LSsX2U5DTgM8TsJNuA8kcDcElCgKjifsU1hT/HgVw4iYpiAMjQga3
         h4xPfIzvv95TvshlP5iotHgUvP/2F2TWGjmsECwN9qenGXDutDDZM9xbmiwvEkvfvqGj
         ACjsTtwf74TzEibDSTyXpS5nEBe6QgvybO/5+NzG0+lGyzLSzce7uVQGE482KK4uIm7P
         +5YKP7SwQWrAzLEi09pS4GI/nmH8dc0Ja/3MKb6UhZlbIDeCKTFFs7mDa9G4e9uIP4cL
         A7gbWLqM5q3BHwxmag+vct70hrLhuZZRIHAzzJV5NXX266NMtIkKon00vYqU+kthJg3i
         gO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4BMc8skHJ6E5Wjltf1hvH+BKcsX0nCy8ykDwKTmkqg=;
        b=YVe+FjKVWXiZPkuudZgMA3ai3yULQ5vFRQBNqjz/axekpHiTYdnsNfpJp45goaUWh5
         Q/WfPuo8fC8yUpF7tYm+fzDjX7HQ+uWIQyDuC/M0puSEOzSukqYwIaWvgVHhi30BIZaY
         fubbLW7jmsm91XlTX/XlcPCRCeVFjVF7FmvUWeVDrooQRiSrPGd35CZQxN9zHp26qYmI
         gyCdQ+q1JHDZyTS+LPh6qElvkQgPo37q8Rb3n9rQoGmziqGwD2vvkGLjo7U57vnyrk5R
         N4B8N8DbJFI05u3vUSg7nHSCaJdBGyY7ZUW33DV15y8/ik33DkYqqiVoKnqwqrgGKDhi
         nrXQ==
X-Gm-Message-State: APzg51AV9YGEFOlF01mbK3uNSf73qBK51luwP5qE64OI2Lt34P7j/9st
        iN1QT4O9g3FRlpnNVZYr6XI=
X-Google-Smtp-Source: ANB0VdYKKSBKBf3ohLfRrvPdtGKufgE2MygS7lM6SO/jE68VoYSRpKHYFBJgG2j3TQ/qBULo36PAjg==
X-Received: by 2002:a62:4255:: with SMTP id p82-v6mr8653166pfa.238.1535601372463;
        Wed, 29 Aug 2018 20:56:12 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g20-v6sm7634329pfo.94.2018.08.29.20.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 20:56:11 -0700 (PDT)
Date:   Wed, 29 Aug 2018 20:56:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180830035609.GA140348@aiede.svl.corp.google.com>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
 <20180829100243.GA28180@dcvr>
 <20180830033000.GD665@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830033000.GD665@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I guess I just wonder if I set up a mirror on another domain, would
> anybody actually _use_ it? I'd think most people would just go to
> public-inbox.org as the de facto URL.

If it's faster than public-inbox.org and you don't mind the traffic I
would send, then I'll use it. :)

[...]
> That would be neat, but I think it actually makes references less useful
> in a lot of cases. URLs are universally understood, which means:
>
>  - people who don't know about public-inbox can just follow the link
>    (and in fact, that's how they learn how useful it is!)

I agree: please don't stop using URLs.

Having the message-id in the URL is very useful for being able to
migrate to another server.

In an ideal world, we'd be habitually using URLs that reference a
redirector, in the same spirit as https://www.kernel.org/lore.html.
That way, there is a very restricted syntax to use (e.g. just
message-ids) that is stable and can be reconfigured to redirect to
another service as appropriate.  In principle it also allows tricks
like redirecting based on geography or making the redirector go to the
user's preferred archive interface based on a cookie.

Thanks,
Jonathan
