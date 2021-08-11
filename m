Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F6C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6141560FC0
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhHKNrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:47:49 -0400
Received: from mout.web.de ([212.227.17.12]:43749 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232058AbhHKNrs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 09:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1628689643;
        bh=jMpUeePqYZxFJV7RP8wSy/MXReU9kL8j3dppI1am7rI=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=Gau/sMfrDLEGPACkm1UUx3QExyHtClJGVYkb6iE5Q3VwNMfOR5boyflOR5SzilPb4
         LOe/jsnV1rnMj3+dd+I4Aks+l5CksmaFmahaXTMPaxeeJTjaaMsE88E0DpJ04Is0Cq
         e6xDdtBdAJ1+d2BewExo1t+zs5KhrJc5qvSwHMOQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [93.218.152.93] ([93.218.152.93]) by web-mail.web.de
 (3c-app-webde-bap05.server.lan [172.19.172.5]) (via HTTP); Wed, 11 Aug 2021
 15:47:23 +0200
MIME-Version: 1.0
Message-ID: <trinity-1ab86a7f-c1b8-4934-9b31-861a78e15889-1628689643260@3c-app-webde-bap05>
From:   Gerhard Buch <Gerhard.Buch@web.de>
To:     git@vger.kernel.org
Subject: Git GUI does not start
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 11 Aug 2021 15:47:23 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:zoe4N/KsBLJ2HXjh/5YcnD/ITn3uhBiBGqo3lKiyi9YnOk3sTj/ebZ7bh77zkAif4jWA9
 tpltkHe9EfliI1NS1LdaCtbLeJ5MgUF+JQklW4fDbJ7xe7BrBO5rcH7WFgQYRqcZ2pYnH8FZGdUS
 PYKJX/tMPhc/RBZSJcgm+xMyu4Ctq9ZIkGEEvfIIXbVok58L1zRPUWMFdxP+DqT9ZoxP7yHAGRux
 r7/SbdyCp08iy9ARa6xpHl83ypvh89BHTxTSHq0mbUKCjdKB48hcBmRBmzRb1FCLyp21iLlDQ+XJ
 pY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:VxXRTikn7nM=:K8kDXPQgQOzT8HrtNPQqzy
 HAThmLVMvhZk08GmHNPEAtCZ3MTNE8OE9h6fZEkx+3DhnXtPIhITY35vlJfuJlTJcdBylxGbn
 QgrD5SfzvHoIAZafb2JlJLjAxmqypp9TPNgmT/ETigRC0RvQuiDAa13w7ebLwRl1CS0HDGPbe
 vr/+lFsVpbmV9DhydfVZ8oxJrYWz7JM+xZD2DufuN7N3sV0by2fUiU96FjMlAic1r6n/Z4SIc
 0wZv7LtdYTkPf4qePbYp0vuzyL19CQSCjxVMeBm5c+bUpE2f5L+T3hNId2wQE3Ja3GqUiOsAS
 TsYjoHiYSir42dbzllV2GxKSdKMfipnbItxRZhD8BkRTqTTOe2a+DM8/zTYqAazKQ6h4lNsqZ
 W6E8CYUpOi++O9tS+XQbyDQaaQQEpEZiDRxx/iB8TWM07pxfVvKVWhVpI9kMZxKfnyG97Dqr7
 Icjck4hlfTc9U775HYVm4s1xUnw+YAxfqQIPZDDUf3PO0JgeaU2XGxkJmmGh43HlmloreImH3
 0r1W6yyLnBNc27vj/tcRg5/IyAnUVXxOta+YCsNCNi849NxpmzoKQxD9UsWg7yUHe6zdEMlrD
 AIyY/iiIWoBCm0HNAOGi3u71gM9TNAVF/2oyzlDyF2IolyaAN/OXlArtGuFHOoB5VebvUCkM9
 d9TKnYpKKOKPKufot7lF7HNJd04oVkbG2YvOKlcyCfHuQZwcxf/oxKHdlu50E7I6B/HkjgEy1
 Yi+0T1zt1grgDRfuLM+9qCWgsubexizR9u14ON0kAMtEvrATFZaubD1zpp2OJtc7hwaL4D4fF
 zK5j2h3n5/dpSt5EyzqWSddD3Lv6Eat74bT1Uc0Br1QPlaYVTc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git GUI does not start any more and I'd like to share the bugreport below.=
 Any idea how I can get diagnostic information to find die problem?

best regards

Gerhard


=2D-------------------------------------------
What did you do before the bug happened? (Steps to reproduce your issue)
Open Git GUI -> choose open existing projekt
It worked with the previsous version 2.28 before. Before posting the bugre=
port I updated to the most recent version to be at the latest version.

What did you expect to happen? (Expected behavior)
That Git GUI opens...

What happened instead? (Actual behavior)
Git GUI icon appears in task bar, but not the usual Git GUI window.
On left click on the task bar icon, the top entry says Wish Application. O=
n choosing this entry two Windows appear.
One is empty. The second is titled "Konsole" and has (System32) 1% in the =
field below the menu bar.
What's different between what you expected and what actually happened?
Git Gui does not start and there is no indication on possible reasons for =
this.

Anything else you want to add:
I've checked the project directory with git cmd:
git status:
On branch <branch name>
nothing to commit, working tree clean


[System Info]
git version:
git version 2.32.0.windows.2
cpu: x86_64
built from commit: 3d45ac813c4adf97fe3733c1f763ab6617d5add5
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 17763
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>
[Enabled Hooks]

