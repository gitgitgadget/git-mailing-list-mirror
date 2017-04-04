Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2471020966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbdDDKNJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:13:09 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36088 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbdDDKMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:12:43 -0400
Received: by mail-wr0-f177.google.com with SMTP id w11so205988400wrc.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1joqHFi/b9uRX+Xk+Hxtta2Vi1AbIk47sAucl4FojKo=;
        b=BMX2+0I/LOntVT4aE7bMhB+5vp7xp1cCNhlHnsbHy4ucUcxbuIDroMcblFt2PnAazr
         FJJgytA0/QW1N8kNY6+z0dbeXtv+MIe5T/k86IKGwGGTOltj+sKJ7kAlJEQsI4Aan9zt
         wj+BxIJR7ZZ7GjUq+wZmnCfJbqduyrCZj4KTSihIZ3r6/Ny4/9Vh/AqfnGTTDv4bq2dr
         /HDltHLfCHcEzy/coQqgZvvfQdsayJ4WGw7QGSN3MZkWppkfpxlDYkFhE/gVoaQroZYt
         JPpw8aGx4TBnphyFsm3Rn16FkvLO4DDPcP5JY0CL43W2VMFRuinvbucENMx+WhS5D2y3
         9+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1joqHFi/b9uRX+Xk+Hxtta2Vi1AbIk47sAucl4FojKo=;
        b=PHCExEXygNFuzpmmUz5hDMDwB4FbvrbUm4ppoPrlvka07uyjSbys+oRhbOumbgiPEf
         67GT4ulxfyQTXNC0EOopQRKo3et3zPyn8nX5gzug6qT5zE1M+h4Fxry3tgIqi81uXUNM
         i9eLGFN/N7o/N0oE6hOlbJLqGECtBLteuz/3gX/g99q+AKRjQg6uFlLBLGJiKAxlwl9p
         mfsGU2z+ZsppRjbuYG0T5TDn6Dn5jW1dU+K+q3mPzHRtJN2IJuxSAJ6/8d3T8yf/wPPp
         sK9LilS8E/IWHk7F4U1eI4hUJoLqtnEwQz2MF7iZMxKQtGeO2Kcu0OrHtAr0Nw5mkAx2
         KyGg==
X-Gm-Message-State: AFeK/H2eepGbRbFbXQgGNIe3SkaxXHkF+EzjVeALNlO5fWVomLC5TI3x/P6B8n6sSpNZkA==
X-Received: by 10.223.139.80 with SMTP id v16mr18471829wra.133.1491300761691;
        Tue, 04 Apr 2017 03:12:41 -0700 (PDT)
Received: from ?IPv6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? (frost.work.nullroute.eu.org. [2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id e21sm13954075wma.5.2017.04.04.03.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2017 03:12:41 -0700 (PDT)
Subject: Re: How do you script linux GIT client to pass kerberos credential to
 apache enabled GIT server?
To:     ken edward <kedward777@gmail.com>, git@vger.kernel.org
References: <CAAqgmoP2uyd5_k-JDOBpBV8ay6BueUvKkwcWAZ_C1n4=4xpECg@mail.gmail.com>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Message-ID: <7ab9e033-906f-f1ec-f89a-952346e98651@gmail.com>
Date:   Tue, 4 Apr 2017 13:12:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAAqgmoP2uyd5_k-JDOBpBV8ay6BueUvKkwcWAZ_C1n4=4xpECg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-03 19:04, ken edward wrote:
> Hello,
> 
> I have my git repositories behind an apache server configured with
> kerberos. Works fine if the user is logged in on their workstation.
> Apache gets the kerberos credential, and validates, and  then sends
> the GIT repo being requested.
> 
> BUT, I want to write a script on linux that will also pass the
> kerberos credential to the apache GIT server without having any
> manually intervention. Seems I would create a kerberos keytab for the
> principal and then use that to authenticate.... kinit supports
> authenticating from a keytab using the -k -t <keytab-path> options,

kinit works, but I think kstart [1] is commonly used for this as well;
takes care of automatic ticket renewal.

ktutil should be able to create a keytab based on your password, but
I've had mixed luck with that. Though still probably easier than
creating a separate instance just for batch tasks...

[1]: https://www.eyrie.org/~eagle/software/kstart/

-- 
Mantas Mikulėnas <grawity@gmail.com>
