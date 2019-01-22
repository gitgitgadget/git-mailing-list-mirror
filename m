Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6595B1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 15:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfAVP2H (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 10:28:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:50051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbfAVP2G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 10:28:06 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh9cj-1gYXoV0TK5-00MNDe; Tue, 22
 Jan 2019 16:27:58 +0100
Date:   Tue, 22 Jan 2019 16:27:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/16] sequencer: remove the 'arg' field from
 todo_item
In-Reply-To: <6bc7f154-a18a-3311-cbd0-c2a578931c4b@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901221627190.41@tvgsbejvaqbjf.bet>
References: <20181109080805.6350-1-alban.gruin@gmail.com> <20181229160413.19333-1-alban.gruin@gmail.com> <20181229160413.19333-4-alban.gruin@gmail.com> <6bc7f154-a18a-3311-cbd0-c2a578931c4b@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:au1NbqKFgHDatF92tQhRS+oPWtaSsIqAMaP5kFMEew9IRs6G4eF
 N5p/IDi2GsOoTglHxPNoq0Ua7TIFMdLe0Pg7JClNgpAlYreit5ZupGtbuedkFc6Wo65Ox0z
 9t0ztyjav9MU/NcijaogrgXcwgZ/SB+jIeTllt2FsBe8tSbAUU4FOsl5RJyXyYpzbK4wti9
 gZmQSqu74MnJhO3WGKQsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eS+zZtmPe5o=:5kuLg/IzG/tH5sMNAalwDu
 bV+lQjPcA0xEpCtQgGLsCX1ZCXczwjXVe88b2EPVAUgLFem4xs3KEC+RJfo1kpfjPuLkWLpSV
 Vdy5vmhlf8rIRIFpqz/amIEUDSGMs1xp4h7WTqbd8YwCqegluzCoMoRIdgGnTe3flh8msyNaF
 grd0B+Vr4mJexWd1dUFESWF/jxuvqybUkmQ3HWufe7g+sgwDVl4KazqknVzZ5FhHH7mQWEsDM
 kc7SQMvk+GlMZGpAgNSqiyFoEZuWv56VJEvMOgXkcGtP4x1cRpY1I1mfvotG6SzNKmTZMYC03
 UmXYr/wurEdDHBs9uuyKI1sy6RAe5PBCzh1h44vLTzFtlvVNdIBDPX4nrqmgvyg9bc8o+2lOG
 AJA9QWed/hol/Xf1s2FutZFoLJvbOFk2vHez+Eib86ti/4Y/DclG2+WFXxuMRTuFHRhiWrr/v
 KqL56hnhKAdUZKtu4T/HhN/gNiLugioCn1Ihv1N7QVaJ8P/34s+ibe66rtKezgwpZzmSAqRgp
 k/iIJpYgTFMGvMoNXIBvBnYWH3JPn+A/5AlKQNpQOUPMqX/2i09PFd4DcuouSiLcLPZJr9y1e
 uPru+6gNsq0l6BOJl+NUGXgrOGDDMcC+tMq0VOJiSbvL4OLFiKyN2e1D85h/fyuADu9tJBF3K
 UQ+ub+sPifm4VmsY7422RXjfdBY7/lDyC9Uu5LTprqaazFXVJIYrmSBSoKWspnlYkoyqojsdD
 qaVRzPyVEnBL/kwSurVN1tD5krMFKZ0v2P2m1H6eONBiS3mIo5MF9hFJMsMZWvn7SyTfTgt+3
 ndonBNiJ5SzGow/CTj7eJLcOZL6IgDRGMiJflE5X81QiI2V21qSz98qjpw2IyHWixQSZuD7qo
 ymluAagO/gf/PNh4e4jgogk7p6KfvxF5N7KjCLmv5erkdiO9F/OJtE0WwKPJh2oQg4PxXEcw5
 kh+AadTzQBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 21 Jan 2019, Phillip Wood wrote:

> const char *get_item_arg(struct todo_list *todo, struct todo_list_item *item)
> {
> 	return todo->buf.buf + item->arg_offset;
> }

I like that a lot.

Thanks,
Dscho
