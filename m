Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F031202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 18:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbdGISzA (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 14:55:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35614 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdGISy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 14:54:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so10173193pgc.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YKLIBW/qnuBDnOqD5pSuwxICMuMeDliVwMX8ery0hdY=;
        b=cRrKVry4/nqKBKOTm50ZFyvp3v9+sOuGwuUp8AIwqDN7dSrDYdMWhn2/ym/qm+iTFI
         sh+Stoe66C6zCHa55jTf28pZaDyrqvgX+r8/2rP4/Tl9MRIi5kE3Ry8Rb8+lppFTKXfP
         uLphc7avBn2CiPfavmEoUdMR813fn0s5MRypnb4Lip/KWBmwn8Aw2YE2p6HdccQ/Gp7B
         LwRaAlv31k5roT+e0J0HAfBskVIGuczTMowK2qfOh03GitxHVATW7zTj0TnJ07QJQ+AN
         3ifuLntXhmc0LOmS/LSyojqdmJyIt3N8/00+fnPz3tgmgm49JDNFtc68va3hGF74tqUr
         KyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YKLIBW/qnuBDnOqD5pSuwxICMuMeDliVwMX8ery0hdY=;
        b=CHXKg8rtHm4IMGiVFGktg4+Llj33FHzozDTtSgPpI3t1SizaMjudFX6hMdDbzpGpdb
         1s74mB90wxVHx1aJBOVMwFSyBuEGCBatUKEXhbhiSUP6xus7tH21F5SpA6TywA1tnVCn
         EjkHWuSxSs5tx1ANtpOq+N2WWfACk35DIlYOwESS2IyqpFwOAP8QbfQQQKK9RKcIVyuH
         LA/QauWrlHDJDAUWs+tdo8ubJOGnbtMvSRBYYTnKTBTkP5oPcSm3UdNdQFHFuQB8Knq5
         KUkVgBRyLjLo3Z1KFuaGg/qjqYpl7LaiRvxANJBJheEOh49+KmKqbYR/xRN/xK7qECS9
         yuVA==
X-Gm-Message-State: AIVw110r5OcjJa2d638DNybmisWQA2N4PB+WnLVkvlGn7otbBVtlsZy5
        cI7QLECbxsIj5w==
X-Received: by 10.84.132.39 with SMTP id 36mr14233653ple.237.1499626498515;
        Sun, 09 Jul 2017 11:54:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id z5sm16941190pgr.35.2017.07.09.11.54.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 11:54:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-template: remove outdated notice about explicit paths
References: <1498792731.2063.5.camel@gmail.com>
        <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
        <1499622873.8552.2.camel@gmail.com>
Date:   Sun, 09 Jul 2017 11:54:57 -0700
In-Reply-To: <1499622873.8552.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sun, 09 Jul 2017 23:24:33 +0530")
Message-ID: <xmqqh8yl8mpq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> It just recently dawned on me that the message,
>
>     Explicit paths specified without -i or -o; assuming --only paths..
>
> is translated and "git grep" shows it's presence in the files present
> in the 'po' directory. What should be done to them?

Leave them as they are.  They are catalogued by the messages in the
code and gives us the translated equivalent.  If you removed a message,
the only effect is that the corresponding message will not be asked
for translation.

Near the end of a development cycle, the internationalization
coordinator will update the master message catalog and he'll remove
it when notices that the message no longer is used (even if he fails
to spot the obsolete and unused message, no harm is done).

Thanks.


