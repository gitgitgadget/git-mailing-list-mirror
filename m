Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABB620229
	for <e@80x24.org>; Wed, 31 Aug 2016 06:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757682AbcHaGZk (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 02:25:40 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33159 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbcHaGZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 02:25:39 -0400
Received: by mail-yw0-f171.google.com with SMTP id r9so25187202ywg.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K53bRLblpZ2egvHxxDyNalwdWhnO5mXs2wa22kcd+Sw=;
        b=N6G7zYVvzk4GbzRqyBFtg71/sDQjAqtjjNXZ/r3Ex2mRe6iqufQBgZCWwqE+gIbPsz
         NGQq19XAJ0cWP8kdFDbKCMxmXNGHcg1V4BOJFuxIwqsrf4qVwNQABc63dldTr107VySj
         K2IJ5Y85hddWjTQP4agKR6arHSUmXcyjqf1w1O6i0ssXjxSI7iIfW9lbIKX220cyaWgG
         obW3GQyEaBoKpBAckjiyx1Sp/sv0cFNhIULaN4PIRq7dfIW5/REswAFQWhYV9rtp0kx6
         oT4YD/09NhbBZyKjbUDDR0kLSM5EGFwyg/ViC/kHZuNPJp/fnCU6v168szdITYth+NNa
         qVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K53bRLblpZ2egvHxxDyNalwdWhnO5mXs2wa22kcd+Sw=;
        b=Zy1Czt5NEvQXbMPq82tlV2dhVVMULKg6oKNStuiU7581nM6aqXFMPY8sGpm+8fVePb
         IXzs5og33JxMTQUWoo9vw4Mzmv6CWskAMas65wa6y84JDWCioUkuADAWBnxjjaXxGT7T
         HQIzhOCmi3TSH8FGwpgvZY99ZlxRFy0s06BPeYXPw7lTVJYeDFthM/2kCaySNPnyXvMU
         v14ilS+DEF+LN3IwbPgxr1PwqPXT4u7SxDLlkTzQuEqO6Q67mq+AbpQRjcKlrH8ZhktP
         /Ken666Ybn71Udi0ngYM9CA1KVGgxq3AgA6c85YHEdsu9eBWs4lHSGznEAFLkdDx7u9+
         QfDA==
X-Gm-Message-State: AE9vXwNK/hbYQsEr0oJI4LdpvZLaTWsIHe/pjDbSHQzR4DLtjDHgCl9CHm9T3ZkvkmQ5IATywvrKyS4juMHiHw==
X-Received: by 10.129.95.70 with SMTP id t67mr6621168ywb.284.1472624738399;
 Tue, 30 Aug 2016 23:25:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 30 Aug 2016 23:25:18 -0700 (PDT)
In-Reply-To: <CAGZ79kYVgCy95Pf14my_pq1qW=MB-3gF=FPf+S-VqO8k-8yf5A@mail.gmail.com>
References: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com> <CAGZ79kYVgCy95Pf14my_pq1qW=MB-3gF=FPf+S-VqO8k-8yf5A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 30 Aug 2016 23:25:18 -0700
Message-ID: <CA+P7+xpjyhdNEMJuP6HB60Sj1uomsNRnZ9tAdcCKAwuRCbgOLQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #08; Wed, 24)
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 10:10 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> * sb/submodule-clone-rr (2016-08-17) 8 commits
>>  - clone: recursive and reference option triggers submodule alternates
>>  - clone: implement optional references
>>  - clone: clarify option_reference as required
>>  - clone: factor out checking for an alternate path
>>  - submodule--helper update-clone: allow multiple references
>>  - submodule--helper module-clone: allow multiple references
>>  - t7408: merge short tests, factor out testing method
>>  - t7408: modernize style
>>
>>  I spotted a last-minute bug in v5, which is not a very good sign
>>  (it shows that nobody is reviewing).  Any more comments?
>>
>>
>
> Jacob Keller reviewed that series as announced in
>
> https://public-inbox.org/git/CA+P7+xpE=GoFWfdzmT+k=Zku8+YjEH-aOMsFUtJJJwFHa1hKDQ@mail.gmail.com/#t
>
> and concluded it is fine as in
>
> https://public-inbox.org/git/CA+P7+xrokr0ZGidQFuvpN+-J_WDjkaUropcnPGVjZHafc12AnQ@mail.gmail.com/
>
> Thanks,
> Stefan

Yep.

Thanks,
Jake
