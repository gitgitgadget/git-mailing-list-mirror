Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6179E20195
	for <e@80x24.org>; Thu, 14 Jul 2016 07:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbcGNHi1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 03:38:27 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34663 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcGNHiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 03:38:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id p190so2916356wmp.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 00:38:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S3sYswXPGK5T0qzUBdt9IITfjKE/5qVbtoj7i7QJBAs=;
        b=0iueYLlajB64S7NczcDHP8rb7Cr+Nyr5BGmuamZRrMV/WzkBfFud97dNVgTVyEawLK
         kDYLvId1c6uGkFNhuyDb0hfJqcKqbDPAyzo4/VaqkiKkPHY5MCzesYt+X040FW3aAiqY
         GamJ/Dt6ldyiSSV/jepK/ZdMjs506u3kIcm1jv0kzYqsAORSOcW1vdeohLZft//crS9p
         sF3nQP5CL+QPj2eqAsA2bUxrmPAqDuRCVUGitwPumi2KiIoSqix5lvkyR3MfkpNILTGa
         4XpFChd9vtbWLtFBUhheG4UJJaZyfT851N0tdM+2HQJRUNNjgIHtfX3qcG8Lu89YawGt
         GbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=S3sYswXPGK5T0qzUBdt9IITfjKE/5qVbtoj7i7QJBAs=;
        b=Tc8bbCWx5jQxFSpwUNecuWikpuVRoh1Vpci8DbVE25JTAayrS7rmXn1Mbf/2FPgMr3
         LGsv22KExP22jGWQJG1pYWENPN/AgkrO6TeLf8jNqzW2JfOn6RFpr0/ifBsAoCvtK3sd
         D0jip72JlsjxbJsigiQiYdwnJhKNUp03d9mbcZfLWZSGsoOLZAdmH7ZlPa4cgjn230Ap
         oUiJWFzRFkYJDYtzmuNvwC0C0qoq58W8n1Hzvl0E7xbEVP1aoKO/bLC755lDlQ2/p7a+
         xIlwSytuTM69ELga1k59VSejLQiB4VQbqiTfLYuGy2akhyTOdTDrkMoR2wiBUzDuhRcZ
         wq6g==
X-Gm-Message-State: ALyK8tJzDDVWl5q9kkKxT7uVlWARQyYAqYfQNFFbohiRRK/PJfsKonI9GwDS5kUOuaHy+g==
X-Received: by 10.28.98.135 with SMTP id w129mr14013226wmb.38.1468481904111;
        Thu, 14 Jul 2016 00:38:24 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB41F1.dip0.t-ipconnect.de. [93.219.65.241])
        by smtp.gmail.com with ESMTPSA id yp1sm1022061wjc.6.2016.07.14.00.38.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 00:38:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [ANNOUNCE] Git v2.9.1
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com>
Date:	Thu, 14 Jul 2016 09:38:27 +0200
Cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <F003C6A7-CF52-4149-9A05-8DDA549BABEE@gmail.com>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>, sytse@gitlab.com,
	Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


On 13 Jul 2016, at 22:43, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> It is somewhat disturbing that nobody seems to be regularly building
>> on 32-bit platforms these days, which is the only reason I can think
>> of why this was never reported until it hit a maintenance track.
>> This should have been caught last week at f6a729f3 (Merge branch
>> 'jk/tzoffset-fix', 2016-07-06) when the topic hit 'master' at the
>> latest, and more preferrably it should have already been caught last
>> month at 08ec8c5e (Merge branch 'jk/tzoffset-fix' into next,
>> 2016-06-28).
>> 
>> Those who care about 32-bit builds need to start building and
>> testing 'next' and 'master' regularly, or similar breakages are
>> bound to continue happening X-<.
>> 
>> Volunteers?
> 
> We might eventually see a volunteer or two but that hasn't happened
> yet, at least in the past few days.
> 
> Does Travis CI testing have an option to run our tests on some
> 32-bit platforms?

TravisCI does not support 32-bit platforms natively:
https://github.com/travis-ci/travis-ci/issues/986#issuecomment-124141683

However, there seems to be a way to enter a 32 bit Trusty chroot on 
64 bit Travis via Docker:
https://github.com/travis-ci/travis-ci/issues/5770

@Duy:
You mentioned that you compiled Git on Docker before ($gmane/297963). 
What do you think the chroot approach? Could that work? Would that
be reliable?

@Sid:
Does GitLab CI support 32-bit platforms?

Thanks,
Lars
