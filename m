Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C8A1F42D
	for <e@80x24.org>; Sun, 20 May 2018 09:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeETJ0I (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 05:26:08 -0400
Received: from pv33p38im-asmtp001.me.com ([17.143.238.68]:47380 "EHLO
        pv33p38im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeETJ0H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 05:26:07 -0400
X-Greylist: delayed 3649 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 May 2018 05:26:06 EDT
Received: from process-dkim-sign-daemon.pv33p38im-asmtp001.me.com by
 pv33p38im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P9000O00PWCS600@pv33p38im-asmtp001.me.com> for
 git@vger.kernel.org; Sun, 20 May 2018 08:24:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1526804696;  bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=;
        h=From:Content-type:MIME-version:Subject:Date:Message-id:To;
        b=w0yKxRaBdVEUGO6KFoYalKQv0PDXmI90YrtgLFjjlZY208TtBQGfg6rhD0n3rUfoV
 1d2wl/EPjhlWNF2k4vIBEuZs23ksahh/NdrVy3434CoXJ3nbDq+OEfKJzo83v1NdI4
 2B52kZxmQ3m59KfBgoJnznKd3ZxZdlHAqowQnu71B0cMHz0ZAsUoG5pkj2Od9aY9aC
 AnVKFwCl4S2GT6LlNZfWefjuWiXEZRRCTDEtyZBpsxd6Aonk5GS6IJNLzV0Q9u19FD
 LwSpFCfl5KOBBSHj6eIBFT9zy//aGUpQ3EfbN+Zap2KEQZzL+LmFw/z87GUAHK4rik
 Owndt+s5iZ81g==
Received: from icloud.com ([127.0.0.1]) by pv33p38im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0P90009EIQ1BK640@pv33p38im-asmtp001.me.com>; Sun,
 20 May 2018 08:24:55 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-20_03:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=1 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805200104
From:   Apinan Ponchan <jackzajung@icloud.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: base64
MIME-version: 1.0 (1.0)
Subject: Re: [RFC 00/14] Allow fetch-pack to send ref names (globs allowed)
Date:   Sun, 20 May 2018 15:24:47 +0700
Message-id: <596688AA-4A32-4A6B-8732-477E79D8934D@icloud.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
To:     peff@peff.net
X-Mailer: iPhone Mail (15E302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCuC4quC5iOC4h+C4iOC4suC4gSBpUGhvbmUg4LiC4Lit4LiH4LiJ4Lix4LiZ
