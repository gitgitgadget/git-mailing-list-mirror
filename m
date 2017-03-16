Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722C120323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbdCPTDi (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:03:38 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33778 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbdCPTDh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:03:37 -0400
Received: by mail-lf0-f46.google.com with SMTP id a6so24433945lfa.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xYpfSoye9/blM41mBa1J2WIBR+Cdhlkr34K8WN0XasY=;
        b=VkzM6Cvn4W1Mbg24j+g0XRW/ydHLdTAFFlJVvQ0Eu4cIDToTrU4bzkD3BIeAOl2B4V
         Hg8AZ9MgNwcf2C4wxwttr0fxQHh/75+hAPtWJyYYYWAWSobu6k40Q04taRWXnY7ajryc
         3n+P8H19oFNas+Eu90MW2Xli7LHJrO1ZOeL3BRLPAVq+J+aiOMF8Ay2O97/GmmsezIDz
         x+YbpkkLbxKbcTrsPfD6STNRnXO8oJnC9FrYUMA1jWdqiPWPGscTst56v1opqKyHuj1+
         QMglA3lOfKljhcyYZvXP1oxVs3mC8Qfp8bXzxgrF1YENAhvrUq7qnxm0Vp4Vps7amjUw
         mhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xYpfSoye9/blM41mBa1J2WIBR+Cdhlkr34K8WN0XasY=;
        b=bSMFMWKCj24oc781lKK7/nSy5ghClBXAcYZuO+k0NXRhziWQ2XoSlAAC7DzrW8qaRE
         2j0tPhtU2WF+c7YegjFqq+/o0ouMjXoR3YfESGZjOtDalOL7/sBi5IqxU79HHOtpiRMB
         SZh7YkWrvhNKHVrwdaGFp2W8OT71/SAGDbvD2Sf0mxQDRUSM20IGXsSy8Ms+waQkO3ZI
         toqek46nw7tUHVENgH4r+5pGzkLhizzxiyfgiur8pC1b+aLCLUH8sBH4xfTN6S0HUyVP
         X3E19Q0i8iYu6SRYJKtl/E6dIITTix2qT8ZLHHT9Ei1nnv7nfS7skYrGteAVmSQ/GBR1
         ghoA==
X-Gm-Message-State: AFeK/H23ewq4x2b65wlbmHchz5U2SzX1gfyLEbxx4g2i87yDWmpRrxO0sxzk8L/yfBBC8zJSOuHvqFSKqsC1gQ==
X-Received: by 10.46.71.16 with SMTP id u16mr3513607lja.106.1489691015281;
 Thu, 16 Mar 2017 12:03:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 16 Mar 2017 12:03:34 -0700 (PDT)
In-Reply-To: <xmqqo9x1aw44.fsf@gitster.mtv.corp.google.com>
References: <20170313200854.6905-1-souravcristiano502@gmail.com>
 <CAP8UFD3toXk36wmJu+EeBnTvCa0yHWqCmQOfoJ0+2QTs8MpB-A@mail.gmail.com> <xmqqo9x1aw44.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Mar 2017 20:03:34 +0100
Message-ID: <CAP8UFD0Exw4GPeat+xCgJdgd1E0dy0tu8JVpzkq=DnvGWArFDQ@mail.gmail.com>
Subject: Re: [PATCH]v2 adding built-in driver for javascript
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sourav mondal <souravcristiano502@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 7:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, Mar 13, 2017 at 9:08 PM, sourav mondal
>> <souravcristiano502@gmail.com> wrote:
>>> javascript is one of the famous langugae,it's needs a built-in driver.
>>
>> Please use "Javascript" instead of "javascript".
>
> While we are typo-spotting ;-) Wikipedia seems to prefer to spell it
> "JavaScript".

Yeah thanks, and while at it, the "v2" in the subject should be inside
the square brackets around "PATCH".
