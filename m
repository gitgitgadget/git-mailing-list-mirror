Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C506320988
	for <e@80x24.org>; Sun, 16 Oct 2016 00:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbcJPAPf (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 20:15:35 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34990 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbcJPAPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 20:15:34 -0400
Received: by mail-pa0-f67.google.com with SMTP id qn10so7658065pac.2
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 17:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kN5nRnVp2FdOhe44nzQJvHUCAqjVoVYx5vDWm9sTjh0=;
        b=tfRVPqeCKPOwPjwZDidwRm/EvGuOmFt6BDNLxnjrT65QeKQDsQnI9bHR+4gGkCQZti
         XsdvyaSpCevKFeOhVbiJVMJi0GJDtkv+VFzICzXn7yjXZPZIzUjU91YeLw2k65n4mdJ/
         ODdswjItSTPpMJryz3kjPJACI6pAJcb6zTMISDZS1V+yESebOnuVBHIdQmsLCKFMPpAq
         AB1deiZPuP4LWV/V9qRQ/ZgxVhtq/TGwE9Jez61viHeJbDt5w6PArSg6pLbokzJfu2Js
         d56vfea+ACUev8noKJqDbgJdnV/BAtNK9lp3J6wwepjR1VkT3vQE0XlDPp7AuDbLVXGj
         6PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kN5nRnVp2FdOhe44nzQJvHUCAqjVoVYx5vDWm9sTjh0=;
        b=VzRfhIiSllWHrlKELS8/JGueKh90LWK/gHfahSvYmDkPFY8bx3OHw6B6qthGWHNyM5
         ItIz9hpzB8GNCtjB+QmpBNErwRD65Yw5/LLwbslIAqvpdxynelQEXCvRBtTJozm4iiH8
         MBbNfvvrv+8Jw0N8/J7uC5vHROIYpvzlrl2yhIcWF7eTqIjX7ArmWRtiEeyzUUJOZZvE
         9aa0D/rOAYcbZvQlGP6cB9rz3uf24Z9uh0rwqj0tYHbVCdt4RFFFk8Q2Oqg6IyiukB+J
         qGwGYInLc3keizG55NG5O80/jax3/xA9XCfU6d16tizwxoxl/UBZlakf9Tu2JcWaG4Tf
         czTg==
X-Gm-Message-State: AA6/9RkpTU3GGIDErHm4ySs2194fqbxt+99Bs+PcECVCdyPAjhQ3RwHNMwOBwOeNePGbhg==
X-Received: by 10.66.11.104 with SMTP id p8mr23548358pab.202.1476576933541;
        Sat, 15 Oct 2016 17:15:33 -0700 (PDT)
Received: from mtl3z26wz1.ads.autodesk.com (adsk-nat-ip11.autodesk.com. [132.188.71.11])
        by smtp.gmail.com with ESMTPSA id t29sm37416153pfj.95.2016.10.15.17.15.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Oct 2016 17:15:32 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] convert: mark a file-local symbol static
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
Date:   Sat, 15 Oct 2016 17:15:31 -0700
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com> <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com> <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Oct 2016, at 14:01, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>=20
>=20
>=20
> On 15/10/16 16:05, Lars Schneider wrote:
>>> On 11 Oct 2016, at 16:46, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
> [snip]
>>> -void stop_multi_file_filter(struct child_process *process)
>>> +static void stop_multi_file_filter(struct child_process *process)
>>=20
>> Done! Do you have some kind of script to detect these things
>> automatically or do you read the code that carefully?
>=20
> Heh, I'm _far_ too lazy to read the code that carefully. :-D
>=20
> A combination of 'make sparse' and a perl script (originally
> posted to the list by Junio) find all of these for me.

Interesting. Do you have a link to this script?
Does it generate false positives?=20
Maybe I can add `make sparse` to the TravisCI build?

Cheers,
Lars=
