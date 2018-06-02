Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F311F491
	for <e@80x24.org>; Sat,  2 Jun 2018 09:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbeFBJnt (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 05:43:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54126 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750881AbeFBJns (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Jun 2018 05:43:48 -0400
X-AuditID: 1207440c-bffff70000000b63-4a-5b1266d34b7c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A8.B8.02915.3D6621B5; Sat,  2 Jun 2018 05:43:47 -0400 (EDT)
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com [209.85.215.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w529hj5P014646
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sat, 2 Jun 2018 05:43:46 -0400
Received: by mail-lf0-f47.google.com with SMTP id n15-v6so928869lfn.10
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 02:43:46 -0700 (PDT)
X-Gm-Message-State: ALKqPwd1l9TvKPsY8vegZmXJkR1KFsCliE4keNq12EtS+IkhG3TuLyf7
        fJeHbI4gusHnobnZkpgpCxbeWnJDp7nYuOMSVN4=
X-Google-Smtp-Source: ADUXVKJhyOJZcVUGOC/VRJe1jKvO3SiwLLNx/224a563jRDkKwqHxNEJh225CtnA0LLKRX9l0VWl73SKV3k33uyqQPg=
X-Received: by 2002:a19:6348:: with SMTP id x69-v6mr8948596lfb.104.1527932625340;
 Sat, 02 Jun 2018 02:43:45 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 2002:a2e:9ec3:0:0:0:0:0 with HTTP; Sat, 2 Jun 2018 02:43:44 -0700 (PDT)
In-Reply-To: <20180601050833.27676-1-chriscool@tuxfamily.org>
References: <20180601050833.27676-1-chriscool@tuxfamily.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Sat, 2 Jun 2018 11:43:44 +0200
X-Gmail-Original-Message-ID: <CAMy9T_Edbrd-90=Zrp_3bSyuT8GhEu9228_iiaGzwLwAVDn40w@mail.gmail.com>
Message-ID: <CAMy9T_Edbrd-90=Zrp_3bSyuT8GhEu9228_iiaGzwLwAVDn40w@mail.gmail.com>
Subject: Re: [PATCH] t9104: kosherly remove remote refs
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqHs5TSja4OdEZYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGXMufGEteAad8XStSINjOs5uxg5OSQETCTur57DCGILCexgkuib
        U9rFyAVkP2SSOH3gITuEM4FR4uzbXhaIjnKJqZ2zWSHsIonetbPYIexKif3fd7CB2LwCghIn
        Zz5hgZgqJ/Fqww2oDSESx088A6vnFLCVuL12B1SNjcTXp5+YQWw2AV2JRT3NTCA2i4CKxM9v
        T4B6OYDmJ0r0zFKFGB8gcWvCS7ASYQFziR3nP4GdIyJgKDHn9xKwm5kFVrFKLH1yA2w+s4Cm
        ROv23+wTGEVmITlvFpLUAkamVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxgh
        oc2zg/HbOplDjAIcjEo8vAHOgtFCrIllxZW5hxglOZiURHmfVQGF+JLyUyozEosz4otKc1KL
        DzFKcDArifCGewLleFMSK6tSi/JhUtIcLErivKwme6OEBNITS1KzU1MLUotgsjIcHEoSvLyp
        QtFCgkWp6akVaZk5JQhpJg5OkOE8QMO9QGp4iwsSc4sz0yHypxiNOZY87e5h5liwZVIPsxBL
        Xn5eqpQ4bzhIqQBIaUZpHtw0WHp6xSgO9Jww73SQKh5gaoOb9wpoFRPQqteyAiCrShIRUlIN
        jPXtSQo+uYxstRF1kVf/TF7b1STkuGaDmejGcNXoU9rJTX/0JCqzfR4e16/gP3pK/2DWbwuG
        fdv3e9rNYfN0yth4IIVP7mj9ks3HRT5sYGUL4X4b+XD/rZxbDqsuLevqVZDL2uZseMFu8p9l
        vHctpyzY7Nh1cgq3oO3M1/LXF3+y9Zy8ItZythJLcUaioRZzUXEiAC9eyC4qAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 7:08 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> As there are plans to implement other ref storage systems,
> let's use a way to remove remote refs that does not depend
> on refs being files.
>
> This makes it clear to readers that this test does not
> depend on which ref backend is used.
>
> Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> This was suggested and discussed in:
>
> https://public-inbox.org/git/20180525085906.GA2948@sigill.intra.peff.net/
>
>  t/t9104-git-svn-follow-parent.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
> index 9c49b6c1fe..5e0ad19177 100755
> --- a/t/t9104-git-svn-follow-parent.sh
> +++ b/t/t9104-git-svn-follow-parent.sh
> @@ -215,7 +215,9 @@ test_expect_success "multi-fetch continues to work" "
>         "
>
>  test_expect_success "multi-fetch works off a 'clean' repository" '
> -       rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
> +       rm -rf "$GIT_DIR/svn" &&
> +       git for-each-ref --format="option no-deref%0adelete %(refname)" refs/remotes |
> +       git update-ref --stdin &&
>         git reflog expire --all --expire=all &&
>         mkdir "$GIT_DIR/svn" &&
>         git svn multi-fetch
> --
> 2.17.0.1035.g12039e008f

+1 LGTM.

Michael
