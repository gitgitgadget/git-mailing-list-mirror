Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E3D202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdB1VPL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:15:11 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33692 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdB1VPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:15:09 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so3110432wrg.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ed/AnqFkDaXUnEgRZFbTae+EfGcDx6U+id0zW7ed6kc=;
        b=kwB8gp/1duHcVrG77GxWUfTcgovOVlWh6f7qENqET2fIGzBSAKRgmxXRMxOmvzLX0/
         eAawjql5vkHdaDCzMQu6eI+dFLULrgSgNjnX4IUKgoxYbDlKghnbb2prVvHDtYgxW0yB
         Y5gIEJfM/qOkcNXn6oCud7Y5XNCUQ7LoNrMwPyxTRfND4gQmzEWNJlIFnBTYcZjowQvz
         Hkp/X9PLP7kLnHacNkleaZjybmI93aLOi4IYcYeUNZuqSSebglMQ1OnLjM1wFBOfb462
         kH/C5O3jdRmceKTwVy6bC3F0F5sKSqlPMVNvz/5IG7fY0zwwNx3URzL+iIy3ZN/i/hom
         9ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ed/AnqFkDaXUnEgRZFbTae+EfGcDx6U+id0zW7ed6kc=;
        b=BAU6sWnJAGrU7HwbSBJiXBdyMV/pcRE2tQfF5nSxGi2jeXyhdJB/UZ3/uSwfWKDf9o
         5bZ4Gv5JIdUPThufiHgVQPfo1B3W7UG53EuG2lXJ//TEHwxrEnCSLzVtPgSb2JD6EMs2
         cSfMXhVWacUrrw+SReVX+YVDQKuOAGX4uNsJp/XUTlakTf1YX2R39vMmrgfMxYUQDxV3
         XjA/CUn6qSwlfBBr+sIVni7g+H3cGabWqjy4r5Zks2vCek8vFOs3wZZjm7NBnjeiM44P
         kyBvIKDsFKHk3bXQ4O1YpnQkDsUYz2UQWqgPbALWYdKXEl4pcqG/5BcAsdMVheya3PdQ
         0i3A==
X-Gm-Message-State: AMke39lH+BTiTOloaTIIbB/dwueAnGdaIPyHPYHzE9hNLwI8DXu36wzL9l5XaP9Fvz09Yw==
X-Received: by 10.223.134.69 with SMTP id 5mr4312620wrw.22.1488316416971;
        Tue, 28 Feb 2017 13:13:36 -0800 (PST)
Received: from ?IPv6:2001:a61:1052:4001:ede7:c9d0:a549:517a? ([2001:a61:1052:4001:ede7:c9d0:a549:517a])
        by smtp.googlemail.com with ESMTPSA id w97sm2502499wrc.20.2017.02.28.13.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2017 13:13:36 -0800 (PST)
Subject: Re: [PATCH v2 2/2] Documentation: Link descriptions of -z to
 core.quotePath
To:     Junio C Hamano <gitster@pobox.com>
References: <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>
 <1487968676-6126-1-git-send-email-asheiduk@gmail.com>
 <1487968676-6126-3-git-send-email-asheiduk@gmail.com>
 <xmqqmvd6jayn.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <d59bda7b-2eb5-a6cc-8240-0ff4f50de540@gmail.com>
Date:   Tue, 28 Feb 2017 22:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvd6jayn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.02.2017 um 21:51 schrieb Junio C Hamano:
> Andreas Heiduk <asheiduk@gmail.com> writes:
> 
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index e6215c3..7c28e73 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -192,10 +192,9 @@ ifndef::git-log[]
>>  	given, do not munge pathnames and use NULs as output field terminators.
>>  endif::git-log[]
>>  +
>> -Without this option, each pathname output will have TAB, LF, double quotes,
>> -and backslash characters replaced with `\t`, `\n`, `\"`, and `\\`,
>> -respectively, and the pathname will be enclosed in double quotes if
>> -any of those replacements occurred.
>> +Without this option, pathnames with "unusual" characters are munged as
>> +explained for the configuration variable `core.quotePath` (see
>> +linkgit:git-config[1]).
> 
> Seeing that many other instances call this "quoted", we may want to
> be consistent.  I can see "munge" in the pre-context, but that one
> can stay as is. Under -z, no modification/munging happens.  With -z,
> a specific kind of modification (called "quote" described in the
> documentation for core.quotepath variable) happens.  The same
> comment applies to the change to Documentation/git-apply.txt
> 
> Otherwise the patch looks good.
> 
> Thanks.
>

I'll fix the "munged" and, unless there are objections, I will also
replace the remaining ones in the vicinity. These are the last
occurrences of "munged".

You are OK with the references to another man page? My idea was to
establish a well-known term.

