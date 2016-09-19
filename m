Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874491FCA9
	for <e@80x24.org>; Mon, 19 Sep 2016 09:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbcISJRi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 05:17:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45471 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752711AbcISJRg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Sep 2016 05:17:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8J9Dwb4092622
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 05:17:34 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25hxp0hpqr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 05:17:34 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Mon, 19 Sep 2016 19:17:31 +1000
Received: from d23dlp03.au.ibm.com (202.81.31.214)
        by e23smtp08.au.ibm.com (202.81.31.205) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 19 Sep 2016 19:17:30 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
        by d23dlp03.au.ibm.com (Postfix) with ESMTP id AC41E357805A
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 19:17:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u8J9HTbJ4260206
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 19:17:29 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
        by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u8J9HTrR012954
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 19:17:29 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
        by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u8J9HTEh012949;
        Mon, 19 Sep 2016 19:17:29 +1000
Received: from [10.61.2.248] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 98981A01F3;
        Mon, 19 Sep 2016 19:17:28 +1000 (AEST)
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC
 PATCH]
To:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Mon, 19 Sep 2016 19:17:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16091909-0048-0000-0000-000001BF00EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 16091909-0049-0000-0000-00004694D0B1
Message-Id: <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-09-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1609020000
 definitions=main-1609190130
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/09/16 17:21, Josh Triplett wrote:
> This provides a shorter and more convenient alias for
> --subject-prefix='RFC PATCH'.
>
> Includes documentation in the format-patch manpage, and a new test
> covering --rfc.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Sounds good to me. Agreed that "RFC" is essentially the only prefix 
other than "PATCH" that I see, at least in the kernel.

I don't have anything to say about the code, though I did note that 
there's a error message stating that "--subject-prefix and -k are 
mutually exclusive." - I haven't tested the patch, but I imagine this 
message will trigger with --rfc as well and could be slightly confusing.

> ---
> v2:
> - Add documentation to the format-patch manpage
> - Call subject_prefix_callback rather than reimplementing it
> - Update test to move expectations inside
>
>  Documentation/git-format-patch.txt |  8 +++++++-
>  builtin/log.c                      |  8 ++++++++
>  t/t4014-format-patch.sh            |  9 +++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 9624c84..b9590a5 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -19,7 +19,8 @@ SYNOPSIS
>  		   [--start-number <n>] [--numbered-files]
>  		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
>  		   [--ignore-if-in-upstream]
> -		   [--subject-prefix=Subject-Prefix] [(--reroll-count|-v) <n>]
> +		   [--rfc] [--subject-prefix=Subject-Prefix]
> +		   [(--reroll-count|-v) <n>]
>  		   [--to=<email>] [--cc=<email>]
>  		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
>  		   [<common diff options>]
> @@ -172,6 +173,11 @@ will want to ensure that threading is disabled for `git send-email`.
>  	allows for useful naming of a patch series, and can be
>  	combined with the `--numbered` option.
>
> +--rfc::
> +	Alias for `--subject-prefix="RFC PATCH"`. Use this when
> +	sending an experimental patch for discussion rather than
> +	application.

Perhaps mention the phrase "Request For Comment" for the benefit of 
those who aren't familiar (which admittedly, among users of 
git-format-patch, are probably rather few, but still).

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

