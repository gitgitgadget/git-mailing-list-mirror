Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74ED81F404
	for <e@80x24.org>; Sun, 11 Mar 2018 17:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeCKRec (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 13:34:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34662 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932167AbeCKReb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 13:34:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id o8so13440232wra.1
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3p4ET9OoUmSWvbw8BQwozvy1r/xjR990iBGkbpOC/T0=;
        b=UO0tA1LTOJO963H3Y/nKC0acaKwyK0XtLImI1DjF83zlB7InmQufiC/BsleofEeRnY
         T2AfKZL/IpnhBkPqikmjyygDwTtxIFcETqg1YRyNARzwcpbXxyVEujtLua9dh9SLOBce
         TgvBJwf56G5kn1voPgE630TiYwgxTk+KaUNPt+Gchv7jcwsrZKclUDCfuRM1KDnGS00g
         8AfiS2+7RQOGACFHdLYBI3+Z7kZUK5OSrxgvCHUstXmUBq3KapBtFvLxBIUwIrvOKt9F
         QfhKIMiGe6zo+jIXTJQRbaOQVxBzc+8J/OwWcuCRU8qAuYtAM8fa/YPGi9DswNEtntNx
         81OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3p4ET9OoUmSWvbw8BQwozvy1r/xjR990iBGkbpOC/T0=;
        b=Aq5nZ2qfGCviWmIMFUWViRpii66VUwfrUb8CYABdFpBE1QFvLGVzCGbmTugrHgfiff
         UdQ2eKMbtTPG6tVtJUzmRmFXRhtgO+zxs50Gh5hIS2pK954ePrffECL0pn04tJUlsuua
         qkug+W5EputbvrS1bvX+y3F/b5ObfE07R71dTGU/rfq+y0mBKX/jnTAdmRobvdNUYUGW
         OHJ3CjbmFwbig6nSeGreg2W6MMH3z6njBG9p8My//yj+memieC0ibW0ggWtA1dnymHaS
         HWlhlpj0J7YXt7ayNkrEafPey3K83/4faaO9Ubxshkqx4S/jxsAQGMNzox1J5cbfHK6Z
         08Dw==
X-Gm-Message-State: AElRT7EANEh5LcSoHDXLvrxr7vmUeFM1SZTZJHjHQxd+ku60skpTHl8I
        qQIQdj/jpmg3G4Cdb5pn6Sc=
X-Google-Smtp-Source: AG47ELvwl8D2EsO5vxlBbN/F+4gZ8nAHCdM1jPmFVy1RWWvg6by+0u8SbieeBQr2+LlM4MsHaiq9TQ==
X-Received: by 10.223.145.33 with SMTP id j30mr3879986wrj.172.1520789669950;
        Sun, 11 Mar 2018 10:34:29 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id i127sm5051595wmf.33.2018.03.11.10.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 10:34:29 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
 <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
Date:   Sun, 11 Mar 2018 18:34:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 11/03/2018 13:08, Johannes Schindelin wrote:
> 
> > Hmm, funny enough, `pick <original merge>` was something I though about
> > originally, too, feeling that it might make more sense in terms on
> > what`s really going on, but I guess I wanted it incorporated into
> > `--recreate-merges` too much that I tried really hard to fit it in,
> > without changing it much :/
> 
> The `pick <original-merge>` syntax is too limited to allow reordering, let
> alone changing the parents.

I agree, `pick <original-merge>` syntax alone is never what I had in 
mind, so it`s missing further context here, touched in that other 
subthread[1]. My fault, sorry for confusion.

> >   pick <original-merge> <original-parent1>:HEAD <original-parent2>:<new-parent2>
> 
> I do not really like it, as it makes things a ton less intuitive. If you
> did not know about this here discussion, and you did not read the manual
> (and let's face it: a UI that does not require users to read the manual is
> vastly superior to a UI that does), and you encountered this command:
> 
> 	merge deadbeef cafecafe:download-button
> 
> what would you think those parameters would mean?
> 
> Granted, encountering
> 
> 	merge -R -C deadbeef download-button # Merge branch 'download-button'
> 
> is still not *quite* as intuitive as I would wish. Although, to be honest,
> if I encountered this, I would think that I should probably leave the -R
> and the -C deadbeef alone, and that I could change what is getting merged
> by changing the `download-button` parameter.

Agreed, encountering mapping is slightly more complicated, but I 
would argue it`s much more powerful at the same time, too, thus 
pretty much worth it.

Without it, actually, it seems like we`re repeating the mistake of 
`--preserve-merges`, where we`re assuming too much (order of new and 
old parents being the same, and I guess number of them, too).

Oh, and as we`re still discussing in terms of `merge` command, using 
(elsewhere mentioned[1]) `pick` instead, it might be even less 
non-intuitive, as we`re not married to `merge` semantics any more:

	pick deadbeef cafecafe:download-button


And might be calling it "non-intuitive" is unfair, I guess it would 
rather be "not familiar yet", being case with any new functionality, 
let alone a very powerful one, where getting a clue on what it does 
at the beginning could do wonders later.

Sacrificing that power for a bit of perceived simplicity, where it 
actually assumes stuff on its own (trying to stay simple for the 
user), doesn`t seem as a good way to go in the long run.

Sometimes one just needs to read the manual, and I don`t really think 
this is a ton complicated, but just something we didn`t really have 
before (real merge rebasing), so it requires a moment to grasp the 
concept.

But I`m still not sure if there isn`t a better way to present 
explicit mapping, just that <old>:<new> seemed as the most straightforward 
one to pass on the point for the purpose of discussing it.

And I`m not reluctant to simplifying user interface, or for dropping 
the explicit mapping altogether, even, just for carefully measuring 
what we could lose without explicit mapping - think flexibility, but 
ease and correctness of implementation, too, as we need to guess the 
old merge parents and which new one they should correspond to.

> > p.s. Are we moving towards `--rebase-merges` I mentioned in that 
> > other topic[1], as an add-on series after `--recreate-merges` hits 
> > the mainstream (as-is)...? :P
> 
> That's an interesting question. One that I do not want to answer alone,
> but I would be in favor of `--rebase-merges` as it is IMHO a much better
> name for what this option is all about.

Saying in favor of `--rebase-merges`, you mean as a separate option, 
alongside `--recreate-merges` (once that series lands)?

That does seem as the most clean, intuitive and straightforward 
solution. Depending on the option you provide (recreate vs rebase), 
todo list would be populated accordingly by default - but important 
thing is "todo list parser" would know to parse both, so one can 
still adapt todo list to both recreate (some) and rebase (some other) 
merges at the same time.

Of course, this only once `--rebase-merges` gets implemented, too, 
but as we had waited for it for so long, it won`t hurt to wait a bit 
more and possibly do it more properly, than rush it now and make a 
confusing user interface, needlessly welding two functionalities 
together (rebase vs. recreate).

But I guess you already knew my thoughts, so let`s see what other`s 
think, too ;)

Regards, Buga

[1] https://public-inbox.org/git/f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com/
