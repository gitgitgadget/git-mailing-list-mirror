Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA82D1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbcLHSKQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:10:16 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34277 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbcLHSKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:10:16 -0500
Received: by mail-io0-f174.google.com with SMTP id p42so17012881ioo.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g4UamnFkAq5QUCMW2e8pcGGRy9hIz+Ml+cm8cOh7wuQ=;
        b=CZ0EIYBOrzMooZtmX2a2HXSjAUQ9d05EMrsX/aPgdYUc7CmXB3EYF63R1CfPQf8phJ
         lNrNafCn+kvJHpPFvb9Kw3xKmhlKaO8ZFoZngKTpUFw/1e1TFOUJCq4Csk80jwZERG0F
         +pEC0gf3sgq1Bd1geU4hmmoHZ20IvBPirxgHVnYsK5byg1o7EkBu07/qwHILdjq7W+80
         Nrigh05Im1HslNpxI3M7ixaD5cxhhdsBpeZBNtNaNgibS2XueSRifovQ/n0xO0FgC59e
         tt9Tg0zU9lfVbrBZEHewhchqSXjheQexnlRZY//RZIEz9jlTaUdXGhWwmB8+H3eDx7u/
         7R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g4UamnFkAq5QUCMW2e8pcGGRy9hIz+Ml+cm8cOh7wuQ=;
        b=kJMykw9NhZ7/5hjuKOXmzD+Ne2TofY09SV5JeLo6FFQOcYCfM6YiEImqcDs0MiCZgZ
         qiL/HjvY4mbIfrWefO5rxmyueMOPVnCMDUXrZcdAhj6vpeIcDLEnkU95h0YLe6OSG+FH
         5K19qKwr2W/GNGoLz26RGO34i38+YINdqHoihQf/mVSXTMn3voLI9EWh15o2J1Kt67ML
         OacQuNSRNVFcO7c3qxAE+38oluyJDBrb35iHHTw12vrKAGX5V6Y5yITFOVbvbuBf13iX
         GgsVCOxIwQfmsOOmMW4Of5ihnYLspT3/ddw0lleH/cKixYrSlY+79wTTVoV4slrTRCBm
         6rqg==
X-Gm-Message-State: AKaTC03lN2kTOD516OxA9eygCUbQCekapnLcvQbllvsedJNdE+s8Hd1yuPHtHtBkISSwOAxQQfCc1HR4KTXY+uz+
X-Received: by 10.36.3.1 with SMTP id e1mr2909561ite.97.1481220614745; Thu, 08
 Dec 2016 10:10:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.12.219 with HTTP; Thu, 8 Dec 2016 10:10:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1612081252490.23160@virtualbox>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com> <20161207194105.25780-1-gitster@pobox.com>
 <20161207194105.25780-4-gitster@pobox.com> <alpine.DEB.2.20.1612081252490.23160@virtualbox>
From:   Robbie Iannucci <iannucci@google.com>
Date:   Thu, 8 Dec 2016 10:10:14 -0800
Message-ID: <CA+q_oBfTs7_-sNujG0wgUu7DDSyukx6DbYcNRTnKxZbc7LWNpQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] lockfile: LOCK_REPORT_ON_ERROR
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks all for taking a look at this, I didn't expect such a quick response :).

No hard feelings re: breakage; I know how gnarly these sorts of
refactors can be (and more libification is always better :)).

Robbie

On Thu, Dec 8, 2016 at 3:53 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Wed, 7 Dec 2016, Junio C Hamano wrote:
>
>> The "libify sequencer" topic stopped passing the die_on_error option
>> to hold_locked_index(), and this lost an error message from "git
>> merge --ff-only $commit" when there are competing updates in
>> progress.
>
> Sorry for the breakage.
>
> When libifying the code, I tried to be careful to retain the error
> messages when not dying, and mistakenly assumed that hold_locked_index()
> would do the same.
>
> Ciao,
> Dscho
