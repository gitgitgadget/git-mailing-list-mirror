Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766D21F453
	for <e@80x24.org>; Fri, 28 Sep 2018 03:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI1JvT (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 05:51:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45784 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1JvS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 05:51:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so3276281pfi.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 20:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RG7WWUTyPcGYJoCX3+hFWBNulALmcaLtS1edXaVknDs=;
        b=fuRQTW1GAFOm56OLZcQl/YDC07xeUqRqJtAMfer3yKlcoVK/ffkeBFVQ52KEDHiOY4
         LG1dW2feY2rz38piw519ZjyTJX/pJ6uWE9Ea4WsVdddY2yJCiLSphDqvmz8jf8jjUmCt
         bQy81U7nnF/6KfUBQH/0J5/hpMXrQzqJdoc8B23dHz61GBtuDztRZsXW3kJjkE0uf2Bs
         4hbaYDIeQAce6Jo5AWJEon9/mDJQ3N1yRIa9fW+JR0FdCuwZBHkac4oKpO9me9+3680p
         M0kuFdcqdM+HbQaidgCiizYORj1QZNkEdbYH14ieNd2uJ5wUhUCVf/rmLSbTuzFReTBX
         UMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RG7WWUTyPcGYJoCX3+hFWBNulALmcaLtS1edXaVknDs=;
        b=rQrmQwILGMZhLpITR01pQvucW4IP/VwfXZSS0AzRRKhLDsXCweir4HwHs8H9qS6Asc
         9QU3rGyEoLTswrS2U4G+spzlpX9OoJS7Rdqr8aPp4I570ahi+wkD/vDrqKw9+fJoEZId
         kqGs/qVFQ40WedJ1ogVt5HwS780K5BkJbOTMBfXCBDPCfMEgUECEhA8lxy/jBGY12uGy
         DkQtCh02KYDa+zxvGASEsVqJPNAgkOcL34kNeIJNHVroKcuj/knmUAy7oWrtQtRtqQbr
         oCY/+bWJI51vsLA15v6DUP0IlvgLf5P36O/hNSZzmMuaUx/8B8jRxxBQYgC3IzORjcAf
         wKUQ==
X-Gm-Message-State: ABuFfohUK7+KmfPxmw4rCbX+H42tXr/YBJIGIRGwa+KL0adVs3PqZpdO
        Q67eG7Vx4JepdDIbpLpLNI8=
X-Google-Smtp-Source: ACcGV62BCcshj4VQ9dZLvwv7TFu5zjaAmPEeYEk3uFcA4HnUkuIWC1KOJ9J5g2Qj/oNApseiax8xIQ==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34-v6mr14050713pld.244.1538105383087;
        Thu, 27 Sep 2018 20:29:43 -0700 (PDT)
Received: from [192.168.1.21] (c-67-161-125-133.hsd1.wa.comcast.net. [67.161.125.133])
        by smtp.gmail.com with ESMTPSA id y86-v6sm5895409pfk.84.2018.09.27.20.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 20:29:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] submodule: Alllow staged changes for
 get_superproject_working_tree
From:   Sam McKelvie <sammck@gmail.com>
In-Reply-To: <xmqqmus2e6rp.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 27 Sep 2018 20:29:40 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <37DC7525-209F-49CC-90AA-D55463456D20@gmail.com>
References: <20180927181054.25802-1-sammck@gmail.com>
 <xmqqbm8ifvka.fsf@gitster-ct.c.googlers.com>
 <D09E2583-BD1D-4C56-9C19-6B1E97CEEDAA@gmail.com>
 <xmqqmus2e6rp.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sep 27, 2018, at 6:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Sam McKelvie <sammck@gmail.com> writes:
>=20
>>>> Subject: Re: [PATCH] submodule: Alllow staged changes for =
get_superproject_working_tree
>>>=20
>>> s/Alllow/allow/;
>>>=20
>>=20
>> Ok, no caps on first letter of subject.
>=20
> Ah, that, too.  I meant to correct triple ell, though ;-)
>=20
> When one reviewer says Reviewed-by: but you later found that the
> patch was not good enough to deserve a redoing, feel free to redo
> the patch and do not add the Reviewed-by: you got for the old one
> to your second submission.  The difference between the one that was
> reviewed and the one you updated invalidates the stale Reviewed-by:,
> essentially.
>=20
> Some reviewers explicitly state "With this and that nit corrected or
> left as-is, the patch is Reviewed-by: me" to tell you that as long
> as the difference between the version reviewed and the updated one
> is limited within the named issues, you can add Reviewed-by: to your
> rerolled patch.
>=20
> In this case, I think the nits are pretty small and I do not mind
> tweaking the version we are discussing on my end, without having you
> to send an updated one.
>=20
> Here is what I'd squash into your commit, with title corrected, if
> you are OK with that plan.  In the meantime, I'll keep the following
> as a separate patch on top when I merge your fix to 'pu'.
>=20
> Thanks.

I wholeheartedly approve of that plan and your tweaking commit below. =
Thank you, Junio.

~Sam

>=20
> t/t1500-rev-parse.sh | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index b774cafc5d..01abee533d 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -134,6 +134,7 @@ test_expect_success 'rev-parse =
--is-shallow-repository in non-shallow repo' '
> test_expect_success 'showing the superproject correctly' '
> 	git rev-parse --show-superproject-working-tree >out &&
> 	test_must_be_empty out &&
> +
> 	test_create_repo super &&
> 	test_commit -C super test_commit &&
> 	test_create_repo sub &&
> @@ -142,20 +143,20 @@ test_expect_success 'showing the superproject =
correctly' '
> 	echo $(pwd)/super >expect  &&
> 	git -C super/dir/sub rev-parse --show-superproject-working-tree =
>out &&
> 	test_cmp expect out &&
> +
> 	test_commit -C super submodule_add &&
> 	git -C super checkout -b branch1 &&
> 	git -C super/dir/sub checkout -b branch1 &&
> 	test_commit -C super/dir/sub branch1_commit &&
> 	git -C super add dir/sub &&
> 	test_commit -C super branch1_commit &&
> -	git -C super checkout master &&
> -	git -C super checkout -b branch2 &&
> -	git -C super/dir/sub checkout master &&
> -	git -C super/dir/sub checkout -b branch2 &&
> +	git -C super checkout -b branch2 master &&
> +	git -C super/dir/sub checkout -b branch2 master &&
> 	test_commit -C super/dir/sub branch2_commit &&
> 	git -C super add dir/sub &&
> 	test_commit -C super branch2_commit &&
> 	test_must_fail git -C super merge branch1 &&
> +
> 	git -C super/dir/sub rev-parse --show-superproject-working-tree =
>out &&
> 	test_cmp expect out
> '

