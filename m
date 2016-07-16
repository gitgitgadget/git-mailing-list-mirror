Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77AE120195
	for <e@80x24.org>; Sat, 16 Jul 2016 05:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbcGPFvM (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 01:51:12 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37842 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcGPFvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 01:51:10 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so35422401ith.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:51:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CIqGJ/VXPHqcwsd1SAhLdGnKlMXoWWkyiCFE2wbnivk=;
        b=sVGuryC9eHds1ZzNQjOXOLxVgio31mTreXvwskiVNAXWHNjnibDNSz4GIFJpmJ/SWB
         BJlY3lYv3I3qAx754rfRk8yXBgC8K0aYwU+Vb9nR6nVIYt8R447ZhP0Z52Ij+xU+MaQe
         xfB4JrP6SQKDLi7//IySJYQVtakC7lWtJaoz2tsktfOVf+FDSyge/7DQXsIyrXQ4f2b9
         08WtnIBO0mU6Em8AdgGDvlCHUMO/lqNZ6FtPDfxDW3J6cxl+qBIx0zSqm4RIFNW6yNsk
         AWOEt/61nSA8iuzG+/R0zxGehsK0+VCpPQgaQIbuE2yfxYFYxMQU27zqQQT0DJ4LatKk
         hKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CIqGJ/VXPHqcwsd1SAhLdGnKlMXoWWkyiCFE2wbnivk=;
        b=ZWImNYNtD5fI7JWn/XdVc7fkHmlkxT4hMSECkcHClI7jjsngRshOAF9V1ZSil1/w0+
         1+HGRpnA8O7fOR9IEHSPVYcugj8Vy4jRQz2c3DIkyiyxdP40tDa2JHs2uxw3s4u4VlKG
         RGb9dXwtJALDPaD7i9Ad0Ox3dHRFrEzjR1wi2muKLbwu6vqJbU+bnXvlauNfHPDfpELs
         PomPv5G1mcSuHPHaLF1+iMkJPS/cKiPqRKkf8Q23f+xjy5FN+g2CrJ9wwyhwswy+KNdO
         bZi0zWU2LjYbXJKG6XcOsq9/LHOMiHYKpausuEsBO37ZXv1aM979qwDgZNBI6gqaN8WS
         LGtg==
X-Gm-Message-State: ALyK8tK71FNtEtpCml+llKN9c+E1b3D9q0rqs2lOp8Vhk3VjEY6sWqoNvZpxbEhJLWcMSlWs3WWxSejS+aW/ug==
X-Received: by 10.36.91.134 with SMTP id g128mr12922098itb.42.1468648269639;
 Fri, 15 Jul 2016 22:51:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 15 Jul 2016 22:50:39 -0700 (PDT)
In-Reply-To: <F003C6A7-CF52-4149-9A05-8DDA549BABEE@gmail.com>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com> <F003C6A7-CF52-4149-9A05-8DDA549BABEE@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 16 Jul 2016 07:50:39 +0200
Message-ID: <CACsJy8AdsMuFQuej+Z5uePWxq=u8C4dKYZLLMeZNKd8wXesmqg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.9.1
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, sytse@gitlab.com,
	Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 9:38 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 13 Jul 2016, at 22:43, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> It is somewhat disturbing that nobody seems to be regularly building
>>> on 32-bit platforms these days, which is the only reason I can think
>>> of why this was never reported until it hit a maintenance track.
>>> This should have been caught last week at f6a729f3 (Merge branch
>>> 'jk/tzoffset-fix', 2016-07-06) when the topic hit 'master' at the
>>> latest, and more preferrably it should have already been caught last
>>> month at 08ec8c5e (Merge branch 'jk/tzoffset-fix' into next,
>>> 2016-06-28).
>>>
>>> Those who care about 32-bit builds need to start building and
>>> testing 'next' and 'master' regularly, or similar breakages are
>>> bound to continue happening X-<.
>>>
>>> Volunteers?
>>
>> We might eventually see a volunteer or two but that hasn't happened
>> yet, at least in the past few days.
>>
>> Does Travis CI testing have an option to run our tests on some
>> 32-bit platforms?
>
> TravisCI does not support 32-bit platforms natively:
> https://github.com/travis-ci/travis-ci/issues/986#issuecomment-124141683
>
> However, there seems to be a way to enter a 32 bit Trusty chroot on
> 64 bit Travis via Docker:
> https://github.com/travis-ci/travis-ci/issues/5770
>
> @Duy:
> You mentioned that you compiled Git on Docker before ($gmane/297963).
> What do you think the chroot approach? Could that work? Would that
> be reliable?

"Docker chroot" is a weird term because they are not the same. If you
can launch a new docker process from travis-ci, I suppose you can use
a docker image with multilib support, then just run 32-bit binaries
and it should work (unless the host kernel is built to only support
64-bit).
-- 
Duy
