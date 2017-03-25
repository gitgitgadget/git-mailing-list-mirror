Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BBD2095E
	for <e@80x24.org>; Sat, 25 Mar 2017 16:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdCYQ5r (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 12:57:47 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:32771 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdCYQ5r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 12:57:47 -0400
Received: by mail-lf0-f47.google.com with SMTP id h125so5908641lfe.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ULC6PS1SYN69FfuMLFF3sVq0aCK2eGL7SzgIusxTP8w=;
        b=a9HMoeZnSRA87RAhbqC4B95G074pP3TFR1LbLbr7ZcuRYeSfBjz9lYMCfqetRLCPPx
         9s86Q2p9ty/yrtjPAQ8ciiNckD50Pzgk3pEw5OqJXLirEpbm5dd/5mWoQrdl7AUpXZ4g
         xVnaeTv8PfkCPpLQWTQ3fFy6PK3OWQPFCfqZpfMtmo8e8MrpJd7g4p9oUbt081NuMknF
         uOa09EXUUDtHAU7ggt80AaTKJZ6p/G54owSkrPc3geuEQj0mJ0iKb3C7A06NUzSVIGDE
         me2LLuT+Nf9Daq5ehhq8oWJkVP5CK7X9sKdBtEcuNDqouskgT0Wz4ltCXVGzgmjZsQr1
         ZfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ULC6PS1SYN69FfuMLFF3sVq0aCK2eGL7SzgIusxTP8w=;
        b=Whfwi0MwhRyK7LdbedtHQ77WlcUjLb4k4/es6g7PfTI4SffXqD2URzKr5/ie05IWW6
         qrYnjsT/LgyR5VsdnCEjqZPicLdHjqk/TlNKmAFAvHktlWNkd0WqSV6YoLsNzvU73Cds
         VaX0cy6x2AXR/L3+jOXS1W0yB23pQJi1CxAHZsMLvzbzt0EVCIswQvfTvEcDNb0TwvgZ
         g3xGCGT8hLSP8zr/IDb8iWDFgD2sPso/tqTF5Rt+6j55FC3xlGbcmA91GQ4pnVCcWMqR
         c/02OGa1rB16ppEFmCFpXWOtMDkxhOGOf7W81R5WAL/Cvw0tJmNZqmaJoJNww0AFlpRB
         wr2w==
X-Gm-Message-State: AFeK/H3vpF809anvIHq1YxG+XEcGEQLiKAf1EIK/pmTnNSfx8dHYL0rxO2bejLBLmSzhQ0yU2TbF+H6BYPfCQA==
X-Received: by 10.25.80.86 with SMTP id z22mr6369166lfj.157.1490461064534;
 Sat, 25 Mar 2017 09:57:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.160.208 with HTTP; Sat, 25 Mar 2017 09:57:43 -0700 (PDT)
In-Reply-To: <CACBZZX4Haah8JmSG6BbfpdOA1aAxtjiuYirLH4=jt01kHL4eQA@mail.gmail.com>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
 <CACBZZX7dXsdu0bwt4Rznregw4=v=Sc3cFTQbxJcb-ynf3HXq3Q@mail.gmail.com>
 <CANgJU+UG1JGYomyQa1FgyN8Q6SkPeEtGKEJfNETrkbtGwrMn9g@mail.gmail.com> <CACBZZX4Haah8JmSG6BbfpdOA1aAxtjiuYirLH4=jt01kHL4eQA@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 25 Mar 2017 17:57:43 +0100
Message-ID: <CANgJU+WR4L-7-r97od7ids6VK9QyO-QzAntbg7SazmPGj0yWXA@mail.gmail.com>
Subject: Re: Will OpenSSL's license change impact us?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 March 2017 at 17:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
> On Sat, Mar 25, 2017 at 10:43 AM, demerphq <demerphq@gmail.com> wrote:
>>
>>
>> On 25 Mar 2017 10:18 a.m., "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <ava=
rab@gmail.com>
>> wrote:
>>
>> On Sat, Mar 25, 2017 at 9:40 AM, demerphq <demerphq@gmail.com> wrote:
>>> On 25 March 2017 at 00:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com>
>>> wrote:
>>>> They're changing their license[1] to Apache 2 which unlike the current
>>>> fuzzy compatibility with the current license[2] is explicitly
>>>> incompatible with GPLv2[3].
>>>
>>> Are you sure there is an issue? From the Apache page on this:
>>>
>>> Apache 2 software can therefore be included in GPLv3 projects, because
>>> the GPLv3 license accepts our software into GPLv3 works. However,
>>> GPLv3 software cannot be included in Apache projects. The licenses are
>>> incompatible in one direction only, and it is a result of ASF's
>>> licensing philosophy and the GPLv3 authors' interpretation of
>>> copyright law.
>>>
>>> Which seems to be the opposite of the concern you are expressing.
>>
>> The Apache 2 license is indeed compatible with the GPLv3, but the Git
>> project explicitly uses GPLv2 with no "or later" clause
>>
>>
>> Read the paragraph immediately (I think) after the one I quoted where th=
ey
>> state the situation is the same with GPL v2.
>
> My understanding of that paragraph is that it's still laying out
> caveats about exactly how GPLv3 is compatible with Apache 2, when it
> is, when it isn't etc. But then it goes on to say:
>
> """
> Despite our best efforts, the FSF has never considered the Apache
> License to be compatible with GPL version 2, citing the patent
> termination and indemnification provisions as restrictions not present
> in the older GPL license. The Apache Software Foundation believes that
> you should always try to obey the constraints expressed by the
> copyright holder when redistributing their work.
> """
>
> So they're just deferring to the FSF saying it's incompatible, the
> FSF's statement:
> https://www.gnu.org/licenses/license-list.html#apache2 "this license
> is not compatible with GPL version 2".
>
> Anyway, I'm not a lawyer. Just thought I'd send some E-Mail about this
> since I noticed it, if it's an issue (and we could e.g. get the SFC to
> comment, Jeff?) we might need to add e.g. some checks / macros to
> ensure we're not compiling against an incompatible OpenSSL.

Just for the record this what Apache says, with the part I was
referring to earlier in slash style italics, and a couple of a key
points in star style bold:

----quote----
Apache 2 software *can therefore be included in GPLv3 projects*,
because the GPLv3 license accepts our software into GPLv3 works.
However, GPLv3 software cannot be included in Apache projects. *The
licenses are incompatible in one direction only*, and it is a result
of ASF's licensing philosophy and the GPLv3 authors' interpretation of
copyright law.

This licensing incompatibility applies only when some Apache project
software becomes a derivative work of some GPLv3 software, because
then the Apache software would have to be distributed under GPLv3.
This would be incompatible with ASF's requirement that all Apache
software must be distributed under the Apache License 2.0.

We avoid GPLv3 software because merely linking to it is considered by
the GPLv3 authors to create a derivative work. We want to honor their
license. Unless GPLv3 licensors relax this interpretation of their own
license regarding linking, our licensing philosophies are
fundamentally incompatible. /This is an identical issue for both GPLv2
and GPLv3./
----quote----

I read that as saying that you can use Apache 2 code in GPL projects,
but you can't use GPL code in Apache projects. Which makes sense as
Apache 2 is more liberal than GPL.

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
