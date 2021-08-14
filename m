Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9CC432BE
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 19:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64C860F92
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 19:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhHNThc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 15:37:32 -0400
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:49910 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232297AbhHNTh3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Aug 2021 15:37:29 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Aug 2021 15:37:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1628969472;
        bh=HHgouAQm25SxdBT7y2nChC1glPB6t+poUPC/SEhndLw=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=euxdXz34fCfXp817g501wtIFk8P3GwQAiLx3/c3WNwJm8Ui/eJBKnUgMqbNay8+CW
         IosNyfbMkNOhKv7mMuorvRnDwFPkdgLTrHZ/eelis99mKwsZ3Ap/Je++hJqeUoDdYq
         61DZv2h26OXqjAlfPGoIZQWRXCf9ejy2ravpXtcvpE/Y3iyOi8BRAFNFmRRNlgYcoK
         diod5plW5MZlD+08ckVifFNHYtoNQzOgEeJI2Xpb5s2BWX10Zzl1Bu10W4eiqiENk2
         LjuzfAsW6o/Zk8ZZnWptZkX+VbOW8MwOVQaHa4V4LSHV+NElQN3kANMWbaBFbVUVAB
         8xZNLphyUsVNA==
Received: from smtpclient.apple (unknown [47.202.205.142])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 803A6540122;
        Sat, 14 Aug 2021 19:31:11 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Court Rankin <courtrankin12@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: A few usability question about git diff --cached
Date:   Sat, 14 Aug 2021 15:31:09 -0400
Message-Id: <41204925-53F2-4F88-8B94-15023B945244@icloud.com>
Cc:     git@vger.kernel.org, paolo.ciarrocchi@gmail.com,
        vmiklos@frugalware.org
To:     gitster@pobox.com
X-Mailer: iPhone Mail (18G82)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-14_07:2021-08-13,2021-08-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=560 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2108140122
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Courtney 

Sent from my iPhone
