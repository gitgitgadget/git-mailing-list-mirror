Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F6820281
	for <e@80x24.org>; Wed, 13 Sep 2017 00:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdIMAib (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 20:38:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750944AbdIMAia (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Sep 2017 20:38:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8D0YDFS001739
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 20:38:29 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cxpge8ffs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 20:38:29 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <sam.bobroff@au1.ibm.com>;
        Wed, 13 Sep 2017 10:38:26 +1000
Received: from d23relay09.au.ibm.com (202.81.31.228)
        by e23smtp08.au.ibm.com (202.81.31.205) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 13 Sep 2017 10:38:23 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8D0cN3K40304876
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 10:38:23 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8D0cM3U017739
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 10:38:23 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id v8D0cMKv017734;
        Wed, 13 Sep 2017 10:38:22 +1000
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8C188A018C;
        Wed, 13 Sep 2017 10:38:22 +1000 (AEST)
Date:   Wed, 13 Sep 2017 10:38:21 +1000
From:   Sam Bobroff <sam.bobroff@au1.ibm.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: use raw format for notes
References: <334a7be4f61c02db24008181eb1d6c80c95772f7.1503894009.git.sam.bobroff@au1.ibm.com>
 <xmqqingw8ppj.fsf@gitster.mtv.corp.google.com>
 <20170911042737.4h5b2jygdeu7cpmf@tungsten.ozlabs.ibm.com>
 <CAGZ79kbcufMxbBdH=a9YzPWWet5nEdmUN6P+xmMEcGna-VL9=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbcufMxbBdH=a9YzPWWet5nEdmUN6P+xmMEcGna-VL9=Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-MML: disable
x-cbid: 17091300-0048-0000-0000-0000025CECB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17091300-0049-0000-0000-000048133839
Message-Id: <20170913003821.xn43yosuieoivmqk@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-09-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1709130007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 10:33:37AM -0700, Stefan Beller wrote:
> On Sun, Sep 10, 2017 at 9:27 PM, Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
> 
> > (If only there were a way to set the coverletter text automatically as
> > well...)
> >
> 
> Checkout branch.<name>.description

AH! I had seen this section of the format-patch man page...

       --[no-]cover-letter
           In addition to the patches, generate a cover letter file containing the branch description, shortlog and the overall diffstat. You can fill in a description in the file before
           sending it out.

... but I didn't realize that it meant that it would insert the text
from branch.<name>.description into the cover letter. Perhaps there
should be a hint to point you to the branch.<name>.description section
of "git config"?

Also, it's not very useful for automating patch submission, as it
doesn't set the subject line or remove the "*** BLURB HERE ***" marker,
so it must still be post-processed.

(To be honest, I was surprised that it didn't use first line as the
subject and leave out the markers.)

Cheers,
Sam.

