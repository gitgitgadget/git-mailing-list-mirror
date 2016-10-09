Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4BA120987
	for <e@80x24.org>; Sun,  9 Oct 2016 19:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbcJITLQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 15:11:16 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49291 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750940AbcJITLP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Oct 2016 15:11:15 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Oct 2016 15:11:15 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C21AA20599
        for <git@vger.kernel.org>; Sun,  9 Oct 2016 15:03:18 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Sun, 09 Oct 2016 15:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=2f/
        MHbIhn9LkXoT1V8Y/DUJGKwA=; b=BExQSAssu/3s00ivVV+IstIQXwQ0W832jFX
        GSzU5/jBVNXjwRqxQOFlC7s6imDuoQYYJfPJbbxopjG5uceM8/69Et1J406s2DlI
        YtGwS1kIGjJkl8vsl2+iP89E3RgWwDhhj2Ssiy6gRoPJfW9OJN6tyJe2yZO7IvK/
        jib4FFz8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=2f/MHbIhn9LkXoT1V8Y/DUJGKwA=; b=Csi9G
        JeLjICcAgRvOJn4FZEzAk0pdkmX8G8XWGvGgnpQWtaVEvECBQ727hVO5TZxKKG7y
        A7xPOAxVuk1Nl+ts/nWnG00DbHQTComGtwWGg8NSGn/vUVvcysKnVFMenVqpvbn5
        KDdRXLXjRe+dDENKY3cFt+vuQL2BjP/iqd8Gh8=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 9AA272EC73; Sun,  9 Oct 2016 15:03:18 -0400 (EDT)
Message-Id: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
X-Sasl-Enc: 5uaIcivlBvrlZWIC5wobWS2CTbdtZZnf605z1foA8fiR 1476039798
From:   Ian Kelling <ian@iankelling.org>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Mailer: MessagingEngine.com Webmail Interface - ajax-43d69252
Subject: How to watch a mailing list & repo for patches which affect a certain
 area of code?
Date:   Sun, 09 Oct 2016 12:03:18 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've got patches in various projects, and I don't have time to keep up
with the mailing list, but I'd like to help out with maintenance of that
code, or the functions/files it touches. People don't cc me. I figure I
could filter the list, test patches submitted, commits made, mentions of
files/functions, build filters based on the code I have in the repo even
if it's been moved or changed subsequently. I'm wondering what other
people have implemented already for automation around this, or general
thoughts. Web search is not showing me much.
