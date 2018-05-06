Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CEB200B9
	for <e@80x24.org>; Sun,  6 May 2018 12:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbeEFMWH (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 08:22:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:50237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeEFMWF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 08:22:05 -0400
Received: from MININT-6BKU6QN ([81.92.17.130]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lee2I-1eXfvI1TcU-00qR03; Sun, 06
 May 2018 14:21:54 +0200
Date:   Sun, 6 May 2018 14:21:54 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lxDIRqPUuduTAVxgnVinA+Mlonx+Lo/6uLVuXZdd6HLdfoNekNZ
 Upkp8c9CXaaD16QZQjSMx/MsECyvzFybIi++fr41C6aZ2LYK7qyfJkeUdXjI4/wkGUJWf7v
 +kWybriZ78T4HB3R+zhDPDIALa5sE4vqsn6mKHajfBhbFRZXM26L9VC/E8VUY3vcyHKI5HM
 7uOoD/lhZwnUaCaFAxpJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0YrztD3MROM=:nDJ6UgBsnQNfgTdq0DE6T5
 xc6lS0xhnZKDEWoT/FHv71E/UvcbBryImK8FA75RYkCQwLHiccoKXaIf+Buu1RuoY7T/8FEG+
 Etnp+Sl+X23cLYQFGISi2Tj2L7gIzvF0DK3ndI4O8zHVbmv8OScAotasxMYtOq1gZzESwVnAk
 JDGDeaf0afagPPSdTsGNKwYyFjJfMVPDk0D773zcKOVit0M+CzhnuJu1Cf61+wQOiXkDFJtCn
 ybB4uDcRejDcc5P+bAdwRnylqMng0uQr6Ua2zT3HrIDBM9IryP6H3esEImA8ZjkIGCHgWppvO
 OBgpjuAZly1sm2aOV6z39ycLHREv9/ruhsEE5whlSZ9+TeGX86mPFP8JnrEFFK1cUALSdUKPF
 h3avP96dQ1q4cKNHvZAa1xXspHuEv9j6vYPye7PtayQn5NKC1TP1PCp1BRAzFOhaO5Dswq5bw
 ena6QS1WgjYuTW0Sdk2182tYcFYgdtxcIYUc7ayPRFdrqS27E0shDxTzG7WJ2FVVkTOTmfeET
 5/xe9TwuiwixemDDZ01J/HX8SWPVOLLkh2IXHTDPzMqf4d3ivRx1iRCGCyPnjO7gJaZF+vds5
 PpKFoPU/iuxfTyHB0+Of1e/jiauqqvHc8LlvJUdea6yU9IV8MdL61A32u6vXBo5OfQ/GpElpk
 yYd/b1jsqjRcOvVxRB/DfVm3Lg08yeNVsnLyGmbU0y6EumX53BD8k4vAg1huUlrksJsvLVp18
 tPUfLjR795qKDMUM3uLLzM5duV2Drv80jtHSZjXSGxHCoahleokc+outFKXqkxm4w96O6jmTa
 qEGnpP5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 6 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 5 May 2018, Jeff King wrote:
> >
> >> On Fri, May 04, 2018 at 05:34:32PM +0200, Johannes Schindelin wrote:
> >> 
> >> > This builtin does not do a whole lot so far, apart from showing a usage
> >> > that is oddly similar to that of `git tbdiff`. And for a good reason:
> >> > the next commits will turn `branch-diff` into a full-blown replacement
> >> > for `tbdiff`.
> >> 
> >> One minor point about the name: will it become annoying as a tab
> >> completion conflict with git-branch?
> 
> If tbdiff were "Thomas's branch diff", I would call this jbdiff ;-)
> but I think the 't' in there stands for "topic", not "Thomas's".
> 
> How about "git topic-diff"?

Or `git topic-branch-diff`?

But then, we do not really use the term `topic branch` a lot in Git, *and*
the operation in question is not really about showing differences between
topic branches, but between revisions of topic branches.

So far, the solution I like best is to use `git branch --diff <...>`,
which also neatly side-steps the problem of cluttering the top-level
command list (because tab completion).

Ciao,
Dscho
