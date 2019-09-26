Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB171F463
	for <e@80x24.org>; Thu, 26 Sep 2019 12:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfIZMuL (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 08:50:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:33553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfIZMuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 08:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569502209;
        bh=DQPgRBpxq4BH+mh5Z2AUMeEHRUFYra+ZRQsikIk57Tw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c6HEAVa2aBQlsrYX0z4M7nTYglHt3jZC27IocFqDtdpvn+56WypzANChVpP/voScl
         uWEf1JeyIDrpupXM/p1CvzQuxNIURc0C7U8XAD0trMWUMu8wcwG1nrkTPp2bFZvt2t
         KjB/soKwt4J4uOFYRuZMnu3WGJ4kLy9ubNjZZLEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1hwM6t1h0U-00rcOF; Thu, 26
 Sep 2019 14:50:09 +0200
Date:   Thu, 26 Sep 2019 14:49:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] Makefile: use $(ALL_CFLAGS) in $(HCO) target
In-Reply-To: <0336d1345abfef563d9228e250316cc58a01f2b3.1569263631.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909261449230.15067@tvgsbejvaqbjf.bet>
References: <cover.1569263631.git.liu.denton@gmail.com> <0336d1345abfef563d9228e250316cc58a01f2b3.1569263631.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lUbWu6fRH2JAkL2nVMZmetlmNNtHXLCVNvO9nMqFAIDfhoNEtPQ
 VZ1etT/y+KtpggXedvlCLR4xjjPo6vKp8pjg85QzHGYXHrpdJTg46U6yHP8H+8nhU9V7afB
 6H7IucsRON6RdHMQXUSIZd99A/hI40rPmKIajGL7+sHeLt7XKo84bZkW6QUni9ykmMAOUet
 j3RNXSqK35ceaOM4zIdOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IWytPO4wMn8=:wQ6Ogb2AFuObtQ2r244DIY
 PAZMSQXe0J7t2NlI3LnNxjDh+oki+QJ8R6r/absD6BIy7YU2Kxfp2/iXxfFW2PdcOMcMkeyNf
 yyjg6tVDNE/+0AiPbE0Yv6awtFnkwuO8qoETae+y9moOoHASycAcvrY4PyuTVBznWVI/yj3Kc
 B76CyW81SscVyq7+hcAYP109GgMLXljCBkd5H17j8o2oxYj5PNCsPZKv/lK57FgtLAc5MYXJ5
 PaC+yN3KoRDXtb+xWTyv2DFT+jnLhYfJ3lqjNvV3JsX/cVqOcvwPpZjow18OPIYkowTsIkVit
 rxsHZtPulF44d3coafREYKlQN55Z9WvNorZjz9umv5U4BNbCB2d1uatkMvOlZ5jULyI5ac2FT
 xPcmVYGbFq5t8Bur/0F4zNlc5ZQ+YHORDx0QNBhmWrlPKDD0bVwJ/Sv70ilSzbTtbLfhOrTmq
 x43g7YiTqltEGQ9Ern27yQoNUiPh7coebQ43xvlegqB9XleqTjn0wgL8kkyXgZAkK9rhb18pV
 oXp3Bi4iIF1bGtk2zI7avaNjXV4kNiqWY2QGIni4aV77aDs7lrgUGJvCsYSAz6A7maD9L/un9
 4885hloBMHhYQze8jDTGDNk6gizWS50dmWpTLab9qzOIEIlyE+VkBKbNBHm3UbY3t4SubvTYY
 ROrwFX5GZoI9DLP3iD4+ACi+zrrvaJY0Mfb4h3BXwlDDIGiZ56tGM1aFF1LXPnNKX0dGS058m
 C5TrrGHgp3nAd8FFACuQPn83IUE25egDm/UpEvXBnH+rtGfy3ldyBSDcZfWsm7v2VkUqKH3W4
 sDF8JPrTGhx/LHYcqYvmyQFxPLtkzVngvbA1Z7ljscrs4RJjq9w1ilN6cua0ZJeV8Y1Ufj+TH
 grSvpUKPSrRfrXpsyz3cYWr/oJOQBQrzp8KZkFbqjQjvWhKkE5DSiQQn3v3ZUBgHlNL6PBszh
 yhAHonr0RkiAGNqh9cQBJZDevZImNdn3hPEQ6v9mvpGjH97dPXw3QhEh53huNK/6mLdOpxUWs
 vCCLneQlDgapo26zu+7YsLDnDv5/+iqbVX16tKXtdfBcxwHkOviCTseFgvB+imr6CDI0PfXB7
 Ut9P06TFEcxjEAIruFqJoJmGyc0zH+l51U6vaZNB7p1OiQtSYLNRpIYF98DGbPTT0TxNj3uJH
 1/aINx6BfZGdY6jSOHt+UdQFDc+3DMjEoUpofIsGeRoaBrmcFgb2gIQDG9WZBk4VN4gvgwl3V
 VySq9BWq/NLB5aPdBX8cthAYvIJ0UJmTih9G/Y9WL7Fa3jJRsLeYelF2504M=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Mon, 23 Sep 2019, Denton Liu wrote:

> On platforms that can run `make hdr-check` but require custom flags,
> this target was failing because none of them were being passed to the
> compiler. For example, on MacOS, the NO_OPENSSL flag was being set but
> it was not being passed into compiler so the check was failing.
>
> Pass $(ALL_CFLAGS) into the compiler for the $(HCO) target so that these
> custom flags can be used.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f879697ea3..d8df4e316b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2773,7 +2773,7 @@ CHK_HDRS =3D $(filter-out $(EXCEPT_HDRS),$(patsubs=
t ./%,%,$(LIB_H)))
>  HCO =3D $(patsubst %.h,%.hco,$(CHK_HDRS))
>
>  $(HCO): %.hco: %.h FORCE
> -	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $=
<
> +	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $=
(ALL_CFLAGS) $<

Isn't this essentially identical to what I sent in
https://public-inbox.org/git/pull.129.git.gitgitgadget@gmail.com/
?

Ciao,
Dscho

>
>  .PHONY: hdr-check $(HCO)
>  hdr-check: $(HCO)
> --
> 2.23.0.565.g1cc52d20df
>
>
