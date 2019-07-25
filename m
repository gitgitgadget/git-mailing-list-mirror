Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0756E1F97E
	for <e@80x24.org>; Thu, 25 Jul 2019 19:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfGYTz1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 15:55:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:51943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGYTz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 15:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564084521;
        bh=GJ5A0v8/vHNYYEeDKkaWWluCmUktr5Cgy1Ti7XvwtCk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Teoszgw2Cd4MqigGNRbFHK0+hNvHnv64tkk5J1UVaBIZs+K0dh3UcJNkYN4T8NApD
         RzT36ZQziP55l0VoGRQjTsRWJjMQTOZMUTYSEtLmp14SbwXJNnJ0/8u0o8CH0lFtD+
         WSO22eGxfM5Fha3c6EyFbHyrRi367TXYXEzJJCfo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZG7-1hzMok2slv-00REfo; Thu, 25
 Jul 2019 21:55:21 +0200
Date:   Thu, 25 Jul 2019 21:55:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/19] Change call signature of
 write_tree_from_memory()
In-Reply-To: <20190725174611.14802-7-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907252153530.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-7-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lu6eP6vZLGlQtcuM0qJZA4gFUKx6ROioE0KBP6PK93wDya3jUV3
 StsoTDZ/HIbo9JR7MXuNEXiVaZkFGxmNmd6O63iejQtCR4divyq758s+5aST11DjPBLoXp8
 QypQXDR6Su6qiGm7n1qxPJf2RKkX51Km0LSc6WhXo+cDNbzDqOgfv6qx2vRWup9ohjLhzQ2
 kXiRzjkB8V92dH3bN4llQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S9N2CCLaAy8=:ZpThYJv5NGnPrTzDczW3Z7
 MYHcVfo1gH1UmThVppDzR8BJm8CQvNMD7iIlecq+iych2PyHh1yru0GZ0iv4AJZpqOqCpUyp/
 bwXlHdIOmHt0/WJX1AOORObu7ssSxy1HFjUFgm45U45rbRCzRvHwBIA3TSG+Ru/vbOiSNHBaI
 bCffVg0480XueT0H4kNf2fRSk2T+RTNnzVoW2IXFnDE5mxK6GinEiqliYje36V3jTd8IxLefG
 VRfPLrl6XpohZkDZCmbjKXbKCiAl2aa0FL+Y92NP05pdC4KfqKQFpKNvj/8u6qsz1cxxLpxtE
 tO9xiFycugTvN5XsiZiHDuwVEOj8eNQK6gHEYG/SioVeoO//LhBl2d3xiCBjFDb+4l44NO43D
 tZ9WWsljap6Fplodtlz3JdlZh7IBdMnDiH3vWZywrOaIA45fdsQXnRFoT/ox3J72tH3hEjkZO
 MeuGzhO7ztdzWo6cyVIrC1G/mLNySIl3wlLM4CbnZolDKlkHc9HmlZ0UphQZqOH+4HM07Er1Q
 htmDost6eIXJ09ynOcO5WFDnV4qyyh6lo99jGSxa6Wy/eNV1NhClblGCCg5gQ+vMs8G28KFpn
 ar0NPzLg+/gSssD2Vfzj6u1dNjXpqEYn43FIlxzeBJ/pTQnyLbHmSJPOV1Gwf+5cFDh7J0B1X
 u7e7M7oiilhz0fZEcvFl/cABfXEkYAolOXJnxGNV72GTFXFDJnUEnb5r8LNQWX166US1gIF4y
 tK9AgMLhDXTRBPt2PspwsUsmP/PN/p/RbmoQ2nkTAtUEnB77t7c9AgxzSWN/CFYV0XG2ufUN5
 V0TKdQ6yBi1VxL3kQ87NqQWyzXadXNsNd/6Bf01Ld3TJWkHhAeAIG15gDUdJc8px2Fi0iALfU
 JD3PMQCBD/U2jqD2Pgf1hPxmPTbe3g0h72RoTPDH9DxDS40B14ClVWoBzXfqVgtBOM6iK9S9R
 tLrCva3x820EymGagOr6JZkGudyahIAbMBUh4nyiWs18E9YoDULhc6DiJn8TiE7W4b97ZJj1B
 VRpTltN//W7/0cBTsN2FdJ4juQ1ss6ZatbZAuVfNliYUdI0GtDETKt02Osoakt/5/dSL8hhtC
 0WEhL8S5L44FvO9lchYezdh7Hy/ETjcQoyT
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 7f56cb0ed1..1a3c6ab7f3 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> [...]
> @@ -434,11 +434,10 @@ struct tree *write_tree_from_memory(struct merge_o=
ptions *opt)
>
>  	if (!cache_tree_fully_valid(istate->cache_tree) &&
>  	    cache_tree_update(istate, 0) < 0) {
> -		err(opt, _("error building trees"));
> -		return NULL;
> +		BUG("error building trees");

Hmm. Is it possible that something else than a bug in Git causes this to
fail?

I wonder, for example, whether a full disk can cause
`cache_tree_update()` to return a negative value.

Ciao,
Dscho
