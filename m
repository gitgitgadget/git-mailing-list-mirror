Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB211F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeCUWiq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:38:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:51305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753865AbeCUWiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:38:46 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1Fe4-1ejAGd1zK4-00tAKn; Wed, 21
 Mar 2018 23:38:39 +0100
Date:   Wed, 21 Mar 2018 23:38:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] rebase -i --keep-empty: don't prune empty commits
In-Reply-To: <xmqqfu4uslar.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803212336420.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180320100315.15261-1-phillip.wood@talktalk.net> <20180320100315.15261-3-phillip.wood@talktalk.net> <nycvar.QRO.7.76.6.1803201630380.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqfu4uslar.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:axQH3nez07R4Dl0FM2LJpFevRbHEKT2ue5aB/e1wKcXysTStK+P
 L5ZljKBAr712c1ABiWoNIiYgIQfd2UjTuRrX8CBSbJAnFOvNru6TCmNBfEcI+vXt5jH1mst
 GFV/CtMa+IDBQN7o5PiwKn73TgXnm1yPJkxMKz6/wy/q+/vLF8qmUTtMLnTN0LueEc5OvUw
 NjRoJpE6sMI6ndQ2irnjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:whd6B4F9PH0=:wFy5WHMzLvcbkoUvIN/Y7z
 Iis2ogKRA1HSGzaIKFmJdThqgGsHOJ9RwUDbCQrps8ahSoSwd3Apt+KzVpW5jum9f7YPVCemi
 EZTGnf+djzRolcQj8C0un/5hkJDwBy5Dj+Db27ibHG2UmM9CUUtwhVCK2vwnuYkc8UHB3pFlF
 g0vR4eW1MyKQr43Y6qI6nVXXKr/dkZzX97KcFwccvXCUxenkn1vaFuJ8CICf9dP+U9kChRK9b
 rCOqFN9jJ62yXat5yVTykxKNs5YcmWXAT2CNcQsicNaSCLf35dbVaVPAdCFl9hvDzgfnJ+TjH
 2m2RkmpHQ2CJnEMmErYcJgmr13N3ndSofirNkCFvTGMsegVd9BIXJGbXbeUrZwC+pJkC472Ze
 G0UXx8jc2lcJ3qv3+GFygr7v+zitzb4Zd04aGyiKqohC1BaoSBXvCMqhuB02NUNa4eANXNhwM
 JTZ+NDp5rbcjUZzLqFB6I5oKoD6HLYMNiV1IC7iTAOJQShdJEA+c8Z9fOhrR6QQDec6nzjbnz
 B/Onedx71rMyRm2GsJ6MIsDNrJ4Zl27pTrC/UNfJ7TZAEPlhi1IFZJe5Bm+g+c6ICafMaXuLt
 XHJpMO1ZQuwbL0PGd3AtUY5XF15FWzNyhL9/6T8dxJTRLcSTcKXP8XiS8vEXf/DwFL9216UKa
 sN5Gu9vDiuMDjzDburHmQIR2hqd5N0jmiSJz+UpBdud+fhYl2Jn88haizJS6ALHr6XrezUMKT
 mk9xgjmNiwMyUSdxE0YaaAZL2Q9H6AW0iBAVJF8clsZ6yrJFw7ShjgrXV6BPv0n/GNw6jckLu
 gEKytuGV0bZVGJQ75i9v3C6n4rwTZLb2Q4jrTAqA5ue+YdZsZs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 20 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> +		if (!keep_empty && is_empty)
> >>  			strbuf_addf(&buf, "%c ", comment_line_char);
> 
> We are not trying to preserve an empty one, and have found an empty
> one, so we comment it out, and then...
> 
> >> +		if (is_empty || !(commit->object.flags & PATCHSAME)) {
> >
> > May I suggest inverting the logic here, to make the code more obvious and
> > also to avoid indenting the block even further?
> >
> > 		if (!is_empty && (commit->object.flags & PATCHSAME))
> > 			continue;
> 
> ... if a non-empty one that already appears in the upstream, we do
> not do anything to it.  There is no room for keep-empty or lack of
> it to affect what happens to these commits.
> 
> Otherwise the insn is emitted for the commit.
> 
> >> +			strbuf_addf(&buf, "%s %s ", insn,
> >> +				    oid_to_hex(&commit->object.oid));
> >> +			pretty_print_commit(&pp, commit, &buf);
> >> +			strbuf_addch(&buf, '\n');
> >> +			fputs(buf.buf, out);
> >> +		}
> 
> I tend to agree that the suggested structure is easier to follow
> than Phillip's version.
> 
> But I wonder if this is even easier to follow.  It makes it even
> more clear that patchsame commits that are not empty are discarded
> unconditionally.
> 
> 	while ((commit = get_revision(&revs))) {
> 		int is_empty  = is_original_commit_empty(commit);
> 		if (!is_empty && (commit->object.flags & PATCHSAME))
> 			continue;
> 		strbuf_reset(&buf);
> 		if (!keep_empty && is_empty)
> 			strbuf_addf(&buf, "%c ", comment_line_char);
> 		strbuf_addf(&buf, "%s %s ", insn,
> 			    oid_to_hex(&commit->object.oid));
> 		pretty_print_commit(&pp, commit, &buf);
> 		strbuf_addch(&buf, '\n');
> 		fputs(buf.buf, out);
> 	}
> 
> Or did I screw up the rewrite?

This looks correct. And the postimage is easier to follow than the one of
my suggested change.

My version is easier to review on the mailing list, of course, as it
minimizes the diff... ;-)

Ciao,
Dscho
