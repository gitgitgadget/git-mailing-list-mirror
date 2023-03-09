Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02BAC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCINGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 08:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCINGe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 08:06:34 -0500
X-Greylist: delayed 533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 05:06:32 PST
Received: from st43p00im-zteg10071901.me.com (st43p00im-zteg10071901.me.com [17.58.63.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D28B718B
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 05:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1678366586;
        bh=YnlWzRzX1pQRV4lD9ayhhWTBURhB7m8HYaHWG6Xe7bY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=pmNlIm/V5Xb2KX+xg/4rPcnhnp9LfAElKCKSV5lr4mf3Z40tHepct1Rhhw/f9WEA/
         Np25DT1WtsAeRcXMy3jzmgtzMS68kRQBrqqsPZ4zjaELsOQC23ejkhFu9VxBYXSi7K
         5dMo1JwAMH+wzF7K9kpefpQKchMKDl+LGgiZkgKXUETgsz90eXVW2ORMTPqOUJZ5Ya
         G0jzXsuBF2AH3gKIrSwtc4wm+OVM9CaCPRxw5BwHUapmwMC7j35fHy/oFLlsQcEIkS
         dVLQdFG03U2Snk1FJRI2bEs9tu18TqGM1QzDo/QlSPzxv4Hoqj3gGMmB13bvZYm+IK
         30pduB9w0j5hA==
Received: from mbp.local (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id DD53B84095F
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 12:56:25 +0000 (UTC)
Date:   Thu, 9 Mar 2023 15:56:21 +0300
From:   Emir SARI <emir_sari@icloud.com>
To:     git@vger.kernel.org
Subject: Feature Request - Better i18n support
Message-ID: <ZAnXddDN7v0AOBdm@mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ptOOB7Byx9srkoLdwWAYr7uFG-RqFd4o
X-Proofpoint-ORIG-GUID: ptOOB7Byx9srkoLdwWAYr7uFG-RqFd4o
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=592 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090104
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

Git is translated into many languages, but as far as I can see, it does not
take localisation formats into account nor it allows them to be translated
into localised formats.

For instance, in Turkish (and in French AFAIK), percentages are indicated
in different formats. In Turkish it precedes the number like %54. However,
all the percentages use the standard 54%. By marking these as translatable,
we could easily provide the correct formats.

Another thing is the decimal signs. In many languages, a comma (,) is used to
indicate decimals, however Git does not allow another formats. I am not sure
how to achieve this in C, but it would be great to have this in order to have
an errorless professional look in Git outputs.

Thank you very much for your attention.

[Sistem Bilgisi]
git sürümü:
git version 2.39.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:42:11 PST 2023; root:xnu-8792.81.3~2/RELEASE_X86_64 x86_64
derleyici bilgisi: clang: 14.0.0 (clang-1400.0.29.202)
libc bilgisi: libc bilgisi yok
$SHELL (typically, interactive shell): /bin/zsh
