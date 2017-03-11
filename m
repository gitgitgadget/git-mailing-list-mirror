Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E805C201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 14:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755674AbdCKOTg (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 09:19:36 -0500
Received: from mout.web.de ([212.227.17.12]:65458 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755680AbdCKOR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 09:17:59 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHp4-1cB18a0e1W-017zi2; Sat, 11
 Mar 2017 15:17:34 +0100
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
 <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
 <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
 <xmqqfuikyjoo.fsf@gitster.mtv.corp.google.com>
 <c93a61a4-05d9-8e49-9734-12c81289517b@web.de>
 <xmqqr324wvum.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0d41423-7227-3417-b4b1-fcf47a66f64b@web.de>
Date:   Sat, 11 Mar 2017 15:17:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr324wvum.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:o+KI8G4VCGolv4AzlVu0VWlbRI7pNBxAckptT8edAOUuVvoomTK
 tMRLd6f5NG+b1hQJtMzzdNqn0f0DgO1b/2arikwIvlfUuAk/43TloJKpQuZlg6tX3shsdN8
 5szO37fnLj/RmxZB93FsGnjovxoC54p8b0kHwi7zxXwaa3xM0AaPH0prPh+rUmDydr/fRyt
 TAzLiP+3c3yQa7sR7mkQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M3fhHHFz63c=:sExqCpffl7kmlSNeEve4UD
 gulxHCR53M5iLfG7RlazyFqjiHB4eOp93UMRYsI1g9/OVZRqDO5YTDa5nJIcBfJqgiUlHMR9F
 w9AgTVhBCbxz+EQuPho8cgUCNmQYJGXbt8+r2l+P1p5cu2hNMnBrQqK01MGcfAIdIkL3hphvA
 hZm/XzrzxJWc3OjHXCzjrq5CDHShBwFok3HU0cug+kZ7EjMgRFMDwhQDwj5hqF4h95vIpVkZc
 NQJS22IjOdwuKrWeCmS+nGLnqxe2Auimu7PGgbCKgOUExdxS0E/ZXKy9oT/kqfk/gg/FqOWUi
 DLUeX4kHIpVgVonG6uBLh/kYLPeH8rz6nBG3GkPz8b4IWKL1rZqOgtfea1VJjSdaiE1dkg2S5
 Tysvn0viKglNXy2z38OqL5MYXNWf976IQ1L58urPE482z4nh+Wx7wH/Q/ENUE7Y7stAd04rsA
 xPS98N/TrEERXQ0uyqGzeWhIdp+lX57umh3tHcQWcE3dG0Or+dsOsHTIiV+gujwwNuVHjkCfP
 h6x/jUegLZtVoScumnaQvc4c4C7LNAlsFZQFrorrrTmQDK1mUaOHcIKAEr0l3l5z5JYngybv4
 BDtezBiWtdmVc0ou9t2bq44bwqZrm+rYXvmV5ZSi8VLyr4vxe0hsinJQknlBxxEW5QkXCfXmz
 w1Q5etpJna2eUhoAFNkJ57khJWyBNkR7uycpDKNuEzufJiPYJQytzlbQDasMNTGhKPkiAr0HS
 jP57s6eWhiyZY0ZXKCM+eQoL5ArjC8orbhPEuHEaetUa03ZgK4DHc14IfKPEL8PsJ6OyDVOLE
 IuyFYoi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.03.2017 um 00:33 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> 	@ depends on r @
>> 	expression E;
>> 	@@
>> 	- *&
>> 	  E
> 
> I guess my source of the confusion is that the tool that understands
> the semantics of the C language still needs to be told about that.

Understanding that E and *&E have the same type does not imply (for a
machine) that E alone is preferable.

> I was hoping that something that understands C only needs to be told
> only a single rule:
> 
> 	type T
> 	T src, dst
> 
> 	-memcpy(&dst, &src, sizeof(dst));
> 	+dst = src;
> 
> and then can apply that rule to this code in four ways:
> 
> 	struct foo A, *Bp;
> 
> 	memcpy(Bp, &A, sizeof(*Bp));
> 	memcpy(Bp, &A, sizeof(A));
> 	memcpy(&src, dstp, sizeof(A));
> 	memcpy(&src, dstp, sizeof(*Bp));

I guess src is A and dstp is Bp?

Coccinelle does not know that the sizeof expressions are equivalent,
but you could normalize them with an additional rule and then use a
single memcpy transformation like this:

	@ normalize_sizeof @
	type T;
	T var;
	@@
	- sizeof(var)
	+ sizeof(T)

	@ r @
	type T;
	T *dst;
	T *src;
	@@
	- memcpy(dst, src, sizeof(T));
	+ *dst = *src;

	@ depends on r @
	expression E;
	@@
	- *&
	  E

That would give you what you expected here:

> to obtain its rewrite:
> 
> 	struct foo A, *Bp;
> 
> 	*Bp = A;
> 	*Bp = A;
> 	A = *Bp;
> 	A = *Bp;

But that normalization rule would be applied everywhere because it's so
broad, and that's probably not what we want.  You could replace it with
an isomorphism like this one:

	Expression
	@@
	type T;
	T E;
	@@

	sizeof(T) => sizeof E

In your example it allows you to specify sizeof(struct foo) (or a
generic sizeof(T) as in rule r above) in the semantic patch and
Coccinelle would let that match sizeof(A) and sizeof(*Bp) in the C
file as well.

Isomorphisms are kept in a separate file, the default one is
/usr/lib/coccinelle/standard.iso on my machine and you can chose a
different one with --iso-file.  Perhaps we want to have our own for
git, but we'd need to synchronize it with upstream from time to time.

There is already a very similar isomorphism rule in the default file,
but I don't think I understand it:

	Expression
	@ sizeof_type_expr @
	pure type T; // pure because we drop a metavar
	T E;
	@@

	sizeof(T) => sizeof E

In particular I'm a bit worried about the lack of documentation for
"pure", and I don't understand the comment.  There's another comment
at the top of another rule in the same file:

// pure means that either the whole field reference expression is dropped,
// or E is context code and has no attached + code
// not really... pure means matches a unitary unplussed metavariable
// but this rule doesn't work anyway

Hmm.

Here's an isomorphism that allows you to use "sizeof *src" (the third
part for T is not strictly needed for your example):

	Expression
	@ sizeof_equiv @
	type T;
	T E1, E2;
	@@

	sizeof E1 <=> sizeof E2 <=> sizeof(T)

That's the kind of bidirectional equivalence you expected to be part
of Coccinelle's standard set of rules, right?  With that rule in place
the following semantic patch matches your four cases:

	@ r @
	type T;
	T *dst;
	T *src;
	@@
	- memcpy(dst, src, sizeof *dst);
	+ *dst = *src;

	@ depends on r @
	expression E;
	@@
	- *&
	  E

But I'd be careful with that as long as "pure" is present in that
standard rule and not fully understood.  The isomorphism sizeof_equiv
doesn't seem to cause any trouble with our existing semantic patches
and the code in master, though.

René
