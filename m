Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F531F405
	for <e@80x24.org>; Sat, 29 Dec 2018 12:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeL2MIr (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 07:08:47 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:38089 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeL2MIq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 07:08:46 -0500
Received: by mail-io1-f51.google.com with SMTP id l14so18535193ioj.5
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 04:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=db6FEA+Z5qz4Ae6E3EmYFqTnr2+36kPBx18Oc4QUOrk=;
        b=QGzjgvywXxiFKtBukP2ZRSD/2clX0KKbVRzMBPEaKLnfjazW+MD5i3SvKFitf6TE/2
         8QdTG70gzaZd5EYw6X9HT/LI1MI9WXydXomsEMZZUCFi+wSlk+4rcTvPlxNi+g1cYjja
         d+Bca/9W+p3T6Hr/JF8lA9JzQu0TEMs/kKMD4cjoEOChupcbTm6/pQgNRIF9BHDlZ4uF
         krxJAyeeU1HXk045lHgWJBYGkeq2T0Qktsvf6NCYi3z2QWaDmGGMoStyzqOEU9tShhHV
         gicB8LF6oAVixXq7ttxrhoECCQW81J+a+LduEtmYbN54ZGlFb5vYDMdZQUAZoO7Q5SbE
         4DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=db6FEA+Z5qz4Ae6E3EmYFqTnr2+36kPBx18Oc4QUOrk=;
        b=jImpb1YfNVsdf3uQwSG63hxBuC4+cV5VMddXdEFjV50JamAvvLBanS/MykmXq/HpA4
         IhbgV6Py8qylDpS2cpveiwcWM9XCMr0NDGuitXwtq+9kV2lOkdqspYyHYnMMkY+2qdYu
         50/kDUQ+JPTZOz0pmHfiii/3I3+/AokNgvTJXh0DM7ANJI0J8t9vrqwTaWzopAia7v0y
         MagL9r5nNvwoUe0QmSJmqAuSgjw+OjcxSNxeADhfnBvK9dz4X3Yj6YQFFvaTSkPjO/IU
         Pv9J1qQK+ii/wYmKG5/gB8A0GDK3+x9WWJizb/rFPNsboAN/w0IcK+Vlfn89ep44+R1s
         2FmA==
X-Gm-Message-State: AJcUukft7ZHuQQoJxu91T43zR/geYCDFOGCFNRghA+2Ubr6Mf4GneY7l
        5C8HJMWUKt7BwjeedrKKf5Tbi7UP
X-Google-Smtp-Source: ALg8bN47XtzqpwJM4eUORvVx+EpeHsfhQ1+HHU8LCiJvmLeYsohfyALFR0dAKxB62kwAvMcVlkZQtw==
X-Received: by 2002:a5d:93ca:: with SMTP id j10mr9113253ioo.1.1546085325921;
        Sat, 29 Dec 2018 04:08:45 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [99.245.246.183])
        by smtp.gmail.com with ESMTPSA id t64sm21957816itb.5.2018.12.29.04.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 04:08:45 -0800 (PST)
Date:   Sat, 29 Dec 2018 07:08:43 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2018, #02; Fri, 28)
Message-ID: <20181229120843.GA5937@archbookpro.localdomain>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 28, 2018 at 10:04:13AM -0800, Junio C Hamano wrote:
> * dl/remote-save-to-push (2018-12-11) 1 commit
>  - remote: add --save-to-push option to git remote set-url
> 
>  "git remote set-url" learned a new option that moves existing value
>  of the URL field to pushURL field of the remote before replacing
>  the URL field with a new value.
> 
>  I am personally not yet quite convinced if this is worth pursuing.

Hi Junio, just wondering from our previous discussions, is this comment
outdated or is it still valid?

Thanks,

-Denton
