Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D2F1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 21:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbeGVWDT (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 18:03:19 -0400
Received: from mout.web.de ([212.227.17.12]:40867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbeGVWDT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 18:03:19 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfiuU-1gNVzi1UHi-00pNUU for
 <git@vger.kernel.org>; Sun, 22 Jul 2018 23:05:19 +0200
To:     Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t7406-submodule-update shaky ?
Message-ID: <208b2ede-4833-f062-16f2-f35b8a8ce099@web.de>
Date:   Sun, 22 Jul 2018 23:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:2uYSEs7s6/m27URdlME0khgm1mH0BpmH/s4fInmAIayZAbxhuJV
 FQUdm80KhFsywXk2n6Eqkw3EKSShQVUi+m79UqQRp+nvUn+J+b5vZfryGoewAy947fku9JJ
 Xhh3WrPMXRy4pxBhwwBGGPVwOKUcQcPudLTRlZ3OoG9Xj1q4OAjhGF6qLFiPfKQ7kjC9bEc
 FLXsgi/Sr8d3lcsgXanAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H5Y6/DI3xHc=:ftXjULFs2axITZFkLyw/Vp
 O3g1njwmF87SxbTgmXyeTXmKv+dibxI86cjBlDcuUY4jXK/6rUagBcH1YNNnl/yFU72RE4taB
 91sJIQ94jpjH2aNeTychhElvh1kcuAacGpo+GHHvJiMkkrj4P7XXP9lz4oPe6tiE2Klb23Uc9
 hpQPROnf3miJb++lVe+5sve9uWYv33iteNYM7xYMNGk+bLak/MlxRVpkllg5vbP5zXOaFiEh1
 3FvwqNTsfCvKttCa21RabuWMRFKb26MpaDqa2zUAgMMNbS4Wes69l1Jm8PqsU8VqkufjNrUgF
 psuO7KZaNj/r07CDhS+IEA3qetIYclfWlAWK1gRrrtbQYPvtxSI5LAKijKVs0ciM4xcFWjryj
 IeNW0ls2J/1AQthbcB8eJYoHLT6czhXzEqs63R4hOSILmGXYQXUUVfHX8uDXUvcBnTitU5rWG
 XXIuI0zpnd0rd7Ywllz8W12MV7G4R37miob+Gv/xf32i7Li8gg+JT9qjli67kphixrfog8OW5
 yD7Ou+LrQY8bXZepHK9v2tKAohSLPFahCoyBeRCs9Pf+6svQsvV0xyWWHK8gUAVHMwqT2y2AC
 +AH01J+xOWiFZ42oJqA4oWhMg2mG7cqX5OEDDopAu0DnSFLGEYZCz6TnOl7usTvCAIYBaUlM5
 xt9RBpHnd5wQH4qVWquR76g7B4BZgZauoAYGFXUzjhafT7/5vfFBW/TEF5riTRvuBGdOQ1IB+
 ydfoQeNbSrGNqljbdMnIQFwTDP8LXRGKzYLfbOIjp1mIB4Ae+U1EJR7LDhfw1WuhdAMrwqbIG
 1GHhai0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems that t7406 is sometimes shaky - when checking stderr in test 
case 4.

The order of the submodules may vary, sorting the stderr output makes it

more reliable (and somewhat funny to read).

Does anybody have a better idea ?


[]

cat <<EOF >expect2
Cloning into '/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/recursivesuper/super/merging'...
Cloning into '/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/recursivesuper/super/none'...
Cloning into '/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/recursivesuper/super/rebasing'...
Cloning into '/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/recursivesuper/super/submodule'...
Submodule 'merging' (/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/merging) registered for path 
'../super/merging'
Submodule 'none' (/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/none) registered for path '../super/none'
Submodule 'rebasing' (/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/rebasing) registered for path 
'../super/rebasing'
Submodule 'submodule' (/Users/tb/NoBackup/projects/git/git.pu/t/trash 
directory.t7406-submodule-update/submodule) registered for path 
'../super/submodule'
done.
done.
done.
done.
EOF

test_expect_success 'submodule update --init --recursive from 
subdirectory' '
     git -C recursivesuper/super reset --hard HEAD^ &&
     (cd recursivesuper &&
      mkdir tmp &&
      cd tmp &&
      git submodule update --init --recursive ../super >../../actual 
2>../../actual2U &&
      sort <../../actual2U >../../actual2
     ) &&
     test_i18ncmp expect actual &&
     test_i18ncmp expect2 actual2
'


