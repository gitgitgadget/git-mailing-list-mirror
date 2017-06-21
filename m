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
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F5620401
	for <e@80x24.org>; Wed, 21 Jun 2017 12:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdFUMF7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 08:05:59 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34329 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFUMF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 08:05:58 -0400
Received: by mail-io0-f179.google.com with SMTP id c201so2164956ioe.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=WJad5Y2b0cN+v4TZvdSuvte7i/eek5Rxz+2NJiv8YY4=;
        b=vToNjzpANp4keVpLuj+QB58A4XP7I+NNdQWJSMHhynH7FJgFP+vLFQN8uW/Flw+S0W
         7Bf0nhkWhUDzFmp6vGD3A2mXZMndk/65TJ7DB3Kc7+cpeV6G8h+3uS6Oqu5uDdv4ocsV
         MkWkV2CgcsH1cSlqSXJX+pfxwZbtdjSqYpteKNUPOsCOoe6cvezw3SI7pn0RzYdDC55z
         wdKIsx/9hEM5p93rpjDF3e50a7XgloR7GUqGXL1S1QrN8RflnnqCzNmjK4XYStiLIMhN
         8MM/NBol6fHITx0v5zwCUslz/z0QDuM7MbC0EHUodo4iuf/xRLUrXnuVHpOaDnwlZ2H+
         VwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=WJad5Y2b0cN+v4TZvdSuvte7i/eek5Rxz+2NJiv8YY4=;
        b=DB9UEM5I8jlyKL4ipZf/Z2Y1u33HxkkM1wp+MDdZAjlK+J8U0CQbJREEEiiK5WS/Md
         pTtaMrSPIEOqkmhkZTPXMq8nbPKzTz4qXWlgGg8xNkQeUR2E7nughUGnMq78qpRKHw0/
         aSNoQZAFjI9GHo3R944WaJVsArDF+kCLGp6D9uzkXlvNpptiX6TSi6u42q0UqtDSNiMi
         xySeDopGp0mz0ulbCn3aP/cP7EAS25bqh9w9KeBTM5UHWRgImNeK3X1SG9I3tJ6yDPoa
         9gn6OXOMMcs96sPJs8jWt2OrgUavTjbuc2kiPBWPO3rSwD+JYC/vIzzmps1GSvsqbcoE
         H+Sw==
X-Gm-Message-State: AKS2vOx83M0//HANLHCiVkanNXVQiNw06cN+Cqs7o/nXUqasH8WxdaPL
        AMlSn6yFJzpTng==
X-Received: by 10.107.180.144 with SMTP id d138mr31267687iof.73.1498046757217;
        Wed, 21 Jun 2017 05:05:57 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id s78sm3214680ita.18.2017.06.21.05.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 05:05:56 -0700 (PDT)
Message-ID: <1498046746.1746.1.camel@gmail.com>
Subject: Re: Small issue with "add untracked" option of 'git add -i'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Wed, 21 Jun 2017 17:35:46 +0530
In-Reply-To: <20170621045211.GA30634@alpha.vpn.ikke.info>
References: <1497278015.7302.13.camel@gmail.com>
         <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
         <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
         <1498013726.5419.1.camel@gmail.com>
         <20170621045211.GA30634@alpha.vpn.ikke.info>
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

On Wed, 2017-06-21 at 06:52 +0200, Kevin Daudt wrote:
> Did you make sure you used the git you built, and also the relevant
> subcommands?
> 
You got it. I apologise for any confusion caused here. I seemed to have
accidentally given a build location in my custom build script,
different from the one that I assumed. I didn't identify it all along
as there was a previous build in the assumed location. Anyways, thanks
for pointing that out.

> What does `which git` and git --exec-path return?
> 
> If you did not install git, but try to run it in the compiled dir,
> you
> can better run bin-wrappers/git, which will make sure the correct sub
> commands are run.

