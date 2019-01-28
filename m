Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E171F453
	for <e@80x24.org>; Mon, 28 Jan 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfA1ONK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 09:13:10 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17515 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1ONJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 09:13:09 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x0SECPo3059455
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Jan 2019 09:12:26 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'COLLOMB Joris -EXT'" <joris.collomb-ext@alstomgroup.com>,
        <git@vger.kernel.org>
References: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
In-Reply-To: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
Subject: RE: Git checkout multiple options issue
Date:   Mon, 28 Jan 2019 09:12:19 -0500
Message-ID: <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF2nyvm1/JdLDX7iJPWJ1IP6XDHBqaA54ow
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 28, 2019 8:25, COLLOMB Joris wrote:
> git checkout -fb "branch_name"
> (force branch creation and checkout it)
> 
> doesn't work (even if option a separated).
> 
> I don't know if this is consider as an issue, but here it is.

I think you might mean (which works on every platform I have):

git checkout -f -b "branch_name"

There is no provision for aggregating options into one. -fb (invalid) is not
the same as -f -b (valid).

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.




