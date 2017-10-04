Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC9420365
	for <e@80x24.org>; Wed,  4 Oct 2017 16:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdJDQ7v (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 12:59:51 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:53802 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdJDQ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 12:59:50 -0400
Received: by mail-pf0-f171.google.com with SMTP id y24so3288864pfa.10
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8recl0yyMr3RH+FJchxKyPm4BhswWkq2w42zTsftEtc=;
        b=HJTyMPW6Kj2IOyaV3beYzcc+5yPycxF8UFh4DYR7b6FsIK7PMtZpHw7lX975bktLbQ
         IVGQyb2BZ9nbqAuz5Cm0JfDTZ/xQXXEmmYArqnY1twNorZQp6JQm3HYai4EyXGTpipwF
         9hAWA9XKIvGkZG2Qzmfut8IJzIXKNhLeYkRUxfZ7M5GanRKT1NYlGBpHXA9GCrtsuC3c
         bJArWGPUmIyOV1Oq6Pa4D/SkuA6ECro1hAMa7Vo4Dr+GS/3EtBr/txznejz/+K4c6M87
         YYjhN8yYXheKgpMGdWVUXdADOoLw0bEokI7waxMeEZ9JKl2FYtpSoycdG6RARGAA1i0Y
         pacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8recl0yyMr3RH+FJchxKyPm4BhswWkq2w42zTsftEtc=;
        b=dxV1IF+wJ7FOkkf2oyP9O4oJ8DGPVd5Aum3cQTrdrmcytvcJM+kq+DyzNNcpZmxh2A
         hgTAzuZltEIT1MwaPHEN/RDYw2xdnIGZ4kiiayQ6/wK5UBJif9wiJAmbVUDJrvW274Q6
         +bX8bmGlD9MU49bGgzJDBZPPFuyhYajRtK+g2eZyuEM8Og4KMTCjSHkd9LTEtv4cKqxu
         4xlZbbZuUEh1yKt5Im97GikjaahK8LOADgk+3iQR+SWTqNBwJ4Ho5IK13msNPCiEBpr3
         s63jaWJVjQHUBiXpl6GwPOnO6zV2b0pZUdXG2S1nJzelWjJGAGPjS1ZogW3LU3F+cVJ6
         92+g==
X-Gm-Message-State: AHPjjUj4F0rWO4pWwVB19zPmMpIIHS+g8DQir6eGYFDm6wWhSHTCXxbj
        eaOaM4xl9dcP2aiTcuKmMmA=
X-Google-Smtp-Source: AOwi7QBovl/UQ1J5yRhrhKbBUowY8CS/P4j4jzFIQXpepYnPhgUmmjAEvjBtXA3FmHsV/yk0gSzBcA==
X-Received: by 10.84.133.11 with SMTP id 11mr20852608plf.13.1507136390231;
        Wed, 04 Oct 2017 09:59:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:e14c:b8fa:a887:14e1])
        by smtp.gmail.com with ESMTPSA id x8sm20941923pfk.124.2017.10.04.09.59.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 09:59:49 -0700 (PDT)
Date:   Wed, 4 Oct 2017 09:59:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
Message-ID: <20171004165947.GN19555@aiede.mtv.corp.google.com>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
 <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
 <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

Robert Dailey wrote:

> You guys are obviously worlds ahead of me on the internals of things,
> but from my perspective I like to avoid the "plumbing" commands as
> much as I can.

I suspect what we are dancing around is the need for some command like

	git checkout --renormalize .

which would shorten the sequence to

	git checkout --renormalize .
	git status; # Show files that will be normalized
	git commit; # Commit the result

What do you think?  Would you be interested in writing a patch for it?
("No" is as always an acceptable answer.)

Thanks,
Jonathan
