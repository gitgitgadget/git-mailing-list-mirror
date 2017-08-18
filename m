Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA196208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 13:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdHRNMh (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 09:12:37 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34932 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdHRNMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 09:12:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id p8so7539623wrf.2
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8wxIDpzU0jOIUAoBXrdoCvb1ASbOOBm7hDNqiTgB1aQ=;
        b=HCugKHfVuYWotVyxqypf9Eoy4X4z43jIJreq/4xOFcbILOCY9t5mKjaGFINIhdq+Ti
         Gndhn2v2ew8YJzuKrRhvgEssulv4J2ryQlN32z5bKvu/RtxVnpAdydL6gLf6vkZPHDiP
         apPH3W7r2JKJB2sCMdJkSKfZlvgtF16X7PKSvvKSoGT1x0oPlCn8UlfZNfrOE/KqtI55
         WfWDqNqRKKhAK3dfMikruaPUC9f+qce0QtFHzSK2oplvNsY+apV3qyoCoq2+tt5TAXU3
         5+xIAYIhWYKISONaNNIusZWo2ZAKYFlSwSml+RSfzRRTycm/haKa7PbeASgJjADdU8Hu
         A/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8wxIDpzU0jOIUAoBXrdoCvb1ASbOOBm7hDNqiTgB1aQ=;
        b=A+cQgjRPw4Po9PPtE09o16o+2V1MCnC2RlDxiBsUCc9ronyBPYVGjPZZPvRx7LcRfW
         IuEYrI9rutBF6X0T52qhcpkimKJ5aI+VZQ7AN+rTBeXML42VMoN4n5Uyo/NFlM0JDUMV
         shTZF1BjAwDZC9w55UQdOoC7EFccY0BB2O6AdqTSyo1Cu7ECQqB3yKaQOO+75Y44StQa
         xJdSPkdvYNFb+0R61npu514SyWiZG8GEEhs+ZKYdNky4lONqFe8ywlUwb6J4/lk8UVff
         X8Hj05wC3jN7BRLTWbX1J64zYLtb5tsTWpf6HXjDYWhgnXeOpKrBMSCgf3lqPNTjPqdB
         fSwQ==
X-Gm-Message-State: AHYfb5gtTkchp+YZmIBIcjb/hw0U4yWzGpkKDefUahXLtgH18BX0qXD2
        bG8AaHUVE/hNmYPim2k=
X-Received: by 10.223.182.152 with SMTP id j24mr3098073wre.43.1503061953503;
        Fri, 18 Aug 2017 06:12:33 -0700 (PDT)
Received: from remr90mpm73.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 134sm1538333wmw.24.2017.08.18.06.12.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 06:12:32 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Submodule regression in 2.14?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
Date:   Fri, 18 Aug 2017 15:12:30 +0200
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D784E926-9FC7-4508-9632-225138679CDF@gmail.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com> <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com> <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Aug 2017, at 23:55, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Thu, Aug 17, 2017 at 2:21 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> Oh, wait.
>>> $ git log --oneline v2.13.0..v2.14.1 -- builtin/pull.c
>>> c9c63ee558 Merge branch 'sb/pull-rebase-submodule'
>>> a6d7eb2c7a pull: optionally rebase submodules (remote submodule =
changes only)
>>> could also be a culprit. Do you have pull.rebase set?
>>=20
>> I bisected the problem today and "a6d7eb2c7a pull: optionally rebase =
submodules
>> (remote submodule changes only)" is indeed the culprit.
>>=20
>> The commit seems to break the following test case.
>>=20
>> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
>> index dcac364c5f..24f9729015 100755
>> --- a/t/t7400-submodule-basic.sh
>> +++ b/t/t7400-submodule-basic.sh
>> @@ -1289,4 +1289,19 @@ test_expect_success 'init properly sets the =
config' '
>>        test_must_fail git -C multisuper_clone config --get =
submodule.sub1.active
>> '
>>=20
>> +test_expect_success 'submodule update and git pull with disabled =
submodule' '
>> +       test_when_finished "rm -rf multisuper_clone" &&
>> +       pwd=3D$(pwd) &&
>> +       git clone file://"$pwd"/multisuper multisuper_clone &&
>> +       (
>> +               cd multisuper_clone &&
>> +               git config --local submodule.sub0.update none &&
>> +               git submodule update --init --recursive &&
>> +               git pull --recurse-submodules &&
>> +               git submodule status | cut -c 1,43- >actual
>> +       ) &&
>> +       ls &&
>> +       test_cmp expect multisuper_clone/actual
>> +'
>=20
> Thanks for providing this test.
>=20
> cd trash directory.t7400-submodule-basic/multisuper_clone
> cat .git/config
> [submodule "sub0"]
>  update =3D none
>  active =3D true
>  url =3D file:///.../t/trash directory.t7400-submodule-basic/sub1
>=20
>=20
> submodule.<name>.update
>    The default update procedure for a submodule.
>    This variable is populated by git submodule init
>    from the gitmodules(5) file. See description of
>    update command in git-submodule(1).
>=20
> The first sentence of .update is misleading IMHO as the
> these settings should strictly apply to the "submodule update"
> command. So "pull --recurse-submodules" ought to ignore it,
> instead the pull can do whatever it wants, namely treat the
> submodule roughly like a tree and either merge/rebase
> inside the submodule as well. The user *asked* for recursive
> pull after all.
>=20
> Are you saying this might be a design mistake and
> the .update ought to be respected by all the other
> commands? For example
>    git reset --recurse-submodules
> should ignore the .update=3D none?
>=20
> When designing these new recursive submodule functionality
> outside the "submodule" command, I'd want submodules
> to behave as much as possible like trees.

In the past "submodule.<name>.update=3Dnone" was an easy way
to selectively disable certain Submodules.

How would I do this with Git 2.14?

My gut feeling is that all commands should respect the
"submodule.<name>.update=3Dnone" setting.

- Lars=
