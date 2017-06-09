Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0846A1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbdFIQSh (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:18:37 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32860 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdFIQSh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:18:37 -0400
Received: by mail-io0-f194.google.com with SMTP id j200so1532786ioe.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KunZtrA2w8jD+Wnl5p4KPtOjDh/S56C5a1PWXPSxHbA=;
        b=CxezK/qd39itJC20clE3E58v7NXKC4jqhkoOu4YB8Nlflu+Hj68bnPFWRmm6EsHMiG
         pF9jVe2sVSRn81EkvgEEyYlCK8daMq5IJxw5+QT5WTuGpJcLDzCyVS9ytldY6VxPeyFl
         OP1sTUAy972t8a2bv/qrV+Yl11Rl89oCRDejLAqRgjF/q++Yhq+AlZOxIcsjM+khUY4u
         SdA61bcMDbZWC67biTGzXioTzcsueTo7p7L0jfdB8HQdHt0u/a62wnC87XQCs2ePpinU
         T/miTYfl2UvHSLcaVdcWOQFp3Bx77GOJjjL7rrwW5g/EaNLe5i1WZ8DftkfwPPlsYFIH
         903A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KunZtrA2w8jD+Wnl5p4KPtOjDh/S56C5a1PWXPSxHbA=;
        b=XOxOisGQOnFP4if9OSXUWTx8ImdKNUgcC+F2biE07+8NhfE9BZPGcjYY6VE5bNpmbG
         y2kzg8ECnxxs12cQvjnb9Sh8d3Vwyg7+Jtjrcuy00TJH2ns8t8k9f5LN4rvV3SUQTKkg
         PLlS3yaMaQM94DTEIrqMVv1Jf7keAX+ScVCkyIMcHCzAQIMgjvzpDC5mz/z5Pk6/swix
         76LkFvxpDhqlx+s6OTmy7DqYv2tTIGsz0pDQIh2agO5qRrpqQmGLUlUGUF1WvIKqEErd
         R+8vV4tqi+pk4mDErjs8G5yH7px3IFMmfwE4Cq8ITgPYjFlnDEuwYhPTvqg7LLjXibhQ
         wWPQ==
X-Gm-Message-State: AODbwcCaPVe1WNqMzyIJ9YOA5ibcNQayFvYZGfysjmxNvkWodEZrd77S
        4pu53oDzop7PEtX9TSLv/dgbVCwqIg==
X-Received: by 10.107.201.213 with SMTP id z204mr21994781iof.160.1497025116108;
 Fri, 09 Jun 2017 09:18:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Fri, 9 Jun 2017 09:18:13 -0700 (PDT)
In-Reply-To: <20170609142151.94811-1-larsxschneider@gmail.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 9 Jun 2017 18:18:13 +0200
Message-ID: <CACBZZX7O9DgLGOHKhojZRi7n=j3X0W9B_sRGLi6cBpc74GLyeg@mail.gmail.com>
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 9, 2017 at 4:21 PM, Lars Schneider <larsxschneider@gmail.com> w=
rote:
> Many open source projects use github.com for their contribution process.
> Although we mirror the Git core repository to github.com [1] we do not
> use any other github.com service. This is unknown/unexpected to a
> number of (potential) contributors and consequently they create Pull
> Requests against our mirror with their contributions. These Pull
> Requests become stall [2]. This is frustrating to them as they think we
> ignore them and it is also unsatisfactory for us as we miss potential
> code improvements and/or new contributors.
>
> GitHub offers a way to notify Pull Request contributors about the
> contribution guidelines for a project [3]. Let's make use of this!
>
> [1] https://github.com/git/git
> [2] https://github.com/git/git/pulls
> [3] https://help.github.com/articles/creating-a-pull-request-template-for=
-your-repository/

It would be good to have some instructions, but instead of warning
people off we could just point them to submitgit.herokuapp.com

You can submit patches to this list using that, and if someone's
trying to submit a pull request they might be much happier using that.

E.g. here's one I made recently https://github.com/git/git/pull/362
and the resulting patch on the ML:
https://public-inbox.org/git/0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb93=
58ee966-000000@eu-west-1.amazonses.com/

>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> Hi,
>
> I am perfectly aware that adding a ".github" directory in the Git core
> tree is ugly. However, I believe the benefits ("well informed new
> contributors") outweigh the injury.
>
> You can see how a github.com Pull Request creation window would like here=
:
> https://github.com/larsxschneider/git/compare/master...larsxschneider-pat=
ch-1?quick_pull=3D1
>
> I added a link that jumps to a part my GitMerge 2017 talk which explains
> Git core contributions from my point view. Although I tried my best, the
> presentation is not perfect and might not reflect the view of the Git
> community. I wouldn't have a problem at all with removing the link.
>
> I also did not break the lines in the .github/*.md files as I thought it
> renders nicer on the github.com web interface. I am happy to change that,
> too, though.
>
> Cheers,
> Lars
>
>
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/larsxschneider/git/commit/d859be5016
>     Checkout: git fetch https://github.com/larsxschneider/git contrib-gui=
de-v1 && git checkout d859be5016
>
>  .github/CONTRIBUTING.md          | 10 ++++++++++
>  .github/PULL_REQUEST_TEMPLATE.md |  3 +++
>  2 files changed, 13 insertions(+)
>  create mode 100644 .github/CONTRIBUTING.md
>  create mode 100644 .github/PULL_REQUEST_TEMPLATE.md
>
> diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
> new file mode 100644
> index 0000000000..8d01be6a71
> --- /dev/null
> +++ b/.github/CONTRIBUTING.md
> @@ -0,0 +1,10 @@
> +## Contributing to Git
> +
> +Thanks for taking the time to contribute to Git! Please be advised, that=
 the Git community does not use github.com for their contributions. Instead=
, we use a [mailing list](http://public-inbox.org/git/) for code submission=
s, code reviews, and bug reports.
> +
> +Please [read the maintainer notes](http://repo.or.cz/w/git.git?a=3Dblob_=
plain;f=3DMaintNotes;hb=3Dtodo) to learn how the Git
> +project is managed, and how you can work with it. In addition, we highly=
 recommend you to [read our submission guidelines](../Documentation/Submitt=
ingPatches).
> +
> +If you prefer video, then [this talk](https://www.youtube.com/watch?v=3D=
Q7i_qQW__q4&feature=3Dyoutu.be&t=3D6m4s) might be useful to you as the pres=
enter walks you through the contribution process by example.
> +
> +Your Git community
> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMP=
LATE.md
> new file mode 100644
> index 0000000000..c737a64620
> --- /dev/null
> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> @@ -0,0 +1,3 @@
> +Thanks for taking the time to contribute to Git! Please be advised, that=
 the Git community does not use github.com for their contributions. Instead=
, we use a mailing list for code submissions, code reviews, and bug reports=
.
> +
> +Please read the "guidelines for contributing" linked above!
>
> base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
> --
> 2.13.0
>
