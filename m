Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AC81F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 23:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKOXi6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 18:38:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:43503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfKOXi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 18:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573861133;
        bh=woktkkEtf60rrmVzEO8LAkHOpcVe3E/LQ9lGVw3+TEI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dcmOqhGeiU5usZq1ncLqa/pA9PoHkxPeNjzmdZa9Bp/VDf3uUduvaeWECsb5p53Tm
         xnYbADfVePpBxzD9WZEyeDsr2rhKYOgL25Sj8F2sTuS3eCzQb4ZFdByWsBQSPxc1pP
         y/7SivU03RBVOq0qS/g7KzDgKXmiICP7ZXH1zwMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1hulfG12lb-00bMV4; Sat, 16
 Nov 2019 00:38:53 +0100
Date:   Sat, 16 Nov 2019 00:38:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
In-Reply-To: <20191115230637.76877-1-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1911160038170.46@tvgsbejvaqbjf.bet>
References: <20191115230637.76877-1-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z4wWO/lt4uf2f3vpz/EiIE7Pd0+yY+YTFdjV1Df+VSPi8Fc6fiJ
 nsOVI0k/2ORd2biykGna2SKHG5ZTbJdm3K2oeDil7DjkngzWwZmp9oSBSu3Ywt9qU2hbcxH
 ro1swz4sxCI7MpiJ11Mp1DBoK9T50bfdviU2T/dDMsKj3/MET9jQZllOtikCxJ2tZDqxzMK
 osBSy5I0HuqrJTQKgeJ9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0GbQJhvwMYo=:S+MCGskF6VnYRJl+UR4+6q
 xtY8dUiYuLaroUBQlFRL6BMzKwoQwO9gbRYI7CFuojT9HKhUWbmwD/aKWQ7osW7jr8PCljZPr
 9nkhsCCCzLTvpLaaupyY8yalrXcompc7gxgsrMdYo5J9ATI6OuWSccYPPaVjmZLewzzDCYxsV
 ZjFswSQgiPLkNHopmEvsqbphxptL0VDtRDj5sR5lQC5wN4PBSQyre/Y4QV1Dgj4AKK79Rp1pW
 JFgrTI0gI9//Xpf7GMBpfkHiOSG+OQ4jGCPLW58RKCeGtBjs8RS++L45MFDG5McDtKUKxepBd
 SZufu7+5ViDmwLqc0jdcqjFu8avULqcl2v8KR7LSXfNyRYdvJ/kog8wPevva/f/kMI7rVtR6K
 4HJSKrLD23DagcWMTtzXzk9YTKJ7VSqPDzSDcjaIbBU+UAtLnZySIhK/S2l0iLLciC6qokmg6
 nGhDzXxQCx6U+d1wQ/kqq7Hxl6bZuXU46Bn3PRhUnqJAUwD7MN0P2JqBV6EI7iTjlyS8gwMjr
 PVoCvuYskP0xh35Xk2B1J59hVtQibl2eQCaw0yHAY2kfcQOS9wcPM3WrMTxFoh0z3pjC/05/b
 NmqtTeEnmI5SMYsZqDFmb2brCIgPL1jPLC+rydhfNCq0MZ36lX7wE8fQCNFH8uHTK0OLHCEDR
 QzhL3X4BzJdORC/llgSI2cL1KEfoRnbSB49+Xbuk69CseTV0XT2OmOKZqtgR6suuOyrROn/Kx
 4DC6EHMamcqbxDCra9YxAEMLvySBAgxyN2hQVZzwdOba7C82vrWxpjZUBfvrxygYshBy8vIOL
 +/wlPYG5eTJyz6UCI+dN22VGEjLCgpuEyZj4vjwj9BnQ1p7Alezy/9dt/PwrzwvRPWsxBs9H2
 Hm5qhLHPW+S5EfmdmOA+ZJ2ns4GkbjCTJgXz8+19Gc8qFnxxWQ4/dhmMfeN4jlY3U9qRLrUpf
 iW5c7OtK978HoTnpygOY/8InxsDALqSAPIOYHxXwB/2kzW0dgjallKs0ZmD5AZztxYs4slbGy
 TH/c1axBkB4wbA8wdFXAe/VeMZusH6xdTSNQDQL0pp2Ph37mfCkLJictWL5FRVJlkLJ8WAXMp
 O+ECx68t5scLX4vZKU5Cf8pC73863u6ob0HxdSrPFlLUozWUgeVFmRkpCxI5RtcDb2xRrqr0j
 TLAt05zxakEMUn9prxewcCma+u4/u9igURJroNOiuvyeFRBeWxSTfZU75N+HEfllGNH1lf22M
 U2sa0CA20q/D1wk05iYpM4zp8J68O6QN6BxuPby/QkWhEqaxUNxyEICV+fK4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Fri, 15 Nov 2019, Emily Shaffer wrote:

> With https://public-inbox.org/git/20191114194708.GD60198@google.com/ we
> now have a mentoring mailing list, to which we should direct new
> contributors who have questions.
>
> Since #git-devel's traffic is fairly low, it should be OK to direct some
> questions there too. Mention some of the conventions in case folks are
> unfamiliar with IRC.
>
> Because the mentoring list and #git-devel are both a subset of Git
> contributors, it's possible that no response is found on either forum,
> so list the main mailing list as a fallback and mention some of the
> conventions.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---

Looks good to me.

Thanks!
Dscho

>
> Reworded the Git mailing list blurb per Denton's recommendation.
>
>  Documentation/MyFirstContribution.txt | 33 +++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFir=
stContribution.txt
> index 5e9b808f5f..90f45b387a 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -23,6 +23,39 @@ useful additional context:
>  - `Documentation/SubmittingPatches`
>  - `Documentation/howto/new-command.txt`
>
> +[[getting-help]]
> +=3D=3D=3D Getting Help
> +
> +If you get stuck, you can seek help in the following places.
> +
> +=3D=3D=3D=3D https://groups.google.com/forum/#!forum/git-mentoring[git-=
mentoring@googlegroups.com]
> +
> +This mailing list is targeted to new contributors and is a great place =
to post
> +questions and receive kind, detailed answers from volunteers on the Git
> +project. You must join the group to view messages or post.
> +
> +=3D=3D=3D=3D https://webchat.freenode.net/#git-devel[#git-devel] on Fre=
enode
> +
> +This IRC channel is for conversations between Git contributors. If some=
one is
> +currently online and knows the answer to your question, you can receive=
 help
> +in real time. Otherwise, you can read the
> +https://colabti.org/irclogger//irclogger_logs/git-devel[scrollback] to =
see
> +whether someone answered you. IRC does not allow offline private messag=
ing, so
> +if you try to private message someone and then log out of IRC, they can=
not
> +respond to you. It's better to ask your questions in the channel so tha=
t you
> +can be answered if you disconnect and so that others can learn from the
> +conversation.
> +
> +=3D=3D=3D=3D https://public-inbox.org/git[git@vger.kernel.org]
> +
> +This is the main Git project mailing list where code reviews, version
> +announcements, design discussions, and more take place. If you fail to =
receive
> +help via the channels above, you can ask your question here. The Git li=
st
> +requires plain-text-only emails and prefers inline and bottom-posting w=
hen
> +replying to mail; you will be CC'd in all replies to you. Optionally, y=
ou can
> +subscribe to the list by sending an email to majordomo@vger.kernel.org =
with
> +"subscribe git" in the body.
> +
>  [[getting-started]]
>  =3D=3D Getting Started
>
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
>
