Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFBD820401
	for <e@80x24.org>; Tue, 13 Jun 2017 10:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdFMKuY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 06:50:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:50235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbdFMKuX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 06:50:23 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MA9FV-1d9Uyu1XZp-00BNiJ; Tue, 13
 Jun 2017 12:50:17 +0200
Date:   Tue, 13 Jun 2017 12:50:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/8] t1308: relax the test verifying that empty alias
 values are disallowed
In-Reply-To: <xmqq37b84g9t.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706131244150.171564@virtualbox>
References: <cover.1496951503.git.johannes.schindelin@gmx.de> <b9e212d508e9103037da2070cc0aaed530ea7473.1496951503.git.johannes.schindelin@gmx.de> <xmqq37b84g9t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:072VA6KEGbv+YFksWI3pnq4u3myzCpiSlAgY9utidVEzmn85Js5
 Fba8quoNl2+j0QFQ5gIGrmHyVWCPmDGYnL+WX2qocB2MJnKLYawUgu13jq6dLH/NV4bSwTU
 kfN4GDAnVWTV/E7vyJoRqzIai55e8Suy5FmeLE2H6AK2i0M8XZE4baLodT1O/0lL0GGyiNd
 149Z6rnMOGY/LtwpALb0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WQpJnqz59/o=:shmybM7CfdzENIdfDOt2e0
 niqQSUL9g3oVWr3OfIKpStuDtPxN3ED7EGqBB2EZHD11RI0TNMNTY/JkO4pxD8NDsjFXGqTRM
 wL3FMNiGdkwYfZpYXaJxI/uic0o1RzHvCvXPrb8iuDkuxNCiwhkKpn/4yJGiqFxj/rbc9/Wou
 tf2os3i6hQmFeE+FFny96L/uavkik1NjtUsoOypC2qZwpfodtHuEX+OBdAF04wc4tSMOZZa+i
 G2+si6NljK2AXyLJMIWA99ifl2xZ82+VF5DhIu8+m5LiOriNeCaXU/+UvUbeLjWevrE7d8+dA
 EKeIsM6GvqRyulXndbkn/+0U/Eu6oWWnPqhdJbbzpQzXtHHPmP4fU8hKU41hnnVu39WGumAxO
 Lwv9NgbaMNfjfyb+b2IPrc18EstW4AYKwaIpomPYbOqfYIR6XsX0lOqM4ORcvMDZvlpLO2RD/
 PLsE41BFxBEeESRnjuGvXtKhiE+ro5i1nGr7njQ97Iz+bXd7W6JgHi8MOVruOY6rmmvEzJKFK
 ktxoWNXQ1Rkan5BqeAPynEoDYyVEZ0zpk5aCmWEgphKD3B/1q7UiHsCRlB6NVfMCVyaldLSbj
 mBd/eFG/zuvZ6etbJGiNE8HCTvR5Lfnn9AgBohGy25/xobJ9+MbAAKg9Pg2lxF1XGqeA0dPss
 YR6TJOuli28yeEYCpAO/fh/KiNJIf5FdkpIFKrS6Go/g6+4xKT5ikT0YB4BY9sXf5eh7+0p0b
 HazNtLoEI4186f8PKS9KXUPxFBtRPW5Ey9HireQhob+YxJ0cU/EBka5oNSACrhA9bYgMbDaJn
 hSoawtT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 10 Jun 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We are about to change the way aliases are expanded, to use the early
> > config machinery.
> >
> > This machinery reports errors in a slightly different manner than the
> > cached config machinery.
> >
> > Let's not get hung up by the precise wording of the message mentioning
> > the lin number. It is really sufficient to verify that all the relevant
> > information is given to the user.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t1308-config-set.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> > index ff50960ccae..69a0aa56d6d 100755
> > --- a/t/t1308-config-set.sh
> > +++ b/t/t1308-config-set.sh
> > @@ -215,7 +215,9 @@ test_expect_success 'check line errors for malformed values' '
> >  		br
> >  	EOF
> >  	test_expect_code 128 git br 2>result &&
> > -	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
> > +	test_i18ngrep "missing value for .alias\.br" result &&
> > +	test_i18ngrep "fatal: .*\.git/config" result &&
> > +	test_i18ngrep "fatal: .*line 2" result
> 
> Just judging from the looks of these, it appears that the updated
> messages are more descriptive than the original.  Am I mistaken?

Sadly, I do not think so. It is just different, not better. Maybe less
redundant... See for yourself:

Before:

	error: missing value for 'alias.br'
	fatal: bad config variable 'alias.br' in file '.git/config' at line 2

After:

	error: missing value for 'alias.br'
	fatal: bad config line 2 in file .git/config

> If so I think the log message undersells the changes made by the
> series by sounding as if you are saying "we are too lazy to bother
> giving the same message, so here is a workaround".

I fear this is not underselling anything for an improvement.

The real fix would indeed be (as mentioned by Brandon elsewhere) to unify
the code paths between the cached and the non-cached config machinery, so
as to provide the exact same error message in this case.

It is annoying that I lack the time to make that happen. My official
excuse, though, is that that fix is outside the purpose of this patch
series.

> In any case, s/lin number/line number/ is needed ;-)

Tru. ;-)

Cia,
Dsch
