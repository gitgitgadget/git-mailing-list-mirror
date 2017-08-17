Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD48C20899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbdHQVWA (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:22:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37239 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHQVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:21:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id z91so7377128wrc.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FbEZcm7FEhiVlkBdmeJWUPjQrdkORl2yAHgOcaGo0WQ=;
        b=bKxbMc+vC888mkHy7DVxlDXLYeh/p24fnTotw9Sp9b6ozBhB19bpBWWks77QZSTSXV
         ITIcg6I0IdifrH7SbRL6mOLlvAqVW/w/AIpbRywijcbvB6+Pix3FPtN5ZFEFOfRJdm+E
         odv85mUL8TrA1lizRYHn8cg7gk9DP2aUVAlmc4J4NByY+e/0n31nS2HlnPZuJosn5T09
         WVJ6NA2Vz6NtsxcDmwP4oE9vYOJ2QUcFehzDWj2Duw/JuAxJeHSNsbVgFmp5TZRe/GBH
         bm5k7X8rXPu+YlL6OPodB5W8ZWKfcwFHans4fbked9o3m4xcSIQuwg7ICRmktFBTMEWZ
         LpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FbEZcm7FEhiVlkBdmeJWUPjQrdkORl2yAHgOcaGo0WQ=;
        b=ApOTcop0OG11f4wCeXpeF5fFemGnAzj8GWSwZxi27GoZ7Yi5yJwgJA8mJIcVg1KSDQ
         RrwtNaxSpq4Y/Og8IKVTGa9iAXrbEi8xJ1M7vb+LtB7qwA9TTt4pXw8J46SXk2NjwwkL
         3q2XIrJPL+jMkmdUgiEh/iOHCJPh0mIQXhgC2lA5P2hCZzstOAIVzEJRMrVzu4P1rDpO
         ALEMRJOGhu4n0141e1jotgrfY0hRZVQSfS++KqS8Uk3mXo+gooTNkwjL9Ez1Dd8wfvXh
         qYmaLqtKoU1uJTnVaWnBKolLAASxC1HM7QnpDe8QIndoBEe7DE4cQMtB1nwkdp7pP9Sz
         M3Yw==
X-Gm-Message-State: AHYfb5jQXidiqSDt2AaT+/NAQ4su6L+41XJRpPu0T79jm8DXR8/cJj9w
        fUnDSPU29wbyyNK/vnA=
X-Received: by 10.223.175.202 with SMTP id y10mr274350wrd.257.1503004918425;
        Thu, 17 Aug 2017 14:21:58 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6AA8.dip0.t-ipconnect.de. [93.219.106.168])
        by smtp.gmail.com with ESMTPSA id m77sm6803420wmd.21.2017.08.17.14.21.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 14:21:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Submodule regression in 2.14?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
Date:   Thu, 17 Aug 2017 23:21:56 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com> <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>, bmwill@google.com
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Aug 2017, at 20:51, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Wed, Aug 16, 2017 at 11:35 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>=20
>> I think we discovered a regression in Git 2.14.1 today.
>> It looks like as if "git submodule update --init --recursive" removes
>> the "skip submodules" config.
>>=20
>> Consider the following steps:
>>=20
>>    git clone https://server/repo.git
>>    cd repo
>>    git config --local submodule.some/other/repo.update none
>>    git submodule update --init --recursive
>>    git pull --recurse-submodules
>>=20
>> With Git 2.14 the last "git pull" will clone the "some/other/repo"
>> submodule. This did not happen with Git 2.13.
>>=20
>> Bug or feature? I don't have anymore time for Git today. I am happy =
to
>> provide a proper test case tomorrow, though.
>=20
> $ git log --oneline v2.13.0..v2.14.1 -- git-submodule.sh
> 532139940c add: warn when adding an embedded repository
> (I am confident this is not the suspect, let's keep searching.
> Not a lot happened in submodule land apparently)
>=20
> Looking through all commits v2.13..v2.14 doesn't have me
> suspect any of them.
>=20
> Any chance the "did not happen with 2.13" was not
> freshly cloned but tested on an existing repo? If so a hot
> candidate for suspicion is a93dcb0a56 (Merge branch
> 'bw/submodule-is-active', 2017-03-30), IMHO, just
> gut feeling, though.
>=20
> Oh, wait.
> $ git log --oneline v2.13.0..v2.14.1 -- builtin/pull.c
> c9c63ee558 Merge branch 'sb/pull-rebase-submodule'
> a6d7eb2c7a pull: optionally rebase submodules (remote submodule =
changes only)
> could also be a culprit. Do you have pull.rebase set?

I bisected the problem today and "a6d7eb2c7a pull: optionally rebase =
submodules=20
(remote submodule changes only)" is indeed the culprit.

The commit seems to break the following test case.

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index dcac364c5f..24f9729015 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1289,4 +1289,19 @@ test_expect_success 'init properly sets the =
config' '
 	test_must_fail git -C multisuper_clone config --get =
submodule.sub1.active
 '
=20
+test_expect_success 'submodule update and git pull with disabled =
submodule' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	pwd=3D$(pwd) &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git config --local submodule.sub0.update none &&
+		git submodule update --init --recursive &&
+		git pull --recurse-submodules &&
+		git submodule status | cut -c 1,43- >actual
+	) &&
+	ls &&
+	test_cmp expect multisuper_clone/actual
+'
+
 test_done


I am not familiar with the code. Does anyone see the problem
right away?

Thanks,
Lars


