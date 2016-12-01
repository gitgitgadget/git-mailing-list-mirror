Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3F91FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756842AbcLAVVX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 1 Dec 2016 16:21:23 -0500
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:32816 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753350AbcLAVVW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2016 16:21:22 -0500
X-Greylist: delayed 5486 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2016 16:21:22 EST
Received: from pps.filterd (m0048205.ppops.net [127.0.0.1])
        by m0048205.ppops.net-00176a03. (8.16.0.17/8.16.0.17) with SMTP id uB1Jn32G049083
        for <git@vger.kernel.org>; Thu, 1 Dec 2016 14:49:55 -0500
From:   "Alfonsogonzalez, Ernesto (GE Digital)" 
        <ernesto.alfonsogonzalez@ge.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "Your branch is ahead of 'origin' by X commits"
Thread-Topic: "Your branch is ahead of 'origin' by X commits"
Thread-Index: AQHSTAwNX33tfXf19Ua4xQQueqSmoA==
Date:   Thu, 1 Dec 2016 19:49:40 +0000
Message-ID: <D465BDE6.B7DE%ernesto.alfonsogonzalez@ge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [3.159.19.181]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <037B62619E9E894AB79B1E53D2768673@mail.ad.ge.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-12-01_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1609300000
 definitions=main-1612010324
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git status tells me "Your branch is ahead of 'origin' by 108 commits.²,
but my local and origin/master are pointing to the same commit.

What am I doing wrong?

$ git diff origin/master
$ git status
On branch master
Your branch is ahead of 'origin' by 108 commits.
  (use "git push" to publish your local commits)
Untracked files:
  (use "git add <file>..." to include in what will be committed)

...
nothing added to commit but untracked files present (use "git add" to
track)
$ 



$ git show origin/master --oneline
92d392c Merge pull request #21 from org/branch

$ git show master --oneline
92d392c Merge pull request #21 from org/branch


$ git --version 
git version 2.10.2




Thanks,

Ernesto

