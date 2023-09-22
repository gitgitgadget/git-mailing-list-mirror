Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA37CD4840
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 16:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIVQNQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 22 Sep 2023 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIVQNP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 12:13:15 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F93D99
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 09:13:09 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 38MGAOiS1868723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 16:10:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Ben Boeckel'" <ben.boeckel@kitware.com>, <git@vger.kernel.org>
References: <ZNffWAgldUZdpQcr@farprobe> <ZQ21NsLmp+xQU5g+@farprobe>
In-Reply-To: <ZQ21NsLmp+xQU5g+@farprobe>
Subject: RE: [BUG] `git describe` doesn't traverse the graph in topological order
Date:   Fri, 22 Sep 2023 12:13:00 -0400
Organization: Nexbridge Inc.
Message-ID: <02d701d9ed6f$abcb4b00$0361e100$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMniK2C5ueFGaecrAkj2WziqqcqsgIDXfParXuyqtA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, September 22, 2023 11:40 AM, Ben Boeckel wrote:
>On Sat, Aug 12, 2023 at 15:36:56 -0400, Ben Boeckel wrote:
>> I found an issue where `git describe` doesn't find a "closer" tag than
>> another tag as the correct one to base the description off of. I have
>> a reproducer, but I'll first give details of the real world issue.
>
>Bump. Can anyone provide guidance as to what the best solution to this might be?

Can you provide details? `git describe` is sensitive to --first-parent and whether the tag has annotations.
--Randall

