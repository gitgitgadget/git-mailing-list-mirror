Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D414AC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352634AbiDZPzi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 26 Apr 2022 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352629AbiDZPzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:55:37 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7926E57F
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:52:29 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23QFqOOn069448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Apr 2022 11:52:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>,
        "'Elektronik \(C.Gerhardt GmbH & Co. KG\)'" <elektronik@gerhardt.de>
Cc:     <git@vger.kernel.org>,
        "'CRM \(C.Gerhardt GmbH & Co. KG\)'" <crm@gerhardt.de>
References: <VI1PR05MB6495349A4C42AA568A665D7BCCFB9@VI1PR05MB6495.eurprd05.prod.outlook.com> <20220426144914.nyaohjqqqlotxnnm@carlos-mbp.lan>
In-Reply-To: <20220426144914.nyaohjqqqlotxnnm@carlos-mbp.lan>
Subject: RE: Error after update from 2.31.1 -> 2.36: Unable to negotiate with IP port X: no matching host key type found.
Date:   Tue, 26 Apr 2022 11:52:20 -0400
Organization: Nexbridge Inc.
Message-ID: <049d01d85985$9ffe3870$dffaa950$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI1QRIxxjBaZoAjii4H7vjDoUnpIAF8FWA9rDyl0xA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 26, 2022 10:49 AM, Carlo Marcelo Arenas Belón wrote:
>On Tue, Apr 26, 2022 at 02:05:14PM +0000, Elektronik (C.Gerhardt GmbH & Co. KG)
>wrote:
>>
>> I found that after an update from git 2.31.1. to 2.36 the authentication to our git
>server (running gitea 1.13.1) fails. We are getting the following error:
>
>I am guessing the issue might be the one documented in the following git for
>windows issue:
>
>  https://github.com/git-for-windows/git/issues/3468
>
>The problem is not with git (neither a git for windows) specific issue, but with the
>underlying version of openssh that is used in your server and the best course of
>option is to upgrade that and generate a new host key, but there are other
>options shown in that ticket that might help in the meanwhile.

I noticed this prior to 2.36.0, so I do no think it is related to git. Switching OpenSSH versions triggered this situation.

