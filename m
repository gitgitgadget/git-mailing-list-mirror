Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61994EE499E
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbjHRVyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbjHRVyK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 17:54:10 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D2C103
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 14:54:09 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37ILpk4Y2377335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 21:51:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <018601d9d1fc$2049ede0$60ddc9a0$@nexbridge.com>        <xmqqedk0uq6r.fsf@gitster.g>        <01a101d9d20b$836f1a30$8a4d4e90$@nexbridge.com> <xmqqzg2ot50w.fsf@gitster.g>
In-Reply-To: <xmqqzg2ot50w.fsf@gitster.g>
Subject: RE: [BUG] Git 2.42.0-rc2 t1092.57 script error
Date:   Fri, 18 Aug 2023 17:53:58 -0400
Organization: Nexbridge Inc.
Message-ID: <01b301d9d21e$81c7ff40$8557fdc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJj6rMrd+LkSlDs2vIPsHje5s2cMgKgLe3DAXnq+uMBlZMaYq6u6e0w
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 18, 2023 5:28 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> Is this new test code? The local qualified appears to be a bash
>> extension, not available across all shells - from what I can
>> determine. Is it really required here or just fancy?
>
>You are asking a wrong person ;-)
>
>You know Git well enough to run "git blame" on this code yourself to answer
the first
>question and find out whom to ask it:
>
>  https://github.com/git/git/blame/master/t/test-lib-functions.sh#L1794

Code has been around 2 years. I will chase this down with the platform
vendor.
Thanks


