Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF14A2047A
	for <e@80x24.org>; Thu, 12 Oct 2017 17:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbdJLRl7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 13:41:59 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:52682 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdJLRl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 13:41:58 -0400
Received: by mail-qt0-f181.google.com with SMTP id o52so15044934qtc.9
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W4Zu5DJbz8wPnD3kD2F0F569hAUfSM+DryQFzZpLPJ4=;
        b=Om5E/mY0fOc9ERsGmLJVq+FM8GlmE1u7o0OsoLXAWLtDxOp0JUGizE6aEIqxxcMbDI
         LryzTJuZQIY5jE6fUnEU34OPrmU8e24pkiSK0EVrtYtYT1el12GafM51UIdhya7tWbYD
         4C7skt/PfJcmBiiFJtr/1CADEIFgIgN9hAIG2+Au98FsvsUFLuvi9zD97nCoMYEdmu8q
         MV4mM79YrXdW51zS+oYqdEu0htty9zV5omYPsak+FTHZhtGIxrchTZ7Xg0IBEYaMfPN+
         tLxqwnea9unO5n20BIEnlxYA3p+4E33cChWgIaDUkgjDdkFh3gOTikb6RyuJiA0i2NaW
         c6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=W4Zu5DJbz8wPnD3kD2F0F569hAUfSM+DryQFzZpLPJ4=;
        b=FJCmGQVa+o6kl3htGyL5brwsFdLT5Z2rxK8kskmbK6CtB7rJ92PdHlWzIDLHHOFN2v
         H9D5CfwNxLhWWtqDtLdbwRifjCQhoybHN8x723BNbJpr6e28qd0QwTnAp2gYhmvY4zwn
         FyhOmSMRAla+k+uubgq/OwKYZUdNzGVZRwaNMmihAsVXoy1N7HoNzKCN8khCceUIVNim
         DadKcvdfjiQOwXh3plEWJt4itQN2L7O2npBYpilh4/C2ABm39uCYw+Ki2eM3TNdmdvRb
         LDjPsIQ6NLYsaUfibtykmlKbFyT4ppcP/KZtfkrIgxxkGQoJ0L3RNa2XUYHO2scrLt8z
         2YIQ==
X-Gm-Message-State: AMCzsaXEXt58yW5x/EaEthHYRWc8MT6aptDFQU97gu3+4GjfwHAWeyfl
        NDZVMbPceaW58De4OycbNnnSc2vNooqxiA5KXeo=
X-Google-Smtp-Source: AOwi7QDjXpug2J5Gqwo1SgnrEsYIYCvxnuCn1h8q51sVVSJqGFbTMcOUTc9t/9OPZkg6rxZDrythdGwCKPrQVfglJA0=
X-Received: by 10.129.193.5 with SMTP id f5mr2280644ywi.442.1507830117485;
 Thu, 12 Oct 2017 10:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.95.73 with HTTP; Thu, 12 Oct 2017 10:41:37 -0700 (PDT)
In-Reply-To: <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
References: <CAFA_24+svnt4uSpx1tjj2t6iAt4G3p9UvrxahEYj=VZWeJxC=A@mail.gmail.com>
 <CAGZ79kYbeVcpEXsei8Lr=Zw+YgJE_E4mBSRWYcYDqOWz20z5oA@mail.gmail.com>
From:   Max Rothman <max.r.rothman@gmail.com>
Date:   Thu, 12 Oct 2017 13:41:37 -0400
X-Google-Sender-Auth: GOdnpnIiVnCJwTYytzpY5Yl3QrM
Message-ID: <CAFA_24Jov7FDw7AxUtFDV6avOj40LD6ptEVMPpVuSdAo_6L_1A@mail.gmail.com>
Subject: Re: No log --no-decorate completion?
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be fair, other --no* options complete, it's just --no-decorate,
--no-walk, --no-abbrev-commit, --no-expand-tabs, --no-patch,
--no-indent-heuristic, and --no-textconv that's missing.

For example:
$ git log --no<TAB><TAB>
--no-color         --no-max-parents   --no-min-parents   --no-prefix
     --not
--no-ext-diff      --no-merges        --no-notes         --no-renames
     --notes

Thanks,
Max

On Wed, Oct 11, 2017 at 2:09 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Oct 11, 2017 at 7:47 AM, Max Rothman <max.r.rothman@gmail.com> wrote:
>> I recently noticed that in the git-completion script, there's
>> completion for --decorate={full,yes,no} for git log and family, but
>> not for --no-decorate. Is that intentional? If not, I *think* I see
>> how it could be added.
>>
>> Thanks,
>> Max
>
> Using git-blame, I found af4e9e8c87 (completion: update am, commit, and log,
> 2009-10-07) as well as af16bdaa3f (completion: fix and update 'git log
> --decorate='
> options, 2015-05-01), both of their commit messages do not discuss leaving out
> --no-decorate intentionally.
>
> If you give --no-<TAB> you'd get more than just the completion to --no-decorate,
> but all the negated options, I would assume?
>
> So maybe that is why no one added the negated options, yet?
>
> Thanks,
> Stefan
