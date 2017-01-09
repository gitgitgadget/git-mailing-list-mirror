Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AA420756
	for <e@80x24.org>; Mon,  9 Jan 2017 07:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdAIH4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 02:56:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:62321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdAIH4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 02:56:38 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1RHp-1ck6CM3asz-00tVWf; Mon, 09
 Jan 2017 08:56:31 +0100
Date:   Mon, 9 Jan 2017 08:56:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 4/4] t7800: run both builtin and scripted difftool,
 for now
In-Reply-To: <xmqqtw99ypvq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701090850340.3469@virtualbox>
References: <cover.1480019834.git.johannes.schindelin@gmx.de> <cover.1483373635.git.johannes.schindelin@gmx.de> <0ae4a950a4cd2c8c4f05a6b46c60f127611580cf.1483373635.git.johannes.schindelin@gmx.de> <xmqqtw99ypvq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eKCPgEDOZ/vonA6IlNlJ/skRPAzzWytcpNOG8Tp8QZL937NmQg6
 TfW3AOnp5qPlbsotqp5likfZFZhWtujJI3LFL/PNoNCKa8V5+HpeoaVUZXVvHQPjwoSBO3m
 f6ytn0JQ4U8+lm9LXTj1dWSZsAjsusktwLdQtKL7ICDg+IIlnGs2nKlRbEohbf9gQpdx3SO
 o9imO7NOc0GnWioPHFaOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S5AkET6X4Is=:2soqMsjAWZTqLAUspUu5JG
 oGcD2OW7O/bg1/Pqc605JSPFFWTTh4l9JbQz0FWdn2+uV7u/lYCATsSzDjv2OBO4sU1ylzKRL
 eNWxmdSg5HCpFwWXDNa4pjAWNFhFzVYAMKJ0uOTXmMENyYcs9wQyutYUQU8q0oTv4lBo+gjHU
 cFfPhYSZIidLyGrdZFkMithqvxT8YH3+m5Yeykz/G9bgF5PtJhpg7xqZm4UjZwoi0zEU09M6V
 UZII1CLaDpxSnyD9IG9j0X87t7RktwY7Mcr40DfBETww/j0ErBK71+49fzbQujmi3LaLM1U6R
 LbuJnr6GlBQfnWRt/2N3A1ALF4i5Y4h/yFAlWLSEfk+e63TxM2PnO4p2NEvjcYkYxqilLM/ZZ
 C+X6kBp7KzEAsUKcvUbtZnL/84HTStJb8Shh/HYUEsHkJsYGCYDORrWQmgwDCyJrqsZCWZ1yd
 xSBSPWzeJ1dJiL9/Hcb9X54DT9uyQg3b0inrwhdgtl49CRrbkBN1mtT4e/r9L5JIzrhjLpzKH
 Ivattq+Owni34Vt8tWb6tWANeaFTkDpQIfsPhuzJf7WUjltqO6Ah8fNt7UZNfdSHXfz7ZIxDU
 WtitMMRekI4xwhZNWgc9275kisLfVaHAMQV83gfT8FXi7ZoGjdyeDM9JqJ0Jx5jhnG67KCcmw
 61y1Dw01VHTnRod3/dLKWX6+vGYCFhCUoxavdX7GYV3hgC/V/na5/ggIIDW0WyPyuzOaG/oE8
 WA1TbXns1EOFkKoXTypTSsiHy6nKEVES9Gt0/9n+v0ByMAAsKieqWJsE32PD0ZHvwcyK7BeCX
 dOdrRwf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 8 Jan 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is uglier than a simple
> >
> > 	touch "$GIT_EXEC_PATH/use-builtin-difftool"
> >
> > of course. But oh well.
> 
> That is totally irrelevant.  
> 
> The more important point is that we do the same set of tests so
> instead of running just one, we run BOTH.

And the most important point is that we do all of this only during a
hopefully brief period in time that is mostly spent on reviewing the code
and finding serious bugs and fixing them.

During that period (which I would expect to be spent completely inside
`pu`), the cross-validation does not have to be beautiful, but correct.
And even more importantly: it has to come at a minimal integration cost,
in case David decides to add another test case to t7800.

And after that period, we retire the Perl script and switch to the builtin
difftool and simply drop this patch to cross-validate both difftools'
outputs with one another.

At which point all of this safe-guarding and indenting and all of those
changes that are just meant to cross-validate the output during that
hopefully brief period of time will become moot and all the work spent on
those changes will be worthless.

Oh, at that point also all review that went into *this* patch will have
been spent in vain.

In short: can we please move on to reviewing the *actual* builtin difftool
and spend our effort on making sure that it is correct?

Ciao,
Johannes
