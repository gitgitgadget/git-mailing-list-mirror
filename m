Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7529202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 20:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbdKWUZw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 15:25:52 -0500
Received: from mout.web.de ([212.227.15.4]:60913 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753299AbdKWUZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 15:25:51 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLg8p-1eH8r142PD-000q1H; Thu, 23
 Nov 2017 21:25:49 +0100
Date:   Thu, 23 Nov 2017 21:25:48 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ashish Negi <ashishnegi33@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Changing encoding of a file : What should happen to CRLF in file
 ?
Message-ID: <20171123202548.GA30957@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
 <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
 <f9dc6482-587d-50a9-d649-aed63be18fad@web.de>
 <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
 <20171115171258.GA12963@tor.lan>
 <CAJ_+vJ7am7dU9B0qTYVtxpkHoZdV45ciZN5ifbv9W8xRO2o=EQ@mail.gmail.com>
 <20171116161506.GA20809@tor.lan>
 <CAJ_+vJ74mocjicpQ2BGUT+TrqrWqidp0bUJUGSz-B40-bC-c6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ_+vJ74mocjicpQ2BGUT+TrqrWqidp0bUJUGSz-B40-bC-c6w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:6NW6cLseXwemVSjTT277pzM8Yex6MiP0yhfXLT0fA8/H0lLJUyK
 cPOuvQG2pytCqWTCrp1F+Mt1hSCnUOLUhcHzHy4yv5AfnTwdNM1zOuF98uoVhsejyPQlmCG
 9hYAVUlkK0naLb7TaVPpFRmHNcBemTM/s35rcRXfRFtoku5ZjVa2VGtKceYC/xYThgW6bBL
 M7Q/IeGzfY0YepmOLNyUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/q2bGtlgKAQ=:GGYGoSglhG3Gm5i7HfValz
 UB70XyhEs/YNii5g43sxGrKcidwHXFq1O6CeMnwNPhd5J5yeq3qEqMAHSvUR5nsZS/VbpCwuz
 1vNatLEdxeJPST1e3A0+I1+etg0lG2VlXkPBLSb9kc+i/yL45a5NIIli/cgJYK7ajxuPrCMer
 11hCSKTSTeGIFNrWoTZHKJ9artFpZpmIlFPKQh4ua1p+NttqJRCvPJsxoShdC/g4YxtX8uJce
 PSTr99Mc+uCi3YPlL5cKcEeVfCcpKjvPFPskXsHzSUiHuHv984aH2cF99PJlL9Qf7kGEqC4Jn
 gZkZtK/q8/c/Qd7/hZqOQq5WsQbC5nsmA7VLTzwniAr3UzqnwqiF5uVde0JhE43tQgeByS3AK
 SXZngQwHoIjlhEVyKZLBBDctWsTRuPm6DhCFp7hmI0bfcgNZsYh5GoH4NKevmdAHPxcgwvrPh
 32FzVtQCKPGGqvTPexE7ixZcGHDhgyGpE4PM1pGGVXsX+bSvOsqfjgraJiM8+uhFlje8XiVCi
 MIOpGGvGyjSok8P+NGHDuzzGOWB1ERBPvh0oEirIrWkDMLRBlPeEu3SrI+0V0u9db+GCjQ7Al
 Ur3ueb4AW4tP3COjQX3RgqVNXnI7fx2vAYER1rf+CqWaoJtSCmsxDcgGjkUVWQE97m6ToPHvp
 HgiBBEdy9EfKOxQCM3SnUZ9akiGPmG86npmPslASAnDNlCU8KRwtKAeXWqoE7QzPhw32aAbol
 emwz6pGGlNPHGs3ulAclYn5TkC87fVwsatuoVvSaC7PmiuVdhD6k1UUXsNd+Ky2ATraP9vKfi
 1t0nwL2tgJYdMH4LYUgs/mJOSY10w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 10:01:40PM +0530, Ashish Negi wrote:
> Thanks for confirming.
> Is it possible to track this via a bug number ?
> It will help me to try out the fix when its available.
> 

No worry, the fix is nearly complete and will come out in a couple of days.
