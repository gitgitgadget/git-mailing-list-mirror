Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F11020966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbdDENFi (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:05:38 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41207 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933071AbdDENEf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2017 09:04:35 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id BC797600050C;
        Wed,  5 Apr 2017 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from
        :subject:to:references:cc:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        jupiterrise.com; bh=0qE7SzXuCHWco/zAyTRH1lJBS0o=; b=hobzAeKtxjtn
        KqBP23GCSvyaPxQ48wSAFqreua2DutwymncD+PY3vYVbaQavtw78Ckft40INTBAE
        Bvic3jOKo30cVx6+YIB4LqNWZhA3LOodAW3ixsxS7ysmTAxJfVfOYvZxyM0+BRvu
        r/vR5G8vM0ihn+UqawcqAoXhKsHPRKw=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 48B686000504;
        Wed,  5 Apr 2017 06:04:34 -0700 (PDT)
Received: from [172.18.98.35] (nat.statsbiblioteket.dk [130.225.26.33])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 98FB4612DA;
        Wed,  5 Apr 2017 15:04:32 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
 <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Message-ID: <4e30ae33-d508-9bb8-74e6-8204967c4538@jupiterrise.com>
Date:   Wed, 5 Apr 2017 15:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/04/17 12:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Apr 5, 2017 at 11:33 AM, Tom G. Christensen <tgc@jupiterrise.co=
m> wrote:
> Whoah. So my assumption in
> <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
> that nobody was compiling this & thus not reporting failures was
> false. Rather there's an entire community & distribution mechanism
> around patching git for older EL versions, but the patches aren't
> making it upstream.
>

The community as I know it consists of me and EPEL5 (now dead and archive=
d).
The packages that I build are probably only used by me and the company I=20
work for as they are not exactly easy to find via search engines.
EPEL5 supported git 1.8.3.2 but the Fedora git specfile still contains=20
all the infrastructure though I cannot know if it actually got used with=20
anything later than 1.8.3.2.

I don't know of anyone that actually *needs* to use the latest git on=20
RHEL < 5, myself included. I kept the support for RHEL < 5 because I=20
could and it was good fun to tinker with.

Also I should say that testresults are good, no problems there except a=20
few small nits as revealed in the specfile:
%if %{?el4:1}0
# These tests fail with subversion 1.1.4
export GIT_SKIP_TESTS=3D"t9140.4"
%ifarch x86_64
# These tests fail with subversion 1.1.4 but only on x86_64
export GIT_SKIP_TESTS=3D"$GIT_SKIP_TESTS t9106.7 t9106.8 t9106.9 t9106.10=
=20
t9137.4 t9164.5 t9164.6 t9164.7 t9164.8"
%endif
%endif
%if %{?el3:1}%{?el4:1}0
# not ok 6 - url high-bit escapes
export GIT_SKIP_TESTS=3D"$GIT_SKIP_TESTS t0110.6"
# not ok 32 - ref name 'heads/foo' is invalid
export GIT_SKIP_TESTS=3D"$GIT_SKIP_TESTS t1402.32"
%endif
%if %{?el3:1}0
# t7800 failed 17 among 56 test(s)
export GIT_SKIP_TESTS=3D"$GIT_SKIP_TESTS t7800"
%endif

It's been a little while since I did a build without those exclusions=20
but I doubt much has changed.

> $ grep -h -e ^Subject -e ^Date *patch
> Date: Tue, 13 Oct 2009 11:34:11 +0200
> Subject: [PATCH 1/7] Make NO_PERL_MAKEMAKER behave more like
> Date: Fri, 13 Jun 2014 11:02:02 +0200
> Subject: [PATCH 2/7] Install man pages when NO_PERL_MAKEMAKER is used
> Date: Mon, 22 Sep 2014 13:42:50 +0200
> Subject: [PATCH 3/7] Allow svnrdump_sim.py to be used with Python 2.2
> Date: Tue, 8 Mar 2016 09:31:56 +0100
> Subject: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7
> Date: Tue, 23 Aug 2016 10:32:51 +0200
> Subject: [PATCH 5/7] Add support for gnupg < 1.4
> Date: Tue, 23 Aug 2016 18:15:13 +0200
> Subject: [PATCH 6/7] Handle missing CURLINFO_SSL_DATA_{IN,OUT}
> Date: Tue, 23 Aug 2016 18:26:54 +0200
> Subject: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0

All original work done by me.

> Date: Wed, 2 Feb 2011 21:24:44 -0500
> Subject: [PATCH] Restore vc-git.el for basic compatibility on EL-5
> Date: Mon, 23 Mar 2009 00:03:36 -0400
> Subject: [PATCH] git-cvsimport: Ignore cvsps-2.2b1 Branches: output
>

These two I can't claim credit for. They are lifted verbatim from=20
Fedora/EPEL and as the headers reveal they were created by Todd Zullinger=
.
I won't submit them for inclusion since I am not familiar with nor a=20
user of the parts they touch.

>> Patches can be found in the src.rpm, though I can also post them here =
as
>> patch series, they cover more than just curl.
>>
>> I don't use the el3 and el4 versions much any more and el5 use will al=
so
>> drop of now as I'm busy converting machines from el5 to el7.
>
> It would be great to have them on-list, as far as I can tell they were
> never submitted? Is there some time/administrative reason for why
> you're not submitting them?

Well I recently took the time to clean them up with the intention of=20
maybe finally submitting them but I never got that far.

The first one in the series I actually submitted many years ago but it=20
was ultimately rejected.

I've submitted a few patches over the years to support older RHEL=20
releases and some of them ended up being included.

> Some of these are many years old, it would
> be great to have them on-list for wider review & included so vanilla
> git works on these platforms.
>

I just posted them now. The series was made against the v2.12.2 tag.

-tgc
