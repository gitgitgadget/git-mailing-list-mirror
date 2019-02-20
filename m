Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA881F453
	for <e@80x24.org>; Wed, 20 Feb 2019 13:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfBTNzP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 20 Feb 2019 08:55:15 -0500
Received: from elephants.elehost.com ([216.66.27.132]:13228 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTNzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 08:55:15 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1KDtCKW031307
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Feb 2019 08:55:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
Cc:     <git@vger.kernel.org>,
        "'Lars Schneider'" <larsxschneider@gmail.com>
References: <000f01d4c915$9c4c76a0$d4e563e0$@nexbridge.com> <20190220125303.GQ1622@szeder.dev>
In-Reply-To: <20190220125303.GQ1622@szeder.dev>
Subject: RE: [Breakage] t0021 Subtest 15 v2.21.0.-rc2 on NonStop.
Date:   Wed, 20 Feb 2019 08:55:05 -0500
Message-ID: <002701d4c923$e6337f80$b29a7e80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGwHdVSg4RxeLZ6JvDY11RSiNVTswEW6JZ5pilUZ9A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 20, 2019 7:53, SZEDER Gábor wrote:
> On Wed, Feb 20, 2019 at 07:12:49AM -0500, Randall S. Becker wrote:
> > Sadly I have to report that this subtest breaks on NonStop as of
> > v2.21.0-rc2. It succeeds when run with --verbose, but not without,
> > making this difficult to diagnose.
> 
> That particular test is known to be flaky, see:
> 
>   https://public-inbox.org/git/000901d4bf98$1ab08fe0$5011afa0$@nexbridge.com/T/#u

Agree, but it's been a while since it broke here. And subtest 15 never did from what I can tell.

