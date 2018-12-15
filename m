Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6410A1F405
	for <e@80x24.org>; Sat, 15 Dec 2018 17:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeLORSC (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 12:18:02 -0500
Received: from e2i236.smtp2go.com ([103.2.140.236]:49197 "EHLO
        e2i236.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLORSC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 12:18:02 -0500
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2018 12:18:01 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1544895181; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Message-ID:From:To:Subject:Reply-To:Sender:
        List-Unsubscribe; bh=D2+4DAWDjbvo0Ugz6lKr02abQRnX4uTk+RQSWwrlSGY=; b=ZsPyatMU
        e5yH3t3w6eY0afuWfbZoD+03ei6lsyf2oqprCygvoA7EB3D1PuPngZEJ/uJqiT0ShnoHdr5lUuSNw
        U4yJmpBCm/Q5uR1+HBbkYyV0TqTMa48mi0cgQDtYcuRaD5EKQxt0O7omk9AMhLtRTFImdURVQnTaw
        +CjfUa8C2JWL7/2YZl3wSXjxj/u3FhhLUiyh8vRIqll3fOcy2wTgoJ7AOgcehHJaaS+pOEVlCdyTz
        OWGScyJy7rYzVznILFmwA2dmIHAA+1TEYL1cqXjUrGaxCi1uTk7OE15K0g2HFl1Kqp4S1GLlaDE1X
        muOKDOZzMhlbeRf2bu2BzcTJbw==;
Received: from [10.45.33.53] (helo=SmtpCorp)
        by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <philipoakley@iee.org>)
        id 1gYDOy-cp4ToG-HE; Sat, 15 Dec 2018 17:06:56 +0000
Received: from [10.176.12.107] (helo=[10.10.101.1])
        by smtpcorp.com with esmtp (Exim 4.91)
        (envelope-from <philipoakley@iee.org>)
        id 1gYDOw-rlZBfD-H3; Sat, 15 Dec 2018 17:06:54 +0000
Subject: Re: [PATCH] doc: improve grammar in git-update-index
To:     Anthony Sottile <asottile@umich.edu>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.org>
References: <20181214212504.3164-1-asottile@umich.edu>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <bfe22381-864a-4a6b-8dd9-78e268e52c36@iee.org>
Date:   Sat, 15 Dec 2018 17:06:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214212504.3164-1-asottile@umich.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Smtpcorp-Track: 1gYDOwr_ZUfDH3.FYSs84mqk
Feedback-ID: 66524m:66524aMf6O2Y:66524sEueuU8nYM
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/12/2018 21:25, Anthony Sottile wrote:
> Signed-off-by: Anthony Sottile <asottile@umich.edu>
> ---
>   Documentation/git-update-index.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 1c4d146a4..9c03ca167 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -326,7 +326,7 @@ inefficient `lstat(2)`.  If your filesystem is one of them, you
>   can set "assume unchanged" bit to paths you have not changed to
>   cause Git not to do this check.  Note that setting this bit on a
>   path does not mean Git will check the contents of the file to
> -see if it has changed -- it makes Git to omit any checking and
> +see if it has changed -- it means Git will skip any checking and
>   assume it has *not* changed.  When you make changes to working
>   tree files, you have to explicitly tell Git about it by dropping
>   "assume unchanged" bit, either before or after you modify them.

Doesn't this also need the caveat that it is _a promise by the user_ 
that they will not change the file, such that Git doesn't need to keep 
checking, and that occasionally Git will check, or may perform 
unexpected actions if the user has the wrong mental model.

-- 

Philip


