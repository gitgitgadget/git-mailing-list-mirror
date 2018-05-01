Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DEF21841
	for <e@80x24.org>; Tue,  1 May 2018 11:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754478AbeEALnP (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:43:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:34251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbeEALnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:43:14 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxt3Q-1eJTGR1q4q-015KW4; Tue, 01
 May 2018 13:42:59 +0200
Date:   Tue, 1 May 2018 13:42:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
In-Reply-To: <20180430095044.28492-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805011338490.79@tvgsbejvaqbjf.bet>
References: <20180430095044.28492-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1215703075-1525174981=:79"
X-Provags-ID: V03:K1:wK4+1fg31v3YIWealqi1TERGEcdVS7HxowbjJKxsm3ZEIBaQJ8F
 a8I4aKJb9j4K9Nc+auGRPCOcd6UetDWPK3so5QR/TU10qhE7S8g7FG/KEDM1R2sLJxqMHED
 E97ipnbXdz/KJSA6Kbuq9H8c3+yMGB6oHNjZ2bWWQil/P2kMIdq2KcwzfqcgQ5Co8Z2AVxJ
 4PTUiwF5+vF+14V9Dwqmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ycRqBzU19H0=:npCzJCW/hKb9yWeie6l41u
 QuhYO22z7UrHtSmNfQW+d06Kmbt1vRn+quGKOHrE8PDA/blxpgAiF2apswSvy5MWfHW+McqSN
 IqwrIqlW8UIfPSH+W7bzNtl5apKiqL/RkrEkQ3wzY40ibdoxVjDErRgbtIO6h6glzST/UX12N
 aQMhQ84kL7SaWye7jpbb2qiGhg40tM7FdJkSZghgG87fqYAZebi5Z48aq80NG5kk+nl1/3/Or
 K6AKJHNWTft2aFdpEEJFbVRxEsmiGzR6qmBU3uzuSD6oUpgBQT+9xxtweHBowG4XxDy96eCQf
 kFTjo13r36vQ0oLSVfvjWb6XtPkQdDDY4VhPqoPCAF++bEAU6AdJ4TQnvop0wNUmhE77JavTm
 ELWf6sSQGrhHIER6DlbQe/zhTtjuWrYFYGaHo3XmuhfMJPMZBVS/gipUC9iST9HJdP32lZPnA
 AYzSX8NcWNO0C7YKrndE4A2VQ9itnxNLBXHS4R6STD17ThHf89USlv/bAIqJYA6W+VZFqs0NV
 kJkHEExsXK4obFQAjz9MMXNHu3XnqBhSgo59XrIz2oRZNw5/lDssL9hDjkHbVMNxji7iGf/ew
 LBNI3s9vBOEtwdpT66sJwL2d5wlkUcvazNJ7Z2RywIMUuNScqfAlQhl1ZE/mk0t4NaY2vwxvz
 +Xf1wDumHCYBNRP4tUo0ISHlGAuUVLgZBk/I3tWJJ/2TeNZln8bwC3zesaqGlS4phAto14ZWu
 mikkJfqMkPovGGU8Dys7xeewKKvQcbsf+PXmsNFaOOW57dGrgnp5NQOFNgEfB/Od/KHbzaiRX
 DsVxZ+p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1215703075-1525174981=:79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Mon, 30 Apr 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I think at this point git-subtree is widely used enough to move out of
> contrib/, maybe others disagree, but patches are always better for
> discussion that patch-less ML posts.

Sure, it is used widely enough.

However, it flies in the face of so many GSoC efforts to introduce yet
another one of those poorly portable Unix shell scripts, as central part
of Git's code base.

The script itself does look quite straight-forward to port to a builtin,
so why not give it a try?

If you are completely opposed to porting it to C, I will be completely
opposed to moving it out of contrib/.

If you need help with porting it, please come up with a task plan and I
can jump in, to help (but please do collaborate with me on this one, don't
leave all of the hard work to me).

Ciao,
Dscho
--8323328-1215703075-1525174981=:79--
