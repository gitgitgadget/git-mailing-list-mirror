Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE620207D6
	for <e@80x24.org>; Thu,  4 May 2017 18:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbdEDSsR (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 14:48:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:53420 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdEDSsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 14:48:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1tv-1dLxMy0Z39-00LqRZ; Thu, 04
 May 2017 20:48:11 +0200
Date:   Thu, 4 May 2017 20:48:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
In-Reply-To: <xmqq60hgacjp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705042038150.4905@virtualbox>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <xmqqpofp9p1r.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705041129170.4905@virtualbox> <xmqq60hgacjp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1q+Zl9tAhgMd3zflI/n07cGj55K0pOzWy6wOU8MO+fN53/rzcgj
 4BUhifPIZmf6jgRhRGDd+H4eHjrj0m+nyNQqEHiVInHHVkEQ0OnEMlDhKH/udROpfM/Xt+v
 g+gOukTUy10kA/vfJkQ4LZhKzV3xEDFheke7bVcWCYfJwuTcnNb/9Ucjo5ZSnbbH69gmJzK
 sglOpyq8DfwzVuCEBUfyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dw4/jxfyOJE=:eFkAZHZQQTtxrESDPOCyhY
 H3lQZa/P7oRQKJmujjr9A6ZgdNHIJUysKzgRX4CvbFekv8b91kJLjYkYyqcUOoID36pRBWIIC
 a/kPiFNnz0UVUSqLnsIKzLDRFdCfq/8f7trpW+6NJsZRPwSq9+sGIamtjChSuuxkrg97DFaV7
 1/FX3JEPUsUiTCbjk8alcfNNiSDvBhF9isGFeBILkmRb7fqmS+sZDDEVKRF88C35g9E/coIk2
 wRT1T8bl0GEct1UKS3WCX5wG6YQxsV+uFUpBwTQr0iexPy9JOXXlC2TOq6/yOFwDQiKMa/GiL
 8f9eyR6+aQoql8imPQFqm+MjUh32KBmwOX7VZlYEbnaRWbeYd2uDsIGLXsSE99YBbSYLWYn3r
 W/RUhDvQPY3uHGgnbZQ6/1Tj78CfrStAmBOTVoexGY+Z/MekJi44YQuIfkn1NpQqlA0Ll7dBQ
 OITCCk+NJoyGo3MAJ2sDq4BmLqtER64rmvTyjyx7UoaCmAxTWxuLOZTpr3yalU3q1Dn7T05RS
 BuVKohBPFNdHQjeeC5XowRvku4T1ns1gm9JjSXzsdto12em8agvchLVq7HUpcqAOxjWmj09Lm
 tkflr/lcmpva97x2EnNHn6YJZZPIWMlj3foIVzIFWF8hLQ+d3ZJXGBS63sJQJxlKBiqzSzhPj
 Svt2sn4agrzxP26UFJu7xtbR4+URZfavecO/+NzQdK6plHIv6EjWL1ntrudW6e1m2wpMShMKN
 J/6Ki+5kEQ7zu7o337+efZmxwdP/BXrRdYOXIXdQR/ojcnJwLMpX+Y6sw/Jk4pKj38xhZDdNr
 SX6iYbJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Well, a couple of comments about your comment:
> >
> > - we say "shell scripts", but we're sloppy there: they are "Unix shell
> >   scripts", as they are executed by Unix shells. As such, it is pretty
> >   obvious that they favor Unix line endings, right? And that they do not
> >   really handle anything else well, right?
> 
> Not really.  I would expect that
> 
> 	cat A B C
> 
> with CRLF line endings (i.e. "cat A B C<CR><LF>") on platforms whose
> eol convention is LF to barf due to the missing file whose name is
> "C<CR>", while on platforms whose eol convention is CRLF, I do
> expect the contents of file C comes at the end of the output.

Let me repeat myself: `cat` is a Unix utility. Unix line endings are
LF-only.

So when you say "platform whose eol convention is CRLF", you speak about a
platform that is not Unix.

If you want to run `cat` on Linux, you have to have a Unix-y environment.
Ergo: LF-only line endings.

The real problem arises only because I decided to ship Git for Windows
with a POSIX emulating environment to execute the Unix shell and Perl
scripts.

The real solution would have been to push harder for "builtinification",
but you know yourself how hard of an uphill effort that is, as the idea is
still prevalent that having a large part of Git be implemented as
shell/Perl scripts is not only okay, but even a Good Thing (and
portability is then a matter of making every contributor know what
constructs are portable and to avoid, say, Bashisms or GNU sed's options
that are incompatible with BSD sed's options).

Ciao,
Dscho
