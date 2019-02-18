Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA9C1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfBRUOM (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:14:12 -0500
Received: from mout.gmx.net ([212.227.15.19]:57295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfBRUOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 15:14:12 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOOpx-1h12V63Nqv-005tOV; Mon, 18
 Feb 2019 21:14:05 +0100
Date:   Mon, 18 Feb 2019 21:14:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Max Kirillov <max@max630.net>
cc:     randall.s.becker@rogers.com, 'Git List' <git@vger.kernel.org>
Subject: Re: [BUG] More on t5562 hangs randomly in subtests 6,8 and 13 in
 2.21.0-rc0
In-Reply-To: <20190213174055.GD3064@jessie.local>
Message-ID: <nycvar.QRO.7.76.6.1902182105520.45@tvgsbejvaqbjf.bet>
References: <000501d4c3af$1748b100$45da1300$@rogers.com> <20190213174055.GD3064@jessie.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ShTNEY9hovVGQe0uaFLB4OTBX2dnJFZFInXBnVJmO+RYLWcV+RA
 RxAhRLv0rIEL49GaF7M3rEixi5dlNWZ1Rwgt+X21QFStuwl3ciAXrcBvpL9sS2FpCTzUit1
 0JfT3eBVcFe619vZfsiUY+DvR5eNlXZ0/7XPFj0a+WOKKOzbAEWUwjnzRSWoNwEI+YA983x
 nIq2rYI+PEoy7cixq1spw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WtsYGdX52X8=:M0BDIsh3yZDfS4WrLr6SeA
 kdqeB1Hnq1la6aa0BqakF+AhgeREgxokr6YngJrC/rdegP/FlspyFXZ19nAGVsz1as7yo8znC
 GReA0Qo0j5rvUixbH4LW8xC1sjTKxZWZHMF4+hwiUTPRtpN23wXTl0Rkibtp9O1Hu0dJxEWAo
 Sx7c7o2fneApy+2SFdTasbSjpoX41DFrG4gnM9yBlGCxkOQywe7JOWa3mTnwZsP5r1kO82qrl
 Qv1+fjZFt+3fBcH3jV4Eo/V6JFKo8/LMBjF0HV0IkWJ4TNB/9OxfntDr2vL0E24XNpa0KFMBl
 PCs8y2DCclnZRPSz4D3GiEW+vgC6qqunmGObqNaEsTj5UiSNT3AvWmrJzepJp2dQaZL06YDWf
 nT88WJmo39CaH3w/03YwB/Iic/SlH0w+d3NcdRpphfU4EXXmc+u7Qxf4rEN5eQ5jP16rjq8dG
 NQUx48AgEXDxY4Znxl56mnM1y3+8A+eowXnck/paEw3DD6NglSWrR/w5yvoywKpDcLnfwt9nY
 Qp064fZJOiXvfZAYRj+wvnvXfq5Z/Ll+WAvbMdPgvhssm3VLN4lk09GNzPogrsrKftKdhrK2I
 l7e8RQtDwq+40+Ox96t8DlPmIBoOnA7833dJCfs9JyWJ1A04erSzX1MltwHwo9L8SjEq6zsUG
 S/Ze3ieyEU4ZJVacYDb1+BQ6I4W3VSfLAv/Cm+/RuQCJRrnJTYX9kcU0QFpF4M34f6LjFTyyd
 Md8Rk1yW11XmIOFHNodaf5X+3W9BKmsN/G8cJTnCa9LqRmQ27JAPz0oDJj4GlPKjiwuF6aA19
 ZZzonyTNAAS+e9VzxKKeBItdWqOGrMlh2bNg/UO5OsB6bzVZlRv/lrIu9HINoi47tgevO4Mms
 JKRstcg0JjdfCqfPpPRBdkkP9cjIGD4DQmnA7SdTLLykar/PkxOKzTqw5HtntsCTWH/9YguvO
 kHr6qMi7R4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Max,

On Wed, 13 Feb 2019, Max Kirillov wrote:

> On Wed, Feb 13, 2019 at 10:16:26AM -0500, randall.s.becker@rogers.com wrote:
> > On 2019-02-13, Max Kirillov, wrote:
> > As far as the unintended reuse of the output file, and issues with pipes,
> > yes, the NonStop is very sensitive to complex use of pipes and much of the
> > compatibility issues we have had relate to those (usually Linux-specific
> > pipe assumptions). That is where I have been looking when trying to debug
> > this situation (not yet found anything). This could very well be directly
> > related.
> 
> You mentioned cases 6,8,13. These are all related to gipped
> request body. Could it be the git-http-backend does not
> clean a sub-process which pervforms the decompression?

That is an interesting question. From what I can see, the
`gzipped_request` flag guards a call to `inflate_request()`, which does
not explicitly close stdin, is all I could see. But it does not spawn a
sub-process from what I can see, other than the regular backend
("upload-pack" or "receive-pack").

Ciao,
Dscho
