Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8A11F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 14:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757405AbcJNOgJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:36:09 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:52115 "EHLO
        homiemail-a22.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756914AbcJNOgE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:36:04 -0400
Received: from homiemail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTP id 005C3114068
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=vanQMIgCLAtxKS683TR
        URMfu8v8=; b=mOuTv7I4Q4GrzPJPgsP0fuj6ODas6fdIcTuFqT+jNpwixdfYPdm
        ogK6h5ackrk2gkX58w6O4uPBh3Nh3qKDzVt9UP3xzF2TMKDWcgJl1ukgKo9p/782
        M7EQ3JtuA5nWbRmcawqWmC6UHGPn+NpLrWg9DXuR3tGpfolJcwvbVNyI=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id AC7AE114067
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 07:35:57 -0700 (PDT)
Message-ID: <1476455756.32360.2.camel@frank>
Subject: Why does git checkout -b touch the index?
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Date:   Fri, 14 Oct 2016 10:35:56 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I do "git checkout -b fleem", with no additional flags, why does it
need to rewrite the index?  Or even read the index? 

(this is kind of a bug report, I guess, but it's a pretty minor bug that
I only noticed because I was out of hard drive space)

