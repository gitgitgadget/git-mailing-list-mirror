Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68211F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeAXW13 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:27:29 -0500
Received: from elephants.elehost.com ([216.66.27.132]:44723 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXW13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:27:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0OMRPO6028415
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Jan 2018 17:27:26 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Todd Zullinger'" <tmz@pobox.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <randall.s.becker@rogers.com>, <git@vger.kernel.org>
References: <20180121234203.13764-1-randall.s.becker@rogers.com> <20180121234203.13764-2-randall.s.becker@rogers.com> <xmqq607rdmka.fsf@gitster.mtv.corp.google.com> <20180124220146.GI1427@zaya.teonanacatl.net>
In-Reply-To: <20180124220146.GI1427@zaya.teonanacatl.net>
Subject: RE: [PATCH v4 1/4] Add tar extract install options override in installation processing.
Date:   Wed, 24 Jan 2018 17:27:19 -0500
Message-ID: <004401d39562$8229d6b0$867d8410$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG+M0yL6q6MsDdNM8SZpgZC9eG5XQCwztsBAVnGvbsCSFA0yaOLxn/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Todd Zullinger [mailto:tmz@pobox.com]
> Sent: January 24, 2018 5:02 PM
> To: Junio C Hamano <gitster@pobox.com>
> Cc: randall.s.becker@rogers.com; git@vger.kernel.org; Randall S. Becker
> <rsbecker@nexbridge.com>
> Subject: Re: [PATCH v4 1/4] Add tar extract install options override in
> installation processing.
> 
> Junio C Hamano wrote:
> > randall.s.becker@rogers.com writes:
> >> +# Define TAR_EXTRACT_OPTIONS if you want to change the default
> >> +behaviour # from xvf to something else during installation. The
> >> +option only includes
>            ^^^
> Shouldn't this be xof?
> 
> >> +# "o" as xf are required.

Drats. Can this be changed here rather than reissuing? I will sign off on
the sticky finger typo.

