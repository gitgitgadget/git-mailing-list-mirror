Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4721320966
	for <e@80x24.org>; Thu, 30 Mar 2017 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbdC3RRA (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 13:17:00 -0400
Received: from proofpoint7.lanl.gov ([204.121.3.46]:36454 "EHLO
        proofpoint7.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbdC3RQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 13:16:59 -0400
X-Greylist: delayed 950 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Mar 2017 13:16:59 EDT
Received: from pps.filterd (proofpoint7.lanl.gov [127.0.0.1])
        by proofpoint7.lanl.gov (8.16.0.20/8.16.0.20) with SMTP id v2UGv3wr093852
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:01:08 -0600
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
        by proofpoint7.lanl.gov with ESMTP id 29dpx8w3b5-1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:01:08 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 29DF6F7C29C
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:01:08 -0600 (MDT)
X-NIE-2-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from pn1216650.lanl.gov (pn1216650.lanl.gov [128.165.243.37])
        by mailrelay2.lanl.gov (Postfix) with ESMTP id 15011F7C297
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:01:08 -0600 (MDT)
To:     git@vger.kernel.org
From:   David Shrader <dshrader@lanl.gov>
Subject: ttk error when starting git gui
Message-ID: <0fc69c73-73aa-5355-264b-a7c55377eec2@lanl.gov>
Date:   Thu, 30 Mar 2017 11:01:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-30_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=15
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703300147
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I get the following error when trying to start git gui:

Error in startup script: wrong # args: should be "ttk::style theme use 
theme"
     while executing
"ttk::style theme use"
     (procedure "ttext" line 4)
     invoked from within
"ttext $ui_workdir -background white -foreground black \
         -borderwidth 0 \
         -width 20 -height 10 \
         -wrap none \
         -takefocus 1 -highlightthickness 1\
         ..."
     (file 
"/home/dshrader/opt/toss2/common/git/2.12.2/libexec/git-core/git-gui" 
line 3190)

I get this error with the latest released version 2.12.2. Two older git 
versions are also available on this system, and neither has this issue. 
Those older versions are 1.7.1 and 2.3.3. I don't see a call to ttext in 
those corresponding git-gui executables, so that is probably why they work.

Here are the steps to reproduce:

1) cd to existing git repository
2) run 'git gui' (no gui comes up, and the error is printed in the terminal)

I'm running on a RHEL6 based system. Do I have an insufficient version 
of whatever git gui uses for graphics in the later versions of git? When 
I try 2.12.2 on my personal workstation running Fedora 25, I don't see 
the same issue.

Thank you very much for your time,
David

-- 
David Shrader
HPC-ENV High Performance Computer Systems
Los Alamos National Lab
Email: dshrader <at> lanl.gov

