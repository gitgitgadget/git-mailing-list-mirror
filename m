Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D1C1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 13:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeGINu1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 09:50:27 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:44653 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeGINu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 09:50:26 -0400
Received: by mail-qt0-f175.google.com with SMTP id b15-v6so15394062qtp.11
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=/bgM/u37L5zF43AqZFSvjqdUaPFoIjLU+STq2f0g21Y=;
        b=GQIG89ujd5ssGtov09WATHgeAyeEPwxQeEYPOYIT3O8MD0/J/T0zI9+HrKQFzh9uoh
         djeegWi9afSF4MnxfTwc/1Hu/H9foxMS7b/3ma6oAwpTjalWR4NB7JxPLiZ2aMpxUg08
         yuXHZzTj8DWd1nJ9K45PVWNmVycdx0gvJqOnw050HZT7gn4GAgL3ellPZHHoeigG6VvU
         UE+1hrX0gSxYu76tfvBfH67NhMA+ICq8Pqfez7qD8vCtii+tPsTf0WtWLdV5mrf1nLGi
         b5wP29PW1B5aGb4s6liJqMweQxffyIYg5RzQB2xvfpfgh+cn33mnmKQYBRnZG41vEJif
         Py2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/bgM/u37L5zF43AqZFSvjqdUaPFoIjLU+STq2f0g21Y=;
        b=Womij6fSmvRvne7T3FdoJZMmsGhv0if0BeR7xQFU0CV3DLa8c6iQPL8V7RxkG4tOHT
         QQDGFuS8+a1aKWQ/yHv/u3b6uEfH2TYZAwpUOZwV+vb1LSoOTqETQWvyRcw05uxll+EQ
         JwLG3Uh9rC5ZhLk7HkPKcNMCKjvvzfdHC0VPclT3S5bDOTeRyWNqaYu3JU0tLY6ZIqhS
         wwkhqDUl8sJCnx7hh5SA9uukVfWlj7zqbOcqRZXcKEBeYBSNj3iaRiXmF264XqVbx3Wo
         IEyzVXaB+q/b75kpHY5C/mwA6w26+9iepvckzSeUNO4GQgyzYfe0Wiq5b+K95nNJ1KJv
         pXRA==
X-Gm-Message-State: APt69E29eEofEqvsFWzAsg4QZWN6nvKLEW9pjGwN+Wt3QPhq2VDdg3bC
        po7EaE4rWmRQnp/DsaRHgfCmRfWP
X-Google-Smtp-Source: AAOMgpfeCsQ82wJ0jByxBgwLVmSIBhMyTSatL7cJ2eFvIyJHZcmQvg+GYzQdvWuR7lmdYBQ/urR68w==
X-Received: by 2002:ac8:302e:: with SMTP id f43-v6mr19184094qte.217.1531144225556;
        Mon, 09 Jul 2018 06:50:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4d64:6d41:6305:74de? ([2001:4898:8010:0:369a:6d41:6305:74de])
        by smtp.gmail.com with ESMTPSA id m15-v6sm11238382qki.44.2018.07.09.06.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 06:50:24 -0700 (PDT)
Subject: Re: What's (not) cooking
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3d8bc7b8-b7be-4583-469e-6b962607b3a7@gmail.com>
Date:   Mon, 9 Jul 2018 09:50:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/6/2018 6:57 PM, Junio C Hamano wrote:
> I'll be pushing out the integration branches with some updates, but
> there is no change in 'next' and below.  The following topics I gave
> a quick look and gave them topic branches, but I had trouble merging
> them in 'pu' and making them work correctly or pass the tests, so
> they are not part of 'pu' in today's pushout.
>
>      pk/rebase-in-c
>      en/dirty-merge-fixes
>      en/t6036-merge-recursive-tests
>      en/t6042-insane-merge-rename-testcases
>      ds/multi-pack-index

I tested merging ds/multi-pack-index against the latest pu and the only 
issue I had was with header files being added to 'packfile.c' and 
'building/repack.c'. Both were that I added "#include <midx.h>" and 
cc/remote-odb added "#include <remote-odb.h>".

After resolving those conflicts, I could compile and test as normal. My 
series did not include any new test failures to these that are already 
failing on current pu:

t0410-partial-clone.sh                           (Wstat: 256 Tests: 16 
Failed: 2)
   Failed tests:  15-16
   Non-zero exit status: 1
t1302-repo-version.sh                            (Wstat: 256 Tests: 15 
Failed: 1)
   Failed test:  15
   Non-zero exit status: 1
t1304-default-acl.sh                             (Wstat: 256 Tests: 4 
Failed: 1)
   Failed test:  4
   Non-zero exit status: 1
t3306-notes-prune.sh                             (Wstat: 256 Tests: 12 
Failed: 2)
   Failed tests:  3, 10
   Non-zero exit status: 1
t5304-prune.sh                                   (Wstat: 256 Tests: 26 
Failed: 11)
   Failed tests:  1, 4, 6, 12-18, 20
   Non-zero exit status: 1
t5502-quickfetch.sh                              (Wstat: 256 Tests: 7 
Failed: 1)
   Failed test:  7
   Non-zero exit status: 1
t5318-commit-graph.sh                            (Wstat: 256 Tests: 63 
Failed: 1)
   Failed test:  41
   Non-zero exit status: 1
t5500-fetch-pack.sh                              (Wstat: 256 Tests: 356 
Failed: 1)
   Failed test:  43
   Non-zero exit status: 1
t6014-rev-list-all.sh                            (Wstat: 256 Tests: 4 
Failed: 1)
   Failed test:  3
   Non-zero exit status: 1
t6500-gc.sh                                      (Wstat: 256 Tests: 10 
Failed: 5)
   Failed tests:  2-3, 6-7, 9
   Non-zero exit status: 1
t6501-freshen-objects.sh                         (Wstat: 256 Tests: 29 
Failed: 7)
   Failed tests:  7, 12, 20, 25, 27-29
   Non-zero exit status: 1
t7701-repack-unpack-unreachable.sh               (Wstat: 256 Tests: 7 
Failed: 1)
   Failed test:  5
   Non-zero exit status: 1
t9300-fast-import.sh                             (Wstat: 256 Tests: 183 
Failed: 1)
   Failed test:  88
   Non-zero exit status: 1

Should I rebase onto cc/remote-odb to avoid these conflicts in the 
future? Or, were there more merge conflicts with the other "not cooking" 
branches?

Thanks,
-Stolee
