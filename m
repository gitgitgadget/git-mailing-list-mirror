Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEC71F428
	for <e@80x24.org>; Tue,  2 Jan 2018 22:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeABWTV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 17:19:21 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44543 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeABWTU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 17:19:20 -0500
Received: by mail-io0-f194.google.com with SMTP id k18so221154ioc.11
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uB3PenATI/IDq9H9VgEwC32//lQyhg04UxUSNwoSrWw=;
        b=e74O9x4MVTr8+UoEO16Qt/U40pZE/b2awCKPPAPGAasJMPRfUk5xHMfL26TV+6b1wJ
         dgJki5ZQdplEtKqt+Zj5ZUEFd5adcEitF8eFCVUjhHfejHcMKRKGWICckSI7eyG5wkbE
         NDAYeh7gKVK/pNvjNm4h8H5k3uWF8nK4VC1zscRBu4Eqg1ge47HZ/10xP6sRNTmMtJMW
         AReNyFs9YSyqPLeEUh3B8cnNIzv1sfIOcn0m+kyMwpnr+XA5K7kC88gNV9bH5diWPbaN
         vfkIrxvsu7DJW1nQz/Q20aIYXxDZemyoWJx9hMZhAcux9menZPD1bq3FTAlCMNZXjIxq
         JyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uB3PenATI/IDq9H9VgEwC32//lQyhg04UxUSNwoSrWw=;
        b=pCWLC8Gcq3A0Wpc7f7dnVpSMYtXMZ/OswYqrUsoqGKrVfvyykP3pWK4erKT3D6nH8i
         5PJCyasspyjpyWM1IFn6fPJe9jNruy2kKPQuG4Snm3jWZt7XvVbGTckQ/UG2HvmL+pXF
         fxDxa21e9b5Is7umiyScJZ6Wfj5eoLOsj9ulFKEfpBcUHW7DYtzNwrfKi2/RW07pbDM9
         YHiSPz5UQ6Fuwr4vwz4GB+YkzexsNE1/hTFpsQu/eZTVLnK1TkoKLwqHCQxg5ixU2nGw
         4ix1DRnumUgQUYiUbySAf1Gez9H1fRWNcWOryOdGH9X8fJyarrfP8LWcBAw6l4FzeUc0
         Zk+w==
X-Gm-Message-State: AKGB3mL9EsRKO554wtA2KbpFqcEl9gsD7Y/uirR8EEItJz3inbY5rnXK
        lGIJ+eWxy6mlLbiDNI2AJkQ=
X-Google-Smtp-Source: ACJfBoujy4PFKivxSxYmFHm56O6kmB4viOmtmnLg3AGqdUTZII2GadMQCnxynslCrSe4MYdlW+hx7Q==
X-Received: by 10.107.175.144 with SMTP id p16mr53824079ioo.199.1514931559384;
        Tue, 02 Jan 2018 14:19:19 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e103sm9718800iod.26.2018.01.02.14.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 14:19:18 -0800 (PST)
Date:   Tue, 2 Jan 2018 14:19:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2017, #05; Wed, 27)
Message-ID: <20180102221916.GE131371@aiede.mtv.corp.google.com>
References: <xmqq608rn9ca.fsf@gitster.mtv.corp.google.com>
 <CABPp-BHxcFU+e4OgccWb+LgLbMo5sJsNjYFQb=WnxViTFdOu=g@mail.gmail.com>
 <xmqqh8sallqs.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kapuEKLO4RUUPVS6_-aeBERDhjpBAtmK=gycT8GaK2bFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kapuEKLO4RUUPVS6_-aeBERDhjpBAtmK=gycT8GaK2bFg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Thu, Dec 28, 2017 at 11:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:

>>> surprised by the branch name, though.  Was 'ew/' a typo,
>>
>> Blush X-<.  Yes it is a typo.
>
> Note on that series:
> I have reviewed the first three patches (which could form an independent series)
> that it would warrant a Reviewed-By: Stefan Beller <sbeller@google.com>
>
> While I reviewed the earlier versions of the later patches, I would
> prefer if there is another reviewer for these as it seems like a bigger
> contribution at a core functionality.
>
> I cc'd some people who were active in some form of rename detection
> work earlier; could you review this series, please?

I'm missing context about which series you mean (though I think I can
guess).  Do you mind resending this request-for-review in a reply to
the patch thread?

That way, the request would be in context where my mail reader can
bring up the thread and it's easy for others to see that the request
happened, all in one place.

Thanks,
Jonathan
