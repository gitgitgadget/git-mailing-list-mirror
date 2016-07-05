Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CAF20706
	for <e@80x24.org>; Tue,  5 Jul 2016 18:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbcGESIb (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 14:08:31 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37630 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbcGESI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 14:08:29 -0400
Received: by mail-wm0-f51.google.com with SMTP id a66so163442399wme.0
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 11:08:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ResU80YtJUvsb1cBIsyCqaTwovebQ3F7nfHAxEDIdk=;
        b=WdxfHG82oXYiHoX42UncAWBqzeo5gIaRzKr3Vw436vz6x+Uku16DUZzyU56fNwzaZK
         zVTL1Xs0i9NMWy4m3vz/ayYGzTzK2csnSaeQsVlJWXdkkGdYbAiiUMGrgUf5tQI8E+8L
         6owrEeJ3xohetPHWxz4QV4vfQyYFR33wghPXe02MirbcPgGHtg/rkL2a2wo76pSBTrsh
         1MiJQaEjGs9Hw0geyuvBrubJpaBU6LSk2jXjPxyUk8wsi6xf4ahn+g0jI4hujWLYAMjo
         gLvF5+7frx3qYVZyIrEiW6q3Bmcv4ZaBoIaWaZpBSKg0juq3rGyeWacfXYtquNVnBvcw
         lQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ResU80YtJUvsb1cBIsyCqaTwovebQ3F7nfHAxEDIdk=;
        b=kCIvS/3W8AbdsSvnHVVexp347nVE23/Mei6REMYLGkhdw/LM2QfzK7VL/V38ebh/UL
         D6t8Ipxr2HX4tQW/pA+HHLuSpCQEJKctldg+HDHmVjzm1AgRCoOBTMY0EZlGF1Hak2fv
         5ipFYk4D+TssNeEM5BSj9Iq2drbkcPi7kCjSGEcPR2HkI3tA8r4HESr999vtF1Eveijd
         A5sXWMK1Il9ZBoUf+vN1RmKMTWc3dAcXGnMuPpdTSP44r3NiPM2QIneDC1m1Ayb0npWw
         oLhVeQN7G0PZ8hhDkRks92IqHMjb46JuWhuViHoBni4gcW+rs4p28rMXxiyXAumqqDDk
         /J+g==
X-Gm-Message-State: ALyK8tKSXMpzKjaEsJwLQafltn9d6M6GyjwqlTavx9kdAx1QtpDyMLSODCxMOsfhj6Xmww==
X-Received: by 10.28.136.21 with SMTP id k21mr17698622wmd.24.1467742107886;
        Tue, 05 Jul 2016 11:08:27 -0700 (PDT)
Received: from christoph-laptop-16-04 (ip-103-010-005-185.cpe.my-wire.de. [185.5.10.103])
        by smtp.googlemail.com with ESMTPSA id o10sm5818089wjs.38.2016.07.05.11.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 11:08:26 -0700 (PDT)
Message-ID: <1467742106.3047.2.camel@gmail.com>
Subject: Re: Missing Package in git Installation Instructions (git-scm.com)
From:	Christoph Michelbach <michelbach94@gmail.com>
To:	Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Date:	Tue, 05 Jul 2016 20:08:26 +0200
In-Reply-To: <577BB507.1060603@gmail.com>
References: <1467670411.13990.4.camel@gmail.com>
	 <alpine.DEB.2.20.1607050807320.8378@virtualbox>
	 <577BB507.1060603@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thank you both!

I cloned the repository to fix it yet found it already fixed so assumed
either of you did that. But according to git blame, that line was last
touched 94 days ago by Yue Lin Ho and they made exactly that change. It
seems to take a long time until they publish it on the website.

-- 
With kind regards
Christoph Michelbach

On Tue, 2016-07-05 at 15:24 +0200, Jakub Narębski wrote:
> W dniu 2016-07-05 o 08:10, Johannes Schindelin pisze:
> > 
> > Hi Chris,
> > 
> > On Tue, 5 Jul 2016, Christoph Michelbach wrote:
> > 
> > > 
> > > Hi, I noticed that the instructions on https://git-scm.com/book/e
> > > n/v2/G
> > > etting-Started-Installing-Git don't work without dh-autoreconf
> > > installed on an apt-get system which isn't listed on that site.
> > > Can you
> > > fix that or tell me whom to tell about this? The website doesn't
> > > offer
> > > contact information. Just tried this on a fresh Ubuntu 16.04
> > > installation.
> > When you follow that link, do you see this text on the left side?
> > 
> > 	The source of this book is hosted on GitHub.
> > 	Patches, suggestions and comments are welcome.
> > 
> > It links to https://github.com/progit/progit2 and I am sure your
> > bug
> > report would make an excellent contribution to the bug tracker
> > ("Issues")
> > in that repository.
> > 
> > It would probably be even better if you cloned said repository,
> > found the
> > respective file via `git grep apt-get`, fixed it, and opened a Pull
> > Request.
> Or you can even fix it from a web interface, if you have a GitHub
> account.
> Behind the scene, GitHub would fork a repository, edit file and
> create
> a commit, then create a pull request.  Very easy for one-off fixes,
> assuming
> that you have a GitHub account.
> 
