Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7867C77B7A
	for <git@archiver.kernel.org>; Sat, 13 May 2023 16:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjEMQwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEMQwK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 12:52:10 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D3730C7
        for <git@vger.kernel.org>; Sat, 13 May 2023 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
        :Message-Id:Date:Subject:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=86ncg0WT5x7ryaiw296wfFfhucSpD7E6vFSUkuZZcpA=; b=AoNFZ5
        /UucWnOLJyC3dBXe0+EQLxJR+eN/7u6rpFQWq4nVZuJgCc3flUdF48b159mfqlAanS8+TWCqfsNEo
        wCW+nCZ1tTB6mEZ59MF4NBkXoHRZbZ3OPvxHyc2F94MD1oHWYG3erTQdWPIukeKsrL3f9LRdpVGpZ
        3OteIrXm7uY=;
Received: from 88-110-117-142.dynamic.dsl.as9105.com ([88.110.117.142] helo=localhost.localdomain)
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pxsTV-0007tw-Dw;
        Sat, 13 May 2023 17:52:05 +0100
From:   Philip Oakley <philipoakley@iee.email>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, alexhenrie24@gmail.com,
        git@vger.kernel.org, newren@gmail.com, philipoakley@iee.email,
        phillip.wood123@gmail.com, tao@klerks.biz
Subject: [PATCH 0/1] cover-letter: flatten
Date:   Sat, 13 May 2023 17:51:53 +0100
Message-Id: <20230513165154.772-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <xmqq5ybug8s8.fsf@gitster.g>
References: <xmqq5ybug8s8.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The discussion on `--rebase-merges` documentation [1] noted the
variety of terminologies that could be used when looking at commit
history.

This change consolidates the current colloquial use of 'flatten' as
a synonym for the linearizing of commit sequences, and notes some
of the potential misunderstandings.

Philip

Philip Oakley (2):
  doc: Glossary, describe Flattening
  cover-letter: flatten


-- 
2.40.0.windows.1

