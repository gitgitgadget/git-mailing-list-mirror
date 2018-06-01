Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB01D1F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 11:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeFAL0Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 07:26:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:41483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbeFAL0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 07:26:08 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgZ7h-1g3FWb1JtV-00nvmS; Fri, 01
 Jun 2018 13:25:48 +0200
Date:   Fri, 1 Jun 2018 13:25:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] t9104: kosherly remove remote refs
In-Reply-To: <20180601050833.27676-1-chriscool@tuxfamily.org>
Message-ID: <nycvar.QRO.7.76.6.1806011324530.77@tvgsbejvaqbjf.bet>
References: <20180601050833.27676-1-chriscool@tuxfamily.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g44wmjS7syJWBGYrmIR3Ykae/d9fpL556psEhIB93umdekkJQx5
 yxeFuxbNmSu8G3JpD2kJVprJN4SObZjCLHJfHvpDnpHJ/6TU65f7HmKGN/mFiViUJoEJ4Gv
 NX7GOhPSkcCW7DnPozauRSzHKA0gbw+fs7DGClCBjd7p2brIiXAX+0K982U30ghqt2HbVox
 cDb+xyXjzwFUe9kKcI8HQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mNtONZDAQIw=:lRsnnjbiRQh0diSIK2aMoL
 t2OvNTKi8jikkMXx1mkamtAAGm/7B5xV425igVDFR+KvA94wyjYPG1na013R16dKbJR0mF5cA
 ith5XPHSG1dM1Qja9QRQv7idbigePDtYGgAsotrqXx61IbErOmJzwqWYmXQ07TEEE5pfUpbZe
 RsEDykavCpUDIXoEKNUn2yihS6rHeWaTMnVCdQ3fUFhlLsAHkMQKFXKzxTSfEpIscSjiuICG+
 yBfxLgB8XwoRX15TH8efdXWOQvXIzqx4NuI5Ci42Kg/25S9CunoQBWKo3N953XbcUTpN2dawK
 nOJ2On7JQxyu8E1t1Tfhmef01gsSNGuD4o42HiKZ1t6AU4TgSdX6+V81qGYj4GHtoqlXwV5JQ
 QvsBvSFC45INF56CJRmvY+czpUaYUl/JO2QhdL/2gq9e7XfuPy8tpHgP5npJcMmaRjhbrVrhy
 RwGuPw3Fr2Dr1VYy/ZI1ikjmekb2rUQVzrDur9PDpoN3gvp4LslkVycvoFk1pBl65c/zDyZNa
 lZ+ftm91N5nxlQdl5QddHP9owyRYIme8iyM6m4s7b+YwyupOWq/qpH0HQQrppJVgYKGr/3z7A
 SCEDXyUx56Z7DBqudnbUc6vLWCLSqQX6AuvD23vxIoCyJxy36DA+lp6JV70q09Jl7FtBFBUvC
 yN+4jRYq5mM7Jaredxk/h/PtrKFJS6VhoyQ9K97BF0HH4l5F11zaTYmJqj7SJa9ZaXNm+FU19
 +WItY9ZxjacSabLHYEzv+KG5zzHw9d/Apm1hoFAi2Jk9H5Czb9+N7iWK+LAi26XXNQ3J3s21M
 6X1sAsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Fri, 1 Jun 2018, Christian Couder wrote:

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
>  	"
>  
>  test_expect_success "multi-fetch works off a 'clean' repository" '
> -	rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
> +	rm -rf "$GIT_DIR/svn" &&
> +	git for-each-ref --format="option no-deref%0adelete %(refname)" refs/remotes |
> +	git update-ref --stdin &&

Apart from the line longer than our conventions allow, this looks fine to
me!

>  	git reflog expire --all --expire=all &&
>  	mkdir "$GIT_DIR/svn" &&
>  	git svn multi-fetch
> -- 
> 2.17.0.1035.g12039e008f

Please upgrade ;-)

Ciao,
Dscho
