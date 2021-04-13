Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E97DC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590A86128E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 12:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhDMMNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbhDMMNL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 08:13:11 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE0C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 05:12:51 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618315968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6u3K3pqE8qlgKHrh9s3TkdT01G+oWNBj+b+30q0ZtE=;
        b=QToiSFjMoljl00VUK0LP+Bz4GDHTPlH43rATBh2AEz0eNMtxn/G1wdqXfUajLGBQq6q8+B
        3bq7XF6VluRegcbJbEOg9vf8QShOt1aagEP/0lQHgn1WnnVFpLHLCQPsPzVpUI0cOzgRSc
        tmlmg3iBIZ+A/0NnJ1O35E4prZPQ3RMkfiV4FXeDnUUz3jDOq+3G/JyxnUzhkAWRa850fh
        KheS4CHTXjdbcirlR8jTVNRIKrxLYqUVJpIWoM0NVC1MAA0C/7o02UmECqqPdQ+IjjuHcT
        ruOX4RgaLmMumVhVxoZKHLHkS4xR+RMFMSWcEx19pw7R+pcUDkUDDmg72gjG7w==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Apr 2021 08:12:47 -0400
Message-Id: <CAML4RYHKQ6U.35902JHAIZYY@taiga>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com> <87blakgaxr.fsf@evledraar.gmail.com>
 <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga> <878s5ogagz.fsf@evledraar.gmail.com>
 <875z0sg8t9.fsf@evledraar.gmail.com> <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga>
 <87zgy4egtp.fsf@evledraar.gmail.com> <CALQY92B6OVL.2Z59Y6W51BU4Y@taiga>
 <87o8ejej8m.fsf@evledraar.gmail.com>
In-Reply-To: <87o8ejej8m.fsf@evledraar.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can I get one of the maintainers to chime in on this thread and explain,
in their opinion, what this patchset needs before it is acceptable? I'm
not sure where I should go from this discussion.
