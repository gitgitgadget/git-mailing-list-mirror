Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A81C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EC72074D
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgIHR6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:58:47 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:64485 "EHLO
        alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731540AbgIHQMZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Sep 2020 12:12:25 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2020 12:12:25 EDT
Received: from [192.168.0.100] ([96.20.238.10])
        by Videotron with SMTP
        id FfzDk4asf4ryvFfzEkJHIq; Tue, 08 Sep 2020 11:56:48 -0400
X-Authority-Analysis: v=2.3 cv=O+9HQy1W c=1 sm=1 tr=0
 a=IvhzMnQCxHlOtQqA98XSUg==:117 a=IvhzMnQCxHlOtQqA98XSUg==:17
 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10 a=rvM64S1SdSMA:10 a=VwQbUJbxAAAA:8
 a=-29Xx4amtzPkbbFDtSUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
To:     git@vger.kernel.org
From:   Daniel Villeneuve <dvilleneuve.4142@gmail.com>
Subject: permissions of main folder for git-manpages.tar.gz
Message-ID: <cc8487b0-c23f-46c3-b8c3-e3188b7c0d0e@gmail.com>
Date:   Tue, 8 Sep 2020 11:56:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CMAE-Envelope: MS4wfNyslbEi9jgMZAGedglR4yorFUkSJ/jxoDe+GA6d0rC5jQpXsB/qgMIG7QTjmc2L2ppHMPt+kuDOudQzw3S5ev1Bogh+qVXhIlplQFqVLVoh2zjUGJDU
 bLK8SRa3yiUxHrBHvFIU28lLII1k9P0bdL4mRgAL9In/wRlIveEYAS2VmSxpyVZEboMLLvDbG/8wJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am using https://mirrors.edge.kernel.org/pub/software/scm/git/git-manpages-2.28.0.tar.gz to get the manpages part of git.

There has been a change in the permissions of the top-level folder, from 2.22 (perms 2750) to 2.25 (perms 0700) to 2.28 (perms 2700).
However, the permissions of other files/directories allow group/others read/execute, as before.

This change broke my latest installations by preventing group members to see manpages (I did a chmod to fix that).

Just sharing this observation, in case the change was not intentional.
--
Daniel Villeneuve

