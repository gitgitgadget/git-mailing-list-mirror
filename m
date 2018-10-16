Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5C91F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJPUYX (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:24:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:60021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPUYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:24:22 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdLw5-1flcR10QXx-00iV69; Tue, 16
 Oct 2018 14:34:02 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdLw5-1flcR10QXx-00iV69; Tue, 16
 Oct 2018 14:34:02 +0200
Date:   Tue, 16 Oct 2018 14:34:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] mingw: use domain information for default email
In-Reply-To: <CAPig+cRaBRP9f3sR8suZxC+Y2_UZaBMbMcpjsRUY+mGN+nyXkQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810161433220.4546@tvgsbejvaqbjf.bet>
References: <pull.45.git.gitgitgadget@gmail.com> <271a5f57cef00d24ee33e99839cf3890e561efe7.1539596822.git.gitgitgadget@gmail.com> <CAPig+cRaBRP9f3sR8suZxC+Y2_UZaBMbMcpjsRUY+mGN+nyXkQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L5w+HPgw1aK15qoWdrDrpKo++vGsuTvjJCjf/+J0LgZ5kSMZJZf
 12HqZXz6EmgxT4JAFxGaGS+AUm60T89sIpXzNw+WKmsbczXmbRQUJ8mJHGS3uVlIAPtiwvy
 fbLdxOKuXg8riS9FN+rz3cjULAQwANTE0t1G+oE1hhhgXPt0nsrXp7cmxZwfRhXbsE8/3R4
 nFGnjgSW0qcM0Pnw1XSUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t9kWSNY4ZS8=:XXk0pztDFhtd7DNOfmEkPz
 KfVsdRk6Po7OJT0VYrPRCmAKyFrmao8Z/u3VwNgQB77E+TuDh32nsbeRtw/acnQKIRqHfOQfg
 bAvl1LMZ8Q9tghOxVQpzcvtEhQWn7DKeSfHG0nIWdcr+9AS8KCtZm1P8LhZqYFy3Tv7Zspw44
 jFh4iIoqAbnCV5Spu8ihK2Py1qLQkZpl2z2iuSdjpKkPk9U6rgktLS1TVlom9KlMAR78czsv/
 x+y3T0rzFD5dx20Lhh640C+784kn0AX6c4owbglaz9XD1a1khQjiRQBUe1/xu5R80BFbXe1Mv
 SC1enieoMiiUaQKVcRJ9lzW2NAXDYa56hjrOMAqmzXkQvi8p40SV5Y1SiaP/Pyb2lRCxxYgjF
 1G8GRf8hURIiKCzNljdGvfWaAq7NPtn86FQdJvf6vejdBuQf9n8hhH4J0V5c5GWd4zG+9rlDV
 Q69ek4t8KTr+rxiAU04CzmisNn9qywTcb4lgZSYfFhrVjaWWpa5USjtkP6CYUerD5yI7ntrvB
 Mi5wfBzs97IpXVpxssi3rqFmKuS2Ogzuk5/vz6vENYM+BEMrmgL3Dyo6WJaNdhmHMSB5o2GOC
 dDA8tOVHQiqy0Pf5d7QALjGzHPxKQOYVoVCHs3P1uspi1tbFD6hBAX/eIlFFfwD2ywwX9u5QS
 hRbeuARpycnqkSvMnQ2qynP4SiWIC/nXxBz5/2eR+XWcZqHGsECrcP4FjU8n+d4QrPoqAkBEC
 oyd2+mTq5hHTbtF8mY39jC7tyMHYWB5Tv+rZL6TQ6tv5gxnZ4g+oG4krCuCD85F6oK5hVRicv
 nUjS5EYn6WMUTFwM9sdqmGailosHaq1sI4l118uhPSKK6z+Y/o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 15 Oct 2018, Eric Sunshine wrote:

> On Mon, Oct 15, 2018 at 5:47 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When a user is registered in a Windows domain, it is really easy to
> > obtain the email address. So let's do that.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > @@ -1826,6 +1826,11 @@ static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
> > +char *mingw_query_user_email(void)
> > +{
> > +       return get_extended_user_info(NameUserPrincipal);
> > +}
> > diff --git a/ident.c b/ident.c
> > @@ -168,6 +168,9 @@ const char *ident_default_email(void)
> > +               } else if ((email = query_user_email()) && email[0]) {
> > +                       strbuf_addstr(&git_default_email, email);
> > +                       free((char *)email);
> 
> If query_user_email(), which calls get_extended_user_info(), returns
> NULL, then we do nothing (and don't worry about freeing the result).
> However, if query_user_email() returns a zero-length allocated string,
> then this conditional will leak that string (due to the email[0]
> check). From patch 2/3, we see in get_extended_user_info():
> 
> +static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
> +{
> +       if (GetUserNameExW(type, wbuffer, &len)) {
> +               char *converted = xmalloc((len *= 3));
> +               if (xwcstoutf(converted, wbuffer, len) >= 0)
> +                       return converted;
> 
> that it may possibly return a zero-length string (due to the ">=0").
> Do we care about this potential leak (or is GetUserNameExW()
> guaranteed never to return such a string)?

Quite honestly, I think that this is so rare an instance (if it *can*
happen at all) that I simply don't care ;-)

Ciao,
Dscho
