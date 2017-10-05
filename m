Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276D320281
	for <e@80x24.org>; Thu,  5 Oct 2017 15:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdJEPrM (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 11:47:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34784 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdJEPrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 11:47:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id z1so9837615wre.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cGxYT0T0JNWeepGYgHzZ8ZydCsseOEMVKqyhFSRaaRM=;
        b=JvA0S/H3azG8V0FD7Hss0U/eU2/dA/3sLPjMcXaHdp4kIMgB2dHEKoMBYupzxFsVwC
         Xpip0NRcsOQcxYbUR1wYThsFSs5Ga1xC5u1M6vJkcLwyBxUXeigNr8f/eYLdLIomoUJ2
         F36g4FDYD/5AOqm79k4rFcfH04TG3Zrih0McPklIG64CvkHgeTMwqwDiG4Fp9jk90QSf
         BTJuwkUYhfmncmVtBAApD08spzCn2Mu0iikc9Z8GFAu7mCqYreBi0hxcq3jQBUubzjTO
         AwgBONh8fqYsTaXIPDcVB3g5OKzlXlobPmHFhQEzQbMjbZAlT+YNSks8BhbLKfuqBFA2
         3s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cGxYT0T0JNWeepGYgHzZ8ZydCsseOEMVKqyhFSRaaRM=;
        b=JqyH0Nuwblhr4/Pm/MNsMVJfycU+C3kUxkTrqghvJLSrHzrEJHxI8GWSTZ0h2Jfkm3
         fyQs41BA5b1dB59S/21Q9P4odizWxn4mCAkKdMdml09UC/KPMpVlTDLTveE8l7Pd3lJo
         +S0FNhOzZjn+l2WYHugTlKnqjzSByyGsVxsdv97347u8dYEMJLXkXPZ2N7qwNVWi1aWi
         RhiAwgvcRo34yBKFnd/Wy5p0fZmW7K7BSPtb+EhkbvHo6rtBO6IMkKqecve9JA4Pc7Dv
         h8OqIs00SnexizUkUWaVjmqmYTDhRtdMPxJzy9scSKPpq+rNXyWElwtcaekfh14lNpVc
         RKlA==
X-Gm-Message-State: AHPjjUi1lJz/6f44Y0iFPC5njp/DJJielUWtHBRWLJs7L0iagJhiVgHK
        7ZgW+Ot/OeN24qZQEqop+FgoDhEH
X-Google-Smtp-Source: AOwi7QD2mF2AP69W3ZfhttaxV0rIcJEGbjb6ptejc31gfwllVqx1+L6DFxgMNGHfmelsPKi7XE8mqg==
X-Received: by 10.223.186.6 with SMTP id o6mr21952743wrg.263.1507218430574;
        Thu, 05 Oct 2017 08:47:10 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-246-117.clienti.tiscali.it. [78.12.246.117])
        by smtp.googlemail.com with ESMTPSA id w23sm6284445wrc.62.2017.10.05.08.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2017 08:47:03 -0700 (PDT)
Subject: Re: git send-email does not work with Google anymore?!
To:     ankostis <ankostis@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
 <384b95b9-822a-872a-999a-10b5e1e60076@gnu.org>
 <CA+dhYEUb7uwpYazR1MXNYBXCTPipY0zVKDadnxOKMLaYiM932w@mail.gmail.com>
From:   Paolo Bonzini <bonzini@gnu.org>
Message-ID: <a5dc6969-9f2b-6468-962d-414d9252fd54@gnu.org>
Date:   Thu, 5 Oct 2017 17:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CA+dhYEUb7uwpYazR1MXNYBXCTPipY0zVKDadnxOKMLaYiM932w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/2017 16:21, ankostis wrote:
> 
> But this seems to have stopped working; I clicked the link in the page below
>   https://support.google.com/accounts/answer/6010255?hl=en
> and for my account it tells me "less secure apps" access is unavailable :-(

It says for me "This setting is not available for accounts with 2-Step
Verification enabled. Such accounts require an application-specific
password for less secure apps access", which is the right thing to do.

I used an app-specific password ten minutes before answering OP...

Paolo
