Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222AC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A18E6194D
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 22:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYW30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 18:29:26 -0400
Received: from elephants.elehost.com ([216.66.27.132]:22286 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 18:29:25 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 15PMQwUn027747
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 25 Jun 2021 18:26:59 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqr1h1mc81.fsf@gitster.g> <YNZW/zsk93Oi/8uY@google.com>
In-Reply-To: <YNZW/zsk93Oi/8uY@google.com>
Subject: RE: What's cooking in git.git (Jun 2021, #06; Thu, 17)
Date:   Fri, 25 Jun 2021 18:26:53 -0400
Message-ID: <01f101d76a11$36700be0$a35023a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJh33r36qlxp1nkpeYqbNBmQkN/agHwGQXJqgDiQZA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 25, 2021 6:22 PM, Emily Shaffer wrote:
>On Thu, Jun 17, 2021 at 11:55:26AM +0900, Junio C Hamano wrote:
>> * es/trace2-log-parent-process-name (2021-06-09) 1 commit
>>  - tr2: log parent process name
>>
>>  trace2 logs learned to show parent process name to see in what
>> context Git was invoked.
>>
>>  Will merge to 'next'?
>
>I've still not seen much in the way of reviews on this series; mostly Randall and I have been talking about ramifications for
NonStop, but
>those conversations haven't resulted in changes to the series itself.

I'm waiting for the merge to try it in our environment in some real-world situations on the platform. It should be interesting to
see what can be reported and subsequently contributed.

>I think it's fine to merge, but I wrote it, so you shouldn't trust my opinion. :)
>
>We've been running this series internally at Google, though, and it looks like we do want to look up more ancestors than just the
one
>generation, after all. However, I'd prefer to send that as a follow-on patch, compared stalling this topic further.
>
>We do have some early insights from these, though. One interesting observation is that it appears Git is more often invoked via
some
>wrapper than interactively; that's not too surprising given that we have a lot of builders who perform Git operations.
>
>Anyway, all this to say that we've found this trace useful at Google and it's working well for us. Anybody interested in a speedy
review
>would be very welcome.

