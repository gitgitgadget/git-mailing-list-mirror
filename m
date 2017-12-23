Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8931F424
	for <e@80x24.org>; Sat, 23 Dec 2017 07:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750800AbdLWH1n (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 02:27:43 -0500
Received: from mout.web.de ([212.227.17.11]:60101 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdLWH1m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 02:27:42 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McFTf-1eiw9O2ATf-00JZwC; Sat, 23
 Dec 2017 08:27:37 +0100
Date:   Sat, 23 Dec 2017 08:27:36 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/1] check-non-portable-shell.pl: Quoted `wc -l` is
 not portable
Message-ID: <20171223072736.GA30043@tor.lan>
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
 <20171221212646.24461-1-tboegi@web.de>
 <xmqq4loiqxn4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4loiqxn4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:wWOAlcjvW8wRjMaWZc2TDYGhr3A8SASlyaZ7aHaOZMqXyZ+bUjP
 dg3pfedMgqrrF9eXBgP6I2tsLnS60DuqxyNWsX5Nb1p1dWyVWfXwH/Zqfucqi5cP8PeszFg
 v+cShOD282tmU1NBWbbJ8eT98qbFlWuNgFqAf0i9aNQU7HVGj2Ctg8Z8ejUAy+ndvs6bQpr
 IH19rDcTNY113AdeiDZrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dvXkcaRknis=:HLVEqBd/PNoc6aR102fNhu
 RjJ55EAEymeMWuvnnJfnJ71zaHUUEMn3E/2RgXvLaA12zC+NVzuTVRraENd+qco0rRJ4Cm4AU
 9HFeoDIxBi2hUmoWoAhxxUhey0YpaITX0TIahGn3ci8n/7mahjlH/UxsAvLGRpCtdpYWHVjv+
 hr3Y7ECcgrOTYnnM6PukvLdrDnb2wg1vrl4HLi0XNCrMxzfH7i6pejfI/9dU/QR6EwftZ2+8g
 /9k/+mTpoNcaffA1zLKKg7GzjEigy95v+383uql3zMJdMCBLLObol+obhTUcgxGQQoEyPWKH6
 aBp38Zw9rtdEQuqNRCkmgHSJnfl3tXph2r1b4VSmf/xboTmDcYv11GtmUfdEf58W4N35p04XA
 QZc/pwVpd1Od+Cw1iQRyhVRii0GhEibsd15bi/7owwjx56H8vlAQf6q52Ytu5P+/gCmsSrZQ2
 qrVCpk4Lo4dIZRvv6JJ+iIqp7+7RMwmfV60L0oXl3rDIIhyAem5d/3VVjzAZJBqmN+HDe3Rww
 1JT2Jf6zaK8AtcLoWuvSdV2URxWJTszLzr1xZ0DvQzuO5esKA/Jo6S6KsGxwZbpeCiV1BXlwN
 dTgo/Zl0IWNmO6NLVKPULWfE+SeUZt2dhFItDcbzB7aIEiv2RynhGZbxRDSHsMYNDqEt3ItIw
 GIwzfExdOkrlnsMV+Hmjw0bW/eVvQhoNQW7Eh570K0eZuy025lqvrJuoNOwzD2zqrG3c6ZL3h
 bxQjy+AgxjiGWkiquhpEJi+Ho3VtdWmCujrz+hjKR5j+uFThCd05m+BZDH4cSl+sXrFm4xfIC
 dvvWFy+cd6D9LvDiD/8SZkImfFsUJFk/f+gHBa3V1Iaya4NEnE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 01:07:59PM -0800, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
> >
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> 

> I'll flip these and add a helped-by to credit Eric.
...
> Don't try to apply this patch to your tree yourself ;-)

Thanks so much for cleaning up my mess.
