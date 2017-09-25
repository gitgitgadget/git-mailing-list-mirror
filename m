Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682BB202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965990AbdIYUFm (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:05:42 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:44540 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934287AbdIYUFk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:05:40 -0400
Received: by mail-qk0-f179.google.com with SMTP id b23so7949430qkg.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XunZFXH4nC8yhQyxhQPIfa4NR99sBOBdtgjnPSC08wg=;
        b=l3n1nwDXJLQf2eK4qbD11qja1K2V2ig0IR/lBkB9fWJMt6xfV8NKY12P33Ev0Tb8IX
         4+f52jf30Qy3WJmBKZlYv0pu1ZGBp6zNrQmjDDAOyAEQen72fkQkDtIUtdLJkZh228Jr
         oicS4meMDquZvr6D0nUQ8WWatdyyDZAOUqg6F4Gn1x48I4Z94vWUlp9iHVc2eL2Cs1kR
         +k9S0g62tI63B9Sr6f6kq+jIpFWMCRVBvWRDDePxpsLT3wiIQjm/toHf6Gqic2tYb04b
         vDpbdPZ+h2Hw4MfDKdqTfCtkZ6Wy8b6UyiVAr2GeCYZrPqYG/ii+Sad299EZ1LCkmZqY
         9N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XunZFXH4nC8yhQyxhQPIfa4NR99sBOBdtgjnPSC08wg=;
        b=aOk9YGA/tBApJepja3exc7os1NfR5piehl3Kcagcs0s/Aj0sHLU3q6AwV08pU76lev
         Gqjrb4kLxGrup3lYxKdAI0bwwOmlHLMKFdeR06tKwvXT5oTjTW86/RxztL09UenXxmh8
         SC9RmD6W13RsSHT5FFj8Jx0qv0JjMu3w5wUgv1Sc/9xFbpyHtVPLq68qIBftdNUFfHQl
         Oh9GimeyVcUrLzNk00dBlkfGGzQCUIPT/FbV6NlOuS0AiPlIEVqCweHjMZ6iGrQWsbVO
         JFag02V2hzmgsoByum6Ryao+fWQoTfVAGc4L0S7yuTA/uYCgzxGZWRhnitvepkv2he7r
         uw2w==
X-Gm-Message-State: AHPjjUjm2koLZf7gyIQO7YLd3Vs5raqa/Rk5a71Bywyho0IRRPp1YOyl
        tI/c4dP+YjWLPzhx+paI01bpKspCnGF1uMJW8wRiJg==
X-Google-Smtp-Source: AOwi7QBXBGgSzBobuX3HyCbx8WebXdnWbV/f6TBKgjYaeSFo7O/2/yH9obE9pigHRPHEViu6PygxdklPVx50dTG8a1A=
X-Received: by 10.55.45.199 with SMTP id t190mr12395126qkh.230.1506369939672;
 Mon, 25 Sep 2017 13:05:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Mon, 25 Sep 2017 13:05:38 -0700 (PDT)
In-Reply-To: <20170925174033.GD35385@google.com>
References: <20170925155927.32328-1-hanwen@google.com> <20170925155927.32328-5-hanwen@google.com>
 <20170925174033.GD35385@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 25 Sep 2017 13:05:38 -0700
Message-ID: <CAGZ79kYnatG7nqmFFqkaB-EHTYDLEn_hM3cMY+-OCZ0p_AmvWQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] Move documentation of string_list into string-list.h
To:     Brandon Williams <bmwill@google.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 10:40 AM, Brandon Williams <bmwill@google.com> wrote:
> On 09/25, Han-Wen Nienhuys wrote:
>> This mirrors commit bdfdaa4978dd92992737e662f25adc01d32d0774 which did
>
> Not really important but most times we reference another commit from a
> commit msg we include the one line summary like:
>     'bdfdaa497 (strbuf.h: integrate api-strbuf.txt documentation,
>     2015-01-16)'

I have

    alias.gcs=show --date=short -s --pretty='format:%h (%s, %ad)'

in the config file for that.

Thanks for converting documentation into header files!

Stefan
