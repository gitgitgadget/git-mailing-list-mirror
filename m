Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8665920188
	for <e@80x24.org>; Wed, 10 May 2017 19:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbdEJTyc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 15:54:32 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36254 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbdEJTyb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 15:54:31 -0400
Received: by mail-pg0-f48.google.com with SMTP id 64so2838107pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z9ZGwnc9BwsXQZX4hpjrpKlGXZ2BsytI6OUSp6D2l0Y=;
        b=RyyUsZXpYIQJjNJMw6hK53XO+2Qnvcd9EnWlBZVHw2g66iSTKl4iYB9DWER/0xKRNO
         X4VDPoOuaMPy4D1u5sMO9lDkoSoCzcTHjw3PkPsrMiEhgAueipGW/K+tKVoXr1xSFOBZ
         ySF2lvxz04vzVU42Vs53Qb1/T/Fe21isNERd+Lxr9ht9NInMd2lS1s7e8LtMDorqWzDQ
         cu0bJuuRlnCKHiV/gtzGIVL8v9mVWz6fOSkXA6SJilVdKZra8UnN1+jheaMo3a5Ldsj2
         ShMi8udiNgLR6urwrD5Ju3rWLE1O3xSZ3dHXaOQ+Q5jh9458ZCIeErFcagNJnzaiWOyT
         ffbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z9ZGwnc9BwsXQZX4hpjrpKlGXZ2BsytI6OUSp6D2l0Y=;
        b=IaZ9/E4Q5TX0XZDXmAufnzjyL271GMO1QIN0l27TNGqOrl03xPiMmhStLr/oSg6gCQ
         wGZFbb3T8uapo+7URDwB3cYaN9F8WsK7iu1szkyXR5Iv5lB4e4IEh5vR91wjX6j9WUn2
         kqs/Oi4I/upu+BX1J7bzlRZZYtUZ7s2UH4S4BBB3uXgBN2jvxxc+rn67Isb8b5t4d748
         jxz0xddhHQAHCsiyaupELAX+sko5CB6LIkSk5moJfwszOF3SyI63rwxkV8xgbp0QWNRQ
         Z0iGNtyUuWK9lffIOH1Ux/EgKAOSuvY1h+VdWuykLaQHag9LLLAg8NJZH+3GvZXgFAy2
         ms3A==
X-Gm-Message-State: AODbwcCb5ctl0fkmdsFZp4O704e4iZMhsdNneOxPUoFiL+7Bfe+zNqsS
        G23FwUxLimiipxYSwr28X/ej+FPyVeRBoz8nSQ==
X-Received: by 10.98.104.4 with SMTP id d4mr7919064pfc.94.1494446070423; Wed,
 10 May 2017 12:54:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Wed, 10 May 2017 12:54:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705101801300.146734@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com>
 <alpine.DEB.2.20.1704280010160.3480@virtualbox> <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
 <alpine.DEB.2.20.1704282205320.3480@virtualbox> <alpine.DEB.2.21.1.1705052227120.146734@virtualbox>
 <alpine.DEB.2.21.1.1705101801300.146734@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 May 2017 12:54:29 -0700
Message-ID: <CAGZ79kaAYU3cSRdXZTvukib3VNmx+_GdeSV5NkZ1g_OWt07i9A@mail.gmail.com>
Subject: Re: Automating Coverity, was Re: [PATCH 00/26] Address a couple of
 issues identified by Coverity
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 12:48 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Fri, 5 May 2017, Johannes Schindelin wrote:
>
>> On Fri, 28 Apr 2017, Johannes Schindelin wrote:
>>
>> > On Fri, 28 Apr 2017, Stefan Beller wrote:
>> >
>> > > On Thu, Apr 27, 2017 at 3:50 PM, Johannes Schindelin
>> > > <Johannes.Schindelin@gmx.de> wrote:
>> > >
>> > > > I still have to find the time to figure out one more detail: how
>> > > > to download and extract the Coverity tool (the .zip archive has a
>> > > > variable name for the top-level directory), and doing that only
>> > > > every once in a while, say, only when there is no previously
>> > > > unpacked tool, or it is already 4 weeks old.
>> > >
>> > > That is an interesting problem, which I ignored as the older
>> > > versions of their tools still works once they release new versions.
>> > > So I just manually check every once in a while if they have new
>> > > versions out there.
>> > >
>> > > So if you find a nice solution to that problem, let me know, please.
>> >
>> > I think I have a working idea (jotting it down in the editor,
>> > untested):
>> >
>> > [... totally untested snippet ...]
>>
>> And now I edited it and tested it. The code is now part of the script I
>> use for pretty much all administrative (i.e. recurring and boring) tasks
>> in the Git for Windows project:
>>
>>       https://github.com/git-for-windows/build-extra/commit/05b5342128
>
> Oh, I completely forgot to mention that I tried to set the FLEX_ARRAY
> constant to something quite large (I used 64k), but apparently that does
> not work as expected, Coverity still insists on complaining about strbufs.
>
> On a second thought, it is actually quite obvious why it does not fix
> those reports: STRBUF_INIT has nothing to do with FLEX_ARRAY. D'oh.

D'oh. I must have been living in an alternate universe for quite some time
as I seemed to have confused different things here.

Checkout this commit,
https://github.com/stefanbeller/git/commit/977f81d6dec4461a1a12da2df6c5c919b41129b4
that is cherry-picked for the coverity build. That fixes it.

That is about the only patch I apply before sending it off to coverity.
I am still contemplating a nice solution for FLEX_ARRAYs in other cases.

Thanks,
Stefan
