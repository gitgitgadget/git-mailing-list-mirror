Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF9C209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 21:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbcLMVsg (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:48:36 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36367 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbcLMVsf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:48:35 -0500
Received: by mail-lf0-f66.google.com with SMTP id o20so16726lfg.3
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=KVSmanhlFcSH+Z9/oFdEERl2Zdy9y+/PZnYvYv/LE1s=;
        b=uIzYR2NdH9CU5O/6k1bf+nWKTAS1UBLlDrmVc01y4Pit2MZSvyUAFJ58xs2cUIzkSO
         7Pal50zrB3t+qeUeQkZ8KrGQab/YjupVrhj8zHzOXmbef6Igox2jYzt4Pc71H0yTslKK
         Qob7EixwqiRYXtAWz4QeBkhw1VJHDF5Gozr6EWj3cZzybqj3qrniEOd747CO/tqyqZ37
         n9R2Wa7CUH9ekyxLObDn8qjPAPJvn+akB8nhBudLDUKEwS2njJuzniMn1oHAUmuRXWdX
         DQpSXjusc/JfRLkYMA6OkP2QfyBVPxSSAQIshwAxBvZ6r+IXHamcN2lNHD8LZVoKKOI7
         Lseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=KVSmanhlFcSH+Z9/oFdEERl2Zdy9y+/PZnYvYv/LE1s=;
        b=Cm97fTNm0Vv+ZAHzXc12yukHI1j58uV8xtFcfBQ9fF2CA1leQHmEt9COFVJp6GuLvG
         Z5vDJpt6EIFbDP7AxhJ7iFYSOx7CQfMHm+AHphh27zNxy2vq9iayjthIi1CA6O8BDrX9
         zg7agBNI9ccWN25DWOYGszk2RkEGxaY/JJRP1YIpcZg0QElSuo7CTCiFsVwEgVPjAHnc
         Z7EWjxlaC/2O+hJzl4hQjGPf8CHmuegzlL870tV06UDFN5AZpoQkYzzgl15OHsfKbaxD
         zUfFIHf68NgQytlEgcIU8/UZRZNc22knOfPDpaiF0HTmLtP6SALpceuzCRFUHjR9BGeB
         D4mQ==
X-Gm-Message-State: AKaTC00nODIBmYJPxyOafrBz0yaua8N2MjqLndt6jxarsn28HUyO/FG1HyPQS716gIcKCA==
X-Received: by 10.46.9.129 with SMTP id 123mr36969464ljj.20.1481664864072;
        Tue, 13 Dec 2016 13:34:24 -0800 (PST)
Received: from kristoffer-SZ68R2 (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id z1sm10248728lja.27.2016.12.13.13.34.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 13:34:23 -0800 (PST)
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-2-kristoffer.haugsbakk@gmail.com> <88A192B34B3D4DDDA47628687AE458D3@PhilipOakley> <8737hsj7wp.fsf@gmail.com> <xmqqoa0f4s2v.fsf@gitster.mtv.corp.google.com>
User-agent: mu4e 0.9.17; emacs 24.5.1
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>,
        Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] doc: add articles (grammar)
In-reply-to: <xmqqoa0f4s2v.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Dec 2016 22:34:22 +0100
Message-ID: <87y3zjikdd.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

> I was planning to merge all four from you as-is to 'next' today,
> though.  Should I wait?

I'll definitely defer to whatever you think is best.  I guess it depends
on whether you are interested in Philip Oakley's suggestions.  I sent
those emails to inform about what I intended to do in the next round, if
it got to that point, since I haven't tried to contribute to such an
organised project before.  So I was informing about my assumptions about
how to deal with "looks good to me"-kinds of feedback.

So for my part, I'm happy with iterating on this (perhaps just adding
the two "acks", or also replying to the suggestions), or just merging it
as-is.

-- 
Kristoffer Haugsbakk
