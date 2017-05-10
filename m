Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665CE1FF34
	for <e@80x24.org>; Wed, 10 May 2017 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbdEJKeF (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 06:34:05 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36479 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbdEJKeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 06:34:04 -0400
Received: by mail-pg0-f47.google.com with SMTP id 64so14553411pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a0o6rIAKhz9cf1L6x+qIpPMgF6hcCbl3IqDh4qmdb+c=;
        b=fjXYhSY1mrRh2iO/ItcW6PrU8+xnMqhgGBnsBuarTZef2YCzBiAYCoSAOtoi1ferI0
         TSQ+mqGZBvwPHLejFCbtYtoszflB3LnV3SSnR11bc1Cn4IApHR9ERsdrgnL+guXxKnWQ
         N6etHmaYMUZlbSJKVl0XG9PZZlkq1l/BUNxz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a0o6rIAKhz9cf1L6x+qIpPMgF6hcCbl3IqDh4qmdb+c=;
        b=mxAvKCn3KNQCPDcyNr0HxTbExT4FPt2R8jhK4MTYJl3dYCWok39i6rNKya0+IKYQB3
         UrzvvcMhHohm+8TT6/dK2PzPskFjdZR8vnNI7v59zFvIsobWqPNUzB9VY2dwUqty3dmt
         s/22bX6L/bePydOjynFahpshMmVQPFicLrcC5FWe0vY7DDQoD9F5aHJFw5QgDgYvkVaG
         xUdbT1Jw6dHSO9r8ORc0MGRCduiBn0RfgoemQGDGFW3c30bRh4tMOvrQ92Et+QVgPD7A
         vIDOGPJP7DbBuez8BmDWFg9Mp+FdUi337TZFWIqJ9rkKgrr3OqwDo5e6kaPpGOOwPQuS
         YVKA==
X-Gm-Message-State: AODbwcD5WZunLFUaHgNb/VXfCNuvK0TFs+vS5OFCGdTgKDEn8dxVy+op
        gBHrQugYH2Xzb+jd
X-Received: by 10.99.123.21 with SMTP id w21mr5417027pgc.106.1494412443867;
        Wed, 10 May 2017 03:34:03 -0700 (PDT)
Received: from localhost ([122.172.108.155])
        by smtp.gmail.com with ESMTPSA id h71sm4975063pfe.85.2017.05.10.03.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 May 2017 03:34:03 -0700 (PDT)
Date:   Wed, 10 May 2017 16:04:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Query] Override sendemail.tocmd
Message-ID: <20170510103400.GD17481@vireshk-i7>
References: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
 <CACBZZX4pz26SCZBbivDneRX6hRPxpuPHXpOQKnn1zJL6xWj_Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4pz26SCZBbivDneRX6hRPxpuPHXpOQKnn1zJL6xWj_Eg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10-05-17, 12:18, Ævar Arnfjörð Bjarmason wrote:
> On Wed, May 10, 2017 at 9:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi,
> >
> > I have a use case and wanted help from you guys..
> >
> > I have set the sendemail.tocmd option in my kernel's .git/config
> > file and that works very well. But sometimes I want to avoid that
> > (for example sending the patch to someone without the list and
> > maintainers).
> >
> > The suppress-cc=all option works quite well to avoid almost
> > everything (including running --cc-cmd), but it doesn't suppress
> > --to-cmd.
> >
> > Are there any specific reasons why it is being done that way?
> >
> > Currently I need to go edit my .git/config file and remove tocmd
> > before sending any such patches and it sucks :)
> 
> Does something like this work:
> 
>     git -c sendemail.tocmd=/bin/false send-email ...
> 
> ?

That failed. I tried with 2.12 version first and then on the next branch with
version: 2.13.0.303.g4ebf3021692d

$ git -c sendemail.tocmd=/bin/false send-email --to vingu 0001-abc.patch
0001-abc.patch
(mbox) Adding cc: Viresh Kumar <viresh.kumar@linaro.org> from line 'From: Viresh Kumar <viresh.kumar@linaro.org>'
(body) Adding cc: Viresh Kumar <viresh.kumar@linaro.org> from line 'Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>'
(to-cmd) failed to close pipe to '/bin/false' at /usr/libexec/git-core/git-send-email line 1687.

-- 
viresh
