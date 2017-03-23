Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4480E20964
	for <e@80x24.org>; Thu, 23 Mar 2017 22:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964913AbdCWWNu (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 18:13:50 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35791 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934371AbdCWWNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 18:13:49 -0400
Received: by mail-io0-f176.google.com with SMTP id z13so6606614iof.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GPb6IcivaEAmUKGvCbQC/Q/fYlJ+cc0yQWNEPBJEz7Y=;
        b=fjV+Y/HZB48L1pj/kwNTijcf3BygkR0EalbpGDwBsunfem7OX4xBfoS/gKVDUR74Q5
         GFiHw+uNQ6fF8LDM0bvUni8MepuwI2CClFEe8k568qlUmqSfHE2+o1cyhc0qifqzxLeo
         fycumbcdijGgkO7FclvT65u/CLLMF+8dM0pId1juvXlm0/5fTa6eQyxJr4xqFNaIXvrk
         UvAsR4HNb52UdGouzuRStVM1NetyU6bNC9X4bl2da05kX78c7PhpnlZqgqLroFqzZwoc
         EmMdney/DcAnZYAXvgJ/6c8AN23CugnTzuqkwpNmXKIlsJy6NSoGMVoN7xsU6merNS9+
         3bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GPb6IcivaEAmUKGvCbQC/Q/fYlJ+cc0yQWNEPBJEz7Y=;
        b=ZttH0f+Hv+kR4udx2yh1I7ILlDxQWibgRM2aQRLR2tyCX1lRDeV6IjxPvsPl+H6mJ3
         KE51LZ8tpTTkwhJRoWpvWZkE0Q8sldz39AhG6+TWCI/5ZY/5I/r2xAHdwid3bUAptRyU
         x5Nne27sdvk3dYnOp8O8cpAPUaWeMg9FoQSQ4iIsfLLuqPqd2/jSHi+aSJDDzW9zvPiQ
         CV88Bh9HKZNd7q6WMUxh5u4R9EmYWEqdxZ4HCyapUEwpUqQkOKJcdILBlJB9WzNNqWw3
         7U+f+SJsRrh0mSkI+AdtE6Aml89E1XpdqFiJr+tfDThygrQfN2HfYVvrBDlfDwrpoVDb
         H1Yg==
X-Gm-Message-State: AFeK/H1hz6UVaTfSg2lCauN96qd8MUsr47q/VFZE8vDV2tppRAna5i9hG62lD+x8FRANGUyf/BV6joCgllsRlA==
X-Received: by 10.107.32.199 with SMTP id g190mr5589570iog.117.1490307227928;
 Thu, 23 Mar 2017 15:13:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 23 Mar 2017 15:13:27 -0700 (PDT)
In-Reply-To: <xmqqtw6jad58.fsf@gitster.mtv.corp.google.com>
References: <20170323130529.11361-1-avarab@gmail.com> <20170323130529.11361-10-avarab@gmail.com>
 <xmqqtw6jex0o.fsf@gitster.mtv.corp.google.com> <CACBZZX5wFaSdeXGxGNMK4j_OoEJ_Zt08vAYRosSwnJVs9K+Lng@mail.gmail.com>
 <xmqqtw6jad58.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Mar 2017 23:13:27 +0100
Message-ID: <CACBZZX4q3Z1CJMb0PAbjRz7eAdp20MWpNf=w_nCPo=+644uMhg@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] tag: add more incompatibles mode tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Mar 23, 2017 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> Amend the test suite to test for more invalid uses like "-l -a"
>>>> etc. This change tests this code path in builtin/tag.c:
>>>>
>>>>     `(argc =3D=3D 0 && !cmdmode)`
>>>>     ->
>>>>     `((create_tag_object || force) && (cmdmode !=3D 0))`
>>>
>>> What is this notation trying to tell us?  A range of lines starting
>>> with the first one to the second one?
>>
>> Yeah.
>
> The reason why I asked about the original notation was because it
> looked as if you are saying "the former is changed to the latter,
> and this is to make sure it does not regress".
>
> Compared to that, spelling out why in a readable sentence would be
> much more helpful for later readers of the log output, no matter
> what they want to do with the information.

Ah, I see. Will reword as "between lines .. and ...". I think it's
worth showing the actual code it's trying to test since it's short
enough, and anyone digging into these tests would want to know what
part of the code the tests were trying to test.
