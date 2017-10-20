Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD691FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 13:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdJTNbT (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 09:31:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53049 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdJTNbS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 09:31:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id k4so22580790wmc.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2IQ6KTYyQ9Up4lPzuk1Nb+zmM8Ybx4tbvmD+NvCygk=;
        b=EWmV2F/+d1seSa+1KB6fmyxRBzxSZDf6uS04Tdu6EG8oM/W1N2th+imEjR//UHHHRu
         vcSjlQKZoN6Btw8fPd1r/Fi3RhbJIt2hBvT4g7NDsgiEdPoPo/bMFYacRBfPFdS2uQoa
         7hymVKWFeBBN2aMBDfiGD+/0IjfZlE1VrXaB2X8clzbZUey/tQqzFSGBBzPuh8qXAxyR
         iY7VeAAnADpsYA3WcVHo71JmrS2GYhEgK7kYHCQuF2OGUpe1C81F2riO9+0/LWMAylgs
         4QiR2cKSTDXMHpiJv18c6PfwJwy7pSiQBff4E3ygAm8KHSA4PfVuGTXoYZuc2kZ1WOs4
         P9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2IQ6KTYyQ9Up4lPzuk1Nb+zmM8Ybx4tbvmD+NvCygk=;
        b=AS6vwD4UiRk6CL07OuMtETTJYmhdP8BegUckct/AWB8rCxRzRnjAz5oXspIrNGxOGX
         ptjbXzx/yWEWnV8eFGkZgTLrGoUtrHn0IXAsAkCF+aZ73vraPfKTP8P4gnenKFiBY2ua
         te92XcDUzkFXwh5Vok+c41jP+qbJqCp2XNCl9dbUq2M6phLWiHXpaBHT9xsYBMuCTR8c
         s7EyumxNKoWk7uZSBBo0oDVVhyJt1JFjMxaM6A9Jv/8Q1qeOIDVNAjgGlIRniMg6aIpT
         hm8XUEKNwcxrjadKkLrEovtYDBPOlZBDfNPwgRlMsli5dept+PdbMpvYEYLjHKbxxfHR
         PAiA==
X-Gm-Message-State: AMCzsaVJlECxPsKGUzlnx8Ib+Z1x4nYyP93AjB1rqCjTxkOqS9msUbsr
        6UXNlr9hn7QTl5GH3gxG1EI=
X-Google-Smtp-Source: ABhQp+T2mQCMQWxULH5YfyWgC+tI0BobUS0yOu+MT09oCmMHBDzEgEoSUS+S/P1LuVVYC/HfOSOq2Q==
X-Received: by 10.80.147.16 with SMTP id m16mr6426463eda.121.1508506277183;
        Fri, 20 Oct 2017 06:31:17 -0700 (PDT)
Received: from dira (gumitek-2.superhosting.cz. [80.250.18.198])
        by smtp.googlemail.com with ESMTPSA id f46sm1147131edd.80.2017.10.20.06.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Oct 2017 06:31:16 -0700 (PDT)
Message-ID: <1508506274.23715.11.camel@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
From:   Jan =?UTF-8?Q?Pracha=C5=99?= <jan.prachar@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Date:   Fri, 20 Oct 2017 15:31:14 +0200
In-Reply-To: <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
         <20171002230017.GT19555@aiede.mtv.corp.google.com>
         <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
         <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
         <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
         <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
         <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
         <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
         <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
         <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
         <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-10-03 at 05:10 -0400, Jeff King wrote:
> I dunno. Maybe I am wrong, because certainly I never set it. We've
> had
> two reports on the list since v2.14.2. The motivation for the first
> was
> "I have no idea why I set that, and I'll switch to auto". This is the
> second.
> 

I also came across this git add -p regression. The reason I added
color.ui =
always was that `git log --pretty="tformat:%Cgreen%h%Creset" | less`
stopped
having colored output with color.ui = auto. And git config man page
suggeseted
color.ui = always on the first place.
