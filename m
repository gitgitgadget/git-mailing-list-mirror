Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D2C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 17:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2523B613C8
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 17:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFFRez (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 13:34:55 -0400
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:49175 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229721AbhFFRer (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Jun 2021 13:34:47 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jun 2021 13:34:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1623000443;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=wCMhA0QrqSnUu2DyemKjjz+hH8T7ZI9BPT2ayPi/wzBoxESDNFB1apqtqFK3VRSLQ
         O9C5dqfVnmmxObpHvi101ytfo91DfKiaJ4cIZQplvgqBsPgMY0WVgXVaGSjx1sumrl
         b8B2tr2/WeJON5MnfzO/6Rzrjxin+HwN5hYjUUIjTWBEadfYKNvj6hkSUkxROEjLp8
         4GdBXmL79hWqiMPQpbncJhDGj7hLBYn4fAJAL60atqz5TY2ihUr9c+Vp5g2hTilHiD
         D9g4R6KBsgP7nkKmbkuHTMlKavCL8L06/X8o3+RiYCYOWtNKhY101VphjKpJAssJEO
         qXHPHVYsri9dA==
Received: from smtpclient.apple (unknown [144.168.163.184])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id A643D8204EA;
        Sun,  6 Jun 2021 17:27:22 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   B <bryce335@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 7 Jun 2021 03:27:17 +1000
Subject: Re: My git repo is broken, how to fix it ?
Message-Id: <141F3738-83A0-440E-B5D0-8EAEA61783BB@icloud.com>
Cc:     git@vger.kernel.org, litvinov2004@gmail.com
To:     torvalds@linux-foundation.org
X-Mailer: iPhone Mail (18F72)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-06_14:2021-06-04,2021-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=429 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2106060143
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


