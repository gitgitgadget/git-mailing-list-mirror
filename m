Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C1E20248
	for <e@80x24.org>; Mon, 25 Feb 2019 22:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfBYWHu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 17:07:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:57375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbfBYWHt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 17:07:49 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNuwp-1gx2YW3rUR-007Sg9; Mon, 25
 Feb 2019 23:07:20 +0100
Date:   Mon, 25 Feb 2019 23:07:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: drop MakeMaker reference
In-Reply-To: <20190225200225.GA16965@google.com>
Message-ID: <nycvar.QRO.7.76.6.1902252304180.41@tvgsbejvaqbjf.bet>
References: <pull.146.git.gitgitgadget@gmail.com> <061093e2f000829a560e7bcce1dc86cb6babbca5.1551122830.git.gitgitgadget@gmail.com> <20190225200225.GA16965@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XloGEJZ5g3MyB0KjvOvzWa5WeG7ke8r+3UQ2kNSb151yyBJkCBl
 hqXXAoczFZmW9qi2baYf3NitvIWfp8i/lAqE1hIi57Yf5YgD542XuNQLSr8EMnQuIqytEqK
 qePdV0oKup/LsnObN4Oq1zE9AgGQS+HsVpySUwbFd3jXlXLGxK1/gQIGrpuuTD09q/WbSW5
 9reAmlN4xqH1R3fwpDwZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bs7hbf7uAts=:5w5+xqSQQHC/y4goiRogk9
 y5herzSJSc0jbbPrBDHJS0sjxDNXjSdiZxkFTCJJji2R+YKtqrk6iI3IfTBMA4ICemWTZYESB
 FMHmKBLy/FrIxfiTdCfWG4ERjA77jVB/Lo3527Z/az/o5wzoF3MB2+Mx2v+o0ku9uZ3wNhGo3
 kjdcbOfw+vDmhRUMzBBz109rp07UA9iDNB5s1FBSENiPI6UasDYUHzGjbldON8jfQ/FTMP/Lf
 r1jembQKv2cRUfqsMvdRSUvBLCsBYok2q0t66u5uRoMWbptVd6wJ0Gj+fh9MpcA719Btgxt2e
 jYd40czu3qjKWSfXSGVBokhl9Xz85gVyFuVtFcyRIqbg4er4l6OGQ+5sIDPnkDeqwLW+iBfUe
 bjgxXFTm5DOMVlTHN5Qfr6DAf1vRoQldxalPbdOu3doDFA6AiN5WlQt1ekn+WZC7Iz3ZJ5Reu
 8vkJti3/G5KhSZ4sr2oliHhBree2i/lSVHmJKmmFzlAsQfTKh3IgmV1OeWtIghF4pKVcd+kto
 yEE/deyHgsZ7OOTTGZN63z34OPqM6DYhIphj/90MRDPiiRr5Ud1TMPTFyaWDc+oxFMkni/FLf
 S4NHMCDsI1T7/I3FXpz76cDCrliPfl6AVN2EkvtEsCGHeKR6cjIvFBL4Z82pQmIdyJAOXyrom
 TaeD8S5TghvFB5Z/aESdpU4yGW7qRQq0pjiH0CkKjXJJ8k8ppUU957Vaj3xWB/5gB1Vx4kuJ+
 D6uu820s+a797U40QFond/RbnL+oZC6xg+t0E7hDUMDwmnJQjzwl05LPUi4tcohxWByoVy8tp
 qrXXOp5faM/4EYndxlL7AOSurlCd7hjiN0u4Z4baVGSxGkrSHZnMxPKp6cidSPTOZkq3enyT1
 RgNg8Ds64+zvyGhGHKCpOERM9Y52GROJ4mUFnPmtl8aYqv3S0dudbEkpAGsNJqyHXOZ7Nkl64
 l6QiUHbYQNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 25 Feb 2019, Jonathan Nieder wrote:

> Johannes Schindelin via GitGitGadget wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 20d2a30f8ffe (Makefile: replace perl/Makefile.PL with simple make
> > rules, 2017-12-10), Git stopped using MakeMaker. Therefore, that
> > definition in the MINGW-specific section became useless.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  config.mak.uname | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Yay!
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!

> Is there a way to automate checking for make variables that are set
> but never used?

No, not that I know of...

The biggest problem is that we only add documentation to the beginning of
the Makefile by convention, and there is not really any consistent way to
parse that documentation to figure out what build variables are handled
currently.

Ciao,
Dscho
