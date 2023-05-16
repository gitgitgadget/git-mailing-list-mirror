Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E02C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 16:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjEPQ63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 12:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjEPQ60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 12:58:26 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CED83FD
        for <git@vger.kernel.org>; Tue, 16 May 2023 09:58:24 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34GGv7PL2467192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 16 May 2023 16:57:07 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] Git 2.41.0-rc0 - Compile Error ALLOC_GROW
Date:   Tue, 16 May 2023 12:58:15 -0400
Organization: Nexbridge Inc.
Message-ID: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdmIF5sWYpJ+5PxQREWvJPJAD3QU5Q==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Team,

I am getting a compile error on rc0:

  	ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1,
git_atexit_hdlrs.alloc);
  	^
"/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/run-command.c
", line 1103: error(114): identifier "ALLOC_GROW" is undefined

Any help o nthis?

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



