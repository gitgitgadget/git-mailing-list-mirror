Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04601F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeFERCv (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:02:51 -0400
Received: from st41p57im-ztfb14240501.me.com ([17.36.64.138]:24838 "EHLO
        st41p57im-ztfb14240501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752019AbeFERCP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 Jun 2018 13:02:15 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2018 13:02:15 EDT
Received: from process-dkim-sign-daemon.st41p57im-ztfb14240501.me.com by
 st41p57im-ztfb14240501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P9U00J00XVL3I00@st41p57im-ztfb14240501.me.com> for
 git@vger.kernel.org; Tue, 05 Jun 2018 16:02:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1528214535;  bh=zH1d5NenJu/Y6ne3kHNyhSHi7+4YyajSR96JxNRppd8=;
        h=Content-type:From:MIME-version:Subject:Message-id:Date:To;
        b=Oy7ka8s9GJqlbN283ZKdtEXDMWQKVkKMDaIA81KtV2GG6hqXzTUewZcHwr9E6YGiX
 J4TjDXNCVV7YBSIKC6Axxa9HJrb8l0dmpd7qcrVF3hjy+Zb1aS3yzOAa+bfpRlFLvc
 GlpA6skVFncMpBFZfkBmt4AbFcxHNEhFHdnkqoYNUPzxQ6h77kVA0w9DwPeheomdlR
 1ona1XxvrRgu5yYwoG04PyRbhuwOEXgJPDSF6dKxlV8lNCMb70wirWkBTJK199+/Uu
 q5+f+TdJSVPCvsiotx3/+FB/Z7iqRwj6jw/fOyOpihDeKaZY0uXJoSIaoof8mDpab1
 LVxT/7fi5q+Hw==
Received: from icloud.com ([127.0.0.1]) by st41p57im-ztfb14240501.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0P9U000VKXVPX450@st41p57im-ztfb14240501.me.com> for
 git@vger.kernel.org; Tue, 05 Jun 2018 16:02:14 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-06-05_05:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=13 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1806050185
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=us-ascii
From:   Sean Hunt <seandhunt_7@icloud.com>
MIME-version: 1.0 (1.0)
Subject: Where is git checkout --orphan implemented at.
Message-id: <2ED916AA-3E6A-4E22-9B9B-13C3B687B357@icloud.com>
Date:   Tue, 05 Jun 2018 12:02:12 -0400
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (15G5054c)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like to see the source code to git checkout --orphan so I can learn h=
ow it works and so I can manually do what it does by hand on making a new br=
anch with no history in the refs folder. I can only do it on my iPhone as my=
 laptop has no internet or way to do it there, and the program on my iPhone d=
oes not have the method implemented yet visually to do it, forcing manual cr=
eation of the orphan branch by hand in the end. If the public github had all=
 the codes to all commands and subcommands like the one above it would be ni=
ce or well at least a file that explains the source file each command and su=
bcommands are from so that way a person like me can use as a reference to ma=
ke our own git gui that has 100% of command line git features.

Sent from my iPhone=
