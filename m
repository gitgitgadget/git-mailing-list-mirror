Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB1C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0D860FE8
	for <git@archiver.kernel.org>; Fri,  7 May 2021 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbhEGMDZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 May 2021 08:03:25 -0400
Received: from elephants.elehost.com ([216.66.27.132]:37045 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhEGMDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 08:03:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 147C2JO2060647
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 7 May 2021 08:02:20 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "'Git Users'" <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
In-Reply-To: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
Subject: RE: [RFC suggestion] Generate manpage directly with Asciidoctor
Date:   Fri, 7 May 2021 08:02:13 -0400
Message-ID: <00db01d74338$d45615c0$7d024140$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD89NHtCaochqkeQ8Q5lNaqEHivBKyMh4jw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 7, 2021 2:07 AM, Bagas Sanjaya wrote:
>To: Git Users <git@vger.kernel.org>
>Subject: [RFC suggestion] Generate manpage directly with Asciidoctor
>Asciidoctor has support for directly generating manpage, see [1].
>
>We support using Asciidoctor as drop-in replacement for original Asciidoc, but
>currently we need to use xmlto together with Asciidoc(tor) to produce
>manpages. However, most users don't inclined to install xmlto toolchain, partly
>because they had to download more than 300 MB of data just to install xmlto
>and its dependencies (including dblatex and texlive).
>
>So completely migrating to Asciidoctor can eliminate xmlto requirement for
>generating manpage.
>
>What do you think about above?

Our toolchain does not support asciidoctor itself because of porting issues. I am not sure it is available everywhere.

-Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



