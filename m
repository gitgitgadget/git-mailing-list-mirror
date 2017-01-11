Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFA220756
	for <e@80x24.org>; Wed, 11 Jan 2017 00:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758878AbdAKALn (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 19:11:43 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:59778 "EHLO
        homiemail-a76.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758807AbdAKALm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jan 2017 19:11:42 -0500
Received: from homiemail-a76.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a76.g.dreamhost.com (Postfix) with ESMTP id 1F8D4458083
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 16:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=ZB9mJCrdJxyFEkzo5xr
        v120KQeQ=; b=bzD7I1TU39R5yGQx+GuAqjE72kpcPwyl/fEMHssF1890lIo3tag
        CnyWT43GyotGlcUaWVxxBP9nFmJ7COnA/MAW/1kZhxYuDlfZLUpQMCmEdTG2j2js
        9uq7kn7UEZ8rxbxvF6ZOvEaI6/pQ7QUcCa5RhTVO37PJ1m+juStD2U5M=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a76.g.dreamhost.com (Postfix) with ESMTPSA id D2509458081
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 16:11:41 -0800 (PST)
Message-ID: <1484093500.17967.6.camel@frank>
Subject: git cat-file on a submodule
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Date:   Tue, 10 Jan 2017 19:11:40 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why does git cat-file -t $sha:foo, where foo is a submodule, not work? 

git rev-parse $sha:foo works.  

By "why", I mean "would anyone complain if I fixed it?"  FWIW, I think
-p should just return the submodule's sha.



