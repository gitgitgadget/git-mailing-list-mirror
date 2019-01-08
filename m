Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B4E1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfAHPXY (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 10:23:24 -0500
Received: from mail.aixigo.de ([5.145.142.10]:11420 "EHLO mail.aixigo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfAHPXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 10:23:23 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 10:23:23 EST
Received: from srvvm01.ac.aixigo.de (mail.ac.aixigo.de [172.19.96.11])
        by gate5a.ac.aixigo.de (OpenSMTPD) with ESMTPS id 0e9ec144 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <git@vger.kernel.org>;
        Tue, 8 Jan 2019 16:16:41 +0100 (CET)
Received: from dpcl082.ac.aixigo.de (dpcl082.ac.aixigo.de [172.19.97.128])
        by srvvm01.ac.aixigo.de (8.15.2/8.15.2/Debian-8) with ESMTP id x08FGf8X2087719;
        Tue, 8 Jan 2019 16:16:41 +0100
To:     git@vger.kernel.org
From:   Harald Dunkel <harald.dunkel@aixigo.de>
Subject: git-lfs integration?
Message-ID: <79fd2b4e-243c-a9f5-3485-2954fb0f50ef@aixigo.de>
Date:   Tue, 8 Jan 2019 16:16:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.2 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I wonder why git-lfs is needed to efficiently handle large files
in git. Would it be reasonable to integrate this functionality
into the native git?

Please excuse me asking. I read some pretty scary articles about
rewriting history, asking everybody to clone existing repositories
again, and strange errors if git-lfs is *not* installed. Apparently
this is a one-way street, so I didn't dare to install git-lfs yet.


Regards
Harri
