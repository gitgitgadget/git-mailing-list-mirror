Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666081F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 03:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfHMDZF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 23:25:05 -0400
Received: from mout.web.de ([212.227.17.11]:59887 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfHMDZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 23:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565666693;
        bh=PL+16GbAC+FQebKe5BuB/hcKhUczdoSsjteUoDXReTc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RxPvpgIJvvyBjE6nYeJTgE7Gp2cFk1vgqQXx+/p57llqNip3BV8gm1e4kwnfpdUBl
         Ens7D4p89U3hRaPQNkGFawSbAdx8vyG51AgUCvjmKhBNJuwWikvHd9t1IQY/I8fk5Q
         Bb7wqMHeeZ9X70S4VrMuVryYUU5cSufoU36o1p8Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRCnT-1hrcpG235z-00UaYE; Tue, 13
 Aug 2019 05:24:53 +0200
Date:   Tue, 13 Aug 2019 05:24:52 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
Message-ID: <20190813032452.qg2ufgljm4bjeznr@tb-raspi4>
References: <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com>
 <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
 <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
 <20190811121004.guygurnopwwggvsp@tb-raspi4>
 <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
 <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
 <aae529ce1b084b7bbcca3977e6909417@bofa.com>
 <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:xGyHtpUqM7JFwd+ooukde0ZCy8vioqOM3ZdtSfUlerm1QZSFQjx
 Fp/8Z7Mvoz2n3C/t0fNkDJhIDJNtjMDLRtdxVJMXb/CNMXfM8RDk7gUuV1KDfOh2UPTU5bo
 ISebew4yA8F+36G0PFgnaiml/4uswguTM69qFtP1TxA2QRDiOZ/6ZF1x4NCoMXGuMtZUMo7
 hiLiIdOxVCG6CJme0ojzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:07exFRkfO6E=:RjngyWSnh0J7zCLu3pR/ak
 qJ6w3FW1OUmJjbSb7pghf2jFdCE6ca5qMiU82lh+8GjFvN1SRVNrclgJS+fYQzNqzPINv/yJr
 Pc1CeXDgLbtYl7zD+BRS1D7/JOnbP/s6czF4yv/lqv6WuA042ebIQpydCxu62Z/Gw38NxvxvN
 sB/pjjz3l2fMovLJLd+sVstx74cXQFwinyMfw0Osl3K+Xh20F4tXb+DEMM8o3iFp2Amu+f6g7
 KxjDNx5TOAMNc9T+gM5r3n/eTUOgI1lFJuL5R3hsUMvGfk6BO9VjqntjUbVVzEgrmW0TveVgq
 Rxl+euia3mobcar+MlFYxbppumvCtub49BDvRiUeV5xLJeAxjNTzIzmFdlhPQ0wqwVp8dr7Np
 yanV27UPnWDfVJh+4wVH751F/el1lUy93b0pNmSoEXGo2qV4+ua0AGfXfjrzLaRKakwVx8hX+
 7CrBh6nsmvwisGskiTvaasKnEUXBAj5nUxwtvD/f1ig+DDsVu2TViqvmPZqcQBG38p27J10iI
 2MM9oJ6uZwe0mml4+bC2TlqeXbf9egsfn3f5fQ2HKbItj6YcG7FezJmIzoRG3QbA+g2jn6K6C
 Skfl47K5G8L1ovBYzcZ7ZICEWvmJF/mDXZifPSGSLp6JjofdmrVlFk0UfYJ/0LIPOEmS81EWK
 MGKIGh0Q5BWdjBzWG0v+duUJn7aTm/5GOfejICYbh7qdniJjodIYTToHhg1a7JZ5gzNRdFUvP
 9k5VwqN9SunlI5d+DgbI+5etSc2UJa30d+GuoQ0T23QLYg/vFpsehUc00u37GAJLfzKJev2vA
 Ep69OnVPqOf330kSg3u6eClFa657JipgOMVzwh44K9Fu+/TFxiNaGjTvqSy3DTyAAUH4A+NG5
 S6qwuagbG3RcXPcp0JtPAm+77M6gWoIvRVtSHn5htPEMetd+tZqpbJA0gaP2RbgmKad7qbcmt
 1Wm9xyEAfUZ37S/1FTGYvBR7eY+KpURkXl6cJLeoGERypuVscVn5GjdCL26xE5zVRVO+/Kp7t
 YWsJV4cBxhrkbpihyvK/pYjtN9h0YXI9HWwhxDkTYd25HGFsu5/l07I7GFSoQNZOFzeA2er+n
 rpmyQiygaJ3wUh4HAT0uRkxhSqinY9vKq7M4FpGNochBFjxyCIQkSBo0g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 11:18:35AM -0700, Junio C Hamano wrote:
> "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com> writes:
>
> > ...  Assuming the repo has no .gitattributes,
> > is it possible to predict what line endings sample.txt will end up wit=
h in my repo?
> > Or does it depend on more information than what I've just written?
>

> Binary packagers can ship custom attributes and config that applies
> globally to the installation, which may affect operations in all of
> your repositories, can't they?

Let me try to split my answer into 3 parts:
- A Git distribution can ship with a global attributes file, but I am not =
aware of any
  distribution doing this.
  Especially Git for Windpws does not add any (global) .gitattributes file=
 somewhere,
  as far as I know.
- The default value for the global core.autocrlf is typically unset in all
  Unix-like distributions, which does the same as core.autocrlf=3Dfalse.
- The installer for Git for Windows allows the user to choose what the glo=
bal
  core.autocrlf should be (false, true, input).
  The help text of the installer mentions what
  e.g. "false" means (line endings "as is"),
  and I don't rember the text for "true" and "input"  out of my head.

Now back to the original question:

Person A  creates a repo with core.autocrlf=3Dfalse and commite sample.txt=
 with CRLF.
Person B clones that repo with CRLF in the repo. When the worktree is chec=
ked out,
sample.txt will have CRLF. Always.

Even if B uses core.autocrlf=3Dinput, sample.txt will keep the CRLF when i=
t is commited.
If the line endings need to be changed, there are 2 ways:
Either user B runs dos2unix and commits file with LF.
Or user B runs `git add --renormalize` sample.txt. That needs a
`rm sample.txt && git checkout sample.txt` to update the working tree.

All this is predictable.
A fresh clone does not have any "modified files"; all files with CRLF
stay with CLRF unless they are normalized.

Our documentation mentions
"files that any contributor introduces to the repository"

Is that part understandalble and the distincion between
"existing" and "new" files clear enough ?




