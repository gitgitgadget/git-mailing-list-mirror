Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85891FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 17:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbcL2RtY (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 12:49:24 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35519 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753060AbcL2RtX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 12:49:23 -0500
Received: by mail-pf0-f194.google.com with SMTP id i88so20998564pfk.2
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=wHUcARUOSYsCYJkJRWUKApBEGG26b/TT4pruiKdmJJ4=;
        b=IsrPcuHVcLsZqgOM4DxR6KRE6Ik81OYDDQlAcLRdSrtHShdL8E0VmKhxUNZ4j5aI9P
         QPGh0ktKbg74swOkr/z/P6d4flrafxsfrGZHvwk5S3rqrxQknXHqXV6UWM+TrqHd0LNU
         wCWTPw3jovCQa1qNwd3ZIEbqzURFSn+2IaDXQ4MD3428/qNBevVSumFew1JUwQ166BCi
         gE4t7frdDxm4uVOsJmvBYY7DUMh/2ZwQW3osuCGDyBvOTSaR6IUZDdCcI65JtsCr+woV
         IHnbpxZy9tuwk019zwFJFxKmvBdt2FnR0jw/YbGjaf4/wpAhekL4RTCiDBOJ6Kpzg5Dh
         WxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=wHUcARUOSYsCYJkJRWUKApBEGG26b/TT4pruiKdmJJ4=;
        b=oS7BAVVx4gZXfjnduazz69jWfQylcPSieKBDpANVrMST4LxnEmL6FGsYW/LAw1dBw/
         8/OciQHdvMKZEagL84GHp9fm3H6Gz2jIWPjChPANFNptzWs+ZhpI8/jCnMTgeSSnHPJL
         n0+1/aQblXlYd1zZBRVP0KFDvNzmApW8L7SWvUYamZGMG/p21BEvbk7JjoTxe8mdj9Mi
         Ae+QMRUiB9Fjom1WfQHJeaj975HrvaxXaDzZR1d0A6RqzyT+bPToaStR4O1p4WHwdkuD
         P4Ljbe5mjO4zxh7XfqHrjgNSSrq2kPn+wwELHGgNSduAHN4sWaHvgtityd7fzUmK5QWS
         juWg==
X-Gm-Message-State: AIkVDXI7IyYoLwjUP/74QMbOByrixO55GPlOr9s/fiEBSYEJF6cNycFI90zCCqDlWVUuKw==
X-Received: by 10.99.226.83 with SMTP id y19mr78892200pgj.147.1483033763077;
        Thu, 29 Dec 2016 09:49:23 -0800 (PST)
Received: from android-572e73cba46c9ae (50-39-169-111.bvtn.or.frontiernet.net. [50.39.169.111])
        by smtp.gmail.com with ESMTPSA id o126sm107189630pga.34.2016.12.29.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2016 09:49:21 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20161229084701.GA3643@starla>
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com> <20161229084701.GA3643@starla>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] am: add am.signoff add config variable
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 29 Dec 2016 09:49:19 -0800
To:     Eric Wong <e@80x24.org>, Eduardo Habkost <ehabkost@redhat.com>
CC:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
Message-ID: <A52AD4B5-8AB3-49E8-9EED-5ABBA91369D4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 29, 2016 12:47:01 AM PST, Eric Wong <e@80x24.org> wrote:
>Eduardo Habkost <ehabkost@redhat.com> wrote:
>> git-am has options to enable --message-id and --3way by default,
>> but no option to enable --signoff by default. Add a "am.signoff"
>> config option.
>
>I'm not sure this is a good idea.  IANAL, but a sign-off
>has some sort of legal meaning for this project (DCO)
>and that would be better decided on a patch-by-patch basis
>rather than a blanket statement.
>
>I don't add my SoB to patches (either my own or received) until
>I'm comfortable with it; and I'd rather err on the side of
>forgetting and being prodded to resubmit rather than putting
>an SoB on the wrong patch.
>
>
>(I'm barely online today, no rush needed in responding)

I don't know what is true for all projects, but I can't believe making it configurable would cause problems.... If you don't want it you don't have to enable it.

I suppose your argument is that we shouldn't ever make it automatically but... I know that many people who receive email patches, apply them, then forward those to another group add their sign off as a mark of "yes I certify that this is legally OK" so I think this would be useful.

Thanks
Jake


