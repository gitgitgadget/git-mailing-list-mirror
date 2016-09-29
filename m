Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BEC9207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755011AbcI2TaP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 29 Sep 2016 15:30:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:61190 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754485AbcI2TaN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:30:13 -0400
Received: from zaphod.fritz.box ([188.174.79.160]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0LqZik-1bLb4y46RG-00eHpc for
 <git@vger.kernel.org>; Thu, 29 Sep 2016 21:30:11 +0200
From:   Sebastian Feldmann <sf@sebastian-feldmann.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Impossible to change working directory
Message-Id: <A99D7D06-8214-4C09-BCB2-E4FCE75FF317@sebastian-feldmann.info>
Date:   Thu, 29 Sep 2016 21:30:10 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3226)
X-Provags-ID: V03:K0:o2o1HF41jAQRcqAssQZUOCojzM2cMbzscKC258DHkbO+fFNgSAo
 VwXxNxS/2S1gnf+dIs9SrvJb3Cq9gjPd3naWiPz1XdhM+0Vwe21fKZypeGI1V/u4tvoosms
 eMKQRQRf/ca7V5tOo3OwOi6yekmWXpLACnLlNijH+Nv2xN8nWLkNfewyOOSgyHYpKKzHqN1
 oeSt9Xaxv+/tw6mqvLTGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4R3lA2eL2Rg=:LVtjo+7pc8uP2JBF+AXM4+
 i0NqYoEt/PLECPNuC3b8o+aiVKcwABoOADV8dSgxJhRi+BBCmJaSm2tz+X8PEFb4sNuBPt74K
 fJpTcJioXg13eXZDVTrPAj28SN6PCCE5oYD61ynmuGu+/We726wyJkl7zz/E9HhAj9HCQRXja
 26Hks/xZW1IIpN4CLgeOPnz+mPw3yGBqzRgdPCUad8c3yiPZ6cphNzOTOFKF+ChwyRYf2TBT1
 PIPUQk2VuHKvEyG7rhXGSbZEoUIkBpanalfzgAMXkNVkCVoQRutjiO8sKozXDkAmB1VkJT0EE
 lEHHYAgy2W/IOTNxmEUlun3nyLrSMcSKOXgQw4U3PvhZFygEUVDQUCe6XryKuxScGp+d7pp4q
 9PhUmvpo0IMbiJf0LsxDnce5w16pAncX5MVe/4Qjlfj9vNet+EPqeUe2m1tjaZ4kMGMGHKgth
 qYfI5KIu42U4m8tvjFA/jy9K310gf4jJfOwfSI9MhInYigVHCKBOg5Sf4pHwVfoY+QbFP/3qE
 qn/rdzdPgtlBjuBv/cjXPwoDtouJDvm0OqTGxHj8L2FAZfV69j6EBwAP/Ne/fq4kExlLjd5fM
 KQiYIxaVWXJOSKwMH3o7ShvONXxSSeUMhx7WYsZUq6nYMRVZGKLj+K0UjxEkmcBOxac6ToZy1
 qZNx/YSQSC4sFjNgMggtEJ6PCicbxO1MWde3TAqeK+43nPMg//MLJ5mxCEsWFctEcCBjUU6gD
 tj3PU91SDhFlSzoe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I have a problem executing a pre-commit hook.
The hook script has to change the working directory to work and if I use plain

git commit

it works as expected, the script executes without errors, but if I use

git commit —only file.x file.y

the script fails because changing the current working directory fails.
If I echo the current working directory it always echoes the root repository path

Is this expected behavior?
Thanks for your feedback.

Cheers Sebastian




