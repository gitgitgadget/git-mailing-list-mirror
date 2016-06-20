Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616CA1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 17:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbcFTRGK (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:06:10 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34894 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084AbcFTRGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:06:08 -0400
Received: by mail-yw0-f177.google.com with SMTP id l125so29080217ywb.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 10:06:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PMV5SZd444Y1T7oxDSfQ02aSbBrVbKvkhzTAgtYBPo0=;
        b=WkqPq0szktWiVyDZ8NpPlRsmyNBQNSqEKXLzBg+4EtxY1PB+rYe+FpnSf5JGRV5nkH
         PElYOQgg5OeHgfUZmOfe9mts/jNdXe3Apm+yb96a0fqPnT+M0yqaGI5Iw7LHqPd7hN47
         qXyEbfoK5aS6Y92o2QL7l4W9dioImVcw3XaTJH/xW1AtvdjyBiMlp0nhWKYqCoGaP9Nj
         SNZYebaOc/4qJeLfD5CMjrKYpLMPRR49cD0yPmdL85jLsw1kywFsRxO1UoTl2or2Nu6p
         vjxm+jfReYqa0EWcEyBbNm47TIbuu+nZhAPlLpEhP1XRAmhRx7T5m8i7DRYeXc4pqrsr
         /aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PMV5SZd444Y1T7oxDSfQ02aSbBrVbKvkhzTAgtYBPo0=;
        b=dC7Bn07G7oYOM5lVHLMVE8ySEMb5b8R4D/cL7w5jqI/+GgXErN8fHGm3oE4KwaCIsK
         hpoL8jaJUJk2AE3NX87g00fMCx0A9hle3iXu5RYWKHUzCPWsj7SAXTSsi7X9/dPH0YTX
         zj+AmTotxrn4/K3/USPX06pAhuqpeoHMKDWUcFMpwwcAwOVsmdha+8u38z+Z7SVoGm0q
         oEnxMn0u/ahOrGsXP7AlA2W+PYjMI2Z9BG+Z5ZUSL79sqAYtYbPVTdUILDDqWjpHrMMc
         /qsH7sfqyoAboL/uUBCv6AkByRNc1tQ9Gh33P+XJh20BGWl9M/7UuhMAeY+5bPwa0DSM
         kHlA==
X-Gm-Message-State: ALyK8tJmylCU7ZWSWp04mhXf6ZDDnUXL70tOg41MxJoPZkS41TpHpWmyj3NE+l1C62Vq5FDbfLjQ4DppXER5jA==
X-Received: by 10.13.229.69 with SMTP id o66mr9480009ywe.69.1466442366929;
 Mon, 20 Jun 2016 10:06:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Mon, 20 Jun 2016 10:05:47 -0700 (PDT)
In-Reply-To: <CAGZ79kaHRz2GZN4FmQBA1wz4FhBWDwVifWX_bN09TAHAxF-wQA@mail.gmail.com>
References: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com> <CAGZ79kaHRz2GZN4FmQBA1wz4FhBWDwVifWX_bN09TAHAxF-wQA@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 20 Jun 2016 10:05:47 -0700
X-Google-Sender-Auth: v9vUryfP-W53c2PHzm81sOsMPWE
Message-ID: <CAPc5daXg+RFYwp9g6NLvH5bCei2kjWy70Gm3vGnZVCTxqGLFRw@mail.gmail.com>
Subject: Re: Short-term plans for the post 2.9 cycle
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 9:46 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jun 19, 2016 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Here are the list of topics that are in the "private edition" I use
>> for every day work, grouped by where they sit in the the near-term
>> plan of merging them up to 'next' and then to 'master'.
>>
>> These will be merged to 'master' soonish.
>>
>
> Thanks for such an overview!

FYI, this can be obtained by running "git log --oneline --first-parent
master..pu".
The point where "Merge ... into jch" ends is what I usually use myself
(IOW, I do
attempt to build and test 'pu', but I do not run it regularly).
