Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86891FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbcFWQKv (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:10:51 -0400
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:54742 "HELO
	gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751054AbcFWQJu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 12:09:50 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jun 2016 12:09:50 EDT
Received: (qmail 5907 invoked by uid 0); 23 Jun 2016 16:03:10 -0000
Received: from unknown (HELO cmgw4) (10.0.90.85)
  by gproxy1.mail.unifiedlayer.com with SMTP; 23 Jun 2016 16:03:10 -0000
Received: from box921.bluehost.com ([69.195.124.121])
	by cmgw4 with 
	id AG331t0132dGC6V01G367V; Thu, 23 Jun 2016 10:03:10 -0600
X-Authority-Analysis: v=2.1 cv=ecGuId0H c=1 sm=1 tr=0
 a=ZeW/8VXwwzXFBt0CnrIREw==:117 a=ZeW/8VXwwzXFBt0CnrIREw==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=zaJ67BFo_GwA:10 a=OLJd5dbTsDkA:10 a=pD_ry4oyNxEA:10
 a=Qw5kwWuYyqPEM_8UjfQA:9 a=QEXdDO2ut3YA:10 a=pH-6VVDMdHoA:10 a=oHarFmrNCaEA:10
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=uberbooster.com; s=default; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version; bh=8w3LIIEvMRxIfle1CpUArBwFvW4pIusqjKo/VjQhr50=; b=frZo1hSvT+Tc
	hrlKX1tMRqYjk1LkskujNYPYmGJPsxvpFc0IOYUAS8xsLHOGqwN6MjjYruEKsZoz+1aAd9oz6Yq+3
	/g1s5OHljEATq5IOSCwBZChDP/5+Bi67ZRtDkcT2G4VHnHp/c9W1GiJghzs3ZHocQP2Q62IJxMkhB
	ikyfLJiDi0D0POY7L5XcrkL36Zae/Db4H3GP+1K3PdRucTpPnnzKA7FWFrnJAKbwMsOg25AaZKhkv
	lTwqBVJpmTnx4TPTxktY4G1ueW93Iz/r2kaxxh85A360U1+p9YQtBCcTVL3E6Xso3BCPC9S6yIUhh
	bkrWpX6EDpMF9jwY8s3QDQ==;
Received: from [209.85.161.176] (port=36473 helo=mail-yw0-f176.google.com)
	by box921.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.86_2)
	(envelope-from <info@uberbooster.com>)
	id 1bG75r-0005AA-GX
	for git@vger.kernel.org; Thu, 23 Jun 2016 10:03:03 -0600
Received: by mail-yw0-f176.google.com with SMTP id b72so75793808ywa.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:03:03 -0700 (PDT)
X-Gm-Message-State: ALyK8tIcF5m7rblGLoFR+T1TGYi06277jTKTBZfuQGqdeNjs14al8zQ50frTI4BRer9ha8MVybrQL5UDNA/47g==
X-Received: by 10.13.193.71 with SMTP id c68mr19947127ywd.58.1466697780569;
 Thu, 23 Jun 2016 09:03:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.252.65 with HTTP; Thu, 23 Jun 2016 09:02:41 -0700 (PDT)
From:	UberBooster <info@uberbooster.com>
Date:	Thu, 23 Jun 2016 12:02:41 -0400
X-Gmail-Original-Message-ID: <CAB-vh3v1v4+jfs1cyDS-Ft5_1ibGqLzzzmJK-s7MHjVPR3uYaQ@mail.gmail.com>
Message-ID: <CAB-vh3v1v4+jfs1cyDS-Ft5_1ibGqLzzzmJK-s7MHjVPR3uYaQ@mail.gmail.com>
Subject: Git Bash Slow in Windows (possible fix)
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-Identified-User: {512:box921.bluehost.com:uberboos:uberbooster.com} {sentby:smtp auth 209.85.161.176 authed with info@uberbooster.com}
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box921.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - uberbooster.com
X-Source-IP: 209.85.161.176
X-Exim-ID: 1bG75r-0005AA-GX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (mail-yw0-f176.google.com) [209.85.161.176]:36473
X-Source-Auth: info@uberbooster.com
X-Email-Count: 0
X-Source-Cap: dWJlcmJvb3M7dWJlcmJvb3M7Ym94OTIxLmJsdWVob3N0LmNvbQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ok, the subject may be a little misleading, but here is what happened.

Back in February 2016, I installed Git-Bash on my Windows 7 computer
and everything worked great.  Git-Bash would execute commands as fast
as the Windows command prompt.

In June, Microsoft, in its infinite wisdom, decided to self install
Windows 10 without my authorization.  Now when I used Git-Bash, it was
painfully slow (7-20 seconds just to get the $ prompt back after an
'ls' command).  I rolled back to Windows 7 and it was still slow, but
now my computer was rebooting every 10 minutes or so after displaying
the BSoD.  I decided on a clean install and wiped the hard drive and
reinstalled Windows 7 fresh.  After installing Git-Bash, it was still
painfully slow.  I read a bunch of forum fixes and none worked.  The
computer I was on was an old Lenovo X200 I purchased almost 10 years
ago, so I decided I needed to upgrade.  I purchased a brand new Lenovo
T460 with Windows 7.

When it came in (Monday, June 20), I installed Git-Bash and to my
surprise, it was STILL slow, but since the computer was much faster, I
could stand to wait for each command to execute, taking only 5-12
seconds.  I then installed Adobe Creative Cloud software, which
included Photoshop CC and Lightroom CC, and I also installed MS Office
360.  AFTER installing this software, Git-Bash was AMAZINGLY fast.
Commands would execute almost instantaneously and I would get my
command prompt back as soon as I hit the Enter key.

After speaking with some people about this, they recommended that I
inform you of my situation as it could be something that Microsoft
installs as part of Office that helped make it faster.  Not sure if
this will be of any help to you all, but thanks for developing such a
great product!

~Michael Wohl
UberBooster, LLC
(352) 258-3737
