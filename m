Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75731F453
	for <e@80x24.org>; Fri,  8 Feb 2019 10:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfBHK6g (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 05:58:36 -0500
Received: from elephants.elehost.com ([216.66.27.132]:43882 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfBHK6g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 05:58:36 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18AwTXP056720
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 05:58:30 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <000d01d4bf9b$d5d48da0$817da8e0$@nexbridge.com> <nycvar.QRO.7.76.6.1902081155000.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902081155000.41@tvgsbejvaqbjf.bet>
Subject: RE: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
Date:   Fri, 8 Feb 2019 05:58:23 -0500
Message-ID: <000e01d4bf9d$38df5c80$aa9e1580$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKt9XefXcIt/s43+J5K5t2qIJW2rAH5tSP9pBOBnaA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 8, 2019 5:56, Johannes Schindelin wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org; 'Linux
> Kernel' <linux-kernel@vger.kernel.org>; git-packagers@googlegroups.com
> Subject: Re: [Breakage] Git v2.21.0-rc0 - t5403 (NonStop)
> 
> Hi Randall,
> 
> On Fri, 8 Feb 2019, Randall S. Becker wrote:
> 
> > This looks like it is a "bash thing" and $GIT_DIR might have to be in
> > quotes, and is not be specific to the platform. If I replace
> >
> > echo "$@" >$GIT_DIR/post-checkout.args
> >
> > with
> >
> > echo "$@" >"$GIT_DIR/post-checkout.args"
> >
> > The test passes. I wonder I should provide this patch or whether the
> > author would like to do so.
> 
> It is the correct fix, you came up with it, why not simply provide a patch
> yourself?

Will do (later today)

