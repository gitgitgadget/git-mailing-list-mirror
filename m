Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303F81F859
	for <e@80x24.org>; Tue, 16 Aug 2016 13:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbcHPNLN (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 09:11:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:58866 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbcHPNLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 09:11:03 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MZCxA-1buctw3XrA-00KtxH; Tue, 16 Aug 2016 15:10:48
 +0200
Date:	Tue, 16 Aug 2016 15:10:46 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
In-Reply-To: <20160815184315.cyhln2bxg465lq2l@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1608161502240.4924@virtualbox>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de> <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com> <xmqq4m6mhsvj.fsf@gitster.mtv.corp.google.com> <20160815184315.cyhln2bxg465lq2l@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5Ltt3B9jgyJ5patIOZq1qsLaleKHuoKmxJyQc39aQOtfFpXBb8P
 nTaSHQEN7nNwabE0ArIgpf6y3wtz1IutuggkF2MsPM2f+RBmJYkTwS3OV7K0ICpbG+N4MMz
 a7qSY6PXjbfaTm0rrri3tYncjJKqTbRYKbzRP8hVf/Dg4+1iKmyI/U8VkrFYllvBf2/dq0k
 LgpIQyQpAvpNh0fFS2rLg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WWbczEPFXXE=:s8CJDYbAUSFCd0qJI/vSHG
 0ZMb3zMC6f5QwqUXHgan6sIjUUwZByQYDFag7KU+KWvsU+DF3F1r7XLmwwT/TaDRUE5J7ds5Z
 iqmLiDUPJ3ZnKUdAkOMVCRJOg90dNp42Ikg6E+h0C48UDJlqomAe2/wNT+OX8yjD8Dr4FunWf
 G/sfv/O4FM/qbxT5J6y+IHSpvNttjTfPATIVvOe9MzLf4wfKTp1sd3GMbqi6l1F1rE16t7pt8
 3ntgAIK9H3GiJ2K7oOZEIppU0aEX10M4ifVlFXj5PVmjOP8lD9jOcsXJA6T7eE4nieZknPXkw
 yEm9wZbD+1ujwXoi1q87GJEuIKe5+XBBBL3uLtW3UZg+y8Ma5FgEHcKWd1R/pPDuGw52Y55CJ
 KCx303rezl2hfM5+gkqFo+wZ0c/ISmEgcPQT5oxy2It5u1JoeCXGrbe95CyaeLbVOZluLNusG
 Tz6Y5P4n3gkRFlMAPR9DaRA830iLhOUSAUKykYaxmprwdXpGI9MoUfrcgy5LnnDIph3+2rLm1
 P3dUKxdzcwMm0DOrFm6oNkx47bmpU7e8aAsPMoJqtDernSR27EXgzm2kS6JJvZ+Hpn7q/mBjO
 S/1HpRuRsgESDUUNY5bpVIxiIzkgMetb+duXURtkNlwzSwdTn2y32XHd+HgQb+sjwV0MyxeH8
 M74sYYK7Rpn+ymRMlxVRUEjMdP3dRWgIyZmuTmG8q8B/iqvASw47WEK6B93/y4h/qdcM99UW2
 T0hXF+eLNgtT2pp/6LagYPvkplIjy7/NIq5aBMKN5TyLTSsTSXvhnNELwWS+qjFVD+k2mHRxu
 +KZsYaM
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff & Junio,

On Mon, 15 Aug 2016, Jeff King wrote:

> On Mon, Aug 15, 2016 at 09:57:52AM -0700, Junio C Hamano wrote:
> 
> > I wonder if we already have a good mechanism to allow a project and
> > its participants (say, "me") to declare "in this project, pathnames
> > must conform to this rule" and help them avoid creating a tree that
> > violates the rule customized to their project.
> > 
> > I guess "write_index_as_tree()" would be one of the central places to
> > hook into and that covers an individual contributor or a patch applier
> > who ends up adding offending paths to the project, as well as a merge
> > made in response to a pull request (unless it is a fast-forward)
> > [*1*].  The pre-receive hook can also be used to inspect and reject an
> > attempt to push an offending tree into the history.

FWIW I think it should be at a different level. See below for more
details.

> > Such a mechanism would allow a project that wants participation by
> > folks with case insensitive filesystems to ensure that they do not
> > create a directory that has both xt_TCPMSS.h and xt_tcpmss.h at the
> > same time, for example, but the mechanism needs to allow visibility
> > into more than just a single path when the custom check is made (e.g.
> > a hook run in "write_index_as_tree()" can see all entries in the index
> > to make the decision; if we were to also hook into "add_to_index()",
> > the hook must be able to see other entries in the index to which the
> > new entry is being added).
> 
> I am not convinced this mechanism needs to be built into git. Because it
> happens to be about filenames, git at least has a hope of making sense
> of the various project rules.

Both of you gentle people may recall a conversation in December 2014 when
we scrambled to plug a hole where maliciously-chosen file names would have
allowed to wreak havoc with a local Git repository's config (among other
things).

We did plug it, but not before I proposed to exclude many more file names
than just maliciously-chosen ones. For example, I wanted to exclude all
file names that are illegal on Windows when core.protectNTFS was set to
true.

If we were to implement this "let's help cross-platform projects"
functionality, it would be at that same level.

However, I have to agree with Junio that Git is *not* targeting *all*
platforms. Conversely, any solution we implement to try to be helpful by
pointing out unportable file names will certainly fall short of *some*
project's requirement.

Given that we have no shortage of problems to solve, I would vote for
addressing portability only as far as Git and its intended target
platforms are concerned.

Ciao,
Dscho
