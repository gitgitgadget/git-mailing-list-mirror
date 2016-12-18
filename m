Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5F31FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 12:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760349AbcLRMTv (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 07:19:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36111 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755883AbcLRMTu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 07:19:50 -0500
Received: by mail-pg0-f67.google.com with SMTP id a1so8257150pgf.3
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 04:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=xfKI6+1SsDK8zF+cEHrChWb4IUHnNgxCe2hkQhFlt0c=;
        b=Ezm13kJdm1ONBy/QlY9jwHRy+dCCZsN0Uj1dCAw2mjwJyqd+FxsEsN6Xyc28/covZf
         XW3msk/N/bhcP/9uywPF6mktxvxTPomKeY5fXKpU0LZsRQmuXlNYFusYFKdpQ8Fok1vi
         pD9edOVI2Nu6suLRTlKV1uIQXZAgSuVySmGoqzrhcsYZc9g7FmYf2x+eQCwXdAsF+mEG
         5qHcUkwlCpBNfhJ7zB3o0KWXHMyz3ZvxKEI9dm9jRTwMN2ah8hWfTJw7LtG4HwCLKNCp
         H6NMHReD1s/VJlrY/6nA9LoghlXxGU8I8nOmqY2wvHOuIgsda+vIpLrQ0H56peAP6len
         q41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=xfKI6+1SsDK8zF+cEHrChWb4IUHnNgxCe2hkQhFlt0c=;
        b=pEMVWiymEU+tcIiiiNj4ZjdZwTPIkO6ePnLFL6UGCS16bQGbdn4zN2hsERJkFMcdcB
         bkS50Eg6lhBr7tlECTerkAEYMrjeuPJKfDkEOlXqrzk7TStAOf4ALGoz8SQwquoq0OtT
         ts2FReQOXG51l05wIwnHKsn1gzFnieVtp+otCibANQv8kwA0Ax5kQmVzCdFySVgWRRXi
         B0SyOuTV29iYYpTnSB+idVVQQ4+U83qLoxgsf+ZuZYs0UHjASj9MHAhBn+ivzhbYOnA2
         Dfo8JcDzn+iNtDvILNgjwKtdymG45WFoDQVBzamgRe3y/VG7P205JUYsWBUPNjc0E4Sr
         oZEg==
X-Gm-Message-State: AKaTC03uuf1JL46aWlisfNYcyj21AFehAy1OJ4WpygjBNReI3qfkO5GSpZ0yuFuTj5iy0Q==
X-Received: by 10.84.218.8 with SMTP id q8mr24906400pli.138.1482063589935;
        Sun, 18 Dec 2016 04:19:49 -0800 (PST)
Received: from android-57455bc40c756945 (50-39-169-1.bvtn.or.frontiernet.net. [50.39.169.1])
        by smtp.gmail.com with ESMTPSA id 2sm24322910pgy.27.2016.12.18.04.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Dec 2016 04:19:49 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <67572777448E4DCE967BA079110A3487@PhilipOakley>
References: <20161217012431.29548-1-jacob.e.keller@intel.com> <20161217012431.29548-2-jacob.e.keller@intel.com> <67572777448E4DCE967BA079110A3487@PhilipOakley>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2 1/5] doc: add documentation for OPT_STRING_LIST
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 18 Dec 2016 04:19:38 -0800
To:     Philip Oakley <philipoakley@iee.org>,
        Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
CC:     Junio C Hamano <gitster@pobox.com>
Message-ID: <E9C90A8A-8D05-4357-BCEF-AAFAE16225CC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 17, 2016 3:56:19 AM PST, Philip Oakley <philipoakley@iee.org> wrote:
>From: "Jacob Keller" <jacob.e.keller@intel.com>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Commit c8ba16391655 ("parse-options: add OPT_STRING_LIST helper",
>> 2011-06-09) added the OPT_STRING_LIST as a way to accumulate a
>repeated
>> list of strings. However, this was not documented in the
>> api-parse-options documentation. Add documentation now so that future
>> developers may learn of its existence.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> Documentation/technical/api-parse-options.txt | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/technical/api-parse-options.txt 
>> b/Documentation/technical/api-parse-options.txt
>> index 27bd701c0d68..92791740aa64 100644
>> --- a/Documentation/technical/api-parse-options.txt
>> +++ b/Documentation/technical/api-parse-options.txt
>> @@ -168,6 +168,11 @@ There are some macros to easily define options:
>>  Introduce an option with string argument.
>>  The string argument is put into `str_var`.
>>
>> +`OPT_STRING_LIST(short long, &list, arg_str, description)`::
>
>should there be an extra comma between 'short long' in a similar manner
>to 
>the OPT_INTEGER argument list below?
>
>

You are indeed correct sir. I will fix this up.

Thanks,
Jake

