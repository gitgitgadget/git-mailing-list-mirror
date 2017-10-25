Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F18202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 08:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbdJYIDU (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 04:03:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42198 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751589AbdJYIDP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2017 04:03:15 -0400
X-AuditID: 1207440e-bf9ff70000007085-65-59f04540a092
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.BB.28805.14540F95; Wed, 25 Oct 2017 04:03:13 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC93E.dip0.t-ipconnect.de [87.188.201.62])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9P839AI021125
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 25 Oct 2017 04:03:11 -0400
Subject: Re: [PATCH 1/2] t1404: add a bunch of tests of D/F conflicts
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <cover.1508856679.git.mhagger@alum.mit.edu>
 <be088bd57e61f4ea0dc974a65829a928ecd30534.1508856679.git.mhagger@alum.mit.edu>
 <CAPig+cRLB=dGD=+Af=yYL3M709LRpeUrtvcDLo9iBKYy2HAW-w@mail.gmail.com>
 <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e66694a3-98e2-33aa-4cdd-dac41d2a89d5@alum.mit.edu>
Date:   Wed, 25 Oct 2017 10:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171024194634.pigmvgoqtdexvjhc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqOvk+iHS4MxSdouuK91MFg29V5gt
        frT0MFucedPI6MDi8ax3D6PHxUvKHosfeHl83iQXwBLFZZOSmpNZllqkb5fAlbFjawtLwQae
        iqO9PYwNjC85uxg5OSQETCTen1/C3MXIxSEksINJYsmEQ2wQznkmiYU3rzKCVAkLuErsnfOV
        DcQWEXCT+DD5JAuIzQxkd9/azA7R0MkkcfDfEbAGNgFdiUU9zUwgNq+AvcTXzplgNouAqsT6
        +8+Bajg4RAUiJDZs5IcoEZQ4OfMJ2ExOAReJo9cOMEPMV5f4M+8SlC0ucevJfCYIW15i+9s5
        zBMYBWYhaZ+FpGUWkpZZSFoWMLKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSnd
        xAgJcr4djO3rZQ4xCnAwKvHwCkx/HynEmlhWXJl7iFGSg0lJlDfK4kOkEF9SfkplRmJxRnxR
        aU5q8SFGCQ5mJRFehVdA5bwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4l
        Cd61LkBDBYtS01Mr0jJzShDSTBycIMN5gIYbg9TwFhck5hZnpkPkTzHqcjyb+bqBWYglLz8v
        VUqc1xukSACkKKM0D24OLDm9YhQHekuY1wukigeY2OAmvQJawgS0pEkVbElJIkJKqoEx0WnP
        QS6jzW9TX0z7NDMnz+XH1Q92cjNyHL2ufjoQZ+1Y5qS7/H37457Dj1oeWHB4uX/akrDRpYPX
        7kpB1L3H5946Lk0Qtc2wefJU2fJ9d0tSw6qfTU+ZlyqV782pmTXNxXzC5grLO/dZX/W9fi9/
        wGnFv7KnTU0lHIIfrU/FTjeL0Ko/ci9DiaU4I9FQi7moOBEALo10QCkDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2017 09:46 PM, Jeff King wrote:
> On Tue, Oct 24, 2017 at 12:19:26PM -0400, Eric Sunshine wrote:
> 
>> On Tue, Oct 24, 2017 at 11:16 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
>>> @@ -34,6 +34,86 @@ test_update_rejected () {
>>> +# Test adding and deleting D/F-conflicting references in a single
>>> +# transaction.
>>> +df_test() {
>>> +       local prefix="$1"
>>> +       shift
>>> +       local pack=:
>>
>> Isn't "local" a Bash-ism we want to keep out of the test scripts?
> 
> Yeah. It's supported by dash and many other shells, but we do try to
> avoid it[1]. I think in this case we could just drop it (but keep
> setting the "local foo" ones to empty with "foo=".

I do wish that we could allow "local", as it avoids a lot of headaches
and potential breakage. According to [1],

> However, every single POSIX-compliant shell I've tested implements the
> 'local' keyword, which lets you declare variables that won't be
> returned from the current function. So nowadays you can safely count
> on it working.

He mentions that ksh93 doesn't support "local", but that it differs from
POSIX in many other ways, too.

Perhaps we could slip in a couple of "local" as a compatibility test to
see if anybody complains, like we did with a couple of C features recently.

But I agree that this bug fix is not the correct occasion to change
policy on something like this, so I'll reroll without "local".

Michael

[1] http://apenwarr.ca/log/?m=201102#28
