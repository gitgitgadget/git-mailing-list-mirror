Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12289207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 09:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997093AbdDZJ0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 05:26:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:62767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1961798AbdDZJRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 05:17:18 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LnBK1-1dkdV70aw1-00hLqS; Wed, 26 Apr 2017 11:17:12 +0200
From:   Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] tests: remove the GETTEXT_POISON compile-time option to
 test i18n marking
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqwpaa38o2.fsf@gitster.mtv.corp.google.com>
 <20170424110434.27689-1-avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Message-ID: <4bd88c83-1892-8fc2-981f-f31cfd1b4c87@grubix.eu>
Date:   Wed, 26 Apr 2017 11:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <20170424110434.27689-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:lRS3iOi4XHjjw/i0sJwgOYtF6+a65+aObRNxqxcUA4nPC/9WOxw
 rjR58o3yn8vXXsozbHIiV/rac1lOUGUDO8TQyKJJ7/oWy9zGtLqjsJcWP+3Iknpkw7/GkYu
 7DS799TR7hXWKM9sZ7iKlp/kpvfWhcOqiXrbKxPPWR+fkmGGfKn59uvTXOykbBeskgBHyR2
 agq0WfjV6M4O77HL6tKdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1NUKTh3moN8=:38Q6WyXET2Bo/9QEzZB/1v
 aUMNCobjAhG2PziQCnR74aoJRZx/LAwh57tie+YvuNDJrL1Ji1KsqWjcAZc8nJezSj58u37HU
 U0CdUwvx4AENs3S3AF0DQutJzkrhspXb+43qGMsd8hOonPQd8yHA+Wz3X1vZMlahEBP75HRRG
 teBi6DlmCM3IYUyRuTecslvdyI3dfPNWhfoVnUmRpAPdBuM5XBivpA4yBx2f31TIFqkRDIpUF
 QFUi68lUMjcTqWCj+dvzXuUuUXs+EjrkCK1MGco3MfXy2WTiRINA4JINhXvqj9Iq+RWN7aNfC
 zR6VmcR/RsgWOL1yPh3lU5M/VAh3KRn9wFuuNAlj9xAa69tW47o+ol+dM9g05V4aEUhDShfsR
 22asSv/fyXwc2A+oXO2dI5oKpb1roI1BvLOo12YesTD4s5hwZCKtBdramHVPXnSvL3fLN02fx
 B+rIcg1mIhdyxUuRX45TwGrlG0MD93v7sTa2d///fLktPyJb6IYWBaj3WORDjedN5Bs7YnCZR
 ZleEZjKjGsguZ8FufO/vwalPD/bead6txy8TbFwA7JXVO0pCqE6X3APBOf91KRZ+a6qlBrmyW
 axeOyUpX75Q0nyrHXfEgO2ij3C4z17H1iWxh04Qk9PcMq55rI4j4h+S52wKJkbxb4kAI3GTRE
 cWkNwNga5YW4DoSR463lvPPvQGIwegqO+PKS4/lXJ8iXL6D2LibJWkzO9pse26sFG+dYjjAnS
 lrnN1KfnU+5T3Nkp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Turns out I still can't operate gmail's web interface. Sorry for the dupe.]

2017-04-24 13:04 GMT+02:00 Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
> Remove the GETTEXT_POISON=YesPlease compile-time which turns all of
> git's LC_*=C output into strings like "# GETTEXT POISON #" instead of
> gettext(msgid).
>
> See commit bb946bba76 ("i18n: add GETTEXT_POISON to simulate
> unfriendly translator", 2011-02-22) for what this was originally
> intended for.
>
> This facility has been broken for quite a while and has been subjected
> to frequent bitrot. The initial idea behind it back when it was added
> in 2011 was to prevent the accidental translation of plumbing
> messages.
>
> This isn't a big concern anymore as git isn't mass-adding i18n
> messages for a newly developed i18n facility as it was back then,
> maintaining this facility incurs a burden, and in actuality this has
> often been broken long enough for potential plumbing messages to be
> translated & make their way into major releases anyway.
>
> Most of this patch consists of search/replacing the test suite for:
>
>     test_i18ngrep ! -> ! grep
>     test_i18ngrep   -> grep
>     test_i18ncmp    -> test_cmp
>
> 1. <AANLkTi=5MrU-JyeQ3UVNbVwzn-8FbstUXafgcQaLWXDB@mail.gmail.com>
>    (https://public-inbox.org/git/AANLkTi=5MrU-JyeQ3UVNbVwzn-8FbstUXafgcQaLWXDB@mail.gmail.com/)
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> On Mon, Apr 24, 2017 at 3:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael J Gruber <git@grubix.eu> writes:
>>
>>> Ævar Arnfjörð Bjarmason venit, vidit, dixit 20.04.2017 23:58:
>>>> As a refresh of everyone's memory (because mine needed it). This is a
>>>> feature I added back in 2011 when the i18n support was initially
>>>> added.
>>>>
>>>> There was concern at the time that we would inadvertently mark
>>>> plumbing messages for translation, particularly something in a shared
>>>> code path, and this was a way to hopefully smoke out those issues with
>>>> the test suite.
>>>>
>>>> However compiling with it breaks a couple of dozen tests, I stopped
>>>> digging when I saw some broke back in 2014.
>>>>
>>>> What should be done about this? I think if we're going to keep them
>>>> they need to be run regularly by something like Travis (Lars CC'd),
>>>> however empirical evidence suggests that not running them is just fine
>>>> too, so should we just remove support for this test mode?
>>>>
>>>> I don't care, but I can come up with the patch either way, but would
>>>> only be motivated to write the one-time fix for it if some CI system
>>>> is actually running them regularly, otherwise they'll just be subject
>>>> to bitrotting again.
>>>
>>> I use that switch when I change something that involves l10n, but
>>> usually I run specific tests only. To be honest: I have to make sure not
>>> to get confused by (nor forget one of) the build flag GETTEXT_POISON and
>>> the environment variable GIT_GETTEXT_POISON. I'm not sure I always
>>> tested what I meant to test...
>>
>> To be quite honest, I have always felt that we are just as likely
>> inadvertently use test_i18ncmp when we should use test_cmp (and vice
>> versa) as we would mark plumbing messages with _() by mistake with
>> this approach, and even with constant monitoring by something like
>> Travis, GETTEXT_POISON may be able to catch mistakes only some of
>> the time (i.e. when we do not make mistakes in writing our tests).
>> Without constant monitoring, I agree that the mechanism does not
>> work well to catch our mistakes.
>
> Here's an alternate patch to just remove it entirely. I think we
> should apply this instead, the only reason I sent the patch to fix it
> up was because of Michael's comment that he was occasionally using it.

Yes, I think test_i18ngrep and test_i18ncmp gave the impression that
they are i18n-aware grep and cmp, whereas in fact they turned off
these tese test lines completely.
Combined with the fact that GETTEXT_POSON builds turned on
GIT_GETTEXT_POISON, this sounds somewhat dangerous - we test more
aspects of plumbing commands but turn off (some) tests for porcelain.

I'm still wondering wether we couldn't generate a test locale
automatically by mangling the english strings (but preserving format
specifiers). That way, tests that test porcelain output could require
LANG=C while others could run in the mangled locale. (tt_TT is taken,
though ;) )

Michael
