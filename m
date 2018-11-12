Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A621F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeKLV43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:56:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:36393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbeKLV42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:56:28 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5Lmp-1fZ1xh00el-00zZcu; Mon, 12
 Nov 2018 13:03:26 +0100
Date:   Mon, 12 Nov 2018 13:03:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] ref-filter: add objectsize:disk option
In-Reply-To: <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet>
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>        <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com> <xmqqr2fq3n1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1E9BQ6Wc0C60zMMXtUccZNoMrh20N04HJGVlkhHTJS2Wrn5Iy/1
 +VjuZPcZ0FuXOIEw2IxYSvNDy886ucWOx51XfxnDF5LmNRp9slJqeJ51eGuBjzhK/t0DtHz
 kteiwznHKMu+kTLo8XvKH/sb51A4IhU20aXmcZdMOkUiLjcTjmgMS6Osc/sPgZ5KI5V81AU
 4FIHnSSTNt7zh/3lV72Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iGVKk6uUlbE=:B1Fd7yr2j+3fYtFFzuB6MH
 TsMoibfYIG1QHYmezEx0ABO4MHbt8CMwdATdbQpX03tnI7uUQR+PEQffgXS8Bf17DY6bh9xf4
 vAsRnuEIbAmdj1Z5DUxRTBDtirS+PiXQj21LT0MR4njo/jfR6/fCFVuz3eM8XcY27XGVgaK3y
 dVx3+n9NuApKQl6F2qKOHN6nwVSWtZCpFmGxpNwcT+gMBe+vd1Wy/TS8WWDfzswVGnPojughO
 gdCnPfh9whlh9cUl581S3bGVSesMrq5feb1JJwGfIu/g96C9ije3aBgVCdhDcB61gS1J+2r0Q
 TMDMK50j9h9Itc3kYWc0/vZ2Oqejm+L+mOm9PqZW2b5Hn7WvVn181Tg69y3e8G0hLUf8pHJmH
 1Uxh4ZiLd3wI4gbuqVMMCUOUqhzF/MxJwVJl3Iq9PzN/+e1OOrOU2xNTxS+GRvypaWWLLsiyg
 Vg6pDX+Ve+FqvR6AsM/V1R/BFcBFt6Q/AIOYHw+tKMZ8S1CA/N1RS87XgOn2Sa4kLMAIjxxm5
 K8MAEKPYyjM1Haw274AIOuigi06SeLWYy2p9/LRBQaDMdjqBruZ9K+IukSjMgOD5JKMEyOYMA
 KCRrs9ZHzyH9fHOV5mTLgya5K6QuLKWZCOJ+9mccAw8o2RcDMvyj3KE+XaPVO6ll/2BZJeFDr
 n0oMkvHcAB9wud1VsDyhwBNAxoJVSZ40OXauuO7tELZ1vapvD+1HevXv0/sUboRdwqLR22jGO
 2wmb9DOHfj6p0R1VX60uPsT7CtFkpVH+BMic7LxTZgXxorjNb/XATJGTy1RQfBUyzuAjmoQnm
 v9HWymCeRG3qQsRGwS2e21i65Em7Y7eo0szG978UFfWXl5FZVHSBUVkTMLfKGHKWtLAv7Gatr
 lkGIX2cj6zF8B0OJE137bfChyLJqqfQiqiEz0XFA23nmesRauuvylfDMlHt0J86/SDPBs9qiP
 AvtRDnFU43A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 12 Nov 2018, Junio C Hamano wrote:

> Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
> 
> > @@ -876,11 +882,13 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
> >  			name++;
> >  		if (!strcmp(name, "objecttype"))
> >  			v->s = xstrdup(type_name(oi->type));
> > -		else if (!strcmp(name, "objectsize")) {
> > +		else if (!strcmp(name, "objectsize:disk")) {
> > +			v->value = oi->disk_size;
> > +			v->s = xstrfmt("%lld", (long long)oi->disk_size);
> 
> oi.disk_size is off_t; do we know "long long" 
> 
>    (1) is available widely enough (I think it is from c99)?
> 
>    (2) is sufficiently wide so that we can safely cast off_t to?
> 
>    (3) will stay to be sufficiently wide as machines get larger
>        together with standard types like off_t in the future?
> 
> I'd rather use intmax_t (as off_t is a signed integral type) so that
> we do not have to worry about these questions in the first place.

You mean something like

			v->s = xstrfmt("%"PRIdMAX, (intmax_t)oi->disk_size);


If so, I agree.

Ciao,
Dscho

P.S.: I wondered whether we have precedent for PRIdMAX, as we used to use
only PRIuMAX, but yes: JeffH's json-writer uses PRIdMAX.

> 
> > +		} else if (!strcmp(name, "objectsize")) {
> >  			v->value = oi->size;
> >  			v->s = xstrfmt("%lu", oi->size);
> 
> This is not a suggestion but is a genuine question, but I wonder if
> two years down the road somebody who meets this API for the first
> time find the asymmetry between "objectsize" and "objectsize:disk" a
> tad strange and suggest the former to have "objectsize:real" or some
> synonym.  Or we can consider "objectsize" the primary thing (hence
> needing no colon-plus-modifier to clarify what kind of size we are
> asking) and leave these two deliberatly asymmetric.  I am leaning
> towards the latter myself.
> 
> > -		}
> > -		else if (deref)
> > +		} else if (deref)
> >  			grab_objectname(name, &oi->oid, v, &used_atom[i]);
> >  	}
> >  }
> >
> > --
> > https://github.com/git/git/pull/552
> 
