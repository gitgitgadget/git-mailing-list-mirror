Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8EA1F517
	for <e@80x24.org>; Wed, 13 Jun 2018 17:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935265AbeFMRVR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 13:21:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58513 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbeFMRVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 13:21:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8B40E28F5;
        Wed, 13 Jun 2018 13:21:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=sdXumw3lOEz+Z+N3/cqeugjzYzY=; b=RCtONoL
        rvGqxm4iyUYm6a17QyF7Lz2wjtNyOIqhJ/90SyLGyh1ov6Zn+5QWsV/tKxQdj/v+
        ArEpFEPnSOe8WpD8hIIPqAhJXowOATkeCT66BWL8O7R97Lkp1oVPNXqBWkWNKuCL
        IgJvuQ1ekC9U/wu4RnEutb8q2fzgnixv2P4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=Gmn/YPXJ/2IaYgXrpiLB32Wz6OWktja5Q
        u5WzIC8+TGeHT3Mjei9X0VOsbacvAwMFK9/48FClvCb4OJL5URjiUsHTXAe5WSUY
        5agEE7Ep0D2P2FRpkkjuNGoeucMgqLGbnQ1jce3/QVD/Uja5foBv+alRKTsdsdkq
        IiOrUnD3b0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C126FE28F4;
        Wed, 13 Jun 2018 13:21:13 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E62EE28F3;
        Wed, 13 Jun 2018 13:21:13 -0400 (EDT)
Date:   Wed, 13 Jun 2018 13:21:11 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH v2 2/4] git-credential-netrc: minor whitespace
 cleanup in test script
Message-ID: <20180613172111.GH3094@zaya.teonanacatl.net>
References: <20180607051958.759-1-tmz@pobox.com>
 <20180613031040.3109-3-tmz@pobox.com>
 <CAPig+cRcPD9vh1WMX7UkiD9R_A-DrybvOYwi3R8U2bskfOV_1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRcPD9vh1WMX7UkiD9R_A-DrybvOYwi3R8U2bskfOV_1w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 2C18D4AA-6F2E-11E8-A3CE-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Tue, Jun 12, 2018 at 11:10 PM, Todd Zullinger <tmz@pobox.com> wrote:
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>> ---
>> diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
>> index 58191a62f8..c5661087fe 100755
>> --- a/contrib/credential/netrc/t-git-credential-netrc.sh
>> +++ b/contrib/credential/netrc/t-git-credential-netrc.sh
>> @@ -17,15 +17,15 @@
>>         # set up test repository
>>
>>         test_expect_success \
>> -    'set up test repository' \
>> -    'git config --add gpg.program test.git-config-gpg'
>> +               'set up test repository' \
>> +               'git config --add gpg.program test.git-config-gpg'
> 
> Since you're touching all the tests in this script anyhow, perhaps
> modernize them so the title and opening quote of the test body are on
> the same line as test_expect_success, and the closing body quote is on
> a line of its own?
> 
>     test_expect_sucess 'setup test repository' '
>         ...test body...
>     '
> 
> I also changed "set up" to "setup" to follow existing practice.
> 
> (Not necessarily worth a re-roll.)

These tests were based on similar test_external tests which
use perl. like t0202 & t9700.  Both examples use the same
formatting (and use of 'set up').  Perhaps a later clean up
can adjust all three tests?

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
How can I tell that the past isn't a fiction designed to account for
the discrepancy between my immediate physical sensation and my state
of mind?
    -- Douglas Adams

