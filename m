Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E12F202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 18:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdJ2SPR (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 14:15:17 -0400
Received: from marcos.anarc.at ([206.248.172.91]:52620 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbdJ2SPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 14:15:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id E243C1A00A8
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Subject: 
Date:   Sun, 29 Oct 2017 14:15:10 -0400
Message-Id: <20171029181511.29148-1-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171029163714.4818-1-anarcat@debian.org>
References: <20171029163714.4818-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


sorry for the noise here, but the original patch didn't fix the length
in the right place. v2 fixed it in the library properly, but i forgot
to also include the length of the suffix. this should be good to go...
