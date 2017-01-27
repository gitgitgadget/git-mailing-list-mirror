Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEBF1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933836AbdA0RfV (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:35:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:56281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933253AbdA0RfP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:35:15 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMIO-1clVsq1lxs-00EJt2; Fri, 27
 Jan 2017 18:34:48 +0100
Date:   Fri, 27 Jan 2017 18:34:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/1] reset: support the --stdin option
In-Reply-To: <20170127170422.lvpghp6jdud37zxx@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701271832270.3469@virtualbox>
References: <cover.1476202100.git.johannes.schindelin@gmx.de> <cover.1485520718.git.johannes.schindelin@gmx.de> <3b0bad26045ed175f40f050e15b65cb6a8f2368c.1485520718.git.johannes.schindelin@gmx.de> <20170127170422.lvpghp6jdud37zxx@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:581J01jFKCoqymZmMHrGMCZIkcO8WuuuWQxwKxTVoahG/aVivGc
 BZTnCwccNYSRkyoDcVUEb/arY0Ko9gSOYL+H2U7NTbWtfwxGCE8T57oWXCah9hpNin3K5Ll
 aIyl19ILj7Gw01g5FP6WFVIV4oemxvr9pa6LreO3tc6akKLRM+MhP/lyplutfI5ILmEKYD9
 kxrNlHDockHXIIcO2gw7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8nAcgBiuj0Y=:HdKVDKGyWxKkoJCmk0l/R+
 mUtOJxu/XkeUeDguyobT0scoPy19Sy9hHkaEFWoizUYTUSSGsMSiFWIQgU3d+waB4Wr6xMe5q
 OtZCDM6uUkdA4qy9tO6bEBRUOeLFOcaRg3fKHdgT3CRjh3XgCVEMQz7EPx18CWW/5SrbOVNkz
 dw3Mb1/kiCdWqKSvtd9w30dEaSFJyYuywBI0xD92ifFkCHAvEq38SylMCYDzH1C/WqbG/BTJP
 h2xrT8sCS1UrUWa+Ol2icpkD9xB/JPntZCK/kLwu2JPP2rYlDn6d/tPyUYrnU6Bz29OeBRGlv
 9fqMgU3BwaAVjmD8CcNqHU9/OCsRUpm0xD6ag9ids04k32t1TcJE2sX0ji1c4lZkKudx7tt/W
 cu9jCbrLkki0+1nzGypy3WjVjWAePRqseuzm/W8zZzfO/2JrPG0Xwj9bYJ5mgRly2bjanDD90
 Du+XXLZn4Pyhf1jyVWaQrTcvjl4po7Cp6WBcKkG0/Pvm6gsYVP6aWv1c6XbxZuuIS0PXiRvoT
 gBpoi2qEn6z02DL3Tp67Vj+h6y6ZDI+Crn2rSiLbHH/DVjdaymGOihYmx06Eie2dKgNEQ7x4U
 odFzgaM9B7i9dUWRGOmz53A5kPdqA2uV0FjapQihKmmSbBmX9qFBE5dTG9wjBCqORBK3/MNei
 IO+zYHVeU/U5Yip9lELf64qFIuGyjm2ngVa098s+35Kb75rdEc/NNlt3xtqaTReTQX5sWtXqB
 DfbpBUE1lWyPKNZoezdiEiuBMVMmwbBFHeJVdcFw3gkBsMgq8sBVgAlDc2hAJJn6r/hbtV8v2
 utEjXbC8zP6hcF1deplwmdw5olNaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 27 Jan 2017, Jeff King wrote:

> On Fri, Jan 27, 2017 at 01:38:55PM +0100, Johannes Schindelin wrote:
> 
> A few minor suggestions:
> 
> > +--stdin::
> > +	Instead of taking list of paths from the command line,
> > +	read list of paths from the standard input.  Paths are
> > +	separated by LF (i.e. one path per line) by default.
> > +
> > +-z::
> > +	Only meaningful with `--stdin`; paths are separated with
> > +	NUL character instead of LF.
> 
> Is it worth clarifying that these are paths, not pathspecs? The word
> "paths" is used to refer to the pathspecs on the command-line elsewhere
> in the document.
> 
> It might also be worth mentioning the quoting rules for the non-z case.

I think this would be overkill. In reality, --stdin without -z does not
make much sense, anyway.

If you feel strongly about it, I encourage you to submit a follow-up
patch.

The rest of your suggestions have been implemented in v3.

Ciao,
Johannes
