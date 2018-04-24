Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 470C91F404
	for <e@80x24.org>; Tue, 24 Apr 2018 08:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756531AbeDXIL5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 04:11:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:49209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756488AbeDXILw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 04:11:52 -0400
Received: from [10.49.234.97] ([95.208.59.141]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5uLh-1eDaOD2xvl-00xqHJ; Tue, 24
 Apr 2018 10:11:41 +0200
Date:   Tue, 24 Apr 2018 10:11:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
In-Reply-To: <0E6803122A5241F98148087A045993BC@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804241006230.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <7360a072f6fdd276d30839613434329b645e2cce.1524306546.git.johannes.schindelin@gmx.de> <9270DF86352B4E3493AADA159E7FFE33@PhilipOakley>
 <nycvar.QRO.7.76.6.1804231401130.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <0E6803122A5241F98148087A045993BC@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IeMh8wE7OqnS84Zl9TE1/N13oY+1EBZx8Bcrx+6MCc9/mS3sihr
 YiYxlUu03n8jkmsse8Ikt1cLhPhzO2yRbQ37uUG+JJpnABN2l4aYYI5t+Jw/pciYcaGsue2
 zT/9g+tN8aOAsYByEdbIFE6+ozljtIV5PxZNUfyB/iW8UnoT1khat/drCsmk/PXiSuQjhQr
 6xtmGqoQGKGemqrLn0zvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7dxGIZsgxWw=:nC7Y3niCuDhveDZTBHpkhO
 O5sbk926mf8oYptUXKv6pCg18cNZXMC4HeVb/I6lcak8nIvd3aZcK7C7izgwFTDeyHPLzK8NF
 /FO2Inft6ervxbNcXMLYUpWsxBo2CBh1xvcnuCWs7s6xqihExv7Uz1TVCbhiSWlIVK9rYA7LZ
 KIKwqEMqB4lRhQMX2q8gno8SmMme9e83C56/5gfj4e3/s2twTwSIFJhtNOIaJ5iHtndIRoWRv
 lM8EE7m9Za/Yy3qsdf8UfIbuT8JYfrsgOoAlfpm5RKfJTxURwttxt3l2Jixyhx9eabeP7nVBJ
 2xKebCnlg42d12WuebC/1Wbj/8Zy5bs8UQXljTvzqiz20NWKWhgWe6dbcoQHWYChhhfpU4azM
 8XkfE1BZUWXPqRULXs0sGfaq2BXw6A9+/Wu/7btxU8WfxZmyCHl39pfK2lEye5NI5txsTJouY
 vWGyPwFIaDWlhsKtsAS0Vi4423Pg1iHfhq0mTzly/QcnM/4fOSdO0NXETmcomw/+6FidWnhZi
 39IjkGjsdcEgaG74SDJdS9ooKfzOBnMAJ6kg24kqXSP6mzBLP37cc5o2CAxbOOe3NF0RbXFge
 tuoqWklO80ohlwpUX3VupiHLlxkMGwJwrJHgFNwtCcfzfteuY/N15zFPSPpiVPMJeygwP4odf
 vhE+JftOb1DROIvE9F6gYXTrR/HFmFSyAPj42e+S1/UHCoh+PFbcLdwkHcCex+Y/ks7BupsQ7
 v2zVQvVGVo0tJ1Jf5T6K4hTgArQApZ+KZn591jPy0xjVcZIYWqP0HPK1JaeeuTyccDRBfgiJT
 a+YBZbRg/koT+4MYps7gAvnpsmrM9v5nCSamYIa3+RlXR4w/rw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Mon, 23 Apr 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de> : Monday, April 23,
> 2018 1:03 PM
> Subject: Re: [PATCH v8 06/16] sequencer: introduce the `merge` command
> 
> [...]
> >
> > > > label onto
> > > >
> > > > # Branch abc
> > > > reset onto
> > >
> > > Is this reset strictly necessary. We are already there @head.
> >
> > No, this is not strictly necessary, but
> 
> I've realised my misunderstanding. I was thinking this (and others) was
> equivalent to
> 
> $  git reset <thatHead'onto'> # maybe even --hard,
> 
> i.e. affecting the worktree

Oh, but it *is* affecting the worktree. In this case, since we label HEAD
and then immediately reset to the label, there is just nothing to change.

Consider this example, though:

	label onto

	# Branch: from-philip
	reset onto
	pick abcdef something
	label from-philip

	# Branch: with-love
	reset onto
	pick 012345 else
	label with-love

	reset onto
	merge -C 98765 from-philip
	merge -C 43210 with-love

Only in the first instance is the `reset onto` a no-op, an incidental one.
After picking `something` and labeling the result as `from-philip`,
though, the next `reset onto` really resets the worktree.

> rather that just being a movement of the Head rev (though I may be having
> brain fade here regarding untracked files etc..)

The current way of doing things does not allow the `reset` to overwrite
untracked, nor ignored files (I think, I only verified the former, not the
latter).

But yeah, it is not just a movement of HEAD. It does reset the worktree,
although quite a bit more gently (and safely) than `git reset --hard`. In
that respect, this patch series is a drastic improvement over the Git
garden shears (which is the shell script I use in Git for Windows which
inspired this here patch series).

Ciao,
Dscho
