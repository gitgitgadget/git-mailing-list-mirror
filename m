Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F28C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 18:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjGMSoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSoi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 14:44:38 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFAB26B2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 11:44:32 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 36DIgaJm3012409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 18:42:37 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Fayez Coder'" <fayez.coder@gmail.com>, <git@vger.kernel.org>
References: <129BE2F7-847E-45E4-8A22-CC76EACF3543@gmail.com>
In-Reply-To: <129BE2F7-847E-45E4-8A22-CC76EACF3543@gmail.com>
Subject: RE: I delete files by mistake not in stage area
Date:   Thu, 13 Jul 2023 14:44:24 -0400
Organization: Nexbridge Inc.
Message-ID: <003901d9b5ba$0ee1e4d0$2ca5ae70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHP5NarjpZzUfrLXC4Tl3CTfNGuUa/LqfKg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, July 13, 2023 1:58 PM, Fayez Coder wrote:
>I deleted files from my projects those files in change area not add it to
stage area ,can
>I restore those files.

If you did not modify the files, you can restore them using git restore --
file-name. If the files were never added to git and are not staged, your
only chance is a recycle-bin. If you are in ECLIPSE, you can use the local
history to recover the files.

--Randall

