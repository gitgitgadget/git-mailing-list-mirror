Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337ECC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CD22074B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 12:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kDpG5gjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389770AbgE1MjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 08:39:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:50347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389832AbgE1MjP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590669551;
        bh=mhGiDuFpwxGBLwc3QZPc4vcOOSYM4SpWdDDkrDm5BYM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kDpG5gjq+leZf7tZKnGrmI7uXLmoXMxOxaLFczsTjvWRLcRg/218JNpNWjrN2ODJL
         fI+IZzpDsd/rAzUfrPIX2VibIejalTIasBj9JQioptqQMznXdS4GNXvLfF/wAVAodH
         pAuks8ctVHxlX67DUkLidl7BLTCMuS6yTMOb/qk8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.188]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1j2U9W04Ur-00bp0x; Thu, 28
 May 2020 14:39:11 +0200
Date:   Wed, 27 May 2020 22:05:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: jn/experimental-opts-into-proto-v2, was Re: What's cooking in
 git.git (May 2020, #09; Tue, 26)
In-Reply-To: <xmqqeer46g9l.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005272159570.56@tvgsbejvaqbjf.bet>
References: <xmqqsgfmmt2c.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2005270526280.56@tvgsbejvaqbjf.bet> <xmqq1rn5kpzi.fsf@gitster.c.googlers.com> <20200527235808.GD56118@google.com> <xmqqeer46g9l.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oOJolzUJ4NiyF9x5C2i21ptf6Y88WPcGM60WJqRSCy07NwQ7+Cu
 mdEZkvcaK9zVNGPYFy2MqFfDr0/18N+5WoLw5SW0K9yig8rmq4Gf1Q779FqbUJSk/+Kccu1
 RxRsLvNTWBQiGzW9P8a0o+n3yBZbfbc+mp4qLlGjkVc/FQLn0YzGT8xCYVEM+LzpNMHXZNP
 1esViLtF/nArx0I6x3peQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPOM0qUt19w=:z1pktl/8bbvGdxQATqvg58
 ewMZAe9xhhulc6xLdf8slxnFTNHRJQuFwv+kuNAcwT5tUzvwn0Qls3Itw0SQVeHxlZnTmKlMW
 3Okdk6WzUBeNLZlGdeBUMgxCI7REwiHhC5EIuyPWS1pevlaDgOu5RAkUe24T4hBoZY60szfMy
 zGU4NezJ4/PYImBC1TH9TDGf/E8BBz7EtxRRB/giTeTJs3JE9Q7sXAUr0VEKpKO4z/T72Q0Td
 166IXzSjUqenb4IS/tFvFJW8xjVeKPAvsqueFpdLZIaQGM0MC4FPH/Kxp2rZaSJtJQW8Vn1G8
 01Pq3Jvy52xDujx0uEu4EHvuWpEeXnZxw+YzDQlxQRqvhsz9/ANYGdJlpfwIs0J9UTcT/oXIs
 FIOEktnpVA3WA78cherwAKl0QLy+9bH416F9GLMyPKh3qLKdC4hAuGStfzWf3PJispfz32O/6
 Ba1xf6rWMtFLtg7Ao7y30asZ9QPzehssioXlG7tevn6hUu/RccEuzOmFogIWK49j9GcGJsy0G
 uCe2cXKJFGdrYWogwwspMxq29cm+XOLGy5t0K38FlDqKmcPKuPytwDpMRVJgZvLi6dYxZzoHz
 IHmZYt0gNItNxCRGMHm3DI2Y/269r+OrvVcDLAhf6EW45LIvUtzwvMq5sdCeGPSJxyKG3M3G0
 0DlNGYJiaZyvreFJHtY6f1ec19rtyU+S5Sx+DyJeGQwFDZyKz9BHqD5gsAaxTd9cm0NPll4uV
 pOYm+jSbhfCmHZqtXodR7m783KqG6Gw31ipsXjYsoY2upr6cMq7JhKXppCMn6G+htJ9l72bGl
 nSxdtX/1Qh02eORxKEXA0s76E5dJDUjax3pfRLn5ftrdyBP+00b+DRwC7AIbMuHD+RtqQ82vm
 RSQerebP7TNgMi5x0g/RQNi/sJcWr3n2DMSeRX7PuJNw5f0UFnnSKfVSnwEnmduW9kWPzuCbw
 4Z3uiYvz3QwuAiKtRzrS0HJ4hYAMHDTd1is0g78OlWiOdbmzbduAVJxqU3y+NL5E0fGE6XNk6
 BCGZ4mefQ0Yqn6AsSwhc8WflieN8Qy2U4Yc5lxwoNUZ3nI8TlyxpZVbYlafzxbMIusaU+Nx/H
 JmtvCkwiYstS2LyASytBs1yojgwZR9+p+vVRCGQhxl6Kf9Lttg+zO/z42lbqcd3rUmNUeTzXI
 soQL4HDstvzq1X8ZGv4zeUgYw0A1KOchqjBizHYVm9aIdmpiGSj5cNFVSmpqKrb+jkb8VLiNY
 4hq5DnMtpd7KTs9iI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 27 May 2020, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> >> I have been wondering about the same thing, and if it were not using
> >> its own custom way to read the configuration, it would have been a
> >> non-brainer to merge it down before the release.
> >
> > Hm, do you have more detail about this?  git_config_get_bool feels
> > very standard and non-custom.
> >
> > Do you mean that you would like it to go in repo-settings.c?
>
> No.  I fully accept your reasoning in the proposed log message why a
> handcrafted query to the config system is done in the location the
> patch adds a call.

Now, I apologize. I had not reviewed the patch, and only just read it.

I agree that it is a bit unfortunate that it uses such a non-standard way
that hard-codes "feature.experimental" in a different place than
repo-settings.c.

And I have to admit that the `git ls-remote` example does not really
convince me that it makes sense to go a different route than all other
experimental options. It makes it unnecessarily hard to gather the list of
features enabled via `features.experimental =3D true`.

Had it been a patch to repo-settings.c, I would now have tried to lobby
for including it into v2.27.0, but as it is, I fully agree with your
reasoning to just leave it out.

Ciao,
Dscho
