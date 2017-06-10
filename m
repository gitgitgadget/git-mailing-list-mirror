Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C7F1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 12:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdFJMsz (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 08:48:55 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:5907 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdFJMsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 08:48:53 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id Jfowd2KylHGLwJfowdMV1z; Sat, 10 Jun 2017 13:48:51 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=NEAV23lmAAAA:8 a=8nJEP1OIZ-IA:10
 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=VwQbUJbxAAAA:8 a=-AnQz9JOAAAA:8
 a=8HJBe0yQAAAA:20 a=z6WkSEa86NyGc9HzAAAA:9 a=aVt2s2O6pSMvfWxN:21
 a=Lut-y9zJrws4RfMX:21 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=PwKx63F5tFurRwaNxrlG:22 a=AjGcO6oz07-iQ99wixmX:22 a=3bnadFWGKyIZm4bBUiDd:22
Message-ID: <31A456B20D984421AA958A39B2FCD29D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Lars Schneider" <larsxschneider@gmail.com>, <git@vger.kernel.org>
Cc:     <gitster@pobox.com>, <peff@peff.net>
References: <20170609142151.94811-1-larsxschneider@gmail.com>
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
Date:   Sat, 10 Jun 2017 13:48:50 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170609-4, 09/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBCK4G7z1ONzH4O3o/7f/iF/mkPd738uXIgZsyXTsjikLkn9ck6BKi2gz+RhiG7XXwWCLP9yyUJ/3yql/nbaWA3V9qieU6a06ikkMtUT5MQYhhZUTzwk
 jrRPAzSNAQE9e02tuzIUvTwyhyU/F3Q7NhuImRx7Od5Im7aOAxbeOiY79DY6WFsrutlAjPa2iFZ+qcw/5DgfK8EIZnlSWx/JoQdaEITxJTdOJ/IXqR8FUOOP
 WtloRbQm7HMasmTXQ/7Zhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Lars Schneider" <larsxschneider@gmail.com>
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
> [3] 
> https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

I see there are currently 84 open PRs (13 in the last 14 days), so it is 
real.

I also see that the Issues page for git.git appears to be disabled, and will 
redirect to the pulls page.

Maybe the instructions should also be part of an Issues template which could 
reduce the potential number of PRs being created (but could create its own 
problems)


>
> Hi,
>
> I am perfectly aware that adding a ".github" directory in the Git core
> tree is ugly. However, I believe the benefits ("well informed new
> contributors") outweigh the injury.
>
> You can see how a github.com Pull Request creation window would like here:
> https://github.com/larsxschneider/git/compare/master...larsxschneider-patch-1?quick_pull=1
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
>    Base Ref: master
>    Web-Diff: https://github.com/larsxschneider/git/commit/d859be5016
>    Checkout: git fetch https://github.com/larsxschneider/git 
> contrib-guide-v1 && git checkout d859be5016
>
> .github/CONTRIBUTING.md          | 10 ++++++++++
> .github/PULL_REQUEST_TEMPLATE.md |  3 +++
> 2 files changed, 13 insertions(+)
> create mode 100644 .github/CONTRIBUTING.md
> create mode 100644 .github/PULL_REQUEST_TEMPLATE.md
>
> diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
> new file mode 100644
> index 0000000000..8d01be6a71
> --- /dev/null
> +++ b/.github/CONTRIBUTING.md
> @@ -0,0 +1,10 @@
> +## Contributing to Git
> +
> +Thanks for taking the time to contribute to Git! Please be advised, that 
> the Git community does not use github.com for their contributions. 
> Instead, we use a [mailing list](http://public-inbox.org/git/) for code 
> submissions, code reviews, and bug reports.

Isn't the mailing list git@vger.kernel.org, with an archive at 
http://public-inbox.org/git/ ?

> +
> +Please [read the maintainer 
> notes](http://repo.or.cz/w/git.git?a=blob_plain;f=MaintNotes;hb=todo) to 
> learn how the Git

Is using the repo.or.cz address deliberate as a way of highlighting that 
Github isn't the centre of the universe when accessing a DVCS repo?

Maybe the kernel.org repo should be first, or at least the alt-git.git repo 
at repo.or.cz listed in those same notes.

> +project is managed, and how you can work with it. In addition, we highly 
> recommend you to [read our submission 
> guidelines](../Documentation/SubmittingPatches).
> +
> +If you prefer video, then [this 
> talk](https://www.youtube.com/watch?v=Q7i_qQW__q4&feature=youtu.be&t=6m4s) 
> might be useful to you as the presenter walks you through the contribution 
> process by example.
> +
> +Your Git community
> diff --git a/.github/PULL_REQUEST_TEMPLATE.md 
> b/.github/PULL_REQUEST_TEMPLATE.md
> new file mode 100644
> index 0000000000..c737a64620
> --- /dev/null
> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> @@ -0,0 +1,3 @@
> +Thanks for taking the time to contribute to Git! Please be advised, that 
> the Git community does not use github.com for their contributions. 
> Instead, we use a mailing list for code submissions, code reviews, and bug 
> reports.
> +
> +Please read the "guidelines for contributing" linked above!
>
> base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
> --
> 2.13.0
>
It's still a good idea though.
--
Philip 

