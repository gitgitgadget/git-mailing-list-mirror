Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DF61FF40
	for <e@80x24.org>; Fri, 23 Dec 2016 09:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938481AbcLWJbI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 04:31:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:57747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935704AbcLWJan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 04:30:43 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mbx62-1c28JI4A10-00JKyh; Fri, 23
 Dec 2016 10:30:35 +0100
Date:   Fri, 23 Dec 2016 10:30:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Beat Bolli <dev+git@drbeat.li>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/3] mingw: adjust is_console() to work with stdin
In-Reply-To: <fc3e0d9c-86ea-4a62-6b70-b9cdd67f581a@drbeat.li>
Message-ID: <alpine.DEB.2.20.1612231024400.155951@virtualbox>
References: <cover.1482342791.git.johannes.schindelin@gmx.de> <cover.1482426497.git.johannes.schindelin@gmx.de> <ca4c61c603247c8ad0b876b068f6cd41fbe01667.1482426497.git.johannes.schindelin@gmx.de> <fc3e0d9c-86ea-4a62-6b70-b9cdd67f581a@drbeat.li>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SfcYZ0MM7P9dV56vvjwiWTd8/zO0lRzgwNKDKqUBpZpYTU+SwuZ
 rfdr8bKxc+Lj1oBjkcbYkl2ydzK4M5rMWD6xkMU0B51HgquNWmqxA0LwaXx9/UtbbeDY712
 3e3hDJRn+L8553GXWO2tDHJ/Dsdn0tOCbzkhm259cUQqUb/3oogEZlFQJuNxZltyo8D5I0p
 oHSjnMl3iWXbT67Uiyu8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2IaLJKEbJgE=:g3NuYI+6RlZnN/26g2J8Em
 ahuOK00U4wRnIQvjIfcy69DhwLwev7MTZCDf0vopeOl4nyQQsE2WypUksThCrRLnBjj+2e7sO
 XjRlzHQtZr4teUZx7hRqOIc328bnz/pQocP6rokGQ4/UuXh4J1EVI0JTZGPTLaE6nqYCRpwFs
 Wn91sjNayWFy/dfiVVQx6N9I1UQ8VdmDy5f/YYwb7A5q7ZSAjTiMT3XqZ/7Dtx4gU2gtgWPPB
 QlRXHuLuLXguKpVnXmQaP9bfhyrg35xbtsLH32rX+ydpwCAzLUvi6HaDrFUCHMdUs8fhnZWPR
 QaCAXAnjVLJdpYg6veC08oyIpopKB9zzSXb9rv9YxXH2xJq74aQpRzzVdWZRgt72kzbm2ljzZ
 Qm8Atd0aHL70DdaiJaH84xeKcirA+qlsLW1Ve9K5yS7rnRpELfzybmpzImuzq/KrQU4Lbybaw
 SERD1I05/xaxVV81C/DuYYbmezyS4z7mJgdRVPwfpSRKepv5r0uyhxJfYo/6lFsTeYMbxj0+h
 YU6CKz98Ni+ZKQ13Cj8z5pao+xkdhNDmSKQDkWOuuIRV+VRDkw5MQ2q3ERuUjDQRPlQz6N/zm
 JL67f1/ApWeupIXkJ3ACNH7lqzgyFBTEqqxbwpdkI6BaWUEMdFoffmbb/O3Vqw+Eea4ttNllm
 KQxvnsO/HzC9MswlH3E3ih5VLqAocPN1M35QlR8TfAq2ER7yvc3+L1EZ1vNf3kI0zMxv/WTK7
 3XeY0K/hipItDUd0tTCzVqEtXZgUtVwXJUDv02g29EPinaJ2t53QE9D8KrBu9k1q6HNwuqJqp
 22RXUtVWKIooEB7T/5N8wrhRA8BKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

On Fri, 23 Dec 2016, Beat Bolli wrote:

> On 22.12.16 18:08, Johannes Schindelin wrote:
> > diff --git a/compat/winansi.c b/compat/winansi.c
> > index cb725fb02f..590d61cb1b 100644
> > --- a/compat/winansi.c
> > +++ b/compat/winansi.c
> > @@ -84,6 +84,7 @@ static void warn_if_raster_font(void)
> >  static int is_console(int fd)
> >  {
> >  	CONSOLE_SCREEN_BUFFER_INFO sbi;
> > +	DWORD mode;
> 
> Nit: can we move this definition into the block below where it's used?
> 
> >  	HANDLE hcon;
> >  
> >  	static int initialized = 0;
> > @@ -98,7 +99,10 @@ static int is_console(int fd)
> >  		return 0;
> >  
> >  	/* check if its a handle to a console output screen buffer */
> > -	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
> > +	if (!fd) {
> 
> Right here:
> +               DWORD mode;

By that reasoning, the CONSOLE_SCREEN_BUFFER_INFO declaration that has
function-wide scope should also move below:

> > +		if (!GetConsoleMode(hcon, &mode))
> > +			return 0;

Right here.

> > +	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
> >  		return 0;
> >  
> >  	/* initialize attributes */

As the existing code followed a different convention, so does my patch.

If you choose to submit a change that moved the `mode` declaration to
narrow its scope, please also move the `sbi` declaration for consistency.

Ciao,
Dscho
