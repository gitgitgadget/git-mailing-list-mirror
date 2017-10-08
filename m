Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6F320373
	for <e@80x24.org>; Sun,  8 Oct 2017 12:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbdJHMjO (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 08:39:14 -0400
Received: from mout.web.de ([212.227.15.4]:63812 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdJHMjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 08:39:13 -0400
Received: from [192.168.178.36] ([91.20.63.142]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLy84-1dve1H34TU-007iVt; Sun, 08
 Oct 2017 14:39:07 +0200
Subject: Re: "git rm" seems to do recursive removal even without "-r"
To:     Git Mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Smith <paul@mad-scientist.net>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
 <20171007190402.GH3382@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net>
 <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <05775b3d-2e88-9ceb-e8d2-8ff2373cfdb5@web.de>
Date:   Sun, 8 Oct 2017 14:39:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1JuEVFePqzAr1zOBL0wsciNH1IBTFm7V8qjDdqOXJSoqCmQHbCk
 gIBj6MvpE/171Kk3VzbvKTeP2pcQJi3eI5XU66J6lTQRuM1L8KM0fwmegW31RT6YVJ6D8IA
 qPC+EmS9vPAaljfQMOPxkyQwJF/xDWZdPXhzIaYnlXOZMM7fjHDNPzaLlGp/WTOEt7DOY/q
 wQqb9Jm5srdTRNe70P7AQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JiwUzJcOw2o=:JarujWv1Oux7mlTqO+h0fV
 2PmMZtGGAYwMJCGtBOtNiBU7hjWUGE859n7VoYtVznI4YHKxL0L428yYpU/7vg+GwOCUDqIoC
 untr4Ml+qQe+qUi4KiVZHxZc4ksEtVGJM+M2M1m5eWKSsH6ro18m83VxwIUG9wO/zaTXhcN9Q
 BIseLQPy0GpWAizcSGcMJRSphKi0L1lpA8s5gun/2vnGdODyhxpQ+/c5uvkt39RS+rQhRC0oV
 qnK81Tpt/s0/9H2m0l0P4rQSp5X31mnErnT928yJgHqrheNyZf+CO4nGTrDpPugHBGAYZxHWT
 A/EaI5L/4E1IIPyeZyojSXhzhC14qYZaE5mod9OrM27oZTHaF4LdwItpQVG04r+YdeMls9lzB
 PLs2UY89iS7GDk/z8LJT94XLE/yTwTMT9Ic86GnrLGHjOZ6yQKD6H3M1eOW50YkMgsyEJE55H
 3VGbKgADbhvSMBIIeQYTM5o3ySKVxJahhvnWuo03CDgrDxLeu/1ab/qcifgFym2vQ4/viV/4J
 2P7XcX82JBOOak0Md6eQA34WASL3sOIKjWdJFRkjS34vHvrqJfHOWJXrXQUA+QrWiLN1OCKhD
 OUNGN8PCgxOUOZWtjnQI0Lxr8aJ4mCl+SohLxxoXPR9TfqFMcpU8zkuKENsvfLSOUNAxMm1HV
 6gwvKlVpYZ/bS5RahuNeXrXc73uA3rR1f5ZXOzOdgqm9O+p3k9jnMU/6Jly5DjvpXkAjUy5/g
 n0u9+s9o3EXSMOKd9i9PdT00jcC0x7u6Bx5OIpD7mLGXH/yWoYAmKxkbRCqbC0VAQ8km1QUar
 nSu9oOXy+xTbPYYyvKDn03GyxvDQ1QBP3LQlSg53XHBzuHnDTg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[My SMTP server still refuses to accept emails to rpjday@crashcourse.ca
 and reports "mailbox unavailable" and "invalid DNS MX or A/AAAA resource
 record."  So just replying to the list.]

Am 08.10.2017 um 13:56 schrieb Robert P. J. Day:
>    but as i asked in my earlier post, if i wanted to remove *all* files
> with names of "Makefile*", why can't i use:
> 
>    $ git rm 'Makefile*'
> 
> just as i used:
> 
>    $ git rm '*.c'
> 
> are those not both acceptable fileglobs? why does the former clearly
> only match the top-level Makefile, and refuse to cross directory
> boundaries?
> 
>    $ git rm -n 'Makefile*'
>    rm 'Makefile'
>    $

Try:

	$ git rm -n '*Makefile'

The whole path is considered.  The asterisk there matches any
directory part -- but also any file name prefix.  Check the entry for
"pathspec" in gitglossary(7) for more details.

René
