Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35122C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C83B61B3A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 09:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbhKRJjk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 Nov 2021 04:39:40 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53613 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbhKRJjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 04:39:36 -0500
Received: (Authenticated sender: robin@jarry.cc)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 090BF20005;
        Thu, 18 Nov 2021 09:36:32 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 Nov 2021 10:36:32 +0100
Message-Id: <CFSSYGFOUE5S.37W5QLMSUSV5T@diabtop>
From:   "Robin Jarry" <robin@jarry.cc>
To:     "Robin Jarry" <robin@jarry.cc>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Jan Smets" <jan.smets@nokia.com>,
        "Stephen Morton" <stephen.morton@nokia.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v3] receive-pack: ignore SIGPIPE while reporting status
 to client
References: <20211106220358.144886-1-robin@jarry.cc>
 <20211110092942.1648429-1-robin@jarry.cc>
In-Reply-To: <20211110092942.1648429-1-robin@jarry.cc>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

did you get a chance to look at v3? Were there additional remarks?

Thanks.
