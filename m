Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E1C1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 16:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbcGSQDb (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 12:03:31 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36759 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbcGSQD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 12:03:29 -0400
Received: by mail-lf0-f49.google.com with SMTP id g62so18424392lfe.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 09:03:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Sa6C7nOTeyZRBRjlpB45VR1fjwJpp6sSoiR83ix3Lqo=;
        b=tKDciyFeJTrOly19H/vtkHBehpnwor1rtWygt9SqZht1wZgshnX9x3iDapna5ipsFH
         D0E4tIgal0poZvBK2rObI1LSmSx5DZ6cfg7ggBKseo9Xcy3WeHYMYWLfEc/jGN1nGACQ
         LizowufOuM5q1Yie4+6O2X/5dAxb7bIL/XsXUAsmIlhkMhknN/eDiqX+xJGNFYasOBLj
         IA1cAOnm7HdffzT2xqubGQbGq1dLXcGKf9onA+Dgpyk67V4XDFQMNppW3UFnC/bdd8vN
         Q7nnUkJmxEM9U3ySbO7f04Ah7V8IFvMrMNOzolQWH53Q0qJAneoPtkv0vvEwrvqcmtzX
         ZcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Sa6C7nOTeyZRBRjlpB45VR1fjwJpp6sSoiR83ix3Lqo=;
        b=b2f5j+hTWHcAXJKYHgYrxODH/2C83HNOWV+LuW3Lr9kzoqAd7dGZQKs8uAdjOHK1bA
         RZlAeWKHkM/8CV70bVkFPE+cRvxAg5TFnGXdRz3bofR/jlJBEpYT/98tMr5/5bUrSJAI
         DxU8Tuqby4G6wccOsuZdE96DkX/JNl5xa97z3GtUPXMt+xGiYQfpjbrjQZ1wYzpgUSge
         N8e9mfDGfhO6QrFK/OJqQRvZEEsCNwcH7M2WnWIt2Z/AS7DDyyZoxM+wZ/1dcINrt2a+
         1jgVxrXyzNE9RUw+bKx3mzorh53gV2v1Uc4Lie8XsqbL+yekBuq9m9Ok9+azWuLS9oTg
         uVvw==
X-Gm-Message-State: ALyK8tIWOGixBMaBRicrjp/5exbyRFMmPg1UhSNlpfAwey9DQIY629oKSNlryV7FgAZJqw==
X-Received: by 10.46.33.76 with SMTP id h73mr6173407ljh.41.1468944207865;
        Tue, 19 Jul 2016 09:03:27 -0700 (PDT)
Received: from [192.168.1.26] (adan30.neoplus.adsl.tpnet.pl. [83.11.249.30])
        by smtp.googlemail.com with ESMTPSA id 83sm5986105ljj.14.2016.07.19.09.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2016 09:03:27 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] doc: give headings for the two and three dot
 notations
To:	Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
References: <20160630202509.4472-1-philipoakley@iee.org>
 <20160711202518.532-1-philipoakley@iee.org>
 <20160711202518.532-5-philipoakley@iee.org> <5784F43E.3080400@xiplink.com>
 <xmqqwpkq6b4d.fsf@gitster.mtv.corp.google.com>
 <D94C739D5C334AFE9E5E8410147899EA@PhilipOakley>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578E4F4A.2020708@gmail.com>
Date:	Tue, 19 Jul 2016 18:03:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <D94C739D5C334AFE9E5E8410147899EA@PhilipOakley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-13 o 00:11, Philip Oakley pisze:
> From: "Junio C Hamano" <gitster@pobox.com>
[...]
>> I actually think this is a good place to have them described.
>> <rev>^<number> is about specifying a single commit.  These two are
>> not that (you can say HEAD^2^@ but you cannot say HEAD^@^2, for
>> example).
> 
> These two are special cases I'm not too familiar with, particularly
> the r1^! which I didn't understand from the description...

<rev>^@ is all parents of <rev>, that is

  <rev>^@  ==  <rev>^1 <rev>^2 ... <rev>^<n>

where <n> is number of parents commit <rev> has.


<rev>^! is (if standalone) a single commit range, only <rev> revision.
It is actually

  <rev>^!  ==  ( <rev> --not <rev>^@ )

that is, reachable from <rev> but not from any of its parents.
Parentheses here denote that `--not` does not affect the rest of
rev-like parameters.


Hope that helps
-- 
Jakub Narębski
