Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B817D211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 18:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeLZSMU (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 13:12:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45925 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLZSMU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 13:12:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so16270732wrr.12
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8DqSy7dyy7ltt28IZF5724+isRFxXEVBMZCaqIJ92OI=;
        b=L4RmL4TQFpSwfelWzXNaIAPg9DxUWa2VP/anf4osUVCTr/VFIfg6uiQvzojhHQKv3K
         5ATSnLNhL9rQHkKlr9jcJctBu3oJ8vEWgc9K2d9EWHcdezmKcGFHDeEvnGdVuLuUXGcU
         L1ULEJ++6iRinsuF8wHKNn/i84kn4bGPb6Cc/dtCA/NtAIEZos/72dI0UD+0zcLC3p4y
         VZFuOfWTcHsv2BqET6+pzAuTjDaPw/fqmljmQ9ObSmoodMUxyWxn99Pgd/4JuvDvRZni
         5v8d8dOuiTWw+jE+6vphrhpMW5/VQgPT5KiY/hL9oM5yI+61ZkbCFcas22nChPQtVh/k
         W3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8DqSy7dyy7ltt28IZF5724+isRFxXEVBMZCaqIJ92OI=;
        b=ACsZLRPfg49AgcUyblsU81IpCfSQfDR4eLujty5zdOxgNyE2phR5/5VZpd7uxuqTyE
         a69SFfMwFZJFTP7y+YDr9XFDQeTASHFVzWcIPW0qOFuKuCZwzc//vOEsp5iKQtHQKvM4
         WmmHJ83htPL7TDjdaV7oLp6Ax5beYX0b5ucTlcjJ3SCg2ZMcAqtuX1PPxzsMLfDD6CB7
         EOoQ9RSx32m775SNj7KSRSljMIxvPp/iI8D8BYzaeATB3ECZ4zLBVTg+eQFTG7EbtDQo
         0n5APBY1NKJWfrGOJQ+l1FClaw77KiZ4ZpmctDrqtmx+YiWTBOeF8halA5Hmz5lYvEMV
         2a4g==
X-Gm-Message-State: AJcUukeRl5KoysmQXjY4eAegeOD0qJYFgaxgDZgQu/1MjI845Oh5vq9i
        u8S0Jmy0R9BddXvCmvIms/g=
X-Google-Smtp-Source: ALg8bN7L6h2Bv3zs6MZXX1vACvIOympfry8B/sagFugPw8X+8yadg0O6OSVkq+rur8TKZGGgbfIX1A==
X-Received: by 2002:adf:a743:: with SMTP id e3mr18680751wrd.56.1545847937927;
        Wed, 26 Dec 2018 10:12:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s8sm29889065wrn.44.2018.12.26.10.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 10:12:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Anthony Sottile <asottile@umich.edu>, git@vger.kernel.org
Subject: Re: [PATCH] doc: improve grammar in git-update-index
References: <20181214212504.3164-1-asottile@umich.edu>
        <bfe22381-864a-4a6b-8dd9-78e268e52c36@iee.org>
Date:   Wed, 26 Dec 2018 10:12:14 -0800
In-Reply-To: <bfe22381-864a-4a6b-8dd9-78e268e52c36@iee.org> (Philip Oakley's
        message of "Sat, 15 Dec 2018 17:06:54 +0000")
Message-ID: <xmqqimzgrwch.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> On 14/12/2018 21:25, Anthony Sottile wrote:
>> Signed-off-by: Anthony Sottile <asottile@umich.edu>
>> ---
>>   Documentation/git-update-index.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
>> index 1c4d146a4..9c03ca167 100644
>> --- a/Documentation/git-update-index.txt
>> +++ b/Documentation/git-update-index.txt
>> @@ -326,7 +326,7 @@ inefficient `lstat(2)`.  If your filesystem is one of them, you
>>   can set "assume unchanged" bit to paths you have not changed to
>>   cause Git not to do this check.  Note that setting this bit on a
>>   path does not mean Git will check the contents of the file to
>> -see if it has changed -- it makes Git to omit any checking and
>> +see if it has changed -- it means Git will skip any checking and
>>   assume it has *not* changed.  When you make changes to working
>>   tree files, you have to explicitly tell Git about it by dropping
>>   "assume unchanged" bit, either before or after you modify them.
>
> Doesn't this also need the caveat that it is _a promise by the user_
> that they will not change the file, such that Git doesn't need to keep
> checking, and that occasionally Git will check, or may perform
> unexpected actions if the user has the wrong mental model.

True.  

Setting bit _allows_, not necessarily "makes", Git to assume that
the path will not be modified by the user when it is convenient for
Git to make that assumption (e.g. instead of reading a blob out of
the object database, Git may mmap the corresponding working tree
file when they are the same and Git thinks using the latter is more
efficient).  When Git finds it more convenient to check if they are
the same, the bit does not stop Git from doing so.

So in that sense, both the text before and after the patch is bad.

	Note that setting this bit on a path does not mean Git will
	always check, or will never check, the contents of the file
	to see if it has changed.  The bit allows Git to assume that
	the file in the working tree is identical to what is in the
	index when it is convenient to do so.  When you make
	changes...

or something like that.

