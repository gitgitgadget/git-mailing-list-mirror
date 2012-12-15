From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: possible Improving diff algoritm
Date: Sat, 15 Dec 2012 13:16:27 +0100
Message-ID: <CALZVapnNFMAMM_UVjgR01DZ2MZhQbJHm7dMLpGzdRqhzrzBuyg@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org> <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org> <CANv4PNnC1J54TSpHuBOpY=rbuU_naysYkmoyi=utNF0vWK1CnA@mail.gmail.com>
 <B1564B28-9BB9-48A2-B59E-7D7C0B0DDECF@adacore.com> <7vzk1izcv6.fsf@alter.siamese.dyndns.org>
 <CALZVap=r0toqWT7aJxiKtezmR8s4QDd0x92JX-eBLWhKaJsmOw@mail.gmail.com> <20121214222938.GB19410@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Geert Bosch <bosch@adacore.com>,
	Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sat Dec 15 13:18:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjqhF-0007PU-4I
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 13:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab2LOMQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 07:16:48 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53481 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab2LOMQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 07:16:48 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so5338992vby.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 04:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nfeUT7mEX2niCssrs9zWQdgeZtwnbR2uLSwEIVfu908=;
        b=LuD4df+N3/offd0uDhX2libjcJ27E7wuK2X9hNv9ZU5b4zySQuTe4yKAjTR1RW5mSJ
         Jq8RhEDW1c8Eygrs4tVlcTL1t01AQoKWg7Fw6k0zZTO+ROLP0a9+YKIRU++dKf9U3x8Q
         v5gKyXPcD544+NdZhHH8BsGzxUNPrca2B8jrcpJz8DvY6SWWoOoHG68LbCcdazz6EPgF
         lLbZ3s5YUca+RRVTNqn2zMvSn5E/ZBmhITFK73Ths/A0ITTxHooOlznVIbzJSw5ANs12
         A6V6gmQkNgdyb2uNYrYYTbtxRjzNq/2knpYXdRgHLPKUbrDsQ9QcFXBi9qHecR8IYWiL
         gFBg==
Received: by 10.52.35.20 with SMTP id d20mr12159025vdj.50.1355573807324; Sat,
 15 Dec 2012 04:16:47 -0800 (PST)
Received: by 10.58.33.200 with HTTP; Sat, 15 Dec 2012 04:16:27 -0800 (PST)
In-Reply-To: <20121214222938.GB19410@client.brlink.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211531>

If just empty lines alone, then it is forced to say there is a new
line. That is beyond this use-case.
Javier Domingo


2012/12/14 Bernhard R. Link <brl+git@mail.brlink.eu>:
> * Javier Domingo <javierdo1@gmail.com> [121214 13:20]:
>> I think the idea of being preferable to have a blank line at the end
>> of the added/deleted block is key in this case.
>
> For symmetry I'd suggest to make it preferable to have blank lines
> at the end or the beginning.
>
>   {
>   old
> + }
> +
> + {
> + new
>   }
>
> vs
>
>   {
>   old
>   }
> +
> + {
> + new
> + }
>
> is just the same case in blue.
> (Although empty lines alone feels not quite optimal, it is at least a
> good start).
>
>         Bernhard R. Link
