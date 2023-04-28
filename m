Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B42C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 07:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjD1HQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbjD1HQm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 03:16:42 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F0138
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 00:16:41 -0700 (PDT)
Received: from lantia.sysgo.com ([172.20.1.5]:55014)
        by mail.sysgo.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <guillaume.noailhac@sysgo.com>)
        id 1psILG-00056p-2q;
        Fri, 28 Apr 2023 09:16:30 +0200
Date:   Fri, 28 Apr 2023 09:16:30 +0200 (CEST)
From:   Guillaume Noailhac <guillaume.noailhac@sysgo.com>
To:     rsbecker@nexbridge.com, git@vger.kernel.org
Message-ID: <1639537111.19077.1682666190088@ox.sysgo.com>
In-Reply-To: <045301d9791e$0c0a6d50$241f47f0$@nexbridge.com>
References: <235af3bc-57e3-283f-6d4d-177ccf273909@sysgo.com>
 <045301d9791e$0c0a6d50$241f47f0$@nexbridge.com>
Subject: RE: difftool does not support --submodule=diff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev39
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Randall

> On 04/27/2023 5:36 PM CEST rsbecker@nexbridge.com wrote:
> 
>  
> On Thursday, April 27, 2023 11:29 AM, Guillaume Noailhac wrote:
> >I would like to see the complete directories diff of my git project
> >using the command difftool.
> >
> >Today the command difftool does not support --submodule=diff.
> 
> Would git submodule foreach git diff ... work for you?

Thanks for the quick answer, but not it will not work for me.

I want to make the diff of the HEAD vs HEAD~5 for example of the master git containing the submodules.
with the command "git submodule foreach git difftool ..." , I need to found for each submodules which commit was pointing the master one at HEAD~5 . This solution is not possible.

> --Randall

Best regards
Guillaume Noailhac
