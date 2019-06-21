Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F43D1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfFUUGr (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:06:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:41643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUUGr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561147601;
        bh=Xi7bwyhs8hPMhYJuPPdQpDjq7f6lGsVLhTEVTakHReQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XgaqpqsMt4fMYuj/DjYf6+wWmtzKD0UysqwP7e5ntcUGhvkl0eubvboLxuUoNJe59
         uj7DmADZp2kDXB0ufQ5Ltx8enZDEKhB3RVEzGUNYVlj7b7vOZwBfzXoxzs1HdO2HRI
         rPdr/zrCHGuYK9GqsCRuxwWsAtx4be+8GVQl8XCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mey7N-1hxyzQ01Ht-00OYkk; Fri, 21
 Jun 2019 22:06:41 +0200
Date:   Fri, 21 Jun 2019 22:06:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: md/list-objects-filter-combo, was Re: What's cooking in git.git (Jun
 2019, #05; Wed, 19)
In-Reply-To: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906212205360.44@tvgsbejvaqbjf.bet>
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jOQ4piNanOIbuttqTwLCIWhFB+WkI0mLNwdqTpXQWC1k+7GKzY3
 tcpyVywe6BUt5fSrXKQBIxRBrbLqGAZIJm1SkuX+C8/cIlcyWj6D7/y4B1MDiYMg2oleFKf
 NoklvD+yvEPoJXHTl4KcP45a6TdHrj9iavsKTnS4kvUSjwMbnPPRExjAcx1P2UuITN3SyDp
 p8Oic1CK1oQ+APqK3OqlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZRylD/6t5l4=:RpvgW4ilo0QL2vmGsH6rdV
 cZcObrLFuFgGGPmTKbijG9Y8Av+HCDHacEi94ov6SsutvUTUU41M60aP8bPn9nnLzRer5Cels
 5ykw62uLmB3tapMapFsaT63Yo6/Wj+1JcJVG/dVgG7hDZkiQ3BSW15uwPA4fDiN5mF6Wv7+LS
 OvnkxYcuGECUPVsDsevHK9WGamd+JDUBusURWyVsoupBumBdjkpDgCN+scCry+1ckfcuSOqpH
 oU9wUBxdCQUeRu/0ULRuaOvN7YSQpHE8C7w6kq1KYh9avpkKGm9bqWb5PKqMIczuKtd8Kw7QK
 SMHEbsizr9qN54jJj97TmwsZwC3XwFIfSUi1sXse31t/uHD7k+c/M8LKWp0WTHEHYYBQ/Vr8X
 +yiztm9VvAa95/xBMFjYFM9HVPgPQIku5ynot5p+OetGIAAjBPub3tz2okWZqjONJ3FSagxg3
 r5FZk5myitgegKvnPhZo33N2/5hXHJvZWTlsN500vmgfR4d+9jqPG2+LjKgTBF9d15Mzyc465
 TWtbCOBqTvwsn3voBiy7Whuqm8aEToNJm3xxAmPDa6Z+jh9zg9jD9tOzXg0O+rtQs466io+b3
 m9qOrCkcToVP6kwzxX9z2uYe80eDC/8CXgeQTAtIJHGlt6dJhWaEvteQt1PMDU7T6mzaYF4sd
 bwWnkHIFyZ98HMbkYtznDCPOHXg4Iuuiy10EtFD/xV8C4rpqfHiEFIVgZ074AE23td5KSQSKm
 lgY4OmiYYLMP2fjqhc8ySR163etrvqntlF4ta3rfTmF46svVN66aZybwR5gfg8E/J1eOFuRup
 L6gKVPkVwTslEB0sZxuIpMYYcFhWvUwqZn1RqHs88VC4AexGdN0meTifqTVglVQ7VenQNBpX4
 S3IFVaQ3dNP5KLwaEIW7cHCb1P7qFj7b29D0YID/Hj5Y/wLEAYMoMbV2YTlJLIER3rPyeHZWL
 Lki1qQlYZvFVuzc1cqXZuxgNrMD04+Bn2NqOkwO5ud2ElYZ/i4+xE
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 19 Jun 2019, Junio C Hamano wrote:

> * md/list-objects-filter-combo (2019-06-17) 10 commits
>  - list-objects-filter-options: make parser void
>  - list-objects-filter-options: clean up use of ALLOC_GROW
>  - list-objects-filter-options: allow mult. --filter
>  - strbuf: give URL-encoding API a char predicate fn
>  - list-objects-filter-options: make filter_spec a string_list
>  - list-objects-filter-options: move error check up
>  - list-objects-filter: implement composite filters
>  - list-objects-filter-options: always supply *errbuf
>  - list-objects-filter: put omits set in filter struct
>  - list-objects-filter: make API easier to use
>
>  The list-objects-filter API (used to create a sparse/lazy clone)
>  learned to take a combined filter specification.

This still needs

=2D- snip --
diff -u -p a/list-objects-filter-options.c b/list-objects-filter-options.c
=2D-- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -146,7 +146,7 @@ static int parse_combine_filter(
 	int result =3D 0;

 	if (!subspecs[0]) {
-		strbuf_addf(errbuf,
+		strbuf_addstr(errbuf,
 			    _("expected something after combine:"));
 		result =3D 1;
 		goto cleanup;
=2D-

(see
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D10925&view=
=3Dlogs&jobId=3De7b80b24-15e8-561b-2b9b-3069817c0357&taskId=3D37898c85-322=
8-5621-0595-22d470949738&lineStart=3D253&lineEnd=3D264&colStart=3D1&colEnd=
=3D17)

Ciao,
Dscho
