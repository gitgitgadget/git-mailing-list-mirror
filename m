Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404381F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfA2Pjf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:39:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:40873 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfA2Pjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:39:35 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUpFU-1geV4P2FcS-00Y9er; Tue, 29
 Jan 2019 16:39:29 +0100
Date:   Tue, 29 Jan 2019 16:39:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: tt/bisect-in-c, was Re: What's cooking in git.git (Jan 2019,
 #04; Mon, 28)
In-Reply-To: <nycvar.QRO.7.76.6.1901291506080.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1901291636270.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1901291506080.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:X4/mAgyL8GXUIDBBIJn423JU9y1qzEUv7ftHjAc2MBfkEcIsdP3
 +ypG5JBLWWYYaP8SI//u57cRO6Y0BXDYpsBrg1jThdGZZbACgWac8SD8AxWvyql2uOTnxet
 wLnkSBbhSt1raysurCUzuyD9HABjjhjhVD68uqOac9KPG9R/x9lIAJitEszjMaEvASY6rhV
 0XGzcac7rcwNIIvs2YsNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UNmu3XhKHPE=:PIJ8JTfYk8TNPRIfRFiYL7
 MzZ3ZVU88FUU5lc/vkxKGI/gr2x/eMn5Xv304ye+Qzt5MPRF8Qp+zS8RBBwGB8s/HrxAIKUl9
 mDozzPGrCy0sxBY1LP0+cp7yjmPBNF9WpaLBilrv+zkqtLECHMUkfQE8xExG1qqbcTvND58Cf
 v9BTIAoDzrSEf6oedQgH+ZEutARQ2jHA5fFvHSi8BREIMOtTtgNzBTYw7LE8sQi4WXZdiEsvm
 P4M2jLMPtXb6Y7tbKpXIpbdMrt7iglqwO3Y2H7SggTucpIUiiY9jiLc6XMoL1uVuxp2CVfF2a
 ki/jqAGuuOYN09l/llTlFSRg7UF1pfBNntH/fL36pkT7ukSUaEz3k2uLeNqsSuxDxSzl2Meg3
 KiHVWhFkemj2LBxrQFgP9b+I/pqZiPb6kFYNh69xCzu1IPDERMUztzUdXqtv0eazivJgmWs6w
 93BvSZ6EqsU1GmZ4rYHbVdGxMREEmVJLqDZfUKMBrrmiiN7GkN7igcB6R/lx2pX1EqKp9QOFV
 ViOQ/zYKL1A1wmIjcn+SjmEYpexMFDGJJKDMCaMKCRYgmNx38V4q6pDJNfC8D6WTdaWooeX74
 9QdChIoNAxN6ZY2IfaQA2Vb5RmXFgeLciFBLFAlD5EX/WB/JFooIy0Hu66yOzmBcWADxtBiVF
 QIlyj+Yq/Seh57oES7OT3ZSJ2QNpZC+lKHqeuiR16VREVs0rmvdmZa2OZQV5UnfWVa7lwrgbJ
 TuDEx9DQ9XyBZOTd5YX+ZFEDyEvTkD35wUjLWx2SWxCtggN1BqZmNB8kF50sLzQUHbPTO8pwV
 j+qlrFIeXN1Q78wK3J2ObRPu76FxCWgsMLhmkwI0g8ZGTLBD2hvfw82HUAA3zHeyXcv0jqolw
 0RM1l8JStpylNANQh/AofDPMziiy3PUDvNVxIlM+XFMlnmwBc0+po4wVnDiTQye8i2t5Ivury
 22jzj3VuAKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Jan 2019, Johannes Schindelin wrote:

> On Mon, 28 Jan 2019, Junio C Hamano wrote:
> 
> > * tt/bisect-in-c (2019-01-02) 7 commits
> >  - bisect--helper: `bisect_start` shell function partially in C
> >  - bisect--helper: `get_terms` & `bisect_terms` shell function in C
> >  - bisect--helper: `bisect_next_check` shell function in C
> >  - bisect--helper: `check_and_set_terms` shell function in C
> >  - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
> >  - bisect--helper: `bisect_write` shell function in C
> >  - bisect--helper: `bisect_reset` shell function in C
> > 
> >  More code in "git bisect" has been rewritten in C.
> > 
> >  Comments?
> 
> Just to make sure you know: both Chris and I reviewed the patches before
> Tanushree sent them off...

Oh, and I just realized that there are 4 merge conflicts with `master`,
all of them related to `the_repository` changes. So they should be easy
enough to resolve, even if I still think that it is a bad use of
maintainer's time, and asking contributors *not* to rebase projects too
much of distrust in contributors' skills in my mind.

So I suggested to Tanushree to ask you whether you prefer this not to be
rebased.

Ciao,
Dscho
