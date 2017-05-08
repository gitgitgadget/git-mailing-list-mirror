Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899641FC44
	for <e@80x24.org>; Mon,  8 May 2017 14:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbdEHOnE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 8 May 2017 10:43:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57342 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbdEHOnD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 10:43:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v48Eh0dV091936
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 May 2017 10:43:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Ciro Santilli'" <ciro.santilli@gmail.com>, <git@vger.kernel.org>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
In-Reply-To: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
Subject: RE: Add an option to automatically submodule update on checkout
Date:   Mon, 8 May 2017 10:42:52 -0400
Message-ID: <001b01d2c809$62ac8520$28058f60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJFtsy+gX9bRxHg9rX7flyynOAlG6EEo5Rg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 6, 2017 4:38 AM Ciro Santilli wrote:
> This is a must if you are working with submodules, otherwise every git checkout requires a git submodule update,
> and you forget it, and things break, and you understand, and you go to stack overflow questions
> http://stackoverflow.com/questions/22328053/why-doesnt-git-checkout-automatically-do-git-submodule-update-recursive
> http://stackoverflow.com/questions/4611512/is-there-a-way-to-make-git-pull-automatically-update-submodules
> and you give up and create aliases :-)

I rather like the concept of supporting --recurse-submodules. The complexity is that the branches in all submodules all have to have compatible semantics when doing the checkout, which is by no means guaranteed. In the scenario where you are including a submodule from a third-party (very common - see gnulib), the branches likely won't be there, so you have a high probability of having the command fail or produce the same results as currently exists if you allow the checkout even with problems (another option?). If you have control of everything, then this makes sense.

Cheers,
Randall

