Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB581F404
	for <e@80x24.org>; Mon,  1 Jan 2018 22:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeAAWMS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 1 Jan 2018 17:12:18 -0500
Received: from elephants.elehost.com ([216.66.27.132]:41683 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeAAWMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 17:12:17 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w01MC966037438
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Jan 2018 17:12:09 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Eric Sunshine'" <sunshine@sunshineco.us>
Cc:     "'git mailing list'" <git@vger.kernel.org>
References: <004701d38346$7dd4be00$797e3a00$@nexbridge.com> <CAPig+cQ_H20ON0usig-FWj7YVF_AOR_yvBRhXJeFmRv_w7pZAw@mail.gmail.com>
In-Reply-To: <CAPig+cQ_H20ON0usig-FWj7YVF_AOR_yvBRhXJeFmRv_w7pZAw@mail.gmail.com>
Subject: RE: [Bug] NO_INTPTR_T not being honoured in compat/regex/regcomp.c
Date:   Mon, 1 Jan 2018 17:12:04 -0500
Message-ID: <004a01d3834d$91bf2520$b53d6f60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE3cxGYCsV/QOaTOLXHLdw3/n0bvAJDGDFipIWa4uA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 1, 2018 4:51 PM Eric Sunshine wrote:
> On Mon, Jan 1, 2018 at 4:21 PM, Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> > * I have defined NO_INTPTR_T = UnfortunatelyYes in config.mak.uname
> > for my platform. The c99 compiler I have does not define it.
> > * The code compiles except for compat/regex/regcomp.c - not sure why
> > this is being used since I have also *not* defined NO_REGEX because
> > regex is sane here.
> 
> Presumably you're compiling for NonStop? config.mak.uname defines
> NO_REGEX for that platform (it also defines NO_INTPTR_T). git-blame points
> at 6c109904bc (Port to HP NonStop, 2012-09-19).

I got rid of that entry 3 years ago but did not contribute the updates because there are many other platform dependencies including FLOSS. Caution: that particular commit is not usable or useful on current NonStop operating systems.

