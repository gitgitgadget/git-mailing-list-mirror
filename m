Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DB31FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdJXS0y (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:26:54 -0400
Received: from mout.web.de ([212.227.15.14]:49953 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbdJXS0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:26:53 -0400
Received: from [192.168.178.36] ([91.20.60.28]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiCrz-1dSYQI3BND-00nPBe; Tue, 24
 Oct 2017 20:26:45 +0200
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
 <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
 <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
 <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
 <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
 <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net>
 <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
 <437f4e47-fcb1-ff8c-3c5a-fa9a5cecedfe@web.de>
 <xmqqh8usg0cs.fsf@gitster.mtv.corp.google.com>
 <7c53071a-5154-1246-d2f1-1064e3f923d4@web.de>
 <xmqqbmkxbc45.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <85e7beba-6f37-423b-24f1-2ad9da389846@web.de>
Date:   Tue, 24 Oct 2017 20:26:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmkxbc45.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:vQ9lKB7G1xpTs2REHK0Jd3p1VouffphSi6omVYR6/oN/qDSNbEr
 IlN626P/UCTP0M0wzhArzN1M78hBbI/f1kQixAO1v/Wfvy1Q6LWkSPATpTAYl3GWrt9vDig
 2NIocJtY2lhQPAO67wN02JK7R5KK/7C+n9MU3r87qIZW+BMNryWnEwMfUVM3rzQQJ27A8+a
 43t8y7ErbsbkHYd//0M0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q67FW1mEH7M=:6FYdALDz9VIdnEckdrVnGp
 MLatk3wlQgVmFF1rquhSQTzVFc0nbqh4WJTOys3UNuLalYqVbW9A2CC9JDQn1S//c1Xx86O2q
 lWbZ0B7xbmUvX3GmINlGbCiq+RYyXbj1mE9RSEIZh1UAqcNOn00TpI3QzImd7wdasy+KfpXDC
 KJj40N4EC0v+c6iNyyURCbFAHlK5W3aOFhl0C+nXyNHnAvtmbyV+TafmUQkmF99Z7yLhTEM1J
 Pt8DQCyQpj/pzhJCI3lO2AYWh8HOsE6Bjxb5J+dBcwCCcbGmHKzaOcTI8ivey0ZIPE6IYzJpt
 KnSWlNg7ow0M/4/yycy3iGMzay1USjPZV9g5Q/k86Kdo/Cw3+zRMHahyUQcXWD3nx0rHe0huQ
 h2mLUKjF7QhCCLcd/ZL3lOFOi/2Vese0pN9DQomQNk96u+r41LJACbjk3ncizLMEh6dlln53w
 EdopkTyJMjgMOjl/j8N1ijP2lb9tkB8LrlC8Q7x64HElFasLciJCgjPO2oTWF2BkvGL/AelTu
 q7pZMQqt90oVUDSZOfCC/1Z3Dl959opwP8cvQwOU2y7BBzFq8BpxC+QCpTy1bFSK6d9Bm3G47
 PHpX1jLfWX74XF/KYGbLuJfOUGRK5ksEjUgiwGEYTEZVB2MkwKD+bmveGMed+qq6/kuf0Ymj+
 QJd7yZ+hZCnPDcGOK35uG5eKzXBCjo4SkEfbueTWbmvN64xTq/tb1CMe68KXVL3qDpQKC5xUE
 558XzbC7GiWyv4+zZfYXdiV+c4Pez0QPm301Srsb60OCjM4rH5aw8PypTZ4n/fIElFUtij0mZ
 VvIB9gwyHXUmp74gwt+vL2L5wTmkX1rb/45K1wZwlOubru0w0c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2017 um 02:52 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 21.10.2017 um 14:18 schrieb Junio C Hamano:
>>> René Scharfe <l.s.r@web.de> writes:
>>>
>>>> FWIW, I use "-?" for that everywhere.  I have yet to find a command or
>>>> environment where it does something dangerous.
>>>
>>> Yeah, it would have made the world a better place if we made that
>>> choice back in 2008.  If we start a transition to make it so right
>>> now, we might be able to make the world a better place by 2022,
>>> perhaps.  I am not sure if the pain during the transition is worth
>>> it, though.
>>
>> "-?" works fine with builtins already -- they complain that the option
>> is unknown and then show the short help text.
> 
> Ah, I misunderstood what you meant, then.  I thought you were
> advocating to move the built-in short-help support to know about and
> explicitly react to "-?", and somehow forgot that it "works" more or
> less already.

I don't mean to advocate here -- it's more like trying to get the
accounting right.  A little bit of OCD perhaps?

> The fact that "-?" already works for most things is good, but the
> transition pain still remains, as what's costly is to transition
> people's expectation (i.e. "'-?' and not '-h' is the way to get
> short help from any subcommand"), not the implementation to fill the
> gaps for those that do not yet support '-?', I am afraid.

A minor cost for help-seeking users would be the extra error message at
the top of the short help text.

The main change would cause "git ls-remote -h" to show remote heads and
"git show-ref -h" to show HEAD.  Confused users would have to resort to
e.g. man, -help, --help, their search engine of choice, or -?.  I feel
this could be justified.  It would be different if e.g. reset started
to take -h as shorthand for --hard, as this would cause data loss.

The hard part would probably be allowing the execution of commands with
unknown arguments outside of repositories to show the help text, even
if they'd normally (with correct arguments) require one.  Converting
all commands from RUN_SETUP to RUN_SETUP_GENTLY seems painful.  Showing
help when a required repo is not found might be possible somehow.

With that I'm going to shut up, as I don't even use the affected
commands, nor can I imagine being in the place of someone impacted by
"git <something> -h" not showing a help text.

René
