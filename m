Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538A41F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDLLng (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:43:36 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45848 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeDLLnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:43:35 -0400
Received: by mail-io0-f196.google.com with SMTP id 141so5915258iou.12
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TzWZ07aKxAg7Gtq5CS9TMze/YAeyimrHlLNHn/KmYH4=;
        b=CQ2aW2sRUPv9qU9R90d8WMpwkH+Hg/VSrrKtcNW2LztjG2hlpWw627wEmR3HpovJXN
         OadamnpjvP5cJZH9MDdYNl5St8HvfcYZjxmCLcWEoXyhILq8E9bbeUVzqROjEzOmi81g
         SqwDP3DNEKfkcr/PBDwaA+m0m7hnbzAiNp/PhXzPHhvQOYGZw6S06ZXSmBA2YXbNQazo
         pbPXmZo9ybzybs+MvMlA6stdjXOyd6kfDgpou4zKq/afqenpmkaH4JyFKNgRD4zBXTlg
         ZSqtkVn8BAp2cwjMyyHNJN5fLsFswi4PTTJz7N+z8QIw6PFsTUD35p5UZ0g8MxgmDch4
         jfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TzWZ07aKxAg7Gtq5CS9TMze/YAeyimrHlLNHn/KmYH4=;
        b=RJ2h/4PbSLE90l9LJOrEQUpJ0cCS49m+c1zN0EGvSavMJf+H0RPFSOh3gkLMeRby6i
         AVwwsb5xC26AXBrysQUZCkvs7Qjsz9K57mqSCykWsXLZoAfIGgeYvXfPd3b9pPPbajI3
         iUONIxq17As1owL0VbNmDfKu0PVU8Lr77IGhLxOR4AOXhEx+743r7vKtzBzvbTONhFPX
         QdSTSlBNf6fKkb4A2Li/pB+dPwOzUn2+w7tVhU5AWC+gj7vn0wKTnJK49kkGdw+2mDzl
         Fy7YAO8kxj6H+uzg/MlKi72zlpyMb8KA9F8CXZ43WUTHgy2Sgu9B2FsjkUn77CDxlug8
         VeoQ==
X-Gm-Message-State: ALQs6tCkh/uw3KHfYqLk6IfCsqfSt0OGkAlzTxdTmTblafFS7juEHUVN
        hhFBI33WzlphnTe8Ec3I/Pg=
X-Google-Smtp-Source: AIpwx4+ZrZsn4oYNy1S5ejfK0FuB8UI8GB7G5TemA5x67xrHheEH0SGWagdx54LbgdMvDr6uspTYeg==
X-Received: by 10.107.155.208 with SMTP id d199mr8447973ioe.5.1523533414675;
        Thu, 12 Apr 2018 04:43:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id w134-v6sm1809283ita.12.2018.04.12.04.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Apr 2018 04:43:34 -0700 (PDT)
Subject: Re: [PATCHv3 00/15] replace_object.c: rename to use dash in file name
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9ddfee7e-025a-79c9-8d6b-700c65a14067@gmail.com>
Date:   Thu, 12 Apr 2018 07:43:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2018 8:21 PM, Stefan Beller wrote:
> v3:
> * interdiff below,
>    the only changes are renaming the variable
>    -       struct ref_store *main_ref_store;
>    +       struct ref_store *refs;
>    in struct repository.
>    as well as dropping the file rename patch.
> * improved commit messages from discussion on the single patches.
Looks good to me. Thanks!
-Stolee
