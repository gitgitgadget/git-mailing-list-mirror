Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7281F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 15:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeJLXFm (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 19:05:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:33761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbeJLXFm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 19:05:42 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MF9WR-1gR9WZ3CCx-00GJ3a; Fri, 12
 Oct 2018 17:32:36 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MF9WR-1gR9WZ3CCx-00GJ3a; Fri, 12
 Oct 2018 17:32:36 +0200
Date:   Fri, 12 Oct 2018 17:32:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v3 0/2] rebase -i: introduce the 'break' command
In-Reply-To: <xmqqva679sc8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810121732240.561@tvgsbejvaqbjf.bet>
References: <pull.43.v2.git.gitgitgadget@gmail.com>        <pull.43.v3.git.gitgitgadget@gmail.com> <xmqqva679sc8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TQor12nR6gKvBdOxQwGi59jAVPInyXz1y5cxJF8anS6zUfnPB4g
 RgCmVTb0Aw+RrXX6UDsUI8HQlLb4A6a4IjW0uphVdvfcMS8ySeN4XxqzC9/xM3DKnWN4JYN
 Iq8uCYvkPGNYp5ZxiJfxcGu1SXJ7/ClaVfSBS+V9hQCU8+dQfrlp9sNy3055hHCjsEdyVZl
 usmWsmti0ktTKydTlOEPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wI9l0JhMsD4=:AAW3p2zwE64kWCpR4w0wgK
 Vt889apcUtvbofwdobXRnrihZOgvk+3sY+nIbJStlsE9NKJKjuWviPweBPBbn+3CQaJcXESV/
 GSdiPc28l9g+3Ubfw1HEVoOZRVD8W1KvDHgemz7W6ctSXkIb73FwxW/+5LZp6VGSlWZY7WYBv
 xoPJdYrST/qbbex37A/hoFZ13Coq/KWe2Qc/YczElS0NSkwxIaQxOi+/sSrrd4Ebu5S6vy9/I
 8jfbhUWOzbUWTLwbQyVQUa4PFpUNmLSM5im3y97nzYu5h+rI0pvHXFXmModkwV9fw/6yUfzhb
 PbsTUprdnwDFHcChw9gQG8Uvt1j1cz7rNkvs2qSkxPLePETK9ACkcA2PK9mXsa/NIATeEMmEM
 Ap7Vkq9TfH2ux3vgO46BftubbtQGHiuPGiWNpHF4aepFK13gCyqjPV4DoFoWMT7W+coysVz+v
 aPFAIHRVwGJqSuW9hqcYV8PxTp6DzewDmjIL2yJ+XJZQSXS150g0kacfkwJ0FOhDWXp1/0qE6
 A3fRYVsmpiFAWjWrp7pC6vOs9J+OACCFJHXl+BP0abHpNPwd+5965ick+zt3meVd+i6ZSYtcb
 CldAk4dvTjwryLmINtfp5wccjhZt2bX8P4IiI1R77hLxkBhJsqQc/G/J0B8TVUD1X52GwiwVG
 dVm1Q1pbq1R6J6rtHGujGA+Ohrgq87HaXld/ywtRN0YurJ8OFLoyzKpdn+LNhDjGDu8tBm2fF
 Ss6kfgK8sg8xzLHKJU7jPllPFZE82mGdOoDPZYnxF6sOCUtUdCtQIZRzmg8r1IyVd2dHrxUuM
 OHQh4mMBzsL942xmMJtr2Pl0gmPdr2N0sgMpAdda8E9afOzz1Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Oct 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > This patch introduces that, based on ag/rebase-i-in-c.
> >
> > Changes since v2:
> >
> >  * Fixed two typos.
> >  * When interrupting the rebase, break now outputs a message.
> 
> I was about to merge the whole collection of topics to 'next', but
> this came to stop me just in time.
> 
> The typofixes are appreciated of course, and look trivially correct.
> 
> I find that the if() condition that does too many side-effect-full
> operations in stopped-at-head shows bad taste.  It is still short
> enough to understand what each step is trying to do, but would
> encourage others who later may touch the code to make it even more
> complex.
> 
> But it is a short and isolated static helper function, so I won't
> complain too loudly.
> 
> Will replace and requeue.

Thanks,
Dscho

> 
> Thanks.
> 
