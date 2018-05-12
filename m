Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF87D1F406
	for <e@80x24.org>; Sat, 12 May 2018 02:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbeELCpT (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 22:45:19 -0400
Received: from st13p35im-asmtp001.me.com ([17.164.199.64]:17517 "EHLO
        st13p35im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeELCpS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 22:45:18 -0400
X-Greylist: delayed 3621 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 May 2018 22:45:18 EDT
Received: from process-dkim-sign-daemon.st13p35im-asmtp001.me.com by
 st13p35im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P8L00100E6SFH00@st13p35im-asmtp001.me.com> for
 git@vger.kernel.org; Sat, 12 May 2018 01:44:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1526089496;  bh=+rKXF2LuytrTfFDVP2c4vRtT6GGt2MiMQUVtxLCkNqs=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=GY5KrBqxs4rBh00o+equUNYYYkpFDSoSINFqdEs9dwnmoA9xBJY8Gk9Cv5oJAsC5w
 80Xn4V4V3d+zqbx3aL7Hu5Jz/J9JKDOqPbUdcM2GNs1DZQitj6x6mI3lGX9FHhm9A3
 ZYwLFaIiYn1AlFBfsjp3xAX81hN3P5EI+uT0jPxO+ABJBxL8MRj2lVbR1ppZ0Kuy88
 b1ILSfzdtoZITP6EU3sHNREvhSTPdWHETKKVjIUcTWaRJPfU4t2Ndnu8WgklxbLM1F
 mWW3wuo2kcUhYbgPsoP55Cfye011iyd972aG6vB82axg9p7VbTAmj5ruEJTlYakTi9
 0C19ZXmEh+Iuw==
Received: from icloud.com ([127.0.0.1]) by st13p35im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0P8L00HVDE6VTC00@st13p35im-asmtp001.me.com> for
 git@vger.kernel.org; Sat, 12 May 2018 01:44:56 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-11_10:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=15 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805120013
From:   Surenkumar Nihalani <suren.k.n@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Bug report for git push
Message-id: <27C6F6E9-2F80-48A6-B551-4AE9957C98A5@icloud.com>
Date:   Fri, 11 May 2018 21:44:54 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

I am facing this spurious issue (not easily reproducible and usually a =
retry fixes it) with git push:

Warning: Permanently added 'github.com,192.30.255.112' (RSA) to the list =
of known hosts.
Counting objects: 8, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 971 bytes | 971.00 KiB/s, done.
Total 8 (delta 7), reused 0 (delta 0)
remote: Resolving deltas:   0% (0/7)
remote: Resolving deltas:  14% (1/7)
remote: Resolving deltas:  28% (2/7)
remote: Resolving deltas:  42% (3/7)
remote: Resolving deltas:  57% (4/7)
remote: Resolving deltas:  71% (5/7)
remote: Resolving deltas:  85% (6/7)
remote: Resolving deltas: 100% (7/7)
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
error: failed to push some refs to 'git@github.com:quora/qcore.git'
[May 12 12:14 AM remote._get_push_info] Error lines received while =
fetching: error: failed to push some refs to =
'git@github.com:quora/qcore.git'
Push flags:  1040
Push summary: [remote rejected] (cannot lock ref 'refs/heads/master': is =
at cf2cc0c147d8215ec87d3ddaf32f0b2c58630423 but expected =
fdda486ad43a6e6b5dc5f2795ce27124e0686752)

Remote repo rejected your commit.


This is happening in git version 2.17.0

I've tried searching stack overflow and the git mailing list but the =
answers aren't recent enough or don=E2=80=99t seem to be permanent =
fixes.
How do I fix this issue?=
