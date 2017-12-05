Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DF920C11
	for <e@80x24.org>; Tue,  5 Dec 2017 07:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdLEHBn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 02:01:43 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:45496 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdLEHBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 02:01:42 -0500
Received: from [192.168.178.21] (x4d075e6a.dyn.telefonica.de [77.7.94.106])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 87AC1140CAE;
        Tue,  5 Dec 2017 08:01:41 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.94.106) smtp.mailfrom=rabel@robertabel.eu smtp.helo=[192.168.178.21]
Received-SPF: pass (mxf98a: connection is authenticated)
Subject: Re: [PATCH v2 1/2] git-prompt: make __git_eread intended use explicit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
 <20171201233133.30011-1-rabel@robertabel.eu>
 <xmqqindmml25.fsf@gitster.mtv.corp.google.com>
 <e8d35c35-ffd5-ef10-bc6a-0834c1703995@robertabel.eu>
 <xmqqd13ukohs.fsf@gitster.mtv.corp.google.com>
From:   Robert Abel <rabel@robertabel.eu>
Message-ID: <818f414b-76ab-6e1d-0c5c-7f9959223e64@robertabel.eu>
Date:   Tue, 5 Dec 2017 08:01:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqd13ukohs.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20171205070141.8096.99089@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 05 Dec 2017 01:27, Junio C Hamano wrote:
> I know all of the above, but I think you misunderstood the point I
> wanted to raise, so let me try again.  The thing is, none of what
> you just wrote changes the fact that lack of callers that want to do
> "multi-line" is IRRELEVANT.

I disagree. The commit comment is meant to give context to the
introduced changes. One change is the  additional comment for
__git_eread, which now clearly states that only a single line is read.

I'm well aware that I'm not breaking reading multiple lines, because
that never worked in the first place. Thus, it was never the indented
use for __git_eread as I see it. I explicitly want to include that
information in my commit message to pay it forward to the next person
working on the prompt.

Regards,

Robert
