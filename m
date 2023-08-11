Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8014AC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjHKUqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHKUqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:46:18 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDCB2D52
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:46:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37BKi2H9876395
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 20:44:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Mun Johl'" <Mun.Johl@wdc.com>, <git@vger.kernel.org>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>        <034501d9cc91$069bd360$13d37a20$@nexbridge.com> <xmqqr0o9qpon.fsf@gitster.g>
In-Reply-To: <xmqqr0o9qpon.fsf@gitster.g>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source code
Date:   Fri, 11 Aug 2023 16:46:10 -0400
Organization: Nexbridge Inc.
Message-ID: <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGYfaIzxiLvNNliA6NGPhsdV5ubsQMKIH4jAmvty4uwPH24oA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 11, 2023 4:39 PM, Junio C Hamano wrote:
>Subject: Re: "fatal: Not a git repository" issued during 'make' from source
code
>
><rsbecker@nexbridge.com> writes:
>
>> On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
>>>I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I run
>> 'make
>>>prefix=/usr/local all doc', I get the following error:
>>>
>>>fatal: Not a git repository (or any parent up to mount point /tools)
>>>
>>>Which I infer means that I need to do the build within a git repo.  Is
that
>> correct?  Or
>>>have I missed some basic step in the build process?
>>
>> Yes, you must be in the cloned git repository in order to run the build.
>
>Shouldn't we be able to build out of a tarball?

I don't get the impression he started with a tarball, so subsequently sent
the doc ref for that. Using just "make" is not sufficient from a tarball.

