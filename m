Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFA71F40E
	for <e@80x24.org>; Tue, 15 Nov 2016 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941450AbcKOJif convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 15 Nov 2016 04:38:35 -0500
Received: from mwork.nabble.com ([162.253.133.43]:61057 "EHLO mwork.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934210AbcKOJid (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 04:38:33 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Nov 2016 04:38:33 EST
Received: from mjim.nabble.com (unknown [162.253.133.84])
        by mwork.nabble.com (Postfix) with ESMTP id 44E146B8BF1FB
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 02:33:12 -0700 (MST)
Date:   Tue, 15 Nov 2016 02:33:12 -0700 (MST)
From:   ravalika <prenuka@gmail.com>
To:     git@vger.kernel.org
Message-ID: <1479202392275-7657456.post@n2.nabble.com>
Subject: Git status takes too long- How to improve the performance of git
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

We are using git-1.8.2 version for version control.
It is an centralized server and git status takes too long

How to improve the performance of git status

Git repo details:

Size of the .git folder is 8.9MB
Number of commits approx 53838  (git rev-list HEAD --count)
Number of branches -  330  
Number of files - 63883
Working tree clone size is 4.3GB

time git status shows
real	0m23.673s
user	0m9.432s
sys	0m3.793s

then after 5 mins
real    0m4.864s
user    0m1.417s
sys     0m4.710s

And I have experimented the following ways 
-          -  Setting core.ignorestat to true
-          -  Git gc &git clean
-          -  Shallow clone – Reducing number of commits
-          -  Clone only one branch 
      - Git repacking - git repack -ad && git prune
-     - Cold/warm cache 

Could you please let me know, what are the ways to improve the git
performance ?
I have gone through the mailing lists.


Thank you,
Renuka



--
View this message in context: http://git.661346.n2.nabble.com/Git-status-takes-too-long-How-to-improve-the-performance-of-git-tp7657456.html
Sent from the git mailing list archive at Nabble.com.
