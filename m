Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A149620970
	for <e@80x24.org>; Sat,  8 Apr 2017 22:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdDHWIA (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 18:08:00 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33279 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdDHWH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 18:07:59 -0400
Received: by mail-wr0-f181.google.com with SMTP id g19so83954221wrb.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=m2wrCQoiyzzyio5KPbLpVNZ8sZOTc9ZiG4sR3ndoi9w=;
        b=f5yd4B7agsDYgpk7k1spiqy80yFecSPV5EQhlBo5QGJeQb863xm7mLpwaBFoZHOQ29
         n3xV2NNu8ww7FybNzs5z14JmCiELOgA5KFTRvbqbrvPpRCnUTsLxoIkrAQYg7G42T4c4
         EMtAwvDRuyFEWbYODaxVffOFzxvUXjZ46jXW3/nvd5I3e1khMS16EQz8C8S4o4qYqXeU
         8oDIdeJApucqpyFZQ6yLyksZDaA/+8tNIzuvxaqnXZFdQ1ypzl6aVJfCtDpgf06GFTT7
         89RMRGJSZ5iAlK5AqfY1lA3ovfO+rMnN3Ixq5yDomk3KSgSFd9PHwFdB5n2oDFQEPSsD
         Z+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=m2wrCQoiyzzyio5KPbLpVNZ8sZOTc9ZiG4sR3ndoi9w=;
        b=k+8SucD3g75V2hV/YpP0kZ3QnMo3K1/IhsRKzEYFxAJXNER4B3OpzSAZ4U97GUHFhB
         QJo8m5H98eVs1jZsTU6oHLDRA1fklK5eMcyDnIPla12Su0AWAO1Ep/71iR0ecSRBKDef
         Bkzqdw+tSqdH5Z9AIc/Nz5vMttzAZCFMmNcA4Y35wiEA83RAfJ4l5gs77CIXzxVdrBXR
         EX5+V+/PT7JB6UmCcgkHsoRkqHYZSX6xM67uYbj/xcbayMDIuY7m2uRx08q8kSkGWzhf
         tZ4LqBKXUMBuvhlJ+3LNvDUkE0jPaWJo+KtMtNX3y+SIw7EW8GY7zz4/AAgvWW4dtux9
         Osig==
X-Gm-Message-State: AN3rC/4wXLJST1rwFKhdlh4bRl3x/UHnlOi2qwNBj9pt3g0DIG+iSsjKLP0YInIImhwAvQ==
X-Received: by 10.223.136.165 with SMTP id f34mr16021758wrf.145.1491689277878;
        Sat, 08 Apr 2017 15:07:57 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.180.64])
        by smtp.gmail.com with ESMTPSA id b31sm5964671wrb.7.2017.04.08.15.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 15:07:57 -0700 (PDT)
Subject: Re: broken text encoding in commit author name
To:     =?UTF-8?Q?Micha=c5=82_Walenciak?= <kicer86@gmail.com>,
        git@vger.kernel.org
References: <12228342.8FuY78Fyzc@kicer>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <e1836f50-1318-b72f-5507-b395be02e88d@gmail.com>
Date:   Sun, 9 Apr 2017 00:07:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <12228342.8FuY78Fyzc@kicer>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michał,

On 08/04/2017 22:30, Michał Walenciak wrote:
> Hi
> 
> since git 2.12 I'm having random problems with broken text enciding in author 
> name.
> 
> As an example broken commit:
> Author: MichaÅ Walenciak <Kicer86@gmail.com>  2017-04-07 21:38:23
> Committer: Michał Walenciak <Kicer86@gmail.com>  2017-04-07 21:38:33
> 
> good commit: 
> Author: Michał Walenciak <Kicer86@gmail.com>  2017-04-08 21:21:15
> Committer: Michał Walenciak <Kicer86@gmail.com>  2017-04-08 21:21:15
> 
> Broken commits are quite rare and I cannot find any rule when they happen.
> Git 2.12.2 here, Arch linux.

For what it`s worth, looking at the timestamp of the broken commit 
example you`ve shown, could the problem be related to amending commits?

If so, are you amending through the command line, or maybe using some 
tool (like "git-gui")...?

There was a similar discussion recently[1], not sure if it`s related 
to your case.

[1] 
https://public-inbox.org/git/CAEPqvoz8s=CVLABuXx-zOzryrXwr_cb39G2TYJvvF
XRYzpCBFQ@mail.gmail.com/

Regards,
Buga
