Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14CE20323
	for <e@80x24.org>; Wed, 22 Mar 2017 23:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbdCVX0x convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 22 Mar 2017 19:26:53 -0400
Received: from vpn.innerrange.com.au ([203.122.143.146]:48569 "EHLO
        remote.innerrange.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754493AbdCVX0v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 19:26:51 -0400
Received: from IR-CENTRAL.corp.innerrange.com ([fe80::216f:2d6c:20cc:241b]) by
 IR-CENTRAL.corp.innerrange.com ([fe80::216f:2d6c:20cc:241b%15]) with mapi;
 Thu, 23 Mar 2017 10:26:33 +1100
From:   Craig McQueen <craig.mcqueen@innerrange.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Thu, 23 Mar 2017 10:26:31 +1100
Subject: git svn and SVN property svn:original-date
Thread-Topic: git svn and SVN property svn:original-date
Thread-Index: AdKjYxm31vA8vIuvSOWBSyqYAq5l7w==
Message-ID: <5500469A22567C4BAF673A6E86AFA3A40295E65B42D1@IR-CENTRAL.corp.innerrange.com>
Accept-Language: en-US, en-AU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-AU
x-tm-as-product-ver: SMEX-11.1.0.1278-8.100.1062-22956.006
x-tm-as-result: No--4.449700-5.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing "git svn dcommit", the SVN revision just has the date/time stamp of the time of the dcommit.

Apparently SVN revisions can have an "svn:original-date" property, which would be good to set on dcommit, to preserve the timestamp from the git repository.

https://subversion.apache.org/docs/api/1.7/group__svn__props__revision__props.html#ga8f17351dd056149da9cb490f1daf4018
"The svn:date property must be monotonically increasing, along with the revision number. In certain scenarios, this may pose a problem when the revision represents a commit that occurred at a time which does not fit within the sequencing required for svn:date. This can happen, for instance, when the revision represents a commit to a foreign version control system, or possibly when two Subversion repositories are combined. This property [svn:original-date] can be used to record the TRUE, original date of the commit."

-- 
Craig McQueen

