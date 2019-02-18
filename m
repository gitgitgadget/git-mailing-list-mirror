Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9561F453
	for <e@80x24.org>; Mon, 18 Feb 2019 18:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfBRSuw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Feb 2019 13:50:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:64918 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfBRSuv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 13:50:51 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1IIohjG074640
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 13:50:44 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Max Kirillov'" <max@max630.net>,
        "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>,
        <git@vger.kernel.org>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>     <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>    <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com> <xmqqef852awh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef852awh.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Date:   Mon, 18 Feb 2019 13:50:36 -0500
Message-ID: <002401d4c7ba$d95a1130$8c0e3390$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFycQzmW9pNbu02MZcMspejNiBnQQDz28D8AaU7wHUB79R99QHgiIWXpndHrxA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 18, 2019 13:46, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I have been wondering about the whole /dev/zero business.  Although we
> > have b46221ff ("Merge branch 'rb/no-dev-zero-in-test'",
> > 2019-02-13) in 'master', "git grep /dev/zero t" has hits in
> > t/helper/test-sha1.sh and t/t4152-am-resume-override-opts.sh, so it
> > must have been somewhat incomplete to help platforms that lack
> > /dev/zero in the first place.
> >
> > We haven't heard from Dscho in European timezone, but I'm inclined to
> >
> >  - keep b46221ff in 'master', not reverted.
> >  - apply Max's "t5562: do not reuse output files"
> >
> > to 'master' and hope that we can declare victory in this part of the
> > code ;-).  There may be fix-ups for other topics before -rc2 on top of
> > that, though.
> 
> Just to make sure you didn't miss the exchange, the above plan is still the
> latest ("Max's patch is [1]).  As I'll be offline most of the day today, you still
> have time to stop or make me change course to avoid disaster by interjecting
> (which would be very much appreciated).

No interjection expected. That is what I have been testing, so anticipate that this is correct.

