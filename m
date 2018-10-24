Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77991F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeJXRxT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 13:53:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:50875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbeJXRxT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 13:53:19 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8IuM-1fKmvL1Ehu-00vvDH; Wed, 24
 Oct 2018 11:25:53 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8IuM-1fKmvL1Ehu-00vvDH; Wed, 24
 Oct 2018 11:25:53 +0200
Date:   Wed, 24 Oct 2018 11:25:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] run-command: mark path lookup errors with ENOENT
In-Reply-To: <20181024091617.GA25118@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1810241125360.4546@tvgsbejvaqbjf.bet>
References: <20181024073637.GA31069@sigill.intra.peff.net> <20181024073800.GB31202@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1810241054110.4546@tvgsbejvaqbjf.bet> <20181024091617.GA25118@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PRc7sGaBEQdO5+fx38CFG30/z+ZRLE9lZJKThRjYiNYRwdtZc7H
 X8H+1sayUg+wvGfLDkzScpf0fCoaoYtTUmB2WIjHdFknrYyfaWIWPQIPOzTSl5BKLo9KrkR
 8UrrU2GwrGYLdntaJmqvi7henp/O8n3Q15MIT2aWw2FIZp3i28PSn/y8N+/NX9XdPwIWAAK
 rFEcV2Z2mIySpdl0Hl7lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:voUjrc5a51o=:mcpTyCd5zPK1a8tO6x682Y
 1VscaOpPcgZH/NmJLIy+O4OucFLMjsHzh87TgJOIrpVOhfJpyeFMz1mudMWJxVoF7dF1MAoDJ
 7WHXl/XpDZQTTwVI4ArJDjCzvilmiDFnjutiE1GTEwb1TnT2Y5Eux5ytCrOalifp1owEGhGEm
 EBVnvEI0qGqPcWEuepn62lmbpJa1R07lm+EDTf61WuENyIm2N4B38YNbRDnZ2h3pwcKs7iHLO
 QEwJYKt2ClYJAzNQLSsU8eSHV5GYA9elXQ8Pb6hldaEi84zXlhb8nHwTjpHaQy6lEQQbBp0z7
 N3ONBuYKER/XCg0Ong4jbFwHOL8hTOm42CSjrWK07lE5kGZnPANoAgzyyhYYWc7JH5+bsdj1a
 /WVZMjg5Eejh+3v2tGn2pU8CBpihe6Po8wYmHyCxSdJRFM1JnttkqPI9waqWTjiolVrbF1Cwo
 8ZPiTKkpzL6xVM9yiIc29nGmiBAZJmIxP5MBSAkyE8THl/kPXg/s35w0y4j7duOAQkvuGQ2l7
 f4vp7sUolt+IJUd+ycTecDzfFfZNIw9WpAJPFIH5CWjI8S3NiuRLF/3S3yu2xOX0j8legtPqC
 3Ve/QXgHcONUQdPj95ZY37YmyfeULm02D6zXI8OZFVIFXHxijrQMuj85CyBI4t+WeioeKUl9w
 +aK0l7G61ZJSj4l2A43Tbzpu/1hblLm78tWCIPp9VPeeR5foTx8Oz+4pBDWPhIIAO7IqdhdL4
 p6Sfk22iRB0nfXPU5UWkqmwaU1ESS5koZpIvbMZjP9l4Un6WOYlHKq3pJWQQ//x4Zx96umDgB
 4P56QwXcZ66wWWw8pXzU/+EMFMBMOe7dUUoCzz7pthGkjtoRl4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 24 Oct 2018, Jeff King wrote:

> On Wed, Oct 24, 2018 at 11:01:54AM +0200, Johannes Schindelin wrote:
> 
> > > @@ -910,6 +921,7 @@ int start_command(struct child_process *cmd)
> > >  }
> > >  #endif
> > >  
> > > +end_of_spawn:
> > 
> > Sadly, this fails to build on Windows:
> > 
> > 	run-command.c: In function 'start_command':
> > 	run-command.c:924:1: error: label 'end_of_spawn' defined but not used [-Werror=unused-label]
> > 	 end_of_spawn:
> > 	 ^~~~~~~~~~~~
> 
> Doh. I didn't think of that.
> 
> > How about squashing in this diff:
> > 
> > -- snip --
> > diff --git a/run-command.c b/run-command.c
> > index 639ea5ac3366..3f03795a5995 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -918,6 +918,8 @@ int start_command(struct child_process *cmd)
> >  		close(fhout);
> >  	if (fherr != 2)
> >  		close(fherr);
> > +
> > +	goto end_of_spawn;
> >  }
> >  #endif
> >  
> > -- snap --
> > 
> > I can confirm that the result compiles and passes t0061.
> 
> That leaves the Windows side of the #else with a funny, useless goto
> (and without even a matching useless one on the Unix side).  Let's put
> it instead inside the half of the #if that actually uses it. Like so
> (actually courtesy of Jonathan Nieder):
> 
> diff --git a/run-command.c b/run-command.c
> index 639ea5ac33..d679cc267c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -868,6 +868,8 @@ int start_command(struct child_process *cmd)
>  	argv_array_clear(&argv);
>  	free(childenv);
>  }
> +end_of_spawn:
> +
>  #else
>  {
>  	int fhin = 0, fhout = 1, fherr = 2;
> @@ -921,7 +923,6 @@ int start_command(struct child_process *cmd)
>  }
>  #endif
>  
> -end_of_spawn:
>  	if (cmd->pid < 0) {
>  		if (need_in)
>  			close_pair(fdin);

That works for me, too.

> Thanks for your review!

You're welcome!

Thanks,
Dscho

> 
> -Peff
> 
