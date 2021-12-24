Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD6C4332F
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 00:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245449AbhLXAPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 19:15:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:40430 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhLXAPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 19:15:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BO0F2Cg069066
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Dec 2021 19:15:02 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqmtkq6frf.fsf@gitster.g>
In-Reply-To: <xmqqmtkq6frf.fsf@gitster.g>
Subject: RE: [RFC] squelch log4j inquiries
Date:   Thu, 23 Dec 2021 19:14:57 -0500
Organization: Nexbridge Inc.
Message-ID: <01d201d7f85b$4bffb2c0$e3ff1840$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIAo5b9afze7l4WQFVka0p7le4G26vvbr0g
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 23, 2021 6:52 PM, Junio C Hamano wrote:
> I wonder if we should do something like this, for limited time like a few
> months or so, so that we have something prominently shown at places like
> https://github.com/git/git/
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  README.md | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git c/README.md w/README.md
> index f6f43e78de..76e99fe5bb 100644
> --- c/README.md
> +++ w/README.md
> @@ -7,6 +7,9 @@ Git is a fast, scalable, distributed revision control
system
> with an  unusually rich command set that provides both high-level
operations
> and full access to internals.
> 
> +No part of Git is written in Java, hence it is not susceptible to the
> +log4j vulnerability that has been causing sensation recently.
> +
>  Git is an Open Source project covered by the GNU General Public  License
> version 2 (some parts of it are under different licenses,  compatible with
the
> GPLv2). It was originally written by Linus

This is a good idea. I have had to reassure a whole bunch of people in my
community about this, not really because of git itself but because of the
Maven build associated with EGit/JGit that may (do) have this issue if the
wrong version of log4j is available. I would rather not discuss the
particulars of the attack vector in this mailing list.

--Randall

