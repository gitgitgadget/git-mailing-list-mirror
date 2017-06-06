Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCFF209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 15:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdFFPEt (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 11:04:49 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33294 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdFFPEq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 11:04:46 -0400
Received: by mail-wr0-f180.google.com with SMTP id v104so55541534wrb.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i2bv44XcgrnMDPhJzQUio15FfpFlmZYwUUGkHrGuMeM=;
        b=e0n8JZSNv2N1iDv/AxcXHpIKDsWJj5MUeOmLiYbCUReCLvdjhOn+yppVQRRjOlCxRr
         db9E4mRaPdk0dFGrvbxmnLqcgHBmFEuL3q1v9OwQGq9WSdtywWfeSPcrZGYn+AlBtyHZ
         vg4yAtW75frSYrdZR/+8iR05jypKY6duDYXhPPBZYybETdfTPDur8zsneerJov6JLN41
         9UK+jTLEU2Lg7WG1HO+RKlusXdtOfToVd9IhJW5o/GpvtrdeTqUEKUMmk3ej32hGcGWw
         5LdjLEiCh0udW2ShaybZEK5YgbYw5ozxETLtbJfDa7OzKxREqT178rMdzTA/Rrg0ZdHn
         EkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i2bv44XcgrnMDPhJzQUio15FfpFlmZYwUUGkHrGuMeM=;
        b=AIOCy1aAAwXxAPyOMMmj/1JdoKR4DmUMml1Ns17r2SYL4yFYIjajgp6YVfX/r1YZvC
         lq1waaMo2ok8ISJrPFhgzRd2BFvJWVEy+PaTDvu3Omu4hSTyJnSVKNwmFf4/V39jUUiY
         iWHMqE/B9ZDDEIieknG19XguvTLTVWW8ikS0JyZSdhDu7/K8o7xH2nsjXm29Lw3jN7tb
         YAlwaV9Th0oLIClVYv3VkimegETjjF1RD/Q4mZGazSR6/jUtOLtialRRrMi6H5Qlf02O
         Q7y6HqjJts/7kJRSgyaLkau01TwVPVonWxtinF7BT1vef48Cxcbsgyyvzo26150DaIdx
         ZBVg==
X-Gm-Message-State: AODbwcDeADGIovMSffl5t+zkf0DPN70gnD9rZzc571aRUzP4gIN0YxGm
        9hTTR23rhPcdmA==
X-Received: by 10.223.160.139 with SMTP id m11mr16446438wrm.99.1496761474485;
        Tue, 06 Jun 2017 08:04:34 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id o24sm13155948wro.21.2017.06.06.08.04.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 08:04:33 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Continous Integration (was: RE: Git v2.13.1 SHA1 very broken)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <6D15A44412C346E2822A74A91FDF77B1@blackfat>
Date:   Tue, 6 Jun 2017 17:04:32 +0200
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: 7bit
Message-Id: <CF387D0C-6743-4B88-A4CC-D6310A634E03@gmail.com>
References: <20170605203409.GB25777@dinwoodie.org> <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com> <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com> <20170606100355.GC25777@dinwoodie.org> <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com> <20170606124323.GD25777@dinwoodie.org> <6D15A44412C346E2822A74A91FDF77B1@blackfat>
To:     Jason Pyeron <jpyeron@pdinc.us>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Jun 2017, at 16:47, Jason Pyeron <jpyeron@pdinc.us> wrote:
> 
> Do we have Jenkins (or something else) setup for Git?
> 
> We would be happy to donate (slave) VMs for cygwin builds og Git.  
> 
> -Jason Pyeron
> 

We use TravisCI for Linux, Mac, and (in a special way) Windows: 
https://travis-ci.org/git/git

Windows is not supported by TravisCI. We just use TravisCI to
trigger a build on MS Azure and read the results:
https://github.com/git/git/commit/029aeeed55f6bfe8014e8ffe5fc7a6f2e5b110fc

Maybe we could trigger a Cgywin build on your slaves in the same way?

- Lars
