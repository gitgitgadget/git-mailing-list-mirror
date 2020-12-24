Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D77C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0ECD22288
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 15:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgLXPKC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 24 Dec 2020 10:10:02 -0500
Received: from elephants.elehost.com ([216.66.27.132]:20219 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgLXPKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 10:10:02 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BOF9EqI058890
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Dec 2020 10:09:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Pratyush Yadav'" <me@yadavpratyush.com>,
        "'David Aguilar'" <davvid@gmail.com>,
        "'Seth House'" <seth@eseth.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        "'Christian Couder'" <christian.couder@gmail.com>,
        <git@sfconservancy.org>
References: <5fdc18a91c402_f2faf20837@natae.notmuch> <20201218054947.GA123376@ellen> <5fdc7a7d3a933_f4673208d0@natae.notmuch> <20201219001358.GA153461@ellen> <xmqq1rfmqc8g.fsf@gitster.c.googlers.com> <20201221042501.GA146725@ellen> <5fe033e0ec278_96932089d@natae.notmuch> <20201221073633.GA157132@ellen> <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com> <5fe134eeaec71_11498208f9@natae.notmuch> <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com> <5fe2c64bd3790_17f6720897@natae.notmuch> <xmqq5z4tdsiz.fsf@gitster.c.googlers.com> <5fe2d89c212e8_18dc12083e@natae.notmuch> <xmqqzh248sy0.fsf@gitster.c.googlers.com> <5fe36790793ae_2354120839@natae.notmuch> <87r1ngufmf.fsf@evledraar.gmail.com> <5fe424d0528a2_7855a208d3@natae.notmuch>
In-Reply-To: <5fe424d0528a2_7855a208d3@natae.notmuch>
Subject: RE: Nobody is THE one making contribution
Date:   Thu, 24 Dec 2020 10:09:09 -0500
Message-ID: <00f401d6da06$be415560$3ac40020$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKJuQac1O2gIiLZsidfq6ptQpj5lANMEEERAjA1fWMCXIGgXQG60tNQAMAuEIICVbbPRgI8s0tDAh0AN90BKwsL8gElVTlsAohtgLoCBcbrmQHOTpTXAxIs6gUCXOU2JwJcRQfqAVUjh+unihKp8A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 24, 2020 12:19 AM, Felipe Contreras wrote:
> To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>; Felipe Contreras
> <felipe.contreras@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>; Pratyush Yadav
> <me@yadavpratyush.com>; David Aguilar <davvid@gmail.com>; Seth House
> <seth@eseth.com>; Git Mailing List <git@vger.kernel.org>; Christian Couder
> <christian.couder@gmail.com>; git@sfconservancy.org
> Subject: Re: Nobody is THE one making contribution
> 
> Ævar Arnfjörð Bjarmason wrote:
> > On Wed, Dec 23 2020, Felipe Contreras wrote:
> >
> > > When I express my dissenting opinion I'm not saying nobody should
> > > write a patch on top of mine. Of course they can. Anybody can take
> > > my code and do whatever they want with it (as long as they don't
> > > violate the license of the project).
> > >
> > > What they cannot do is add my Signed-off-by line to code I don't
> > > agree with.
> >
> > I don't think that's what Signed-off-by means, per SubmittingPatches:
> >
> >     To improve tracking of who did what, we ask you to certify that you
> >     wrote the patch or have the right to pass it on under the same
> >     license as ours, by "signing off" your patch[...under the DCO:
> >     https://developercertificate.org/]
> 
> Yes, but the DCO requires (d):
> 
>   d. I understand and agree that this project and the contribution are
>      public and that a record of the contribution (including all personal
>      information I submit with it, including my sign-off) is maintained
>      indefinitely and may be redistributed consistent with this project or
>      the open source license(s) involved.
> 
> We can narrow down the part I'm talking about:
> 
>   d. I *agree* that a record of the contribution is maintained
>      indefinitely.
> 
> I don't agree with that.

Clause d is important to maintain compatibility with GRPD[1] rules about maintaining identifying information. This clause is more than about the contribution. It is about consent to maintain your name and email on record indefinitely, as part of the contribution, in the git repository, without the ability to rescind the permission at some point in the future.

Sincerely,
Randall

[1] https://eur-lex.europa.eu/eli/reg/2016/679/oj



