Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD7D1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 23:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeBZXXv (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 18:23:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:51571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbeBZXXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 18:23:51 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lj61K-1eIlnY39Qs-00dBZD; Tue, 27
 Feb 2018 00:23:46 +0100
Date:   Tue, 27 Feb 2018 00:23:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
In-Reply-To: <xmqqwoz3ttod.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1802270022120.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1802231310120.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqwoz3ttod.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bzv8TfnVZHwqc9mKye2sPUgFu1MsyyJw4QUlLt3ivBqKk4m4P8Y
 AkrrtIiNbmKqge7HKf/80bgZzxYot5NlDe1tQcd7bYJhoikbo6N6IFjADDsbcdZM/KGWCYc
 8jZkSwzONSFe5ox3cD3QVSA1rmX8S2m2/nqLBWaXT2cEQ5cPwFE+Ja1GI5iCni7Q+Qz8GOa
 97++PhFdMg09nGe57j+2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1Je50uwYYKU=:pjrHvecml57Jllrd6fIDq7
 md6sTIr8QqwUGFMrJUAoURncj67DmevazstgvWGYcubEAmc0BTzZYq4EobBB8oVpvppAyRuRI
 qYd/05i0xmbLYmisOBXHReC7F2zrrxEsGsnhnhAzj+6QUhD+BfHMIGRWPhsbf6upB3K1qiAxU
 Fq8k3X0VEmAH5B+/ywEUvePhwK82lJHHQVqylY3uCzqrrEOxkeLsd5fT8fd6O/BvkJk2qR8GJ
 IJ19Sb+FmDCz25Cpz3UhfWkhwpkvTw7fdBtnXc8Y31tdplvJ55sSq7+Subc3ZFKF7B6C3ip+R
 jyUagToYkL8ttCPxifcxdq9cBEtFYfXbwOdUQ1otk3bEilJ2WjDh9GgTDTPSo5kIsNr2CEkxL
 1fvSrPTk6mljXcqbT6HBV0x+NPTWNk+OMpo/j8ZfV4PIOo//FIuo2rlpb61cgvJ3iNll87XT1
 4sKCVXhSu1M1Jf+m/z9hJBrXifpIkAx9tsi3i4WST/o8oFqNKSVm12l61vTBBAiWDFvHturLa
 QRCzCkeOgPEOZ4p59DzEBsCb4R8hds0qHyNB88clQu8REzIAkM4vRlyoWW3LxIcYtkc5uLA/R
 R1QfQfw1N/dVVQcavFJahwHRQtz61r70BOHBenypzCIzUE4SK5R1NNpLT9aJR0SZ35NXXfImp
 1DliPfBowbrUdsb1Kqhlo+J6RlWsWrBIugQ5m7jJKRcJBHWzm/MEL2/pKQXBzei7MSf8AUkzR
 uPwrLiE7xq1i3ryOxg533UD1+DjL81i5qT6n2va5lepVNtIQ/EbVGKokzJjVDgGmlXmbKJPWD
 z3N7WiQZ2Q2wLVERJm5gw9iq2NwMldz5cPEdsJWGbnHhJJcM2DuR2pQRRkqz0anlHGbUObX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 23 Feb 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 21 Feb 2018, Junio C Hamano wrote:
> >
> >> * js/rebase-recreate-merge (2018-02-12) 12 commits
> >>  ...
> >> 
> >>  "git rebase" learned "--recreate-merges" to transplant the whole
> >>  topology of commit graph elsewhere.
> >> 
> >>  Is this ready for 'next'?
> >
> > Not quite. I have two more changes lined up. Let me send v4.
> 
> Picked up and started looking at it.  Thanks.

FWIW v4's patches are identical to v5, but the interdiff as well as the
pushed tags are completely broken in v4 (culprit: an error in my script
that I recently converted from Bash to node.js, where it would not stop on
`git rebase` returning with a non-zero exit status, fixed since).

Ciao,
Dscho
