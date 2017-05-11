Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D5F1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbdEKJ7a (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:59:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35692 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755398AbdEKJ71 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:59:27 -0400
Received: by mail-it0-f67.google.com with SMTP id 67so2645705itx.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jZmy2kbwX4OdXpunYCrWvYXMp6elwIFS7KpC2RdtQ3s=;
        b=ZvFwhfyQn0Wb2Zmz4Srj7BHU+cfnY01XKl+1u27h3pdHIUxir9883zuffn6H2qORts
         1cTu7lTx4hF8O0Y1Jg2qaEEk1VoyVaXVLr/JxP0+FhuN+GrbQx0M8yNosXQ/8LSoGld9
         s8nAVmwTN0/cxoyYX1u0AT8pL1WrwuRfWLIrunlDBKg83riXlrSjhDS/u47QH3Jy7ja5
         qay3RRlUEAR62zdMbXm2eap8K45C8Ag0n8r00cdcLct05MPTKFi4MhSB8I6MLJH8LyyV
         7tj3Nc3ktPti2uaFbQCn3v8B24pli7PVueHVtmKLGOrA1vbCDuEDzpJBeQLl6StcfIaT
         IrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jZmy2kbwX4OdXpunYCrWvYXMp6elwIFS7KpC2RdtQ3s=;
        b=Fgwrcw+tRA+DIU0Rf8qNu+VXbrzNOUBLPJDKWiEuiKP2LzKjCir/1TRItCGAsQ1YhU
         n4sluKPehO4y8k6bdoPlpsWhag2Yy+EKotlYrCvyQUQR3eb4luFl7sWsqh+2aBAo4yX3
         saUh4o4lsqJ0z4ncDP9m328eVFT8R3anLjXgi6QEYMVV6UQFpUTR+VFnpJuEy5wi6i3b
         RNuUdjgEHIpM0byUhBo8VG/s3+vj857FBrEul10PWaFHpbZOikFiAekEkTyYiQ0kWhHS
         iDxSO/DtI261w6xDQo9MoLbNin9H4CEFetSDTSyT5s22ECABk0+RuhKljQ8qOp+XFBue
         37Bw==
X-Gm-Message-State: AODbwcC7OAHcfK6T0iA7v79pHmiwrT1nwOlkUr/7achwEXKRglNziZ1V
        2AZoLAk5miuWePfFakUmZV4nlFQ3CQ==
X-Received: by 10.36.89.207 with SMTP id p198mr5344008itb.71.1494496761849;
 Thu, 11 May 2017 02:59:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 02:59:01 -0700 (PDT)
In-Reply-To: <xmqq8tm3afaa.fsf@gitster.mtv.corp.google.com>
References: <20170510225316.31680-1-avarab@gmail.com> <20170510225316.31680-2-avarab@gmail.com>
 <20170510233032.GD28740@aiede.svl.corp.google.com> <CACBZZX50-0uzMyYJo5Z92nRH0m-Q70=P4Wr-LwBqH71nXdsmcA@mail.gmail.com>
 <xmqq8tm3afaa.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 11:59:01 +0200
Message-ID: <CACBZZX5gXWLb4oePjC+aCRQ5HsVD8-M9Ao6akgvEKf1+gx-79A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf: add function to setup a fresh test repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, May 11, 2017 at 1:30 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>>> Hi,
>>>
>>> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>>>
>>> [...]
>>>>  # call at least one of these to establish an appropriately-sized repo=
sitory
>>>> +test_perf_fresh_repo () {
>>>> +     repo=3D"${1:-$TRASH_DIRECTORY}"
>>>> +     "$MODERN_GIT" init -q "$repo" &&
>>>> +     cd "$repo" &&
>>>> +     test_perf_do_repo_symlink_config_
>>>> +}
>>>
>>> Unlike the other two variants, wouldn't this leave the cwd inside the
>>> new repo?
>>>
>>> In other words, I wonder if the commands starting with the 'cd' should
>>> be in a subshell.
>>>
>>> Thanks and hope that helps,
>>
>> Yup, I'll fix that. Thanks for the review & also on the other patch.
>> Will send a v3 with these issues fixed.
>
> Hmph, does v3 actually have this change?

Nope, sent v4 to fix it, sorry:
https://public-inbox.org/git/20170511094108.8756-1-avarab@gmail.com/
