Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B114120D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 19:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdFUTOO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:14:14 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36546 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFUTON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:14:13 -0400
Received: by mail-pf0-f171.google.com with SMTP id q86so5219079pfl.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=rrDXcjU7o3VI17sCisDrE9p2TfWlsobnwfVJ3AYcewE=;
        b=jIXIavt8kPFem3oBB+rCSkKot+Pm+ogzGwXOdZUnSO7u7CH51vIGV13VJ9OOeaf5//
         jfe1FkfIJTGGTpAQKW6kgKx72HEiT7hBZb74u7qlvNAylWvoh49Mb0EkqXcrV9SnjOMW
         b56hB0tbWRI2cZ1qPu4/7464S7RGc/xGhSgxLApulQQIExmviJk8e0UO6kVEMp/DxFgy
         +E9IP0HU3ewRu36WyfNYSlo4KZ6GdRxZfLBp/d4uMSpjbIUTwfRSPuE6L/oTRM3xiBOi
         FEfQGEN3LBSpuOTfweBMDVJEeYoy9GXS5myiUev979OWbj1CC1gvCxvZgkyJ4/iKxE9i
         0VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=rrDXcjU7o3VI17sCisDrE9p2TfWlsobnwfVJ3AYcewE=;
        b=gYWbQTz4iNBeqiTh3u8nGCuZ8ShVkqa0QGVyHiqTtL5hnMdzzEjUXihKOT2T6Zk0df
         V4huvV6l0awSBrjYoJm5fgx75NNhdTE9krZUbEZK3uR95Oz7cPDSO9EDYR8I/ZSRkom0
         IZ4y3XBOjPA/sFUCOfkeMmD0AqnY/ff5dQLvlKs6x59KHOAeCU/ambaZZsPFlx3AJO1X
         XhF8dRqrwq+7RB8GpebY52AkIVOmvoCHBeLar7QKp9ULIoUGPlkIyoARn0nvGb+It4hE
         wkS7D7RuSRL+1lgQyLkiGKoq2KkIrfOnB9mvgM3KCAyGj8eGppj6WUwFk27Cf4GPsZVP
         idlA==
X-Gm-Message-State: AKS2vOwmrVyIVbU/D40sya2bN70y4zWMJXnLpd5bWUcieeSDmlc3vzaP
        eBj7PZRbIap4YDvSUpUZTA==
X-Received: by 10.99.18.65 with SMTP id 1mr39427017pgs.132.1498072452545;
        Wed, 21 Jun 2017 12:14:12 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id i27sm23381170pfk.1.2017.06.21.12.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 12:14:12 -0700 (PDT)
Message-ID: <1498072442.32360.20.camel@gmail.com>
Subject: Re: Using '--help' for aliases
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Date:   Thu, 22 Jun 2017 00:44:02 +0530
In-Reply-To: <20170621185518.nhnqlkbt63hdoate@sigill.intra.peff.net>
References: <1498070489.32360.14.camel@gmail.com>
         <20170621185518.nhnqlkbt63hdoate@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-06-21 at 14:55 -0400, Jeff King wrote:
> It could do that. I think we even discussed it at one point,
> but I
> didn't dig up the thread. However, you have the problem that running
> "man checkout" is likely to clobber the mention of the alias. So the
> question is whether it is more important to tell the user that it's
> an
> alias (and which options the alias is using!),
Now, that's something I didn't think of. Does seem to quite an issue as
aliases accept argument this.

I seem to be getting the idea of '--help' just now. All these days, I
was actually considering it to be another way of getting to the man
page of a command. Have to play with it a little to see in what other
ways '--help' could help me! In case there's anything that's so useful
about it that I'm missing, let me know.

>  or to show them the
> referred command's manpage.
> 
> -Peff

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
