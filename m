Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD5C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 19:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCBTlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBTls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 14:41:48 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8BE18163
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 11:41:45 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 322JfFwR1971200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 19:41:15 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <000001d94d26$1e52a910$5af7fb30$@nexbridge.com> <xmqqh6v3j8n1.fsf@gitster.g>
In-Reply-To: <xmqqh6v3j8n1.fsf@gitster.g>
Subject: RE: [Failure] Re: git 2.40.0-rc1
Date:   Thu, 2 Mar 2023 14:41:38 -0500
Organization: Nexbridge Inc.
Message-ID: <001a01d94d3f$04c2e460$0e48ad20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJtn73P7CYGffBgedw5ASJ2ucV6kQHxJnHOra+099A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, March 2, 2023 1:44 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> Git 2.40.0-rc2 was a regression from rc1. The following new tests failed:
>>
>> t3206 - virtually all subtests failed. An example of this failure is a
>> results comparison in subtest 1 (seemingly relating to abbreviation):
>> + test_cmp expect actual
>> --- expect      2023-03-02 16:39:23 +0000
>> +++ actual      2023-03-02 16:39:23 +0000
>> @@ -1,4 +1,4 @@
>> -1:  4de457d = 1:  35b9b25 s/5/A/
>> -2:  fccce22 = 2:  de345ab s/4/A/
>> -3:  147e64e = 3:  9af6654 s/11/B/
>> -4:  a63e992 = 4:  2901f77 s/12/B/
>> +1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:
>> 35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/
>
>Are any big endian machines involved?
>
>cf. https://lore.kernel.org/git/Y%2F+paI8WGSmEbv%2Fw@pobox.com/

Oh yes. All NonStop variants are big-endian. That hasn't changed the SHA-1
signatures though.

