Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4582C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiE0Ulk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiE0Uli (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 16:41:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B75C132A0B
        for <git@vger.kernel.org>; Fri, 27 May 2022 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653684073;
        bh=BkfUlbKI9B0hy04Fu7ZVVxrR5xwa81RROAphunqDPro=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z+mzJDzQchSW/9a44eypqCz+wBOZA6p46WV75maVuqkQXJl42wOPRfPpJSa2ez37m
         EC+AIbKUiXUD7gG9MfC9/hHV4KP9EvoUdqxj6mCBUzHkiwiQVtFtI/AxHOXFiSMXvA
         CE0XHD1rWDde1kQHIcVBdNskLQdXrmX6HcydiBpE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1oGyZn43ZD-00Vkqs; Fri, 27
 May 2022 22:41:13 +0200
Date:   Fri, 27 May 2022 22:41:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: Re* jc/http-clear-finished-pointer
In-Reply-To: <xmqq7d68ytj8.fsf_-_@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205272235220.349@tvgsbejvaqbjf.bet>
References: <xmqqzgj41ya2.fsf@gitster.g> <220526.86v8ts3z2k.gmgdl@evledraar.gmail.com> <xmqq7d68ytj8.fsf_-_@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MzRwBbFQxjmDLvU3TjARomQZlDc0sv93lYneGqUF10ceMfCLBDZ
 m31b/c2Q8CLAtfwRxol6XWyoIqys1z1XxhjSeOP4VgR+wgPnHgnC4rECUDqiEQ6uVbdjNrb
 mQ2tXcSq5lliAwxMySn1aMzyBInZx9udzAnQP4/e7U8cWCqwI9UU6BVkmEhp7OTKBOvZin6
 RcokZVg4HiS6t/hLGrbGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fCIoHCifGkA=:yercmvRpfELhs6unnrHEvc
 yRvh67biFVA/tTw8BrP9qClPL1NqHIjtiloFBdWByb4JnWHygT7oRrpGgbC4BRZgTNg5OkzsP
 yYr/+zdl6zMnuprHbwsudwsxkPitjOiuB6xjcdqX9AiyVvxvbTQf+L/ket39IQlAqhgyZ30Dw
 EDgQY3FOXQyNN4XLDvtme7uhaPHUBZlMOlcq+UIpWWwZJoONp1vqcX/9U5e6ZCnzRVAeaZ+ht
 ixoLh3VAofTByvzB/Spruwd7GPmhqFfggsOGTeuzILGhJBTMWSLB0aVvs+mROxOCwoGNLVYdS
 O86e6nGya31TWP3WJTywfSqHtZm77tTOfAwkwnz6Iq2vbGnsNKwIFWvvN1+wvt3Ad0PqlXH7u
 TbCXVYFbBLpKAt7Lvds20CX3p1i+l9rl3xUCEDeP4q+yZkYRpU0YXhXbKKsGWs8aB9jgq0rbC
 jDVFrDQ4hEbl+jVvrq4RKGt175qySsBZB2isYOrz9XIVaScZrE62pajDIswSx99LYVPuUbjaa
 75T5GnH7AufenQkZfiDVfwkTiGpaAFYeB4bUJiJm5A2yTYUL2l0Cf8RVtwurzIKJMhD1pCde4
 QPSEDDS3ET8OsM2Eed9W58V5MFSWymuJ19bJ6iI5t2uSV/LtC8rwe1juLvuFBu95q/4OVvMez
 +Q9uoKL0KGV5xJggccLAwQ2Aw3Fh3FoAQN1PbrNNbJRIm+/CuBPB6PTgkFsoIEMp1NCo+emlP
 FweSAxmkwxIoxCPUjb48810ueFrzVVnyOWPFUcjhmQKkx4EvnUwsOO3GXRcZPw91DzRk0RINd
 pHvTdE3RTj5W8aj72H261lJ8pUPQlxD9Ad1OtKHEI82wsAtdW7fdxXjl6d0rb1L6Oqo+k/fVD
 iLc/zx7PzQvj/xoaN9QLkvl2CSIR9Hfp3rzjvFR90ndT5GqjmY3nab1QZwW1cxHS772UagAhn
 96PnpRJtifvMS0N9qWU7m1Kikvnq6lmyGkxaNcWmc41GJdMFftd7vBtA6AoViPEFWsfguVdFX
 Ete45qQBgyk0VSYhT7YGbBez7jUUBcJGAphra4uG2j7jtmz6cR3YUAAdSqbgiDbV9nN+o8sDb
 HL7zPafkqI8U8843re4zc1pvRpjn0JjX5ZTkoto4pPIm0zjTX/6G7aRVA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 May 2022, Junio C Hamano wrote:

> diff --git a/http.c b/http.c
> index 229da4d148..9a98372f74 100644
> --- a/http.c
> +++ b/http.c
> @@ -1367,6 +1367,32 @@ void run_active_slot(struct active_request_slot *=
slot)
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
> +
> +	/*
> +	 * The value of slot->finished we set before the loop was used
> +	 * to set our "finished" variable when our request completed.
> +	 *
> +	 * 1. The slot may not have been reused for another requst
> +	 *    yet, in which case it still has &finished.
> +	 *
> +	 * 2. The slot may already be in-use to serve another request,
> +	 *    which can further be divided into two cases:
> +	 *
> +	 * (a) If call run_active_slot() hasn't been called for that
> +	 *     other request, slot->finished may still have the
> +	 *     address of our &finished.
> +	 *
> +	 * (b) If the request did call run_active_slot(), then the
> +	 *     call would have updated slot->finished at the beginning
> +	 *     of this function, and with the clearing of the member
> +	 *     below, we would find that slot->finished is now NULL.
> +	 *
> +	 * In all cases, slot->finished has no useful information to
> +	 * anybody at this point.  Some compilers warn us for
> +	 * attempting to smuggle a pointer that is about to become
> +	 * invalid, i.e. &finished.  We clear it here to assure them.
> +	 */
> +	slot->finished =3D NULL;
>  }
>
>  static void release_active_slot(struct active_request_slot *slot)
> --
> 2.36.1-306-g0dbcc0e187

I just verified that there is currently no other location in Git's code
that assigns a non-NULL value to `slot->finished` than
`run_active_slot()`. Otherwise we would potentially overwrite the value
here (which is why I preferred the conditional assignment, which does not
shut up GCC though). So for now, this solution is safe.

Having said that, it is quite puzzling that GCC thinks it is safe to
assign a local variable's pointer to a struct that is then accessed
outside the current file. This would make it easy to copy and use the
pointer well after the function scope was left. This is _not_ the case in
Git's source code, but GCC seems that this isn't possible by
(mis-)interpreting the final `slot->finished =3D NULL` to mean that the
`slot->finished =3D &finished` was safe (because it clearly isn't). In GCC=
's
defense, there is probably a lot of code out there that would no longer
compile if they truly enforced the new `-Wdangling-pointer` rule
correctly.

With all that, here is my ACK.

Ciao,
Dscho
