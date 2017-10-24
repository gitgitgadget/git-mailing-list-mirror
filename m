Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816D81FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 12:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbdJXMo3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 08:44:29 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43152 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751920AbdJXMo2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2017 08:44:28 -0400
X-AuditID: 1207440c-7fdff7000000143e-4e-59ef357ea3be
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 35.4D.05182.F753FE95; Tue, 24 Oct 2017 08:43:43 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCBEA.dip0.t-ipconnect.de [87.188.203.234])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9OCheZq025984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 24 Oct 2017 08:43:41 -0400
Subject: Re: v2.15.0-rc2 ref deletion bug
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20171024082409.smwsd6pla64jjlua@sigill.intra.peff.net>
 <ea715dae-b410-d4fb-77c7-2e61b764a343@alum.mit.edu>
Message-ID: <44c489f0-4c72-46a1-61a0-48917d64958b@alum.mit.edu>
Date:   Tue, 24 Oct 2017 14:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <ea715dae-b410-d4fb-77c7-2e61b764a343@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1F1l+j7SYOozJYuuK91MFg29V5gt
        frT0MDswezzr3cPocfGSssfnTXIBzFFcNimpOZllqUX6dglcGYtv9LMXHOes2Pj2B1sD4zb2
        LkZODgkBE4nOGTNYuxi5OIQEdjBJLN+0E8q5wCTR+GYTC0iVsICmxJ5518BsNgFdiUU9zUwg
        toiAo8SFLUfA4swC4hLr5p4HmyokUCnR0baYDcTmFbCXmN91E6yeRUBV4tLqZ0BxDg5RgQiJ
        DRv5IUoEJU7OfAI2hlPAQeLrt3ZmiJHqEn/mXWKGGX/ryXwmCFteYvvbOcwTGAVmIWmfhaRl
        FpKWWUhaFjCyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdTLzSzRS00p3cQICWieHYzf1skc
        YhTgYFTi4W0wfxcpxJpYVlyZe4hRkoNJSZT333ugEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
        FSbvI4V4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK8Z0EaBYtS01Mr
        0jJzShDSTBycIMN5gIY/AxteXJCYW5yZDpE/xajL8Wzm6wZmIZa8/LxUKXHeBSBFAiBFGaV5
        cHNgiegVozjQW8K8/0GqeIBJDG7SK6AlTEBLZO3fgCwpSURISTUwlvIX5dqZ/hKbsf7oUoXd
        Jw2q3hzY03VcNfRjmlm0aGmtj0RMeMbLe0d+3ffZrs3+TrLg2OcS3xzW3KdlV6zry/Yk3Em4
        fnpr1YYdgfqxYUz7j65/3ef7aNqP6Rv+Fvzeku7Ydf3Eq0PL/umr3uXPn7p1im3w2Y65pnxB
        H59fmh69Wa60NapvtRJLcUaioRZzUXEiAM7luuwfAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2017 01:05 PM, Michael Haggerty wrote:
> On 10/24/2017 10:24 AM, Jeff King wrote:
>> I found a potentially serious bug in v2.15.0-rc2 (and earlier release
>> candidates, too) that we may want to deal with before the release.
>>
>> If I do:
>> [...]
>> then at the end we have no refs at all!
> 
> That's a serious bug. I'm looking into it right now.

The fix is trivial (see below). But let me add some tests and make sure
that there are no similar breakages in the area, then submit a full patch.

Michael

----------------------------- refs/files-backend.c
-----------------------------
index 29eb5e826f..fc3f2abcc6 100644
@@ -2523,15 +2523,15 @@ static int files_transaction_prepare(struct
ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];

 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, &affected_refnames, err);
 		if (ret)
-			break;
+			goto cleanup;

 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
 		    !(update->flags & REF_ISPRUNING)) {
 			/*
 			 * This reference has to be deleted from
 			 * packed-refs if it exists there.
