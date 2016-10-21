Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A978620229
	for <e@80x24.org>; Fri, 21 Oct 2016 19:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935908AbcJUT5h (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 15:57:37 -0400
Received: from mout.web.de ([212.227.15.4]:62919 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935106AbcJUT5g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 15:57:36 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LaIRi-1ce8Yj2X9C-00m5CB; Fri, 21 Oct 2016 21:57:27
 +0200
Subject: Re: Drastic jump in the time required for the test suite
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <CACsJy8ALRjnvgM6sW5ioFHtquSR6zgQHkQ6-LUnKFnqXV9eDCQ@mail.gmail.com>
 <e0e320ce-14a1-b4a8-aa07-6bc4f3c4a424@web.de> <vpqd1itdf02.fsf@anie.imag.fr>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6616be42-7c47-0b6c-28a3-e3ec70e624bf@web.de>
Date:   Fri, 21 Oct 2016 21:57:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <vpqd1itdf02.fsf@anie.imag.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:eoaV3qOgmY+KEXRkAyQLOvBYfqqLdDoqSm7C1XZ8Bl0GVmcxHzs
 //IZBudRkFucOWOLnNmcC9XB95sDVWTI7o4P7iWfl0lj3q0dFaRJsgYJhx5tioIp+OYmk+t
 N73dQ7ikaICaGRVnQhUSC7Srmtn5Hhs45QASjC7UJ8g834Ywylz2ALoo7jCFkSkrSSn+Yd7
 kpC9OKeaVrQdpKnQO1Vwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oU7LfkV//dg=:m1Bo70ffFUCgpuyiOLeO41
 ec/vtCSEragCtF0Q6AwZJROVn6n+pMuCJtxQHONtVUyo6yoBnMvTW8F8SeOLn49sbAuGyMdJF
 ANT3pLRKZQWKH1cAfAWbJ9jmHDwyiOM+1S9RGy4DKCHRonNZg81ynxbFRYb60dm5KKeyhbF83
 wRukDxodXFb8wvkzBeEeG8DTFCF/onuT14hH8JPUAyI2rgsQ/zCmEnWb3fk6Ud1W1js2VC0dS
 i53JWGSlhOyMr+v7GKL5xd28ktImwnAtbpwSetYFwD/bV61pb1fKZ9oEEt5KYn+I304tX5gAA
 CkA0Ht0MEtnl850vNYzz5SisQcNXPXs1Ms8y5j72TzOJAozFX9q757mU7K8Rc9z1A16xHG0xO
 WT3Prsd3n018Ggi1vqvXvhHZunyC6f9/DZ+suKjfUfDPnRhxayK2+Bo8p+Foudk8guclbXOPr
 hBbQW1YKQxfwBUZgcA6Itp6dHKrekn6S+brKQmtDZMYzLRP4ZCX6Jcdjrg5fzbm/PiDqVIWKp
 Pw4X0bieP9qXp21ooOcd4Ev/LV3j/FFq/ny6ou4efgEzvL/fddxcfL6YPGMQr8mDfptoin162
 rMVNsz/QP5aRRGbBgmI9gUUBIktzjW44hHypPDqUTpwzD651cS/VuggSBGGX6+oibsz3RAld+
 atKmsSz7cgtYJSRX+a5ELnBF/E9eDQrZ8YZiTAviNx5xJamkCZifwe8lS2EfKEZJoGW9luycA
 MJN1onEcYRa7dHeofTZBUXbriAwx0OaT4E/OVAu6v4aaIyjEOMs9z0SeQDs0VBocJWVmLbz1h
 cf1J/gW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.10.2016 um 15:10 schrieb Matthieu Moy:
> René Scharfe <l.s.r@web.de> writes:
> 
>> I get this on WSL with prove -j8:
>>
>> Files=750, Tests=13657, 906 wallclock secs ( 8.51 usr 17.17 sys + 282.62 cusr 3731.85 csys = 4040.15 CPU)
>>
>> And this for a run on Debian inside a Hyper-V VM on the same system:
>>
>> Files=759, Tests=13895, 99 wallclock secs ( 4.81 usr  1.06 sys + 39.70 cusr 25.82 csys = 71.39 CPU)
> 
> What about the same without WSL on windows?

Files=755, Tests=14894, 1774 wallclock secs ( 9.31 usr  9.58 sys + 821.87 cusr 1961.23 csys = 2801.99 CPU)

René

