Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE9C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjHKUSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKUSr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:18:47 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E64D3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:18:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37BKGUkn872491
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:16:30 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Mun Johl'" <Mun.Johl@wdc.com>, <git@vger.kernel.org>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
In-Reply-To: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source code
Date:   Fri, 11 Aug 2023 16:18:37 -0400
Organization: Nexbridge Inc.
Message-ID: <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGYfaIzxiLvNNliA6NGPhsdV5ubsbBoJogA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
>I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I run
'make
>prefix=/usr/local all doc', I get the following error:
>
>fatal: Not a git repository (or any parent up to mount point /tools)
>
>Which I infer means that I need to do the build within a git repo.  Is that
correct?  Or
>have I missed some basic step in the build process?

Yes, you must be in the cloned git repository in order to run the build.
--Randall

