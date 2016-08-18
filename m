Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147A8203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 00:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbcHSA6a (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:58:30 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34991 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754457AbcHSA62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:58:28 -0400
Received: by mail-yw0-f194.google.com with SMTP id r9so344002ywg.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 17:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R09007yfdDxxoHfxujblS6gnOKuhadLAaZPZ3QmfiX0=;
        b=fAiYrOiMNerghijVLXxenfaEUZM2VfR1TOZaB/QAhrJfkldkrMmzvzPkb9oIec5agB
         s6E6J3K6w6/JhJtEfqz0+2/p6zRezbVkCsqfAue7Lgu8Y5eNn2uUjpqy3t5nVzFEJEjt
         SrSfrvgqprb3X/jS4RDlY9CsP0Plzc5D0qHxptwKujyeUVEiltr6A7sgf7jlzMqklnlv
         UDAGEdf+hDaCYYZ3HIcyZ4l5F6RrHWtRtz1Ej+M5nUr37Snn1R7eygFFnEzRss/HN4PM
         YFginE/K0UxJVZYJ4WZgJOEPAJ+UTQyEB2ER35GIfyWv3zmT819rmTslKnv9SigxLuOm
         ayYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R09007yfdDxxoHfxujblS6gnOKuhadLAaZPZ3QmfiX0=;
        b=PLC7sh8d9Vo8YKP0TDevFBbVCob+aQp8VQqnmnOw7+qG3hMPuNJwicilXUvLCKqZae
         3wxjFVyc0Pe+5nO2tt9//SsOjvFmWsZksl0goWLsCf3i2IXXdk00xKVtHlMLQuM6gDZI
         yqf1BN4jBN70VDZiBUiKHTwtOaHI9muX4nqEB0jvFEzFPfQO2t7RfZ22PIouZJe/zAUA
         tjxrjt+axsY5oxYJVa2UoA4GzNPy9yFTGMlRhm9wUhp4jUdtfzQtLESZ37Z70YT7ip6X
         jOHRvBt6Bwn1Vu7igtAIpcUF5t/Ev8jM2ir1+V07/FNTX+W56uDkuMqnifess1spmeo2
         qg4Q==
X-Gm-Message-State: AEkoouuB9nb3+jLgmuh2fxxRmdNS7p5xy+lhUzmiE+AsipAxPzeM8UrhDvUVCw6+TosogCJbC2IKoRNLpko3WA==
X-Received: by 10.13.228.196 with SMTP id n187mr3484947ywe.83.1471553069463;
 Thu, 18 Aug 2016 13:44:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Thu, 18 Aug 2016 13:44:09 -0700 (PDT)
In-Reply-To: <CAGZ79kZp+fhB-APx+zSAyYYiLq0pinDZOS1s33a7OjckJOi5=A@mail.gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-7-jacob.e.keller@intel.com> <CAGZ79kaFfrVwe+JXVJBBZVPn=mTv7F1db8T1ZzXEaMtZKoupQA@mail.gmail.com>
 <CA+P7+xrNzc-+KBdu20QpEcCJ_udYUUk=qQyDi26YoOyCwrPXiQ@mail.gmail.com> <CAGZ79kZp+fhB-APx+zSAyYYiLq0pinDZOS1s33a7OjckJOi5=A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Aug 2016 13:44:09 -0700
Message-ID: <CA+P7+xqQ-iaax3rtZbsGb6D4vBbwP7d63Qq4D2_z71V0Z4YCeg@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with
 helper function
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 1:39 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Aug 18, 2016 at 1:24 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Aug 18, 2016 at 12:04 PM, Stefan Beller <sbeller@google.com> wrote:
>>> On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>>>> +       if (is_null_sha1(one))
>>>> +               message = "(new submodule)";
>>>> +       else if (is_null_sha1(two))
>>>> +               message = "(submodule deleted)";
>>>> +
>>>> +       if (add_submodule_odb(path)) {
>>>> +               if (!message)
>>>> +                       message = "(submodule not initialized)";
>>>
>>> Before it was  "(not initialized)" for this case, I think we'd rather keep that?
>>> Though this code path is only used by the porcelain commands, we'd rather not
>>> want to change this in a subtle way in this commit.
>>>
>>> If we were to change those, we could discuss if we want to go with
>>> full sentences
>>> all the time:
>>>
>>>     submodule is new
>>>     submodule is deleted
>>>     submodule is not initialized
>>>
>>>
>>
>> I agree, I'll make a new patch that does this as a cleanup prior to
>> this re-work.
>
> I was actually not suggesting to change that. I rather wanted to point out
> that if we'd want that we'd rather do it consistently and in a different patch.
> Sorry for not being clear.
>
> Thanks,
> Stefan
>

Sorry for being unclear myself, too. I'm keeping it as "not
initialized" and updating the description of the patch that changed it
from "not checked out" to "not initialized"

Thanks,
Jake

>>
>> Thanks,
>> Jake
