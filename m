Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59191F442
	for <e@80x24.org>; Thu,  9 Nov 2017 18:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbdKISrK (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 13:47:10 -0500
Received: from mout.web.de ([212.227.15.4]:56331 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753293AbdKISrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 13:47:05 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MX0q4-1egcbp2NLI-00W1ss; Thu, 09
 Nov 2017 19:47:01 +0100
Date:   Thu, 9 Nov 2017 19:47:01 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Introduce git add --renormalize .
Message-ID: <20171109184700.GA27635@tor.lan>
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
 <20171030162913.23164-1-tboegi@web.de>
 <xmqqvaimeixm.fsf@gitster.mtv.corp.google.com>
 <20171107172659.GA11119@tor.lan>
 <xmqqlgjhobb4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgjhobb4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:1/m/DD0YZ6JwfkjLHhMpaDGGM04zh+3nu4To8vzIREtZs3szeBd
 C0/MHixHQGZDewPUOucWC2exFfbgY5p570vMv6uLnYHi/9EGlUP+W0dUKqvvmmlUMVhnogS
 Y3ZPFQvP+qNER6AsHIezASAQH+SVo1o9mg0EMOO7HqS1VWevJG9kQltigymmaSe/tdVr8kX
 92DBYW1Xa3/QprBSuewMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jRdrQVErBio=:MXLHqAVgXi3jCMYuocrR48
 1ZhTJHWFvIU+YN8v6EWt0Pz33ULVkeG130zAYGdpQDTuF2DTNCOF8FvcjCyKzY4Jb0bMHc09b
 TMkhjnVreeAS7dQH8i6E+UKQw3hfmtqP2raxsVqS3ETCJWzzBfXlJpYMRyKDRZd8ZmoVxEwk9
 cszZQH4lXilVyFHBhV+4ceWn13Z/omLj8JWDI1Sp5azxkUwLw+2UZCQTnYFJaZ9nRPOBt5yhh
 em6JhF0VF0LiO2c+tX/KfPbAHtmVs+MREeOkw+Ux3bRyKdUwNtxmd/zt/8r9CI7lfg2tff5Qw
 RgZZanrk4fOS6+uzXMcd+7F3prdQFredj8+v4pXeZW+R0WYKglkDTdvO3pe+Ma3ntGzZNqpxS
 ZPEdWqGCSTeUpSrAgHaO2mqARPoq7veD1BTcDGTPoSvgfYRnFii8a7cJZ/oJG/LLmJXF0JpX+
 RLMBGEyYW/IdXZPQQgJ+1lZjfpynbAaJtvDzBcBSrXP0buj2aF0baXtg8rtild50P2HalSEv6
 tnAGTLgKqG2PlyGgm9RI/EI5+a/whDg3sYnpF+Fe1Ws3SxpEdbOyCNj1g3cRLakp6Mku+qMsd
 45ganEKmk0nj8QwU3nv/DGUGxVi3gHU152/VjNjD9Zl+zYlbsLiYd9bT5T8fDHHl3PGWwTq2I
 G14qQOFovCAhSS//4lo9y5bEka160UvOd70sGv7Pf1JdhtU9CpExJhcKk2wYjCzITPL4K1PsM
 8VAaaTObTdLEslCcSJzbVRyfzoiiqmFROsJ2hxFTGURVrXrD9NMEtS7Rn4j3C0jLU+7vNhdzR
 NYdrfD+uDsWfz1+nxx2CSNzxip59w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
> 
> If we had such a term in Documentation/glossary-contents.txt, we
> could even say
> 
> 	Add contents of all paths to the index by freshly applying
> 	the "clean" process, even to the ones Git may think are
> 	unmodified in the working tree since they were added the
> 	last time (based on the file timestamps etc.).  This is
> 	often useful after updating settings like `core.autocrlf` in
> 	the `.git/config` file and the `text` attributes in the
> 	`.gitattributes` file to correct the index entries that
> 	records lines with CRLF to use LF instead, or changing what
> 	the `clean` filter does.  This option implies `-u`.
> 
> The point is to express that the CRLF/LF is a consequence (even
> though it may be the most prominent one from end-users' point of
> view) of a larger processing.

Here is a somwhat shorter description:

Apply the "clean" process freshly to all tracked files.
This is useful after changing `core.autocrlf` or the `text`
attributes in the `.gitattributes` file because
Git may not consider these files as changed.
Correct the files that had been commited with CRLF,
they will from now on have LF instead.
Re-run what the `clean` filter does.
This option implies `-u`.


> 
> > [snip the TC. Adding line endings is good)
> 
> What is TC in this context?

Sorry for confusion: TC means test case.
