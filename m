Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE335EE498B
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379197AbjHRRsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378933AbjHRRsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 13:48:01 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5E826BB
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 10:48:00 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37IHjeXu2341853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 17:45:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] Git 2.42.0-rc2 t1092.57 script error
Date:   Fri, 18 Aug 2023 13:47:52 -0400
Organization: Nexbridge Inc.
Message-ID: <018601d9d1fc$2049ede0$60ddc9a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdnR+9s0/0Bz57hDTCSvy56IUvA8Cw==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

I'm getting the following error when running t1092.57 in Git 2.42.0-rc2 on
NonStop ia64:

+ ensure_not_expanded status
test_region[8]: test: argument expected
grep: ensure_full_index: No such file or directory
error: last command exited with $?=1
not ok 57 - sparse-index is not expanded

Any suggestions?

Thanks,
Randall
--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



