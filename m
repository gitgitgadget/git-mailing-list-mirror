Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE46211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 13:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeLAAbF (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 19:31:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:55549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLAAbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 19:31:05 -0500
Received: from GREGORY ([188.174.46.189]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIMyZ-1gWIAm0hp9-0047uv for
 <git@vger.kernel.org>; Fri, 30 Nov 2018 14:21:47 +0100
From:   "Uwe Hafner" <u.hafner@gmx.de>
To:     <git@vger.kernel.org>
Subject: git difftool directory diff problem copying changes back is not reliable
Date:   Fri, 30 Nov 2018 14:21:47 +0100
Message-ID: <007501d488af$a5dac7e0$f19057a0$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdSIry5D8oEbyhrKQtOUuVFQMu+WMw==
Content-Language: de
X-Provags-ID: V03:K1:64hubLe3huNtBDElL9/R5HCQjxvlAr3AbgNvZPisI4dT2xmedzu
 C61ac0AzbloftOVCTTPlonQZDC9rHkAXnNIXLMx7T3QX+MkXAu4JXt0jGbOhE/Q6hvGg0xC
 HWoqWjouVFfgvND2BUIqoJeRiYdMnt0hYwWH6HVz2haGi7BaQMTRkM7t1IHdEnB7gA+iDCy
 oCcRNQa9pGqAz1quoiGpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:obS4nx64uSM=:SvlBqQgt9ExAf7gi9Ur9m7
 rKx/+5EstJYHbt5YuQYih9D98Gw54UhZV741w/nBU1GpQJMmpuNZyYiYEau3QyRvi6iu0ynQ3
 HjshTL89vh8e6mBDUmGrM0mT5k1K8/RzTyhaq3f2HI6o3eQrvqUdgDYOket5GArCyRFQ202Bd
 yv6q9zKSD0oKmU7NQzKDfsBIOz2CgDrIaI3SOa5dLzN76jK/uVqpmhwoItnJCMMj7wXFsuJa0
 ot9o7axQ9kb8in5ioq4mnweHWWAz1tddPPTPlC1D0K+kR2bjm+U5AVDVE7Gs0sOdi9Ny5NJf1
 FvmN3Jrzk3yAscVuqskUGYFFd2RQDzH5X8mQccrnIie55V3C74GnaxKqElxkctrCbj0CjuBRP
 0w4HNu9/JWr1nPAnukj2Y61cBEokoxxIDovjGsoL989R5BAyn7O/S2NUiCAW0EFnvip7UEhsO
 RaUjRjSyOrqjEJPE+g3wRFiTHLszxosRYQ1e+YIX/wBA/MK8nGvCjvef4V1ZkwvljToMqDZfg
 qtIJ+LTFOc/5QX90hdVJ3rygOL6DmRpZQW3q990I74L2lBcKOK9NnPmSMsNX0Y2xtT6qvzPsH
 sZxS1ZZnFVezfcFo3GEvLVrKzOQZSVGchBP8GzOsSDJ3nHsppkdTTjWn+2sE3RFR0Opa5yPNT
 H8+Q8yRm+tu60mlJ8Ug46Eka1KapyGvmkFQ7p18V5cxAD9rUrDNaMjUW/Qmgl3xVHvyXNkcCz
 PFYykWtGKwY1k9w4mMsFjrr/hKrKHNkVgLUkFf/IVPJ0EczWLy+XkJ9JScnHFVOqem4D+beI2
 XyyCDUw5Nku682jAuWQhfMss3sK3eUA+9OuokAZyZVCGMQiEXl8loQCTKFdsfV8oFS1rf+BuD
 m24U720UNY7ROGTKlCBhyONEQxS5SOxIVvRTG7bXPKNfWDwp9V5VmAj3B5zq6K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a problem with directory diff. The following command:

Git difftool -d _commit_sha_

Opens my compare tool (Beyondcompare) and I can make a folder diff. The tool
also allows browsing through all changes and looking/editing single files (a
beyondcompare feature).
So my workflow would be to open single files and make changes to the right
side of the diff.

After saving and exiting the diff tool sometimes these changes are copied
back to my working tree.
 
I currently assume from my tests that changes are copied to the working tree
if they are not too deeply nested in folders. So changes to files in folders
up to a depth of about 4 or so are copied back. If any deeper they are not.

My system specs:
OS: Windows 10
Git: 2.19.2.windows.1

Folder of repo. Folder name length is identical to real folder name length
in case it is a folder name length issue: 
C:\Users\Developer\source\repos\Project_name_length_

Folder for comparison (temp names are really used names):
Commit sha side:
C:\Users\Developer\AppData\Local\Temp\git-difftool.a07928\left
Working tree copy side:
C:\Users\Developer\AppData\Local\Temp\git-difftool.a07928\right

Can anyone confirm this?
Thanks

