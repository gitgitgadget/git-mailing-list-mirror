Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBCED1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJJWm5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 18:42:57 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:43414 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJJWm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 18:42:56 -0400
Received: from vyasa.cs.utexas.edu (vyasa.cs.utexas.edu [128.83.130.99])
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w9AFKEtx032549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Oct 2018 10:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1539184815;
        bh=Zwes0L6Hc0b9BBsNxCAsyLlsNrbwlkJ+TCKT9LV83NI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gvFDLlELGkzYSPKqfzOe3v8nsBONluwPH2jlC5fa0QGwYtdctW+R4mIyNGljA24ST
         bbjSaAygcqunLuqLQteo4TJHU+HJ9RzOChZfr8yV8A8Ietv+HXbPUJXDGLUYB9YELr
         Y44q0h0hssrDDhB2DmqiPm54F45/6uABhrGBhg6g=
Received: (from mihir@localhost)
        by vyasa.cs.utexas.edu (8.15.2/8.15.2/Submit) id w9AFKEab014656;
        Wed, 10 Oct 2018 10:20:14 -0500
From:   Mihir Mehta <mihir@cs.utexas.edu>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: 
Date:   Wed, 10 Oct 2018 10:20:06 -0500
Message-Id: <20181010152007.14441-1-mihir@cs.utexas.edu>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <xmqqwoqw29uw.fsf@gitster-ct.c.googlers.com>
References: <xmqqwoqw29uw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Wed, 10 Oct 2018 10:20:14 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio. Instead of removing that part of the patch, I opted to
expand it to make it a little clearer (in my opinion) than it was
before. Let me know if this works.

Mihir.
