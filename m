Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7642070F
	for <e@80x24.org>; Sun, 18 Sep 2016 13:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932579AbcIRNWU (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 09:22:20 -0400
Received: from mout.web.de ([212.227.15.4]:55925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755853AbcIRNWS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 09:22:18 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LvB2o-1b32BM0WUU-010LxZ; Sun, 18 Sep 2016 15:22:10
 +0200
Subject: Re: Two bugs in --pretty with %C(auto)
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
References: <nrje96$q7s$1@blaine.gmane.org>
 <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
 <CACNzp2mkD7Se9R=SVwXhyRstkGAs1N9YbNgaZRQYKkpPM1kj8A@mail.gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bddd85de-76d1-fbd1-06f5-4ced57879f2c@web.de>
Date:   Sun, 18 Sep 2016 15:21:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACNzp2mkD7Se9R=SVwXhyRstkGAs1N9YbNgaZRQYKkpPM1kj8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:uhJtuLKVxg02v2tXNcxNTCrZZ0r/BxylkhFTKrO8rD4gvCre2u/
 uJv+MayuSsw27+ypURz6cVfv2ZZzgNiuLEkV/BhrQRcTipNsHUZrHUHZQifvn2SKONr8b0q
 WposkBKQ3H8q/OK/BikE8wW2qk3PpZTc5p+RBI7ZF4lI0FGdjGi+ztc/7ODhlqwovkZnGR2
 1DfMlZpxOMASWXHjebqFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kG6PJdYeD2I=:cTP2DO4NA34yRXudNlfEPB
 BB9dLQWLNfQt7jJUXqiPunDGmKvYK/wALfhX8UA01AhzDtG5bD1xUBrjLGV+irjn5IUFDr18q
 lWRUBAkStwAzBx9zym9QzPwItBWW74drh5HCyEKPIDRJSfNeMJAwgtWXomzboANBspoxW/Yua
 zIYvPnHCKQuSCJQj0Aeo09/YJadr55mo6/tMyVN7IgFosB0lemuiW1rUQ9pPwmZGYeSylQR7n
 vHjCmJ3g6ObpnBDIwodQ4/T+jr9Atqq4rDisMplBLsT4ozxEipUNTFR/vPjT6ZsRsi2IAMlKg
 kvvTYtndY4CjA1hF8AOdHrzb/A/i0SD7pB91rKM424nMd/nM6xh1Nb+7WqGjQMy4j3yDF/1kU
 4Isdef1JuUmaqnasUymuIFchBXQ09SDgT5/ccb9jbhFX/tGWg1ddku2NGnR6vXvJFZBu+L+zq
 BdY5tpH9Ynvlhb5akMiGAcU6SjeBqLmuCkolp5AyQteKJT1j0TBT2biLll9rBggUBbFK2vYbU
 zKEY9LbmckcghrHkQpdqay9L7JXUW3fVSMdTHhxoi7Yy38odi3QqkWgvXHjqEDHvDO/ytk77t
 i9fWigqtm9+MUSk1m3VoJkACODlFfHbRcFuVsptoejR8Zft1lxV10MywwaaYvMgB+ArPyg2zm
 CzADYtDIlT++1YbcWdluIbFbmZySoZdpt0fjD0ALLK+H5MMN6jaTOLIyMdQPAc5aMBAYgoFRu
 v6zTKLxh7iW1b9HXhPy2PWfF/GNQnKJCOem/ZO6D+4xJRsy+QqjVkFd8PREblmC9ClcJAfZPH
 7aIuX73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.09.2016 um 14:30 schrieb Anatoly Borodin:
> On Sat, Sep 17, 2016 at 8:25 PM, René Scharfe <l.s.r@web.de> wrote:
>> I'm not sure how just how automatic %C(auto) is supposed to be, but you
>> expected it do emit the reset for you, right?  Sounds reasonable to me.
>
> I don't see a good reason not to do so. Spare some bytes?..

The states for colors and attributes are separate; that's how the bold 
attribute bled into your the auto-colored parts of your output.  You 
could use that property to specify e.g. "give me automatic coloring, but 
reverse it".

This only works by accident now, I think.  Full resets are emitted after 
many placeholders, so attributes don't reach very far in practice.  We'd 
have to be more careful with these full resets if we'd want attributes 
to cover multiple placeholders.  An automatic reset at the start of 
%C(auto) would go into the opposite direction.

René
