Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C5C77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 23:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbjEXXHH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 24 May 2023 19:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbjEXXHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 19:07:04 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D614189
        for <git@vger.kernel.org>; Wed, 24 May 2023 16:06:46 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34ON5OD8198129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 24 May 2023 23:05:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References: <xmqqedn5fluv.fsf@gitster.g>
In-Reply-To: <xmqqedn5fluv.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.41.0-rc2
Date:   Wed, 24 May 2023 19:06:39 -0400
Organization: Nexbridge Inc.
Message-ID: <022501d98e94$68c671c0$3a535540$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKqBzO6zDBfHf12TijP/VCsWNlc463JGGLA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not sure this is a new thing but it is the first time I noticed it in the log. It was not in the build log for 2.41.0-rc0.

/usr/coreutils/bin/bash: line 3: tclsh: command not found
    * tclsh failed; using unoptimized loading

Tclsh is not available on NonStop or S/390 AFAIK. While its use does go back to 2007, I just want to ensure that it does not sneak in as a dependency beyond git-gui and gitk-git.

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



