Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A0420281
	for <e@80x24.org>; Thu,  5 Oct 2017 13:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdJENnw (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 09:43:52 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:48509 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdJENnv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 09:43:51 -0400
Received: by mail-lf0-f49.google.com with SMTP id q132so17013828lfe.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=93wN6EwJQFf5xL5aYIA7wcMjS9UsubWCSGJB/256/D0=;
        b=hoKpCr7eojAOcm4y4yOk4Thntr891zzVDMVkzaA+p0EfVNyFvy9ahwef5qbS280a/g
         XDRoPmJLjciLVJmv+om3pPNVfYZFNepG6yrK8GoJVukKQOtuSHtf5d3pB1uUGgQmZ3kb
         oLkbIs9mKADkx9fbRwvE7YiVvPuSKeKEsPS//i0lQRN8oaLpPl/9irp0D1wm+nxPutng
         2AlM4jdpaAXx4QTOJQCUcCdN8Alo8ELtCPeL79gXwnzPmZTL2/3fDqon+eJBtzOI/XMC
         nrwb5Do7GsjARQbHHCf6eoWSofQqoRudP/CtId0wHrVVk5kdOCQpOaIj5JnXzuNWacmM
         Q/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=93wN6EwJQFf5xL5aYIA7wcMjS9UsubWCSGJB/256/D0=;
        b=QvXKbKPJakpm3VLS4sy/b5NPW61C9onQPtHPMJJ9iifj/ooUjKmVNfUGT5d959lPSk
         a6d7RA3gM5oUaxIsasYGhuHaVOF5tkZ1IxnwHGcztu56g2wEb8d0via6wQz1BSvrOr8V
         8rtJhfzbSgu+f9JmjNyYau07VkqLXS2A8zn5GGGLgJQGF5r9MdemzvipqP/SFWpgoDBJ
         SHhbV7rH/pRyQaGpFnqbXhKGidCi1vFqcXQC9SKAhvO3PZ8tCJ5gwoaTz/MTPCAQXfm4
         rAMfzsFmdgUPQo5WZBplQujWp0RO34uob+iEZ7+5I3KMGdEM0eSZTTImt6c+Bec/fnc/
         WV/w==
X-Gm-Message-State: AMCzsaUP23oCpFzzI/kT+qtCdS9Ph2hYCnpIw1JlHf5xHlxdY6J+6Ozz
        35Jpz81nBGUHCwEx4f72o5JB8Tel
X-Google-Smtp-Source: AOwi7QAddJpRtNmO4OGgxHcb09n68uQ8gK5eXcOCMAH80I8ns/mYhGiE1vDFJYzSn7NnSVPQKT00EA==
X-Received: by 10.25.145.90 with SMTP id y26mr7876203lfj.247.1507211029040;
        Thu, 05 Oct 2017 06:43:49 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-246-117.clienti.tiscali.it. [78.12.246.117])
        by smtp.googlemail.com with ESMTPSA id 37sm3003200lfv.46.2017.10.05.06.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2017 06:43:48 -0700 (PDT)
Subject: Re: git send-email does not work with Google anymore?!
To:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
From:   Paolo Bonzini <bonzini@gnu.org>
Message-ID: <384b95b9-822a-872a-999a-10b5e1e60076@gnu.org>
Date:   Thu, 5 Oct 2017 15:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <EC14D46D-61AB-4531-AE20-8C2B3F6B5A2A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/2017 12:52, Lars Schneider wrote:
> Hi,
> 
> I used to use the Google SMTP server to send my patches to the list with 
> the following config:
> 
>     [sendemail]
>         smtpencryption = tls
>         smtpserver = smtp.gmail.com
>         smtpuser = larsxschneider@gmail.com
>         smtpserverport = 587
>         from = larsxschneider@gmail.com
>         chainreplyto = false
>         suppresscc = self
> 
> Apparently that stopped working today. I get this error:
> 
>     (mbox) Adding cc: Lars Schneider <larsxschneider@gmail.com> from line 'From: Lars Schneider <larsxschneider@gmail.com>'
>     Password for 'smtp://larsxschneider@gmail.com@smtp.gmail.com:587':
>     5.7.14 <https://accounts.google.com/signin/continue?...token...
>     5.7.14 ...> Please log in via your web browser and
>     5.7.14 then try again.
>     5.7.14  Learn more at
>     5.7.14  https://support.google.com/mail/answer/78754 ... - gsmtp
> 
> Of couse I tried to log in via web browser etc. Does anyone else use 
> Google as SMTP server? If yes, does it work for you?

It's probably a good idea to set up two-factor authentication and add an 
app-specific password for "git send-email" (at least that's what I do).

The password can be stored encrypted using the OS keychain, or if you
don't want/have one (e.g. you are running headless) you could check if
your distro installs git-credential-netrc.  Create a ~/.netrc.gpg file,
where the decrypted content should look like

    machine smtp.gmail.com login larsxschneider@gmail.com password mypassword

Then do

    git config --global credential.helper netrc

and you're all set. :)

Paolo
