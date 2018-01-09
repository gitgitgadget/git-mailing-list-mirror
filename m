Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47BA71F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756040AbeAIOdQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:33:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:57450 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753713AbeAIOcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:32:54 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbVT-1f8njt1bf9-00aG7p; Tue, 09
 Jan 2018 15:32:50 +0100
Date:   Tue, 9 Jan 2018 15:32:50 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] "Fast-"track Git GUI changes
Message-ID: <cover.1515508360.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+tjtoHPVoZIdEtE4ySFEhwn5vWJ1Vwsa2XegcfIN3sQK6GbYSVw
 6ZSgq7m+rVpldo7znO5ombu9/eL25uHgeS/mZi28WyACgHlP0WHddZqHMJXPdABUtrGdXvM
 U6tKE+BJ6aiiJJlZvDRkMWTzlWBKwuZMFmU6NmfV4yHsF0bY6WEe13X0ZuGGKuWjWA9RT9a
 NKX+bXIgxDiC2fhVYfVIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2LKDcSltY+M=:+jcZxfJmHT3gySN/N/j3IP
 vjKJq4hWZM0SOKR624FNOxH8sFL3HWw4FfEfNLshUCQC36KV6BrdIIdYKSGI+vCoNNbx9byxj
 38qYPHTqtmr8WSfQO53JhtYugojEdgZlCt+UhF21baE184uCZaa1PF7C+J6DG//c1i++UZ+Ux
 NO2Ssgpne0P1ZPRXI5Dp9o+pbq6t/yXWJBZGYwyHji6hbk9sm0vAxmS7oKU4B5j7w5QRbO5ry
 nnS/lSJkCsT9fSc4y59+e+N1QT6HvBhv+kmAiP9yPAHx1dMz4In2FtuWhmBLuVZXVCc83eWZS
 XyBrM0lFrvmAVzgQ1wVyu/a1RcxdWtrrclgRoD/Ylrv6/td7MspkbJ9lC1pZprUxqFJONadht
 y5EDZ4G0RiK9Nu5aEazVsoO778ekmVtpqgc1toYo/tgAJY0eVsm6E/JCeTRIVDZBXdZ0GgVZy
 hmIL5Opl2siBvCLaJthrPNzWXtEnU4q7nAy2tWGgzrBFszwDh74wW5YHDpiCgyiu78TSiZdLA
 qoJPAGECY09j0W3onSLn5btlejpem7QmmQp2AHUv7MDuuF6zrHlU9KFeH5tbTe5g5SPZ8B5kk
 ma9vFtsVjxvomRAuL5Zp/nQ7FkWzBzK35nlpkV25/0QGP+tmxNoowgPBbBGyGog+KVVO6qyPo
 RHdaJ/YzL0X78wx8nWjpNAjQeVRUtNtjexPJnsf+SnYUIWT2MT7egQsM7KbSqO35WqLTUXEBl
 6YPxa/YSqeppjMqL54v+hXQtK8ZEinj7NjCrdTsGKr/9un5+vTZzkoqCnJgNJrq34lbmJBZJ6
 iCd6Z0TuCWZk4Cmc8pCBk2q5FolP94ExFAJj/ogso8i1zE5Yzy0f2g5yuzTi7P6u81tUnVn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As it seems to be impossible to get the attention of the Git GUI
maintainer these "days" (I have opened Pull Requests on October 16th
2016 that have not even been looked at), let's just side-step that
contribution path which seems to be dormant.

These fixes have been in Git for Windows for various amounts of time.

Note: there are more Git GUI changes in Git for Windows, I only
accumulated the ones I deem wort considering for inclusion into v2.16.0,
still.


Johannes Schindelin (4):
  git gui: fix staging a second line to a 1-line file
  git-gui: avoid exception upon Ctrl+T in an empty list
  git-gui: fix exception when trying to stage with empty file list
  git-gui: allow Ctrl+T to toggle multiple paths

 git-gui/git-gui.sh   | 27 ++++++++++++++++++++++++++-
 git-gui/lib/diff.tcl |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)


base-commit: 36438dc19dd2a305dddebd44bf7a65f1a220075b
Published-As: https://github.com/dscho/git/releases/tag/misc-git-gui-stuff-v1
Fetch-It-Via: git fetch https://github.com/dscho/git misc-git-gui-stuff-v1
-- 
2.15.1.windows.2.395.g5bb0817ee52

