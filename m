Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686CB1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdA3RsF (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:48:05 -0500
Received: from mout.web.de ([212.227.17.12]:54495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751645AbdA3RsE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:48:04 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCZh8-1cgT9C3vQA-009LgK; Mon, 30
 Jan 2017 18:41:17 +0100
Subject: Re: [PATCH 5/5] graph: use SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <af5a7205-7703-f5ad-4ea2-b20ab4c01c80@web.de>
 <alpine.DEB.2.20.1701301714450.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <63f1dcc0-729c-955b-63fa-859e441406bd@web.de>
Date:   Mon, 30 Jan 2017 18:41:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701301714450.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:lJ/8VXtr9FuPFktTF1esDJdiNHwaZ8WAMGqB/V3ZxVCnn2JgJq+
 i0qfq/L6IUvDOVfQXJJ5v7w5GD08Md+ci6rlukc0gEOdGZI6wLBl28EdG6faVSACMdqooVO
 /MtyRA9aSzV5izQoZc5qjO5NT10O+wdE9N5GsjczJojBOAWLuSh4uhr3ioHc0D0H8V7bPX/
 aqwg8loVgdPNfpNkUtT9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zpoCZPKKfZ4=:HbIrd4e6C/zfvdtUjp4tqC
 ey/d7fiuDwUjEjTxpczjH2RbsfbM1w4NYwSyqT6SfpGaqt4zDTbGPIaLkGsi+/dotrR7oGFCZ
 +47uQWuP/wNFhk8d5zWw9V0S9P5Q87ENLF1iogu1aoE4divx7sVN7sQ2u96jy2BQm5lZpjxxB
 Q0LRzYTVduaheWWlpQrtOnTE1s4OgL7eSqBm1Pndoth+n5xHc+rKbHJjQ1jG/6Z23oXGJIy+M
 TVBvaeTKOgk259Intjluhx3LIiFiXSJd4vCsLXPJRvoFUxU65FHdLEP+BO+/gJ27irncUejMP
 hKbpERvZZcsrv+A9k1f9TPRggrnVPzLxR9wPPzPLGomweGE3DurvzlsFz5xQYB2iqu5ZfJFVQ
 9wmY6C/MsSxE/7xj+z7IwQeeP1kcWb0K7Ev4Qf59H4hIhB5t1SUxruTrV/YejAYqFkne9PU1b
 Af+FQrUl48PKhTA6jPiMI+V/biH79/FL0ki7LIpP2UuumVyumjetpNffM21wSjhClrfMUcgZl
 UZDabyUtpHu5vNHoboBJgzf5xW0oIal/JrguM/P7kfvXS1MFI1iW9E9M+Ovd0yxqrbb5Ttpg9
 riblRoj3W+Af9ZxT2SRFit9bfbpp3mDkQoKBpgHoeDgBoBCEk0o0mIRnlHqS983NzO1YQ7kdj
 zCaFTs9/lHG23EBppD71wz5mhhjRzqu3rg+DAUBUvsNVPtbYRIDV6FXmZHKfTbdm210W29DpM
 mkW31ksfwpUhYBu+3jIBOyNTSpJu6cuuNNaRx3D1DKpMSkpff221u+S/Ah+zfqR2JuJ02+Ga8
 r2hKbSr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 17:16 schrieb Johannes Schindelin:
> Hi René,
>
> On Sat, 28 Jan 2017, René Scharfe wrote:
>
>> Exchange the values of graph->columns and graph->new_columns using the
>> macro SWAP instead of hand-rolled code.  The result is shorter and
>> easier to read.
>>
>> This transformation was not done by the semantic patch swap.cocci
>> because there's an unrelated statement between the second and the last
>> step of the exchange, so it didn't match the expected pattern.
>
> Is it really true that Coccinelle cannot be told to look for a code block
> that declares a variable that is then used *only* in the lines we want to
> match and replace?

Hope I parsed your question correctly; my answer would be that it can't 
be true because that's basically what the proposed semantic patch does:

	@ swap @
	type T;
	T tmp, a, b;
	@@
	- tmp = a;
	- a = b;
	- b = tmp;
	+ SWAP(a, b);

	@ extends swap @
	identifier unused;
	@@
	  {
	  ...
	- T unused;
	  ... when != unused
	  }

The first part (up to the "+") looks for a opportunities to use SWAP, 
and the second part looks for blocks where that transformation was done 
and we declare identifiers that are/became unused.

It did not match the code in graph.c because the pattern was basically:

	tmp = a;
	a = b;
	something = totally_different;
	b = tmp;

Coccinelle can be told to ignore such unrelated code by adding "... when 
!= tmp" etc. (which matches context lines that don't reference tmp), but 
that's slooow.  (Perhaps I just did it wrong, though.)

René
