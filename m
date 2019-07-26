Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545611F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfGZU3S convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 26 Jul 2019 16:29:18 -0400
Received: from mx.innout.com ([64.58.191.10]:49072 "EHLO mx.innout.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbfGZU3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:29:18 -0400
X-Greylist: delayed 807 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jul 2019 16:29:18 EDT
X-ASG-Debug-ID: 1564172149-0f186f720b157b50001-QuoKaX
Received: from IrvMail01.innout.corp (irvmail01.innout.corp [172.16.3.75]) by mx.innout.com with ESMTP id V3vHR8BQ9jDqYSq2 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO) for <git@vger.kernel.org>; Fri, 26 Jul 2019 13:15:49 -0700 (PDT)
X-Barracuda-Envelope-From: GPoli@innout.com
X-ASG-Whitelist: Client
Received: from IrvMail02.innout.corp (172.16.3.76) by IrvMail01.innout.corp
 (172.16.3.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Fri, 26 Jul
 2019 13:15:49 -0700
Received: from IrvMail02.innout.corp ([172.16.3.76]) by IrvMail02.innout.corp
 ([172.16.3.76]) with mapi id 15.01.1531.003; Fri, 26 Jul 2019 13:15:49 -0700
From:   Gary Poli <GPoli@innout.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: 2.22 issue across samba
Thread-Topic: 2.22 issue across samba
X-ASG-Orig-Subj: 2.22 issue across samba
Thread-Index: AdVD6joARgwrKQElQpOCIKHKyl7zMA==
Date:   Fri, 26 Jul 2019 20:15:49 +0000
Message-ID: <6e717834410e46d7b194785323dc4cbb@innout.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.110.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: irvmail01.innout.corp[172.16.3.75]
X-Barracuda-Start-Time: 1564172149
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://barracudaspam.innout.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at innout.com
X-Barracuda-Scan-Msg-Size: 1262
X-Barracuda-BRTS-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
	I'm running git for windows installed locally. Windows 10 Pro version 1903 OS Build 18362.239. I have a repository on a UNIX machine running AIX 7.1 TL4 SP2. I use SAMBA 3.0.23d to mount the drive for use. I upgraded to git 2.22 and am having issues. Even starting from a fresh clone of the repo, the head immediately detaches. After a few commands like status or branch it stops recognizing the repo altogether. I suspect it is having trouble reading or writing to itself; perhaps the index is getting corrupted. I reverted to git 2.14 and I'm working fine again. I've got my system admin looking into updating both AIX and SAMBA, but I thought I would report the issue here as well. Let me know if you need anything else from me. Thanks.


Gary Poli | Lead ERP Programmer
o 949 509 6216
4199 Campus Drive, 9th Floor
Irvine, CA 92612

This e-mail, including any accompanying attachments, may contain confidential information that is private, personal, and/or proprietary, and it is for the sole use of the intended recipient(s).  Any unauthorized review, use, distribution or disclosure by others is strictly prohibited.  If you have received this document in error, please immediately contact Gary Poli and delete all copies of this message.
