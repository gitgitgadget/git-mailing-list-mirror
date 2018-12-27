Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD5C211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 12:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbeL0MKO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 07:10:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39776 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbeL0MKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 07:10:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so10722073qkh.6
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 04:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nr+2IBOxou5a/v00iWmMS6lpXyqc4/m7tR6/BZfQEcs=;
        b=fma+qZhmKr4+SXn/rBemQuNff88AHa0ARuXSenPkRIukdTG6xGIz69KRjixoCd84P2
         lnf8btK+K3bEfZ+JxwmWBcAVWphv6DnZ81qm3Gwi7zHhoolRQm1vW0H9u3mO7UTCSOkb
         a65R/BqPNDD2se0NSUJg86vcZGj92sLw3SbBM8whWQbCy9TbwjjWWlYdpyAoUP3Y1K/n
         noQeoS+qohrx4UTJciDL7lQqWmFBo+iAlX3dVbs4MJScAon0KEy7JqIWoKl8Hx9XHMwM
         pU2Xcha3N59e2HFcglQi9+o8z8W+OYWLGxXAvF1QuIWt4U0glcPqP+4+fsaIPhtLlnM4
         wU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nr+2IBOxou5a/v00iWmMS6lpXyqc4/m7tR6/BZfQEcs=;
        b=YzatnroKjMwoRl86UcplQv9s6Ukp/5xO0ue2Y59++5pb8rfFQxzww4vADuYY7Zg8Wx
         f0QJ5JRaSBKCfVZQ8i7qG6HP5E4Jj06l5+y8yQWg1mP0II8ZI773TkDy/PIwWEM/YY2M
         gvvbQrTbyjKsBLZtE2iZNbKWxNXBDyWbByaJ0uMU+XYoy9/wbzKYtJ7vyf+j2149G5iw
         v+yjZBdZF8WHOCn9rThgiGC/UxXERxO8GMlLg0lvm4i97eGfM/Eyvq/SRVsfPzv02Hit
         2qW63Okgapd7FwMJxv6eyla4ruhgoPY/QrTNGUzSdIr2kP2p+9DeRhxE/Syn48qqMepX
         Ny+w==
X-Gm-Message-State: AJcUukcdxVjAJScwUeEhq8UKltY123waJ590Sj5qFMtUodMtkYMrLsGG
        dsllPbW2jxSo4mwmHmT+gTmAb54J
X-Google-Smtp-Source: ALg8bN6wpagTV3tdlUuVH0ydFp2CYXWj1KNEFRMOuB+C7Lk8tuSUMZX+cBpD2Q56lFEWe2+p0R3RFQ==
X-Received: by 2002:a37:99c5:: with SMTP id b188mr21907489qke.100.1545912613330;
        Thu, 27 Dec 2018 04:10:13 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b51sm16198774qtb.32.2018.12.27.04.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 04:10:12 -0800 (PST)
Subject: Re: [PATCH v1 3/4] git-compat-util.h: add FLOSS headers for HPE
 NonStop
To:     randall.s.becker@rogers.com, git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
 <20181226230523.16572-4-randall.s.becker@rogers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5712b2bf-8a90-42d7-9159-261dd990eb66@gmail.com>
Date:   Thu, 27 Dec 2018 07:10:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181226230523.16572-4-randall.s.becker@rogers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/26/2018 6:05 PM, randall.s.becker@rogers.com wrote:
> The NSIG define is also not defined on __TANDEM, so we define it
> here as 100 if it is not defined only for __TANDEM builds.
[snip]
> +#if ! defined NSIG

Why didn't you use "#ifndef" here?

Taking a look at the file, I see both "#ifdef" and "#if defined" but no 
"#if ! defined".

Thanks,

-Stolee

