Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB14420136
	for <e@80x24.org>; Fri, 17 Feb 2017 16:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934084AbdBQQzy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 11:55:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:60626 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933900AbdBQQzx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 11:55:53 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpcBS-1c8To827R0-00fRWQ; Fri, 17
 Feb 2017 17:55:42 +0100
Date:   Fri, 17 Feb 2017 17:55:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] rev-parse tests: add tests executed from a
 subdirectory
In-Reply-To: <xmqqshnllw2f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702171753340.3496@virtualbox>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de> <cover.1486740772.git.johannes.schindelin@gmx.de> <cc23463af8096c5f8429f939ce881cf0eb5c2dcd.1486740772.git.johannes.schindelin@gmx.de>
 <xmqqshnllw2f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3nuQ3THyeNziJ75qKbB8QlTE6R8JuCQEeQKT6+jlJ/xJCsgQ+n1
 3t1nvOusX5KpsTPI8Is6JmdrMISsGjXMJERHmOCAVAmjWKf3YJ2an1a04hoY3xKLLW4lOwz
 JMqzBBfvRHfS470Re4jQmQ/JL8Qf08CV8O/AkGokRy+2rlOX72tdWkQsDNYtmIhcHAtFG/O
 WRNvqevBx6WO9wFZjH4TA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sOJkSwreAik=:gIjhT7lJgjn1xapJ/KsSw6
 cBpezv8/qpCzCkqtm4h9ALHVNcnn1UtLD6d0r1Uh32q+iqjecSDh5m6r0e7I6bNmnSEi8QZPY
 751CfWwMoJjZatVM2iahwvSZQLXyoDrTNTDnfCxvLsylKI1cQF1c/JJpAk7gZYQ9KQWwohQIB
 x3F3egPR2J2CLChFErDT2je+WZmiNt0I30pfxeZcj8s/wvRZtO1vXniWfSBwPmLNGWACopBnu
 jMKL9T0RKVliZqeAUCSG5Foe+nRtOm+Mk34z43pApML+4PVfn2egaqIHGleRTx7oKJPydCOZe
 uV4wHkUUq4pcce2IFxIhB34Xk4Fst0BgmyExEwHPhyKilyHSKp+XxZrBEkLYoU3WTAIvhnLUB
 3t86kXybKKKwFK5HpjCT0Zd2FPlgdpsVP+1XA4HnoPGtAVlh+xKGMcoD11QR0rs8jUXcjTh48
 ykeGeIXk6xP5hkoOJACflcyGt9Q3CPyNlCDBPeV4HmceJfjXGtiLKckPDFFxRNMqP6yL1eZWP
 R7tITgKX7TKspOwCT0LMa8GlcAbqrQq7Ltizv7W2PIx5h6zYO5vPyjsJvtmugFmKqoRUP+s0J
 EaYtw77xq/+gYxAIJp4z6DQIpwsgT1yB9STXBaga3P5tJWEp5jIkeZbrUyuY/k6JVJfhvmx+n
 MiVCgMDrf/LeCnPMJEP0v6L6mnXToaKW8nKncH+Kv5Euks3+MWcg3fZ1tgQhUIGD6f39Jpoz9
 9RyFBkJ7Uwyi6btOGCAnYU1dsF4tu8GnOMQqaGCn8annaGjuzfo+IPPMOHFj+GQMDEn5Nyxml
 UaOeT/n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 10 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> > index 292a0720fcc..1d6e27a09d8 100755
> > --- a/t/t1700-split-index.sh
> > +++ b/t/t1700-split-index.sh
> > @@ -200,4 +200,21 @@ EOF
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_failure 'rev-parse --shared-index-path' '
> > +	rm -rf .git &&
> > +	test_create_repo . &&
> > +	git update-index --split-index &&
> > +	ls -t .git/sharedindex* | tail -n 1 >expect &&
> > +	git rev-parse --shared-index-path >actual &&
> > +	test_cmp expect actual &&
> > +	mkdir work &&
> > +	test_when_finished "rm -rf work" &&
> > +	(
> > +		cd work &&
> > +		ls -t ../.git/sharedindex* | tail -n 1 >expect &&
> > +		git rev-parse --shared-index-path >actual &&
> > +		test_cmp expect actual
> > +	)
> 
> This looks iffy.

Indeed.

> If we expect multiple sharedindex* files, the first output from "ls -t"
> may or may not match the real one in use (multiple things do happen
> within a single second or whatever your filesystem's time granularity
> is).  Two "ls -t" run in this test would (hopefully) give stable
> results, but I suspect that the chance the first line in the output
> matches what --shared-index-path reports is 50% if we expect to have two
> sharedindex* files.
> 
> On the other hand, if we do not expect multiple sharedindex* files,
> use of "ls" piped to "tail" is simply misleading.
> 
> If this test can be written in such a way that there is only one
> such file that match the pattern, it would be the cleanest to
> understand and explain.  As there is only a single invocation of
> "update-index --split-index" immediately after a new repository is
> created, I suspect that the expectation to see only one sharedindex*
> file already holds (because its name is unpredictable, we still need
> to catch it with wildcard), and if that is the case, we can just
> lose "-t" and pipe to tail, i.e. "ls .git/sharedindex* >expect".

Indeed. We can expect only one sharedindex file to be present, and we do
not even have to call out to `ls` but can get away with calling `echo`
(which is a builtin in Bash).

Ciao,
Johannes
