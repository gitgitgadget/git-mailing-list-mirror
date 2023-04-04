Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F41AC6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 11:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjDDLX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjDDLX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 07:23:26 -0400
Received: from server43.webgo24.de (server43.webgo24.de [185.30.32.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC38195
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 04:23:24 -0700 (PDT)
Received: from earendil.localnet (dynamic-089-013-004-129.89.13.pool.telefonica.de [89.13.4.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by server43.webgo24.de (Postfix) with ESMTPSA id 2A1C84111194;
        Tue,  4 Apr 2023 13:23:22 +0200 (CEST)
From:   Thorsten Otto <admin@tho-otto.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: "git diff" does not show a diff for newly added, binary files
Date:   Tue, 04 Apr 2023 13:23:11 +0200
Message-ID: <1997583.yJf2vTnlun@earendil>
In-Reply-To: <4e5ac983-a45d-4459-b398-4d092ca2f1c8@app.fastmail.com>
References: <3473764.PTxrJRyG3s@earendil> <2349908.kWcu0K8Tai@earendil>
 <4e5ac983-a45d-4459-b398-4d092ca2f1c8@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dienstag, 4. April 2023 12:45:35 CEST Kristoffer Haugsbakk wrote:
> Has it done that before?

Not that a know of.

>unless I instructed it to do it via some `.gitattributes`
>configuration.

How can that be done? I mean, git detects that file to be binary. I certainly 
don't want to treat it as text, and then dump binary data to the terminal when 
they differ ;)




