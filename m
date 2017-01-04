Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DEB8205C9
	for <e@80x24.org>; Wed,  4 Jan 2017 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966706AbdADJRY (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 04:17:24 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35211 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966657AbdADJRX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 04:17:23 -0500
Received: by mail-qk0-f178.google.com with SMTP id u25so389744582qki.2
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CXBx14k5UZ9X8Gpd02AHSfxFuune73uabq5STOU0hW4=;
        b=aMYpwKEpeyOhHqhFnls3JYAknElfTj/QqSeHsfotV4ZoT5PVh/KmPSaDBDBCIqclX1
         WZxhCOV8yZzO2VZvUJRRVhtPefsP5q/yAu4frSet1Sc7TeYeLkoWd4p+rsB269aat9q+
         V6y/LK08uo1wKCX+MwND38fswGOqA+j9lzcac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CXBx14k5UZ9X8Gpd02AHSfxFuune73uabq5STOU0hW4=;
        b=XM1WeKG8awY5r7zw6noaaMrr2H3IYWHn70WaWPLM9zdPGFfMRKwyxjBMrSOWT6Igh1
         PGHRuv1r6+OFSStMAIErhtWIJr/IKBX/goGtJHqF7+BWybrs8fvr8hT1e87znc+ERWwv
         kEv2jMDKjht3ASM3DdVoufuULV8miU+OkomaQ7iNeHx4SF5AYNIXQHZf7C4+FisnyXmT
         fYClYvKZGqUvCS/SBP1NoigqveYDOOniAcugd9uriMAdpTCjl0r7D8pPhFsH/8bekxMa
         1sjFE2AxoO8OLLq3ZxmxrYUm9kC5EXR/cenjqzuJX3Dzob2b8qTYMM18qenvtJ1CNv4I
         1izA==
X-Gm-Message-State: AIkVDXKJtkltcH9JqXxfptPpetduiUOQhaEIp2zmYNqkONba5zX/+g8bWpXcys54RHolVMcHn26Qt61wypIssA==
X-Received: by 10.55.112.65 with SMTP id l62mr74088504qkc.76.1483520970714;
 Wed, 04 Jan 2017 01:09:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.62.179 with HTTP; Wed, 4 Jan 2017 01:09:30 -0800 (PST)
In-Reply-To: <CAPv0x+PoQ+3ERAc_0gviYP5j1-Zg=X+B1OSC6vDKatqUhFtAag@mail.gmail.com>
References: <20161229102223.6028-1-igorkuo@gmail.com> <CAPv0x+PoQ+3ERAc_0gviYP5j1-Zg=X+B1OSC6vDKatqUhFtAag@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 4 Jan 2017 09:09:30 +0000
Message-ID: <CAE5ih7_D4F=vic+Dud-QwTushVmW200W8C+T6H+igH+WoSz6rA@mail.gmail.com>
Subject: Re: [PATCH v2] git-p4: do not pass '-r 0' to p4 commands
To:     Ori Rawlings <orirawlings@gmail.com>
Cc:     Igor Kushnir <igorkuo@gmail.com>, Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 January 2017 at 20:02, Ori Rawlings <orirawlings@gmail.com> wrote:
> Looks good to me.

And me.



>
>
> Ori Rawlings
