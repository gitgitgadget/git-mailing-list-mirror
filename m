Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4618FEEB572
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 12:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjIIM7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 08:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjIIM7N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 08:59:13 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB3CEB
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 05:59:05 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46894)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qexYG-008G41-76; Sat, 09 Sep 2023 06:59:04 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:37332 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qexYF-001TzQ-Dh; Sat, 09 Sep 2023 06:59:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
Date:   Sat, 09 Sep 2023 07:58:33 -0500
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Fri, 08 Sep 2023 18:05:52 -0500")
Message-ID: <87msxvlczq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qexYF-001TzQ-Dh;;;mid=<87msxvlczq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+1Ozq4dl0c70OI44aPl/EPvD4T4fQ2Vtg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I forgot to mention the patches are against 2.42.

Eric
