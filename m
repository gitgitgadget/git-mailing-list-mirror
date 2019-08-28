Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1391F461
	for <e@80x24.org>; Wed, 28 Aug 2019 19:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1TPG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 15:15:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42495 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfH1TPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 15:15:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id u13so455196lfm.9
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=A6karn7RDcqZ2XVTeu6jeYB4sdww51xCs8ddaal2Tbc=;
        b=nk8bNx9dsyznVVL9MuXXHRO1Ri0/6SyaiQ3ibaWxolxOvj36OKFijBTXXby3UU4PwB
         Rht4uDiOysMmmi1M+9XADLZoHKdoHp/Sn3zUSr2Mn1uG1itCg0nuwhqAjvJDNnm837vp
         c4dAS+U6YuDCSMbzvDZ9DHBQU2jIa0U/PoysvSMqoGbQCIF21xovSeTOM3yC4oEE+lp+
         ZPabGs8UJ6Ww1szzIaBJo4f1hRu7GgQh1YQFMpea7oKZWqQ4w+SkohbPqGekGt37GHoc
         3SEQQaxbVVhSQhUVOLyZb89BiCmX6E0EdA2Kq9sv4FajNhJTvy8/1tDFCuBM+HANYAM/
         vBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=A6karn7RDcqZ2XVTeu6jeYB4sdww51xCs8ddaal2Tbc=;
        b=OeCjoHG4ra5hU3uydlb2X71uvspK1tca8qdwaWVAzHh2rF+FYnLGdOjQNu7nQS4DHE
         f+8G1eeiir8GMLiuZLWTjFIgmXzoPK107dgda8hiCbRagA3WwuVwQVF1Ur9uo9rxzkRT
         8lg2MnksyuWdQjFXC8XvaEILVGI70PSZKdmnf2P2+6kyuPw8DopfTblr98yF5K6Ala64
         lID8VKMDQDx9ddMLRD+T/J9elboJQE9GJ5IS3jo8BjeENRY8sTITCkHmwScy+O3MFNRf
         NujqWSbPYsjHlZmgRMN/imQzmttD203NTB2ZDQFemOMt0zFOhSAaB5ZpS7gW/0FhVkWZ
         sHsQ==
X-Gm-Message-State: APjAAAW36N7TjOe7PQvKR8BsQGzDJZ8v1v9YdpvWAS8sE7BEWTeTxR82
        RI9TYfHYbwWyooEZRosu2J5shxx5
X-Google-Smtp-Source: APXvYqzPK7VPAKKTNVe1s4MTZJ5oSW8sdAaM1DMLK9CIqZwBnj6phrZuTbxUl475Vvfx0bw3Jg027Q==
X-Received: by 2002:a19:5215:: with SMTP id m21mr1351826lfb.89.1567019704303;
        Wed, 28 Aug 2019 12:15:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l15sm20304ljb.92.2019.08.28.12.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 12:15:03 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various ff-related options
References: <877e6x3bjj.fsf@osv.gnss.ru>
        <20190828155131.29821-1-newren@gmail.com>
        <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
Date:   Wed, 28 Aug 2019 22:15:02 +0300
In-Reply-To: <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
        ("Martin \=\?utf-8\?Q\?\=C3\=85gren\=22's\?\= message of "Wed, 28 Aug 2019 20:45:27
 +0200")
Message-ID: <87a7btqeyx.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Martin Ågren <martin.agren@gmail.com> writes:


[...]

>> ++
>> +With --ff-only, resolve the merge as a fast-forward when possible
>> +(when the merged branch contains the current branch in its history).
>> +When not possible, refuse to merge and exit with a non-zero status.
>> ++
>> +With --no-ff, create a merge commit in all cases, even when the merge
>> +could instead resolve as a fast-forward.
>> ++
>> +With --ff, resolve the merge as a fast-forward when possible.  When not
>> +possible, create a merge commit.
>>
>> ---ff-only::
>> -       Refuse to merge and exit with a non-zero status unless the
>> -       current `HEAD` is already up to date or the merge can be
>> -       resolved as a fast-forward.
>
> I was sort of expecting these to be listed in the order "--ff, --no-ff,
> --ff-only", and I see Sergey suggested the same ordering. The way your
> proposed text reads does make sense though... Would it read as well
> turning it over and going through the options in the other order? That's
> the way it is before your patch, so you could argue "but people don't
> grok that!". What your patch does well is to offer an overview before
> describing each option in a bit more detail. Would that work with the
> reversed direction as well (compared to this patch)? Dunno.
>
> I wondered briefly whether it might make sense to float "The default is
> `--no-ff`." to the top, but since it's really "The default ... unless
> so-and-so", it would probably complicate things more than it'd help.

Dunno if it helps, but here is what I came up with somewhere in previous
discussions:

--ff::
--no-ff::
--ff-only::
	When the merge resolves as a fast-forward, only update the
	branch pointer (without creating a merge commit).  When a fast
	forward update is not possible, create a merge commit.  This is
	the default behavior, unless merging an annotated (and possibly
	signed) tag that is not stored in its natural place in
	'refs/tags/' hierarchy, in which case --no-ff is assumed.
+
With --no-ff create a merge commit even when the merge could instead
resolve as a fast-forward.
+
With --ff-only resolve the merge as a fast-forward (never create a merge
commit). When fast-forward is not possible, refuse to merge and exit
with non-zero status.

-- 
Sergey
