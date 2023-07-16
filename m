Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6EEB64DA
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 11:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGPLrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPLrk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 07:47:40 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5A10E0
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689508051; x=1690112851; i=l.s.r@web.de;
 bh=DFJNigvwMMGc1hv7FjVeB5feRotIVwH1eqQ9bX+yxDc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=JjymcvYg1gpIB5r6eb+2WvPDjVWXR0i8vhWIY45nLbciSR/o8VE1rcOeMPUjkiwtBhc0DWa
 a84fq7wNZ3jRbWRVqxtWfs5KZrzLpcgdl8jbOn9vLIuO+cECMNdASEkNIuGHKw3J4fRtbsw0Y
 d1CYZ117fLJgBZicYN7+IUyT7VoP0GY2pbQ621TJ06tT6INjL4+4siJH8xeEPvMXc7Bt0SfW4
 wDTH9YZgnw41t/7SrP2moIC4gsTSYuZOEaOM1n7gjC5R/RVQYGE051BnZFiKY1vc5IgqIP5Mw
 LmxgHxF1xnE6Gqf4rb/hRiQMV9mcw40s+A5vVy0FK8U+q9ggn7NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.247]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1qV8Yq0CTr-00TJs7; Sun, 16
 Jul 2023 13:47:31 +0200
Message-ID: <1d36d5ce-f452-fc31-6e30-b4ba819de7e4@web.de>
Date:   Sun, 16 Jul 2023 13:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Git Privacy
Content-Language: en-US
To:     nick <nick@nicholasjohnson.ch>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CidzTD0QQQkvAL5jUIjV9AqwqkIvsyLJNkzbAFsTnbQdIGEnsVE
 zV2Rt+87OKD6ICLqR4Y7uNNpBeniRDccYdLt9wSR3oFoqb4dJMlGFLLObpADJASZ6+vxFZ+
 ShG96Hvyf1a/rTnKlT2Wc0I4cb1pbOVlEDuBvDC/TWvtxeOM2Ls5ZSr9OXKa0ZMCTCBMpIl
 nGqlx/CWpt3jeN4dMoMcQ==
UI-OutboundReport: notjunk:1;M01:P0:SvxlojXLWag=;AMS33acZeRnQx8UFmImF6qlGqEb
 y8G+Ul5+s2o/HSAHxVIlyIp470S1Uqw+s9O/xia+ipNxrUjFltVwSnTdPZLz9bNenjBLlsLGt
 Ka4a+So/Uxvq0gqmmd0sLWhYlx2T/JBMpbedEBlFKLsK6I1o4jp0GnVYWcybeL9dG1rZ5qipM
 AFzhvOMV1rFjM0VsUbsSpvm8QAhonMu3ViwVkc43m20HIMq6GPT+z5fBHKe059Z+T7OweShmS
 rzqux6g6gWucjcnG1xYb8thyKvHnCazQfJWk1BvNyrH+rtjUk5BH0exa/FFNyJXQlfxelpJym
 wvBRVvI3CFqXwkEfUyH9SPBrUjZebQCuXYGzMCpp97fVNtNvUpxEc2vV8Mce/nUHv/GKP5mLk
 9F3WjDSbdqOz7ngg9Adi0TLz3Ybi0Vg1zR5JbqUcl/J4fUSwyH3vlmrdv3TUJSa+cwBvRpSce
 Tj39JkRkmxo5XZyl0i9f9ZGpcXMDUMKaj05U67e0d7MvSb9X6nhYh1P09dkeflmus2SZ41FES
 g2vP+VJUwkEc6m/GUkeRimYpX3knUFIMbWdYGisSoJRHy+PwzIzAs6zPtAOZ2AaoS/ZNUHtMt
 qKiHRjvkEe11ykv1Xi0cvlCaZZNjWgZI4F8GP6TiklGWuv4lOPeP/dg+Hoe7q3HwWtErdjKG1
 vSNz3y2dZ+/5Z4XjYMFZUxBJPTWOmPRcoeGCZozXCzPK5ikw8NefgTkCRoRsVrELSmkehalOD
 DEeynCAPjeiKnhDw/JxCo2/u3B1cUCK1KnvWPgUX5u3vYUtmxqE0+QqbNlqPPGh8iJod98Fqt
 aGamKDIGv0Ib2arLYlOlvgtJJOisZg+3xKOPRzaT/6Hp5qlkNDo/adaIcojlhU2IneCC5pUtd
 6RQ8E4OHPSMLaM9zEcUini7yPtVQSQfYN4mdnevuUoS6KAqqasO8zUUZ0xG2AdK+aJn3Nhnqv
 zb18RQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.07.23 um 06:32 schrieb nick:
> Junio C Hamano wrote:
>> "nick" <nick@nicholasjohnson.ch> writes:
>>
>>> However, I think it is worth the effort for the time zones. Is there a=
ny
>>> reason Git doesn't automatically convert local time to UTC in timestam=
ps
>>> to prevent leaking the developer's time zone?
>>
>> Actually it is the other way around, if I understand correctly.
>>
>> Git could have been designed to discard that information like
>> previous version control systems, but it is another piece of
>> interesting information and made a conscious design decision to keep
>> it. In other words, "is there any reason why we do not discard the
>> information?" is a wrong question to ask in the context of VCS.
>
> I'll make my best case one last time and if it doesn't convince you,
> then I have nothing else to offer.
>
> Git leaks private information about developers publicly by design
> through its precise timestamps. You mentioned this makes it easier to
> deny copyright claims, but one could get more or less the same benefit
> without sacrificing privacy by rounding commit times to the nearest day.
> I'm not advocating making this behavior the default, just that
> developers be given the option to do it.
>
> The time zones reveal private information about developers and they
> don't even serve a use case, as far as I'm aware. A backwards-compatible
> way to solve this leak would be to convert timestamps to UTC by default
> and have a Git config option to revert back to the current behavior.

I get it to some extent: timezone and timestamps are personal data, which
may only be collected and processed for a lawful purpose according to the
GDPR.  Git works just as well with timestamps that omit time of day and
timezone, so is there a valid reason to collect that information?  At
least that's how I understand it, and I'm certainly not a lawyer.

But Git is not a legal entity, it's just a command line program that you,
the data subject, control.  You can use the  option --date or the
environment variable GIT_AUTHOR_DATE to set the author timestamp and the
variable GIT_COMMITTER_DATE to set the committer timestamp on commit.
Not sure why there is no command line option for the latter, hmm.

So I see this more as a usability issue.  Git allows its users to tailor
commits to suit their needs in many ways.  You can edit file contents,
history and metadata.  For timestamp and timezone this isn't as
convenient as it could be.  If git commit has a --signoff option that
can be enabled by default then adding config options for controlling
timestamp granularity is hard to say no to.

Ren=C3=A9

