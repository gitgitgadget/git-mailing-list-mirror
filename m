Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F65C1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 08:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405696AbfJYITB (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 04:19:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:51695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405453AbfJYITB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 04:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571991525;
        bh=PaGWNpBS+NDId4JZDyj4TEiq2xTKj+dz35dQ9rcyJyY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EDdOsVIZYrjAzL9PipieZYR0NDOOXojhLBURD/NbTE8GinkUe6pMhEmhCw+s+UH8n
         FxYmO8/9i2hTGWf2jjG4lyYVzBiVChnqyCvbs8tamSFLqAVxNmbk001CelR5lXEUgU
         H3LkuEHyGhthPcG8VaNdEzscr3GOzC20oKfG1kRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1iPpPy1jgp-0038ok; Fri, 25
 Oct 2019 10:18:45 +0200
Date:   Fri, 25 Oct 2019 10:18:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [git-for-windows] Git for Windows v2.24.0-rc0, was Re: [ANNOUNCE]
 Git v2.24.0-rc0
In-Reply-To: <20191024233432.GB32602@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910251007550.46@tvgsbejvaqbjf.bet>
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910220004190.46@tvgsbejvaqbjf.bet> <74f50326-e613-8545-2c69-65cd29dd3cfb@iee.email> <nycvar.QRO.7.76.6.1910250052350.46@tvgsbejvaqbjf.bet>
 <20191024233432.GB32602@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hfh3vKvCprp6Qe4+TggkSGjeMd6Nteb5E9H7GsDDtnS72kGLHLj
 sgMcujRAt3ju9KZ+0EQrlN92hO2EP+GEjNwxBc3oAhyIKdx84jXuJvNr/tKgMmwf9E1973R
 akjajV/c8kz9YYIdle6D854B9nMbugqmPcwfKXrznRMc2LYiMsdj3O9YX1szgLvV67bBAlk
 UgohPgpQyHGapxHf9kCzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iz2uiLlt7eM=:F4RCU4UlZvW1VnZDuv4Bm2
 Vmj1irlLKlGwH2zKVeHFedsIndNKzPId1VbAS1r9IpJx4l4lKssIjWIHb66rY5FcUDYsT42Sf
 rlppI1Fnkw8hO8jkm540PLltlhCN+CKeVAJyMg+SiXrd7OlP4tL48splabje0n2lXYkpyTEuH
 A93s101fAKXakfo7uULnooknCIgEP6v01m2NbRU2IY98KX1ZJhFJWcfZFda5DdtvIhLm9WWzX
 T6taD9TWkROwZbRbqXNJrV4AwCdXlkHR3ZeywGQfjTTD+MQhdln8+H6clVCfEyJQY2nXGMT+P
 DFQ0AzX/hvwWYCB8i6rqssG2b+uo+DtdSF8XpYpZVwta3l7Vi2LWlEFOj7Eg0AFlE7fEl+xWe
 RTZuMxom8h6v4WmX2JK2Vi6EEYfGkM3OBKOrT6LLQ161ArAofm6paJrXTBWsdA9pKjlnEhtHA
 Cjtns3MCEAbtYDbeNQKPE+TZFoTqC1JayigdTMw3mkFkCQM4bmDeY3qZ1NItQm64F0v8rcU6H
 HMdAf1J2WnfatfjhhlIGcS2TwtyyziHgv2O94i7yZIjMZFZdqT+7LRsDuAqbjosjgCT7ijtHG
 ZcP2VKS+OEYo2SO686Yqbw9iW45vDT2FrnZEDpVSSpUxVxeWjDmo5I93Bnub+LN/JNhAVX85j
 Smg338YjfyGX7iXb6OW3k7gNhoWGdcEPE9IjHmOvhLmQ9kK5Pnl/GI1HnyngkVhe6TlHcb08i
 lAXPIrGXgrGOU8CtzSt8jT8KD/zP+8LVBPEgiaY0o0qr7YRJTDKksMhNLLxeEvedfbhQ7KfJ1
 7keAlRCEJjQz7NLhEKghYRcfPJ44VPk2xQibL1T+QxkCzfs6T0TbwOmHbHzufDIMqgCrsApwM
 20icKzLPjkPwQM6dP0eEJ+dw/muKSJDoBQZQedWe3eEtRrpeR3i9eguaBaLqbb1sGCWIcz9oe
 U9YGkBka1teyes5q12D6Ulkq5Bqr5K1K43+otK7N+ESmFR2Z7MdM+FXLnLHMzVZytdxRdKz3J
 oaz2lBxFOhJEAXhnliWLfAQFJUF1Ni6vhKu0vXxCWjImosFo5S9dFjtUQPq44gK5TPw87NsMR
 3qyzM8uB+7MPNbA+EbG89ZZVtnngA6xz0d1mV8vTF0kgIhwAjF1A7SZaHw1GTnias33m6jmEG
 nm3KUnHPNeP9poImcDy0di31h0gT9/iUYfrDOpCIejjN5uQUCcodmVlwauugPlTC3IclQ7kcX
 HuuvQT0W64RGglDDgYTy6XoWkrR0s3Nvclwkq5wlDG1F+Aywbbv8KUsefQIE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 24 Oct 2019, Jeff King wrote:

> On Fri, Oct 25, 2019 at 01:08:16AM +0200, Johannes Schindelin wrote:
>
> > diff --git a/config.c b/config.c
> > index e7052b39773..8e2f4748c49 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1658,8 +1658,10 @@ static int git_config_from_blob_ref(config_fn_t=
 fn,
> >  const char *git_etc_gitconfig(void)
> >  {
> >  	static const char *system_wide;
> > -	if (!system_wide)
> > +	if (!system_wide) {
> >  		system_wide =3D system_path(ETC_GITCONFIG);
> > +		normalize_path_copy((char *)system_wide, system_wide);
> > +	}
> >  	return system_wide;
>
> This cast made me wonder why it was OK to write to system_wide. The
> answer is that system_path() hands ownership of the memory to us, since
> 59362e560d (system_path(): always return free'able memory to the caller,
> 2014-11-24). So I think the better solution than the cast is to drop the
> "const" from its declaration to better indicate our ownership within the
> function.

Makes sense, I changed it to `static char *system_wide;`.

> I also wondered how we know that system_wide is a large enough buffer,
> but I guess normalizing always makes things smaller. It would be nice if
> normalize_path_copy() said so in its docstring, but that is certainly
> not new to your patch. :)

Well, `normalize_path_copy()`'s documentation says:

	It is okay if dst =3D=3D src, but they should not overlap otherwise.

But yes, that does not state explicitly that the resulting string won't
be longer than the original one. It is currently true, though the
documentation hints at the possibility that a future version might
follow symbolic links (in which case it would no longer be true). But
then, that would technically not be normalization anymore, but
canonicalization.

Ciao,
Dscho
