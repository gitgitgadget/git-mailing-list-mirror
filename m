Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D097AC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 16:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiAQQFi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 17 Jan 2022 11:05:38 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16958 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiAQQFh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 11:05:37 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20HG5a0o034487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 11:05:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <xmqq35lp68rw.fsf@gitster.g> 
In-Reply-To: 
Subject: Re: [ANNOUNCE] Git v2.35.0-rc1
Date:   Mon, 17 Jan 2022 11:05:31 -0500
Organization: Nexbridge Inc.
Message-ID: <026201d80bbc$10a251a0$31e6f4e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGnTa7oMwcFXa3F3zH2drJd0IRiN6zE1kmQgAP1A/A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 14, 2022 9:19 PM, Junio wrote:
> A release candidate Git v2.35.0-rc1 is now available for testing at the usual places.
> It is comprised of 467 non-merge commits since v2.34.0, contributed by 80
> people, 32 of which are new faces [*].

FYI: rc1 built/test (mostly) passes on both NonStop x86 and ia64 platforms.

We seem to have a recurrence of a transient failure in t5562 from a few releases ago. Retesting makes the problem disappear.

Subtest 8
#	
#		test_env HTTP_CONTENT_ENCODING="gzip" test_http_env upload empty_body &&
#		! verify_http_result "200 OK"
#	
Subtest 14
#	
#		test_env HTTP_CONTENT_ENCODING="gzip" test_http_env receive empty_body &&
#		! verify_http_result "200 OK"
#	

Am I mistaken that using the ! verify_http_result construct is not recommended or am I misremembering the discussion?

Regards,
--Randall

