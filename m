Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1781F1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 15:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933101AbdHVPZz (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 11:25:55 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34876 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933028AbdHVPZy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 11:25:54 -0400
Received: by mail-qt0-f181.google.com with SMTP id x36so29915670qtx.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=woBrgbORFkjqzv+F6Qh7snQBf5djWcmxlZfws5+5RiE=;
        b=WWIrLF2Zu3++84fK4O2iMhsfUq7UqkMpvPoR1HhniEFSiMzQjMpUHAw4Z+rN5MUbbD
         dkps1KFAx+Y9sd+QLEiZv+yhRUaJZfVIKd9++mq9XN7kZVpiL2WM9tU+hcf+K+6xjMiD
         pKLsfAe5pzibvwF6uzrgbv29PUAPua5ACt3djFCS24AZ2JmPrJ3zlRDAEGqIGCvl0Lkt
         vX1i7HJWkUbPI4nhBYXV9MJei4HL1WuVVu40DWP0vJQPchU2NHic1VmCD6uFPOWDuOUs
         xMysla8kibzkvmDPbmpee+EzgGF3O0UySKTDYKxo3Kln1TpOz8RKat7jrYLzvj/ntv0O
         /CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=woBrgbORFkjqzv+F6Qh7snQBf5djWcmxlZfws5+5RiE=;
        b=TYz3vGhMU6tHQ4TZkJtbD7Hi8O3mHCxA+2LBtydgUe+tXfjo34Iq0oTghSgaA6cV4/
         QR+KbNICKYUjWgTV9ihDqdGrFa9jtbEDZhs6f+4rzM69Ib2H5kk/PHdAZXfKsJP8GJQj
         mv49vsIFtlrRH+lPyeBAeRKAr9hNUqekSilDgkoLGT3lVLnB730/tpkcWD88O4VWTd+u
         geHQBQUVyNizaEp0D7PlpsNz/VSTxQ6eVYLYGa9xxvJnwM/VWF//jOTj4y515JcKPVDH
         2ouM94+svon/roi0ZYT3TyDKJK3TZaNemkh7jIGFn/BI1Smby+RQwcns6lF3YLDzm/Ve
         b2Ew==
X-Gm-Message-State: AHYfb5i89aG9JuqbtHaNaXQwS0obCJINgRe7d9On735NHLIsomrcz5ed
        o23XNHh+m4TeCT8g
X-Received: by 10.237.39.35 with SMTP id n32mr1494794qtd.48.1503415553617;
        Tue, 22 Aug 2017 08:25:53 -0700 (PDT)
Received: from ?IPv6:2604:6000:b40b:7800::5? ([2604:6000:b40b:7800::5])
        by smtp.gmail.com with ESMTPSA id 22sm10241490qto.36.2017.08.22.08.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Aug 2017 08:25:52 -0700 (PDT)
Subject: Re: [PATCH 0/1] Add stash entry count summary to short status output
From:   Sonny Michaud <michaud.sonny@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
References: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
Message-ID: <cd00912b-5b66-f299-87bf-52aa19d90270@gmail.com>
Date:   Tue, 22 Aug 2017 11:25:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <c3ac0335-4f41-40d9-00ee-2a4e115bcf7a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am just bumping this thread; I presume there is something amiss with 
my submissions, so if someone can let me know how to fix any issues, I 
will gladly re-submit the patch.

Thanks!

- Sonny
