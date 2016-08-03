Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C3B1F858
	for <e@80x24.org>; Wed,  3 Aug 2016 16:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757585AbcHCQOs (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:14:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:58566 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754339AbcHCQOq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:14:46 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MBnvD-1bN2603P7f-00Apgz; Wed, 03 Aug 2016 18:07:47
 +0200
Date:	Wed, 3 Aug 2016 18:07:45 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608031753431.107993@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+7wMPwV4KFxlxPpb9jKY1lgZTKH3jfIvif8mrAHcn404KVhplYn
 guFIZQe2ocaAfsBQcHoeAqDbjE70WdigH+/LilksQDvTH3TklmqmYF7lyCOeBoZRwXX4l1n
 bDxLG3SePuqawZymORy0tJgDRv16eZVqz+6l5Wmv2ZnJHCTMPE+sMOkZfS1K8KQ3Q0PUvFo
 ZyD7SXGPEqHikYnmL2/fw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:oHUSsPbMmbw=:4zIayX9SjfUXDv4TbZCvIR
 SJWK38SpMCXYdbdRpx0pvZ89D1LdzlSkG5sQeKcvrdPtF/16D31qd7RUwGVlnVwuWGTifjw3t
 Eqz0TPt7rLERtB/rmNGAYrgxy0/xIIx+MNKnX4GJ/cNGaxUUYmlVLhxYb6uTZ5CsCY/V/0/s/
 YTGs6BX03ZPM1Cd1xdzqJRmg5fK1XhoMvsdTFys6B95gJ3vYS3lDhCa4rJvnTH8Lp3mwWia6X
 VcgGL597HJpl3b7RwOnLOVVRSr7/TAJWPxFHea2JDGwyKrBjXM/gSFe9ZxDYLhvOMBvtSYWR+
 7+MtS7MOVQPFMdbhoTcr+xz68s0AI/nfX/jhTw8WFPF1Uc6r83ys0aTge22mFo/ix6VeJx+B6
 0r1sX1YV9VgNLkaaQDnIAyXPJ1zdJO4DYFJx/13AJe4kaXetXGjYKUbrpd5ZDWj9CI2dUtK3b
 xF895UO6aH10sAuHOc9UV4in2Qa2m+TtwIBWuy5CythaLJLbDcSWUR/Q1R1klCS9RU9URred3
 6zLWWL7bDgWiQyNgWWNYmDvyVYAO+zTsN6YBIFprVKvWckPtaqulh7+8T2md4PYi1NL9OqQ64
 GUZ0zQ2YoYRlkPCc75m2jhjIA33uATnGNmGlSoCNK5PI2xoxFLX7I20BHNFPKzjxxt/er+90C
 mbMd0AQIpXJnk7RcGfP/e0y0RZQPCdsSsY48wL0A8ehpkzgF1Pjs0BOdJ36szqvt3bqhpHGuG
 zWS962eLuThl3VMGAsPmVWRi6GiBsoXyNgEVKkDvON/ZfOxIKBsX4Bo2IXyJkX+nIbvwshrzK
 HQjx6Tx
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 3 Aug 2016, Junio C Hamano wrote:

> On Wed, Aug 3, 2016 at 4:59 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > I disagree, however, with the suggestion to sift through your `pu` branch
> > and to somehow replace local branches with the commits found there.
> 
> To be more in line with the "e-mailed patch" workflow, I think what I should
> do is to send the version I queued with fixups back to the list as follow-up.
> Just like reviewers review, the maintainer reviews and queues, the original
> author should be able to work in the same workflow, i.e. reading and applying
> an improved version of the patch from her mailbox.

You seem to assume that it isn't cumbersome for people like me to extract
patches out of mails and to replace existing commits using those patches.

So it probably comes as a huge surprise to you to learn that this *is*
cumbersome for me.

I got too used to the ease of git push, git pull with or without --rebase,
and many other Git commands. Having to transmogrify code changes from
commits in Git into a completely different universe: plain text patches in
my mailbox, and back, losing all kinds of data in the process, is just
not at all that easy. And it costs a lot of time.

In short: if you start "submitting patches" back to me via mail, it does
not help me. It makes things harder for me. In particular when you add
your sign-off to every patch and I have to strip it.

If you change your workflow, I would humbly request that you do it in a
way that makes things easier on both sides, not harder.

It would be a totally different matter, of course, if you used the
branches I publish via my GitHub repository, added fixup! and squash!
commits, published the result to a public repository and then told me to
pull from there, that would make things easier. We could even introduce a
reword! construct, to make the review of the suggested edits of the commit
message easier. I could easily verify that my branch head agrees with the
base commit of your branch, I could build proper tooling around this
workflow, and it would lighten my load.

I guess what I am saying is that we might just as well start using this
awesome tool to work with code, that tool named "Git".

Ciao,
Dscho
