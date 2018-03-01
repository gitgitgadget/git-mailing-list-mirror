Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1841F576
	for <e@80x24.org>; Thu,  1 Mar 2018 10:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967523AbeCAK6J (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 05:58:09 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:65111 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967461AbeCAK5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 05:57:42 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id rLu8eYgWP59cnrLu8exaXv; Thu, 01 Mar 2018 10:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519901861;
        bh=BjHsMJWv9HyH/z804i+IQLg1EoJezxG1kE70o63UZno=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gtn00ahsqi8q/2XYmcHTGVpBIZoChBF4nsOMlwOw+JeJNTqS7211bza9ToMR50aGv
         KRMwRYaOORcM3Fzeh6C/wOYD/Q63d7Nn79UmtsUGULzDhWoEqA2GA6iiCV2w7nQLsJ
         CXsXOR0b/+LGMzUusojSxIVoK+ujP4UW1uFbFq90=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=Yr8hubQX c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=NEAV23lmAAAA:8 a=MY0H4mv8Uc7-u6UNygwA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/9] t3701: indent here documents
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
 <20180227110404.16816-3-phillip.wood@talktalk.net>
 <xmqqo9kanjrk.fsf@gitster-ct.c.googlers.com>
 <12a03e03-640e-90c8-0ac8-14807a1834c9@talktalk.net>
 <xmqqsh9lm8fl.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <30ff8d98-e86f-2eca-c7fb-25f537f9e3e5@talktalk.net>
Date:   Thu, 1 Mar 2018 10:57:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh9lm8fl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJiNuC1/btIfJfnlUGbkBfxCxkgtvaqxTnkdZqob9ZCziMLfI0C0OI3H+UlEv8eUlf8s/wvO1md2EGiqDmZnDKtXNraR4VHXIS5f0RZqwR0VGvKzay96
 VFRLRVVPeCDOiqnM1DTae+OKIaqM/fmD6ubg9UuLyt9fqvbdA2JsXjsWe4KwKtJzqY0QbVAbqYoyrkGIpXbg0Kn9S5e+8p+z7du9NkD5RRZFDu5myXtvS4ld
 1T6rYGaYrcU+1I0jG0cHiO16gh2GozQhHN4kTo2a8djJ9Nuo7tXTnQcEWmx8MKwZ0CSStMgEK6YU5lbJlwtJOWwVjCl7Moj/4czaXqOkRoc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 28/02/18 15:37, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> Is there an easy way for contributors to compare the branch they post to
>> what ends up it pu?
> 
> Distributed work is pretty much symmetric, so it can be done the
> same way as one would review a rerolled series by another co-worker.
> 
>  $ git log --oneline --first-parent origin/master..origin/pu
> 
> would show merges of topic branches, so you can find the tip of the
> topic of your earlier submission (it would be one $commit^2; call
> that $topic).  origin/master..$topic would be the one branch
> (i.e. what is in 'pu') to be compared.
> 
> The other branch to be compared is what you sent the previous one
> out of, or the new version of the patches.
> 
> To compare two branches, git://github.com/trast/tbdiff is one of the
> easier way.  
> 
> Before I learned about the tool, I used to "format-patch --stdout"
> on both branches, and ran "diff -u" between them, as a crude measure;
> it was more useful for spotting typofixes in the log messages than
> code changes, before I got good at reading diff of diffs ;-).
> 
> Also, tentatively rebasing the two branches on a common base, and
> then doing "git diff $oldtopic~$N $newtopic~$N" or something like
> that for varying value of $N (and N==0 is a good way for final
> sanity checks).

Thanks for the tips, tbdiff looks useful (I just need to learn to read
diffs of diffs!). I also find rebasing them on a common ancestor useful
but its a bit tedious.

Thanks again

Phillip

